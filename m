Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F89C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B259620658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uS7dXGL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B259620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWSB-0001kV-Re
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWRd-0001LB-6L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWRb-0006w5-Sb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:46:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyWRb-0006rb-L1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:46:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id z9so4376935wrs.10
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 23:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dgKsRA5jQBRxwi25ZiUm8TJnhsDyQNaGAYSKvwPVKxA=;
 b=uS7dXGL+5wEudmZIFobUjH5VkYx+qvs25Q/R1BWrI0LnVhH+ql9BgsPApI9KZFhCMX
 HgkRgQlUbNpVLx3hXBKIcP/dZNitL3zp9kuB+wxQWXFFpBWjXphHbtAxMfM0fNQ/7I7S
 ojbN3cl3zMMlFT+PtLrNaLgatockfuK32dx0bUM/bMuuy5eb9m3286W/XLvkO2cu5bF0
 fF1uKsie8JNukI7GDgMra3+OBLnuHjDZjy+P5t5pm/B+PNE5XkG28GM/2/A24KnepWxK
 Ul8TjbJo3o7N7c4g68nwpp7sXGk6tE+/F2WDQiCVa4BW6Ec3hz4U0dskqtKmGQOCqCFc
 Ueow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgKsRA5jQBRxwi25ZiUm8TJnhsDyQNaGAYSKvwPVKxA=;
 b=SpUG5AdxqiwaUnUk5jRn0yZR7BihLk5Oxd/y08qhpWbXQOJUkOeNKe8geT1/g0iZoL
 bYjevYfScr1WpF3aneQx7bWpJQHbJ6+Ls1Ge/6OtLFSNbAGjOeWjJ3elEG4Vz/d81uWj
 mUmgi6wA2xmXRCwHahRiQRaUbVx63J7f5bze4yMpWKpIKY4reQmfq6WcoQCa3JMl3Ol5
 iDfbQESX/YzZLo51iNyXdLTCUTQwQ8diVP38EWtzJQH2aBO5QQGZ6KF8fpu4HdVaj/Gb
 nav9F51CID8R+Ct0a7kPk/EYe4JTEUq+6NVYId3c7Rqa1uG1aaEKaFn4HEYZ+ysUjf5I
 FFGQ==
X-Gm-Message-State: APjAAAV2K9CvRXTiTrNdg/peW315gJNm7easIcgo7qwdN1F8gw4dmNzI
 ImRQPQL2j9ho+F+66BySs23X6b45ebYp1g==
X-Google-Smtp-Source: APXvYqzWVMHarK+dbpVknQZIDlUdOk0/zVn7TdxuFYobxJyzEewoluHElvGsRMW4Xv5P+vR6rfYWLQ==
X-Received: by 2002:adf:b310:: with SMTP id j16mr13797458wrd.361.1580716013915; 
 Sun, 02 Feb 2020 23:46:53 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id y20sm22936456wmj.23.2020.02.02.23.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2020 23:46:53 -0800 (PST)
Subject: Re: [PATCH 2/4] target/arm: Update MSR access to UAO
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-3-richard.henderson@linaro.org>
 <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
 <2871294a-0577-9390-1887-a2e81c1a35e6@linaro.org>
 <CAFEAcA8tkhpHAM2niDmpm=Oi4XQDTNTzKUJ_A-hKFLXsz_rPxw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81d05d7b-7bee-ac3a-3804-f35f8a9f4eff@linaro.org>
Date: Mon, 3 Feb 2020 07:46:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8tkhpHAM2niDmpm=Oi4XQDTNTzKUJ_A-hKFLXsz_rPxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/2/20 1:29 PM, Peter Maydell wrote:
> Yes, but SPSR_ELx isn't started with a clean zero and built up
> the way the new PSTATE is, it gets copied from the AArch32 CPSR
> via cpsr_read(). I forget how carefully we keep the guest from setting
> CPSR bits that aren't really valid for the CPU...

We do an ok job, except...

>> Well, there is no CPSR UAO bit, so there's no aarch32 bit to clear.  But I did
>> add a clearing of PSTATE UAO on the exception return to aarch64 path, to
>> prevent the guest from playing games with SPSR.
> 
> ...for instance on the aarch64->aarch32 exception return path,

... here.

> I don't think we sanitize the SPSR bits, so the guest could use
> a 64->32 exception return to set a bogus CPSR.UAO bit and
> then enter from 32 to 64 and see SPSR_ELx.UAO set when
> it should not be, unless we sanitize either in all places where
> we let the guest set CPSR bits (including 64->32 return), or
> we sanitize on 32->64 entry.

There is no CPSR.UAO bit, so this chain of logic doesn't hold for that specific
instance.  But plausibly so for CPSR.PAN.

We do sanitize all of the places where CPSR/PSTATE is explicitly set.  I think
we've covered all but one of the exception return paths, sanitizing the
SPSR_ELx values.

We could move some of this logic to internals.h so that it could be shared
between CPSR and exception return.  I'll think about that for v3.


r~

