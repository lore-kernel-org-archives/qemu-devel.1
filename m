Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB272080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeWICpaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB272080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPDB-0001ow-2P
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPCK-0001J0-BI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:12:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPCI-00060L-F8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:12:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id h12so4239164pgm.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9lzToOPWYMpNXxltVDhvTXL7wLedAnfdkTvlLAmCJis=;
 b=oeWICpaUW2tRjWv19wiklVLQwgBpg/fQGIfj4hBLyJRPrDMCbS+Nnki/OJagIGC5e3
 H+o/5PudgFS8UUr7j9a44aGGlDDFI0faTelqGmo5du8NKs1ONgYgyydhPh/46+b4zy2B
 HjslqsC0tkXJCakd19J6WPP48SYS/Q6/IvKlASkZSYrydH8RmCrPyGjDk315eQXxILDD
 LU3Il9SFf64Kv4osLa81zlDRn6ZDB3Ni9Z3XMzcW9YXFW6KOaF+TVbV3gh0JqQdrqxVE
 O+RrdqsAxX0SmkYkAb6zYSkPudW6TaAPAQYMyAU4+5xp3FjD2Czk6D0zRlLnBq7Dxx2R
 riwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9lzToOPWYMpNXxltVDhvTXL7wLedAnfdkTvlLAmCJis=;
 b=OsxbjGmJWQ0eh/e/5BYaTFu8XnT9f3YIUFrSwDbzWypiS0SN1vBwzREklwcY3cptJT
 9Luj5n5D4yM3z5jrlFRaLiONoV742aGipVdrA5aN/CdWkchbG/PEC/vEhHjA5QgaluWW
 mkKFBQihYqv28g5+T8Nk3Fi8gFXGT+PEvKK9rzb9saHnQdZwk16XyeuICQJcia+zCivW
 EADtiyzCH0vDqXRMVCpS/Eb9NmeR5gcnaq2Guut69TjQw500y4TclAaEobjjlDND4PPZ
 QboVocPJ6igw/0zjX8PQ3B+x0HM/rYt19/fhe1CKBgh5iXu4ivOyfWOeAGuKzK0oBaVc
 M0Xg==
X-Gm-Message-State: AOAM5314HnyfWm0mCkneP57kMsjdaNdTxNRNAAXFFMjj6Dwd7qj5Fk5j
 Pme619SBnOp2rMl/YeRez6v7WzVecGwPTw==
X-Google-Smtp-Source: ABdhPJyEhVAUIUDUIYtFNyXVntCr3ItA7PnjEU/WtO0QJa3BI72VsQeF+5Gq7w4g8Vm0g/vKT9RgTA==
X-Received: by 2002:a62:a10f:: with SMTP id b15mr18257759pff.253.1598562756078; 
 Thu, 27 Aug 2020 14:12:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d13sm3742832pfq.118.2020.08.27.14.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 14:12:35 -0700 (PDT)
Subject: Re: [PATCH 00/20] target/arm: SVE2 preparatory patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <CAFEAcA8OfO_XxNG9KRHVgM501cu-ERVXXwVSMqcNhySA1QMrqA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fee9487d-1df2-a0de-c038-2cead6a1e917@linaro.org>
Date: Thu, 27 Aug 2020 14:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OfO_XxNG9KRHVgM501cu-ERVXXwVSMqcNhySA1QMrqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 11:28 AM, Peter Maydell wrote:
> On Sat, 15 Aug 2020 at 02:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> This is collection of cleanups and changes that are required by
>> SVE2, but do not directly implement it.  The final 3 patches are
>> relevant to Peter's aa32 neon work.
> 
> If you agree with me about my suggested bugfix (s/=/+=/) in patch 14,
> I can take the reviewed patches (1-14,18-20) into target-arm.next
> (which will be useful for me as I need 14,18-20 for my neon work).

Yes, please.  If once done you'll push to your target-arm.next, I can rebase
the rest of the patches on that.


r~

