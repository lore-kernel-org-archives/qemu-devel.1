Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D318C38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588CC216FD
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/8HZ/B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588CC216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXFub-00031I-IG
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 23:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFtV-0002XE-DY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:11:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFtU-0001Au-CE
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588993875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=un7W13Pwoo0ykPYpOB3fFD8olDxlxQSGtoLr+GS5O+E=;
 b=G/8HZ/B7rfaq8kPlgpJsUNGG3tc/GcUkw3MW7TDXXm2CEM41eDMhZkQFVARuqEfQblQqNc
 BHRvKIOpFntSOkpw73OGLtrS1POHjgVe3ce1TI8c6oTnf+q2n9f1oqxMPdFaJBYS74yawd
 BGDSzHyhYPEQXitDmvwy60QSnYM6HR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-teLtDMIwOASOGQnoJn1jAA-1; Fri, 08 May 2020 23:11:13 -0400
X-MC-Unique: teLtDMIwOASOGQnoJn1jAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3226080B719;
 Sat,  9 May 2020 03:11:11 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 785015F7DC;
 Sat,  9 May 2020 03:10:50 +0000 (UTC)
Subject: Re: [RFC v2 0/9] vDPA support in qemu
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05a79596-13c4-d66b-4014-32b0229914ab@redhat.com>
Date: Sat, 9 May 2020 11:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-1-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 23:05:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/9 上午12:32, Cindy Lu wrote:
> vDPA device is a device that uses a datapath which complies with the
> virtio specifications with vendor specific control path. vDPA devices
> can be both physically located on the hardware or emulated by software.
> This RFC introduce the vDPA support in qemu
>
> change from v1
> separe the patch of introduce vhost_set_vring_ready method


I think you meant "separate"?

May worth to mention TODO:

1) vIOMMU support
2) live migration support

And it might be helpful if you can publish a github repo for people to try.

Thanks


> separe the patch of qemu_get_peer
> separe the patch  of vhost_set_state
> intorduce the new macro specific for vDPA in configure
> intorduce the fuction to pass the fd from cmdline
> introduce the docmation in qemu-options.hx
> the other comments form last version
>
>
> Cindy Lu (3):
>    net: introduce qemu_get_peer
>    net: use the function qemu_get_peer
>    virtio_net: introduce vhost_set_state
>
> Jason Wang (4):
>    virtio-bus: introduce queue_enabled method
>    virito-pci: implement queue_enabled method
>    vhost_net: set vq ready during start if necessary
>    vhost: introduce vhost_set_vring_ready method
>
> Tiwei Bie (2):
>    vhost-vdpa: introduce vhost-vdpa net client
>    vhost-vdpa: implement vhost-vdpa backend
>
>   configure                         |  21 ++
>   hw/net/vhost_net-stub.c           |   4 +
>   hw/net/vhost_net.c                |  77 ++++-
>   hw/net/virtio-net.c               |   9 +
>   hw/virtio/Makefile.objs           |   1 +
>   hw/virtio/vhost-backend.c         |   5 +
>   hw/virtio/vhost-vdpa.c            | 447 ++++++++++++++++++++++++++++++
>   hw/virtio/vhost.c                 |  14 +
>   hw/virtio/virtio-pci.c            |  13 +
>   hw/virtio/virtio.c                |   6 +
>   include/hw/virtio/vhost-backend.h |  10 +-
>   include/hw/virtio/vhost-vdpa.h    |  25 ++
>   include/hw/virtio/vhost.h         |   1 +
>   include/hw/virtio/virtio-bus.h    |   4 +
>   include/net/net.h                 |   1 +
>   include/net/vhost-vdpa.h          |  19 ++
>   include/net/vhost_net.h           |   4 +-
>   net/Makefile.objs                 |   2 +-
>   net/clients.h                     |   2 +
>   net/net.c                         |   9 +
>   net/vhost-vdpa.c                  | 227 +++++++++++++++
>   qapi/net.json                     |  22 +-
>   qemu-options.hx                   |  19 ++
>   23 files changed, 930 insertions(+), 12 deletions(-)
>   create mode 100644 hw/virtio/vhost-vdpa.c
>   create mode 100644 include/hw/virtio/vhost-vdpa.h
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c
>


