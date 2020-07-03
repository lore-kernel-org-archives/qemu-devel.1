Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02FEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F09120890
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+Q1gb/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F09120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGAJ-0005dz-Or
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrG9g-0005Bn-JL
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:30:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrG9e-0007s8-A2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593761437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BO+UoMCKelL16/Y2pSLyoI6zj6H6iuUXbalWUnmtq6Y=;
 b=R+Q1gb/c8XmKgudLkDQKGIWszvDRSLnwDQH3lSLdeD8YKqDxvX/UdH1ghbw8/sHhQG4NLe
 1go+NcWk0vEmusYxBNW5RbGjy9kEjr7erH/e4vpX+gHD99N5acS+MoaR6GSwECwpATZYd9
 NbvNGQaI8zS5JPDFvHcK4X68IRlz4+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-9G0KWRe_Nou5cXOTKSbIOg-1; Fri, 03 Jul 2020 03:30:33 -0400
X-MC-Unique: 9G0KWRe_Nou5cXOTKSbIOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56554107ACF9;
 Fri,  3 Jul 2020 07:30:31 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A17CA10013D9;
 Fri,  3 Jul 2020 07:30:04 +0000 (UTC)
Subject: Re: [PATCH v4 00/14]vDPA support in qemu
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200701145538.22333-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2f068402-2b8f-c3e5-0f91-c2e18a802b04@redhat.com>
Date: Fri, 3 Jul 2020 15:30:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701145538.22333-1-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


On 2020/7/1 下午10:55, Cindy Lu wrote:
> vDPA device is a device that uses a datapath which complies with the
> virtio specifications with vendor specific control path. vDPA devices
> can be both physically located on the hardware or emulated by software.
> This PATCH introduce the vDPA support in qemu
> TODO
> 1) vIOMMU support
> 2) live migration support
> 3) docs for vhost-vdpa
> 4) config interrupt support
>
> Change from v1
> separate the patch of vhost_vq_get_addr
> separate the patch of vhost_dev_start
> introduce the docmation for vhost-vdpa.rst
> other comments form last version
> github address
> https://github.com/lulu-github-name/qemutmp.git PATCHV2
>
> Change from v3
> fix the complie problem
> separate the patch of vhost_force_iommu
> other comments form last version
> github address
> https://github.com/lulu-github-name/qemutmp.git PATCHV3
>
> Change from v3
> fix the centos7 test problem
> other comments form last version
> github address
> https://github.com/lulu-github-name/qemutmp.git PATCHV4


Thanks a lot for patches.

I think we may have a more generic handling of forcing IOMMU_PLATFORM. 
But it can be done on top.

So

Acked-by: Jason Wang <jasowang@redhat.com>


>
> Cindy Lu (11):
>    net: introduce qemu_get_peer
>    vhost_net: use the function qemu_get_peer
>    vhost: introduce new VhostOps vhost_dev_start
>    vhost: implement vhost_dev_start method
>    vhost: introduce new VhostOps vhost_vq_get_addr
>    vhost: implement vhost_vq_get_addr method
>    vhost: introduce new VhostOps vhost_force_iommu
>    vhost: implement vhost_force_iommu method
>    vhost_net: introduce set_config & get_config
>    vhost-vdpa: introduce vhost-vdpa backend
>    vhost-vdpa: introduce vhost-vdpa net client
>
> Jason Wang (3):
>    virtio-bus: introduce queue_enabled method
>    virtio-pci: implement queue_enabled method
>    vhost: check the existence of vhost_set_iotlb_callback
>
>   configure                         |  21 ++
>   docs/interop/index.rst            |   1 +
>   docs/interop/vhost-vdpa.rst       |  17 ++
>   hw/net/vhost_net-stub.c           |  11 +
>   hw/net/vhost_net.c                |  45 ++-
>   hw/net/virtio-net.c               |  19 ++
>   hw/virtio/Makefile.objs           |   1 +
>   hw/virtio/vhost-backend.c         |   6 +
>   hw/virtio/vhost-vdpa.c            | 475 ++++++++++++++++++++++++++++++
>   hw/virtio/vhost.c                 |  52 +++-
>   hw/virtio/virtio-pci.c            |  13 +
>   hw/virtio/virtio.c                |   6 +
>   include/hw/virtio/vhost-backend.h |  19 +-
>   include/hw/virtio/vhost-vdpa.h    |  26 ++
>   include/hw/virtio/vhost.h         |   7 +
>   include/hw/virtio/virtio-bus.h    |   4 +
>   include/net/net.h                 |   1 +
>   include/net/vhost-vdpa.h          |  22 ++
>   include/net/vhost_net.h           |   5 +
>   net/Makefile.objs                 |   2 +-
>   net/clients.h                     |   2 +
>   net/net.c                         |  10 +
>   net/vhost-vdpa.c                  | 228 ++++++++++++++
>   qapi/net.json                     |  28 +-
>   qemu-options.hx                   |  12 +
>   25 files changed, 1004 insertions(+), 29 deletions(-)
>   create mode 100644 docs/interop/vhost-vdpa.rst
>   create mode 100644 hw/virtio/vhost-vdpa.c
>   create mode 100644 include/hw/virtio/vhost-vdpa.h
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c
>


