Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE4C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A675206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPQ/dz4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A675206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT6IT-0002CP-Gh
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT6Fx-0007IJ-4r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT6Fw-0001Lw-Mu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:05:16 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT6Fh-0000nN-2I; Mon, 27 Apr 2020 12:05:01 -0400
Received: by mail-lj1-x241.google.com with SMTP id g4so18197352ljl.2;
 Mon, 27 Apr 2020 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SFy9ImzktZE2Epy0PJlBnUaywlV+F5c+rKkog0oIig4=;
 b=BPQ/dz4ZA7HaXSgtCd2XZ4R5nI9maR1g0q61DqeN3wmnaUVFsO4MT6Ww2Uqdosx44t
 vqOxI3wbPYyWemwITNYpQ8IsXnpYt04flTPAPmHSq9rM2X95QRMz5wSIRXgiKcy/GDfC
 Z57CKLaMF48V0adlcSi6tMCbCZO25fMlXSa0W3rxWYpHuX6ZnZ9uyFETjXZpVyCDdmNE
 IrStvGDq7DX12PtdbCNEGTcJojZg7ry8h9S0vaIfxhQXypLZTF4lIrxQFXiJg6TTERfq
 SleKOrSkHbj/nnngNIfITF5uEEwkcE58ilfXilm3OHdxXA47Zht4r7Oz/6iJ/oGYAeNl
 X9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SFy9ImzktZE2Epy0PJlBnUaywlV+F5c+rKkog0oIig4=;
 b=Fre+R4FHM9eH3UFeBlCMLF+9trnuEsqrN1jehEgoEezhsseZ95yjp7XPsmvCAAiNpl
 vTiVGBg2JgR1C2SQMwBcJa6AV1/GU7Dhm61u7yj12PygM85DkS2wnrRb1D4xs9dZMkTo
 9Ni6ECX8gC7br1eGl6nQXTUuXTp0Y3QSSEE/H2BDvbO+xK3YOO/kiSwY4sYHGeIkVJqh
 Em1Szp/W00sCicM5C/Q3uzef3TFVRxuXKDeEAlXdlfRlIhIOY5ot+5tszhlk7YsZ4h/T
 0K/ZFD7YVrpTodvjtP900VUtM6F0MHozp4l1rOUTqSLpT6EfkYp/f+BaNDvexkzu8jGB
 u0sg==
X-Gm-Message-State: AGi0Pua71l2kw42L7Me+zepz2QgaYxjB2tp6DrV85ufJ00qqRiG6W62g
 Jj+utrCxTjAffkGYYCNQnek=
X-Google-Smtp-Source: APiQypK9GsRuEz0Q3sIR3JX9f9kyZ4D5thjlxyK70ARMdwvhzr1ugpVlzTmHl0WqDl1nyOmJ//vFsg==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr7424743ljk.4.1588003498247;
 Mon, 27 Apr 2020 09:04:58 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b25sm9819691ljp.105.2020.04.27.09.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 09:04:57 -0700 (PDT)
Date: Mon, 27 Apr 2020 18:04:25 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] arm: Implement ARMv8.2-TTS2UXN
Message-ID: <20200427160425.GK2669@toto>
References: <20200330210400.11724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330210400.11724-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::241
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 10:03:56PM +0100, Peter Maydell wrote:
> This is obviously not 5.0 material, but I figured it would be better
> to push it out for review now rather than hang on to it and forget...
> 
> TTS2UXN is an ARMv8.2 extension which changes the 'XN' field in stage
> 2 translation table descriptors from just bit [54] to bits [54:53],
> allowing stage 2 to control execution permissions separately for EL0
> and EL1.
> 
> For QEMU this had the potential to be awkward, because it means that
> the stage 2 translation now depends on whether it's being used
> for an EL0 or an EL1 stage 1 access (the address doesn't change
> but the access permissions do). Fortunately, although we allocated
> a QEMU TLB/MMU index for Stage 2, we never actually look anything
> up in the TLB. So patch 1 turns ARMMMUIdx_Stage2 into a 'NOTLB'
> index (ie one without a QEMU TLB), thus avoiding the complication
> of splitting it into separate Stage2-for-EL0 and Stage2-for-EL1
> indexes. Once we've done that the actual implementation is pretty
> trivial -- we just need to plumb an extra 's1_is_el0' argument
> into get_phys_addr_lpae(), and then use it to decide what to do.

Hi Peter,

The whole series looks good to me:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar



> 
> Peter Maydell (4):
>   target/arm: Don't use a TLB for ARMMMUIdx_Stage2
>   target/arm: Use enum constant in get_phys_addr_lpae() call
>   target/arm: Add new 's1_is_el0' argument to get_phys_addr_lpae()
>   target/arm: Implement ARMv8.2-TTS2UXN
> 
>  target/arm/cpu-param.h |   2 +-
>  target/arm/cpu.h       |  36 ++++++--
>  target/arm/cpu.c       |   1 +
>  target/arm/cpu64.c     |   2 +
>  target/arm/helper.c    | 183 ++++++++++++++++-------------------------
>  5 files changed, 107 insertions(+), 117 deletions(-)
> 
> -- 
> 2.20.1
> 
> 

