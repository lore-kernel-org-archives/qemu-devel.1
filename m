Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF5C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2645C20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBYnoxng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2645C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFIs-0000FE-71
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFFII-00089n-Po
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFFIG-000532-ML
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:54:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFFIG-00052M-Bs
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584701664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvzlhyHZkndh8wuF5TkKCKUi304wR0VSY/TILLqJjE4=;
 b=ZBYnoxngLRoSACjFaxnWYzSExakLiNPQ/xmxZ/3ipvSYToRwsTeDAmufPVH31R8Kw3Qg4N
 GmkGQYGhi3LcysGWmOvWhZIPzaO27JlcP+EWJ9uBisIEOBm2oo3Kr6x90fNhB7Y5oZFhkA
 DuiY4ZupJqJo6Dibe2/q/v5K0h5zn5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-ACQ7BTtjNIiEv3_RBJE-fA-1; Fri, 20 Mar 2020 06:54:22 -0400
X-MC-Unique: ACQ7BTtjNIiEv3_RBJE-fA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA1A477
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:54:21 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39331912AC;
 Fri, 20 Mar 2020 10:54:14 +0000 (UTC)
Subject: Re: [PATCH] virtio-iommu: depend on PCI
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200320104147.643941-1-pbonzini@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <61c1af7a-fb94-4c84-50bc-f509621f07e4@redhat.com>
Date: Fri, 20 Mar 2020 11:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200320104147.643941-1-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo

On 3/20/20 11:41 AM, Paolo Bonzini wrote:
> The virtio-iommu device attaches itself to a PCI bus, so it makes
> no sense to include it unless PCI is supported---and in fact
> compilation fails without this change.

with the --- cleanup (?)

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks


Eric

> 
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index d29525b36f..83122424fa 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -12,7 +12,7 @@ config VIRTIO_RNG
>  config VIRTIO_IOMMU
>      bool
>      default y
> -    depends on VIRTIO
> +    depends on PCI && VIRTIO
>  
>  config VIRTIO_PCI
>      bool
> 


