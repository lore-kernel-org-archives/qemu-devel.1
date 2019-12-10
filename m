Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48640C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBDC2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cP2GPmuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBDC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieile-00039z-LF
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieifm-0006D6-2G
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieifj-0005Va-Tu
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieifj-0005VI-Nu
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so20786751wrl.13
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LtrQYfJdcTkOs3pftjkEUGXoyOJMbtVXOFWCdr+C1OY=;
 b=cP2GPmuVUE7UNfgpHtT+qtVlOHHLBBq2Wn4i+ghjaISiVk6S3tjqIKxoKxPLmkPUtf
 H/IVjd6DInMah9YbnLyHRTnJA/DH67iu952gCAgOO8294jdcLuN7fpsCYQZnOkLvKuNJ
 I8jTkqA0QeFh6E5nVECXnK60JrlTeUA9suaRTGiAkNLItgQol/FnQl1DkSoRgd89Yldo
 JfCh1q4Jb6h+s0YDQ9I932jkgYq2adIaX44hVUYOFqdS55IOlJXL+4TN7+rVs7nG14ER
 SVBMc7uWbAS50tQO2qPMg/cHrdWK10MCNa8ASNGESX3ocFmq3dxAtE2lqsemgUWBeYFP
 0KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LtrQYfJdcTkOs3pftjkEUGXoyOJMbtVXOFWCdr+C1OY=;
 b=OJblCM+76IZ4+w+pfrKaFbH74tjfEJ47+n+6TTQdIcslVjzYrlvIfz6go+yDa5HFgV
 Z7mxp9iB9aFHFh8l1/ws1rsi9mWF8bn3c0HgAt3oNufM3DOobvl87iGCBR36yb9md4/Y
 lS7YIKL5k6ZIg9HIBPJIH5Q3j3G5SWBAqAihp5f6Iy48X/AaOy0QLSAa8UmV60EEqbtf
 MDbQwGyfDA53k1LweHVlK2eHOrDoUm/aSQOTuZOLlN6Z4UiO+W4f8j7i044QiP4cXMK0
 9+dm/89zx97WgDPaeZukXKN4RG9A17OsKfuA5zzg0rvFqlESlqYT4nG6GqDDopWgSpWI
 OrRg==
X-Gm-Message-State: APjAAAW4KLCQRHpDG+lWtelU1qudyUSuQcOQMoVRhEY3HMHBiL+r0q3O
 SguzQ8CAqlVWI3rtV9coY9dcag==
X-Google-Smtp-Source: APXvYqzQ0vFombUSzUKCftQxtoWRZFhDtjVyKt3Qfkgpt/nAIWLb5hKleceMyatefZMevhl7+p1Ndg==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr4248392wra.8.1575996458872;
 Tue, 10 Dec 2019 08:47:38 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id v3sm3759098wru.32.2019.12.10.08.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:47:38 -0800 (PST)
Date: Tue, 10 Dec 2019 17:47:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 16/20] hw/arm/virt-acpi-build: Introduce
 fill_iort_idmap helper
Message-ID: <20191210164733.GN277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-17-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-17-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:39PM +0100, Eric Auger wrote:
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> @@ -426,13 +437,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          smmu->gerr_gsiv = cpu_to_le32(irq + 2);
>          smmu->sync_gsiv = cpu_to_le32(irq + 3);
>  
> -        /* Identity RID mapping covering the whole input RID range */
> -        idmap = &smmu->id_mapping_array[0];
> -        idmap->input_base = 0;
> -        idmap->id_count = cpu_to_le32(0xFFFF);
> -        idmap->output_base = 0;
> -        /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference = cpu_to_le32(iort_node_offset);
> +        /*
> +         * Identity RID mapping covering the whole input RID range.
> +         * The output IORT node is the ITS group node (the first node).
> +         */
> +        fill_iort_idmap(smmu->id_mapping_array, 0, 0, 0xffff, 0,

nit: the other calls use uppercase hex digits

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

