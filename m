Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC765C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B847B20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cq5oSMRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B847B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aFW-0005b7-Rg
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aEZ-0004kM-0x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aEX-0007i5-8j
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:26:06 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aEV-0007e6-9Z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:26:03 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so6169057pgi.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pbVS14weyRBfRKZk0C8oEHtPLLyHkDt0WAt2KTAXFR0=;
 b=cq5oSMRM/HFXn3zF0CFc6qMNMrUbsfKpNwLA7GnbHzMIUNuBkzX9NYknfj7bvcWObH
 l8RCA4GzrX63vfSCSO1ZWPc9naYJ9R1ITOwp1HHKMM1lQ8rwla691V2vsE65/VjEuSLm
 DsP7d8P49PQed2Sh86edmzN8dxikOX+tEVlU/TltLKmulBRak6s4rg1mZML2/tfFXDNI
 3hfcHdwLbz+d7RVbJ/dZUH09bEFtMHmnjScAQ8dY9zDCHiutpNOxHZASUA6JOzZLHV5U
 QDcRnT8GVFACkYJ2HRpinMUArgzsWaf2qPt61ipAnt/51EdRnOLr/ZHcszIY5ca4b4XZ
 egCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pbVS14weyRBfRKZk0C8oEHtPLLyHkDt0WAt2KTAXFR0=;
 b=JCMWzzFbiK8Q/AvzVReEi7wL//H6ahVfBYYsAU0mBxPpYsgaBugK7P43iYmkG/o2NH
 FQSIaWeYufSh0hiZUXQ5yJSlCAR+zOGAB5FBnKtLIVMa0IrY/s0G8PPuvZMBSU3x1U+M
 KPylMfcqy0xOPeZSn4v2X7yaTZ/oqBnhhpDsWsj7in6DleeSyPil6tYm2qbHW7/tx80y
 vopiigYTC2JTQlg3/Vy0MPv+ufr4P1reK3aPcnnGYijpFmG9tS6alOK/0CUMlrtzpYef
 pc52sRjWWQgOdUTfuwcgUTwonMoWqyEW40QyGaig8BEd0K63d0zjIds5wVIYVR6xNtfL
 oxWg==
X-Gm-Message-State: APjAAAXXaCKOjErSkjdlo3DEY8VU34BrLYDh+/YclTqBd/FSKa+VgxXO
 sVNoaJFpV0yeECttpQPdRCESIw==
X-Google-Smtp-Source: APXvYqyqXhINoHganN6FLNR7wvvGkGlyLKnLicTipLI4tiityifEmyIQziJ879mE+zKR7hJXV74maA==
X-Received: by 2002:a63:7558:: with SMTP id f24mr8067131pgn.259.1581445562156; 
 Tue, 11 Feb 2020 10:26:02 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d3sm4929725pfn.113.2020.02.11.10.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:26:01 -0800 (PST)
Subject: Re: [PATCH 01/13] target/arm: Add _aa32_ to isar_feature functions
 testing 32-bit ID registers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1cb2368b-4e72-cea5-d3fd-170d15c11c88@linaro.org>
Date: Tue, 11 Feb 2020 10:25:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> Enforce a convention that an isar_feature function that tests a
> 32-bit ID register always has _aa32_ in its name, and one that
> tests a 64-bit ID register always has _aa64_ in its name.
> We already follow this except for three cases: thumb_div,
> arm_div and jazelle, which all need _aa32_ adding.
> 
> (As noted in the comment, isar_feature_aa32_fp16_arith()
> is an exception in that it currently tests ID_AA64PFR0_EL1,
> but will switch to MVFR1 once we've properly implemented
> FP16 for AArch32.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 13 ++++++++++---
>  linux-user/elfload.c   |  4 ++--
>  target/arm/cpu.c       |  6 ++++--
>  target/arm/helper.c    |  2 +-
>  target/arm/translate.c |  6 +++---
>  5 files changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


