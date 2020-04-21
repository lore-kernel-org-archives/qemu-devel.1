Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D2BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811F5206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik00sc8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811F5206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQk96-00015W-Jg
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 00:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk8P-0000eg-F9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk8O-0007jW-R8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:03:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jQk8O-0007ih-Bs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587441823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHta0XXZB4k4xxqYh4AQsXrfTb4hKzavkEMq8Yc4cgM=;
 b=ik00sc8uGos3DFlsK52A+OAuVzGLnQRd2ByCgta2ffAOcsROVHcmllPzn3ceWtqEiMoe/k
 V4RLnUtmr7crAreSxJHmLtdLqL68l2l6p9hiNiS4iNToIS8LLCEaeh8IXuAfbvwFlPtkvW
 z/pIiZCBV1nV1ysa0+ce1Os7bngkovo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-YFAXgb_AOo6qzvDOTJcmTQ-1; Tue, 21 Apr 2020 00:03:39 -0400
X-MC-Unique: YFAXgb_AOo6qzvDOTJcmTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC67DB25;
 Tue, 21 Apr 2020 04:03:36 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1AA28982;
 Tue, 21 Apr 2020 04:03:12 +0000 (UTC)
Subject: Re: [RFC v1 0/4] vDPA support in qemu
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48a6f0ae-ca3f-a890-10b7-99792df9fb37@redhat.com>
Date: Tue, 21 Apr 2020 12:03:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-1-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:40:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, maxime.coquelin@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, hanand@xilinx.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> vDPA device is a device that uses a datapath which complies with the
> virtio specifications with vendor specific control path. vDPA devices
> can be both physically located on the hardware or emulated by software.
> This RFC introduce the vDPA support in qemu


Looks good overall, see comments inline.

And I think we need reorder the patches and split some patches into=20
smaller ones.

E.g

1) qemu_get_peer
2) queue_enabled method for virtio-bus
3) queue_enabled for virtio-pci
4) set_vring_ready for vhost_ops
5) vhost_set_state for vhost_ops
6) call vhost_set_state in virtio_net_vhost_status()
7) generic vdpa support
8) vhost-vdpa net backend

Thanks


>
> Cindy Lu (3):
>    net: Introduce qemu_get_peer
>    vhost-vdpa: introduce vhost-vdpa net client
>    vhost-vdpa: implement vhost-vdpa backend
>
> Jason Wang (1):
>    vhost: introduce vhost_set_vring_ready method
>
>   hw/net/vhost_net-stub.c           |   5 +
>   hw/net/vhost_net.c                |  75 +++++-
>   hw/net/virtio-net.c               |   9 +
>   hw/virtio/Makefile.objs           |   2 +-
>   hw/virtio/vhost-backend.c         |   3 +
>   hw/virtio/vhost-vdpa.c            | 376 ++++++++++++++++++++++++++++++
>   hw/virtio/vhost.c                 |   5 +
>   hw/virtio/virtio-pci.c            |  13 ++
>   hw/virtio/virtio.c                |   6 +
>   include/hw/virtio/vhost-backend.h |   8 +-
>   include/hw/virtio/vhost-vdpa.h    |  14 ++
>   include/hw/virtio/virtio-bus.h    |   4 +
>   include/net/net.h                 |   1 +
>   include/net/vhost-vdpa.h          |  18 ++
>   include/net/vhost_net.h           |   2 +
>   net/Makefile.objs                 |   2 +-
>   net/clients.h                     |   2 +
>   net/net.c                         |   7 +
>   net/vhost-vdpa.c                  | 211 +++++++++++++++++
>   qapi/net.json                     |  21 +-
>   20 files changed, 773 insertions(+), 11 deletions(-)
>   create mode 100644 hw/virtio/vhost-vdpa.c
>   create mode 100644 include/hw/virtio/vhost-vdpa.h
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c
>


