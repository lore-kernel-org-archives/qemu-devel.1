Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB41C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BB220723
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I13p8uw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BB220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxPz-0002An-9S
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxO1-0006d7-Lo
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:28:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxNz-0007oX-SU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593689290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/TrKNlxOU6seaS4tH1CrUjegFyYhUFRccpA01OeEqw=;
 b=I13p8uw0nPtRpm6MxwoKBQS3LvPWzmbtT2XAs7D7dQCZl11ZR/TkkXwT5jBPpiuIHzOUAn
 zjTKpb1hii8rR+9gCUXvehEDzNFQhcNEBs7IuOSmMlG0yq4dolXBT086UinaQ/FPdQjTTe
 v4Ule3CD3gBL5As0beJKTbbfoZBzhec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-NOrBtrYWMne29H4lRDKWkQ-1; Thu, 02 Jul 2020 07:28:09 -0400
X-MC-Unique: NOrBtrYWMne29H4lRDKWkQ-1
Received: by mail-wr1-f71.google.com with SMTP id j16so19850491wrw.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7/TrKNlxOU6seaS4tH1CrUjegFyYhUFRccpA01OeEqw=;
 b=IdK9yaMKpl+yQmBlIB3rpT7jGL/FLlhzfpBmjv61s48wuEIAslMPPAyFM/KeBM5H9D
 dX1/h6qw9ILmMWn7OUF0qOmHrBVL+hlKmYE5/eLBzjB1iO3d2D5ZbRgcdV+wRMdrxIt7
 ZdR/Jt5yKQlyy2y2b+M7dfttP6uOvG+5iFFLkgFCHLiI3uxLAJ354osnFBrIwOYII4aM
 rv0uyoqIdhWbGfs3Oq5eMIne3jWwxvw+uHzR32K8zakiEQI7pxy4hU3MNTCcwS1lzFXB
 8vwul9aonk8ik0ra6PVXJi2GOyBc+wof3ZGu9pHKCvD2GNugJwNWiDe64DFWhsI8mZwb
 3D5g==
X-Gm-Message-State: AOAM530RwoFqq5xmheS3SAOWXchTKtk7nuashYtXBCqnRrKomEmoNZgf
 6tlKJh8786XSZ7AcqoU9ER/LmTJ/zL58Ei8W0Iw5ldeeXCLCfQTKZAWlpfW7PLjVBjDSmLciGXW
 f/Ivlbec2mJfhQLc=
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr31730524wru.399.1593689288250; 
 Thu, 02 Jul 2020 04:28:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyckNeyTtCSP2ffKGv/S4CtCGrcVT1jD8kO9x+goiZxNPVg3GuLQkgpA4aX/mI3rG1zrGiNUg==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr31730501wru.399.1593689288029; 
 Thu, 02 Jul 2020 04:28:08 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id p4sm11072565wrx.63.2020.07.02.04.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:28:07 -0700 (PDT)
Date: Thu, 2 Jul 2020 07:28:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 0/5] VIRTIO-IOMMU probe request support and MSI bypass
 on ARM
Message-ID: <20200702072655-mutt-send-email-mst@kernel.org>
References: <20200629070404.10969-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629070404.10969-1-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 09:03:59AM +0200, Eric Auger wrote:
> By default the virtio-iommu translates MSI transactions. This
> behavior is inherited from ARM SMMU. However the virt machine
> code knows where the MSI doorbells are, so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest iommu subsystem will not need to map MSIs.
> This setup will simplify the VFIO integration.
> 
> In this series, the ITS or GICV2M doorbells are declared as
> HW MSI regions to be bypassed by the VIRTIO-IOMMU.
> 
> This also paves the way to the x86 integration where the MSI
> region, [0xFEE00000,0xFEEFFFFF], will be exposed by the q35
> machine.  However this will be handled in a separate series
> when not-DT support gets resolved.


virtio things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


ARM tree makes sense for this, right?


> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v5.0.0-virtio-iommu-msi-bypass-v7
> 
> History:
> 
> v6 -> v7:
> - fix the hint message
> - put the assert again on probe request
> 
> v5 -> v6:
> - do not hardcode start/end addresses of doorbells
> - check reserved region type on realize()
> 
> v4 -> v5:
> - Take into account some additional comments from Markus:
>   - reserved region type becomes an unsigned + some comment/desc
>     rewording
>   - assert if the type is not RESERVED or MSI
> 
> v3 -> v4:
> - collected Jean and markus's R-bs
> - tool into account all Markus' comments in [1/5] (except removal of
>   goto)
> - use ':' as delimitor instead of commas
> - add example in 4/5 commit message as suggested by Markus
> 
> v2 -> v3:
> - Introduce VIRT_MSI_CTRL_NONE in VirtMSIControllerType
> - do not fill the remainder of the probe buffer
> 
> v1 -> v2:
> - check which MSI controller is in use and advertise the
>   corresponding MSI doorbell
> - managed for both ITS and GICv2M
> - various fixes spotted by Peter and Jean-Philippe, see
>   individual logs
> 
> v1: Most of those patches were respinned from
>   [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
>   except the last one which is new
> 
> 
> Eric Auger (5):
>   qdev: Introduce DEFINE_PROP_RESERVED_REGION
>   virtio-iommu: Implement RESV_MEM probe request
>   virtio-iommu: Handle reserved regions in the translation process
>   virtio-iommu-pci: Add array of Interval properties
>   hw/arm/virt: Let the virtio-iommu bypass MSIs
> 
>  include/exec/memory.h            |   6 ++
>  include/hw/arm/virt.h            |   7 ++
>  include/hw/qdev-properties.h     |   3 +
>  include/hw/virtio/virtio-iommu.h |   2 +
>  include/qemu/typedefs.h          |   1 +
>  hw/arm/virt.c                    |  30 ++++++++
>  hw/core/qdev-properties.c        |  89 ++++++++++++++++++++++++
>  hw/virtio/virtio-iommu-pci.c     |  11 +++
>  hw/virtio/virtio-iommu.c         | 114 +++++++++++++++++++++++++++++--
>  hw/virtio/trace-events           |   1 +
>  10 files changed, 260 insertions(+), 4 deletions(-)
> 
> -- 
> 2.20.1


