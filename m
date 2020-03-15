Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47640C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0933F206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOS0p3lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0933F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDN61-0005Jr-5g
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 02:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDN4p-0004pP-1u
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDN4n-0003GO-Iy
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:48:46 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDN4n-0003Ds-Ar
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:48:45 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so6353139plk.7
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H2xdeREEFOV9KzA37pmW7TUq9y/bfXSHkRJvNdSM2TE=;
 b=MOS0p3lxuAVDpk259/tBq4N4bpmuHIdTWHUkPm8ql8vvMYpn80LS4ii2fzB2IXv46j
 VWCANacFi4HUbhftTxW5yho+VWkPtXlYLZLwL/0twITF58Afpso3Qcl1eWiHoKVaU7pw
 SPECJSe9W301ps2P5A7DIGwsQ8d3heQoa5PAAso8fw6aRbTfyLzgNJawuPIXc9WLugyr
 bEZJ0TNSS7EDpUIicbVNMMmzcy/79thF34PeYaBiYLBceCGhFxlCBJz1rbsAyNMNZPrF
 1XPZUTWDsUdR85sxBkgTU/s1TKFusAB6wPlJf0xWCi3zHyyPep1hVcDsJYdDKNCdbgl+
 HiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H2xdeREEFOV9KzA37pmW7TUq9y/bfXSHkRJvNdSM2TE=;
 b=gGCEWCj4Az1y1xY+yDNr+fEQjzAha9aT1ieA4g3tn94Yplm1T4s+XIsKLxIqMguj0+
 uLag+/lGZbIXitZmGZ/XwEFEAwjUhClfL/lszHOq5uDiIS3qjtgJi8pxpBXirT63+R/r
 ldfnHJ4L3QfrT4LvGU4XD0qXUSS0nXBb5KeOiZW2QG5eO+LANtEs29xOEa2ev+UezC6T
 2rMVI64zy5O4fwZ1i23wyhGlr+iAlPY7RaRCJfRbkVyaXSkYIw6R6uInAv5P0G+yn5kZ
 ClmWdJ82hiioPrNthP5Pog2e8ShSggAXhq2QvXNybYyGBh8gxGnCyEGTl7aLCr7OhtKt
 yl2Q==
X-Gm-Message-State: ANhLgQ0UXmD/uR/JyV2qRmLqPXwyIizN7znS6/gdaODaODJpxFyjxcEL
 HozG8VEGtUDIiqMyBE3hgMkYjQ==
X-Google-Smtp-Source: ADFU+vuybhkSKNVnxyiH//mqK5U30H22lH5PXlG6KojDjLkpMQNxLa0FFhtiNqlLwGNZB4kD76EvuA==
X-Received: by 2002:a17:90a:3208:: with SMTP id
 k8mr19043124pjb.161.1584254923958; 
 Sat, 14 Mar 2020 23:48:43 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f127sm64188191pfa.112.2020.03.14.23.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 23:48:43 -0700 (PDT)
Subject: Re: [PATCH v5 56/60] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-57-zhiwei_liu@c-sky.com>
 <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
 <04119654-2741-5bdb-a764-457dbc04161d@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <34b03380-fa6b-f0fa-0af1-a8b2abf787b0@linaro.org>
Date: Sat, 14 Mar 2020 23:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <04119654-2741-5bdb-a764-457dbc04161d@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 11:13 PM, LIU Zhiwei wrote:
>> SEW == MO_8 should raise illegal instruction exception.
> I agree. But I didn't find a reference in Section 17.3 both in v0.7.1 and v0.8.
> 
> Perhaps I should refer
> 
> "If the current SEW does not correspond to a supported IEEE floating-point
> type, an illegal instruction exception is raised."(Section 14)

Yes, that's the rule I was thinking of.

>> Missing nan-boxing for SEW==MO_64 && FLEN==32 (!RVD).  Which I think should be
>> done here inline, so that the uint64_t passed to the helper is always correct.
> I think all float registers have been NAN-boxed in QEMU target/riscv.
> 
> As float registers are  always 64bits.  If FLEN is 32, a float register has
> been NAN-boxed in FLW or VFMV.F.S
> 
> Should I NAN-boxed the float register explicitly here ?

Hmm, I see what you mean -- RVF is supposed to have already boxed all of the
values.  Except that it doesn't at the moment.  I remember now that we were
talking about this some months ago; I thought it had been taken care of, but
hasn't.

I think we should explicitly do it here, with a comment.


r~

