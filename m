Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066932065D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKYFTw32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066932065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtp8Q-0006sg-AQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtp7Z-0006DO-PM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:15:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtp7W-0002it-Tt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594372501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0WEIQNcesRzcEk7Bl2MoAsnOENehDzHZTiU7+lEAOA=;
 b=GKYFTw32Y8HE0O39J8TZIVMDvSv9SujzXs5MoA1Gjl9UWKzNVZGa9VmoAhUINUsxFuX3Nl
 LdnJNKTYfs4shpz7rYJVLwDyAIEkECLVm4Gcjl3s2VkNvED6Zs86rAPq/aegAUdm0snvHD
 x80HEjI+awiwAwy3EU1C8IcLxgf+3t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-ePRz95pSNfKo_b6wrFAFkw-1; Fri, 10 Jul 2020 05:14:58 -0400
X-MC-Unique: ePRz95pSNfKo_b6wrFAFkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7934D1080;
 Fri, 10 Jul 2020 09:14:55 +0000 (UTC)
Received: from [10.72.13.228] (ovpn-13-228.pek2.redhat.com [10.72.13.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5A76FECF;
 Fri, 10 Jul 2020 09:14:34 +0000 (UTC)
Subject: Re: [PATCH v2] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, peter.maydell@linaro.org
References: <20200710064642.24505-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <60661311-2f76-9c6b-f2c6-d9f522dbbf10@redhat.com>
Date: Fri, 10 Jul 2020 17:14:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710064642.24505-1-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, zhihong.wang@intel.com, ian@iankelling.org,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/10 下午2:46, Cindy Lu wrote:
> In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   hw/virtio/vhost-vdpa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a3d17fe0f9..b9265f3761 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -38,7 +38,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
>   static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
>                                 void *vaddr, bool readonly)
>   {
> -    struct vhost_msg_v2 msg;
> +    struct vhost_msg_v2 msg = {};
>       int fd = v->device_fd;
>       int ret = 0;
>   
> @@ -61,7 +61,7 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
>   static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
>                                   hwaddr size)
>   {
> -    struct vhost_msg_v2 msg;
> +    struct vhost_msg_v2 msg = {};
>       int fd = v->device_fd;
>       int ret = 0;
>   


