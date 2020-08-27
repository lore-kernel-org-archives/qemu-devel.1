Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC46C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB5922B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbskRA/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB5922B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGhV-0006LV-Gp
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGgl-0005on-6q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:07:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGgj-0001gi-0T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E0lrKIRwpk3fspP40Kgkcgsrt3UnRS77wqaXy4RP/9A=;
 b=SbskRA/EFEJsdMWI4PYR0byALBN9PRy00j/47VO0EtEL4+JLB2+uCa++kWz+JBzuTu88Ld
 jnVRNyViWgzdTJewFK4OtffdivX5Kp01vZ3jfd2KaVUuh7yHzRj1vX58BqBgFG+rYYWmer
 mL9QBVc/MO4DwRLg7MVN/V1JE8fIrgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-vg0pVzrIMZGK38IGa7MUOg-1; Thu, 27 Aug 2020 08:07:25 -0400
X-MC-Unique: vg0pVzrIMZGK38IGa7MUOg-1
Received: by mail-wr1-f70.google.com with SMTP id i6so1456908wru.23
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E0lrKIRwpk3fspP40Kgkcgsrt3UnRS77wqaXy4RP/9A=;
 b=FbrFcwpp4v24UTD0C0cY48tJYPmM3IcEvBbIZhyzRTs/mi7AWElIdeyeX/DIYzq8Wy
 tCCfVEQJM4TNXdPrs+6ipWUr4xw1mWs4trcAwR3IUvyhpi/z28+/DHxx7yAVUKSD1Lo9
 UhEkhw/gLi0jHZaBfsTUcCc4MdkILWvr7N2OMtzlN8/zdiHcCF5QbD/ruKMZcxKZi6va
 0xziavOSemf6CDLKaRlpM273/eyLwDh9t8qfqr6ORvcBetmVnIvQdcjW5b+EUo5E5bs6
 0Xk7+xIl7TMMj7XTmr9C1tsBJZ08D9gTavHpuCX3HhslS+tScmJ9BuAXF7azrhtODrUj
 pjrg==
X-Gm-Message-State: AOAM530g2l1miyw6hWUgW1AiXRaP4s0IJAuUpye01c9n1aA28b/pZSXj
 eNjhTCobAOnx+DLuiplPhe4/ZkFZfx1KqoZ+jGa0IM/SNA5N9Yoz1iVYcB9eZ6Lq0ULE2mjoRa0
 bW8FwBKFIWEcIlYU=
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr20486712wrt.67.1598530044133; 
 Thu, 27 Aug 2020 05:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwguSvprA0Yx/RiuO+41QL/KmE5DXl08XKmj7YWP+gR/4VqFuGUhTVaT+hSap7enzTdL6bm8Q==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr20486696wrt.67.1598530043944; 
 Thu, 27 Aug 2020 05:07:23 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id m1sm4174221wmc.28.2020.08.27.05.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 05:07:22 -0700 (PDT)
Date: Thu, 27 Aug 2020 08:07:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 3/8] amd_iommu: Use TYPE_AMD_IOMMU_PCI constant
Message-ID: <20200827080657-mutt-send-email-mst@kernel.org>
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-4-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826184334.4120620-4-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 02:43:29PM -0400, Eduardo Habkost wrote:
> This will make future conversion to use OBJECT_DECLARE* easier.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge with the rest of the patch.

> ---
>  hw/i386/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 087f601666..18411f1dec 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1622,7 +1622,7 @@ static const TypeInfo amdvi = {
>  };
>  
>  static const TypeInfo amdviPCI = {
> -    .name = "AMDVI-PCI",
> +    .name = TYPE_AMD_IOMMU_PCI,
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(AMDVIPCIState),
>      .interfaces = (InterfaceInfo[]) {
> -- 
> 2.26.2


