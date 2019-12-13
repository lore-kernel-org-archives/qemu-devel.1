Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07152C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7574024679
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgTJOpCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7574024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiub-0003fL-8k
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifitn-00034z-9T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifitm-0004ck-0H
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:14:18 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifitl-0004Yz-Nl
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:14:17 -0500
Received: by mail-wm1-x341.google.com with SMTP id d5so6125374wmb.4
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hxzgsq+yoFWLY6k0DD0wP6nI9bTxnJN1dRCOWQVkrK0=;
 b=BgTJOpCebewKLqe9enw6uhmA0XyVQnUye0qMxIkMmaDehtRJJRpJsI8QLtb58lmXtb
 8XgEbysRYDuqm3TC/KZmxX9Bqlr14yKSUInInh+TnsVe4ugKK3axa0XSSG2xyCkytuN9
 Mc2OaJ0zdvna2Mb4sJa48LKnh4vWrWWfSoYYpU2j5iBkndXEZP0hbp6qhBTLtlVBoBp7
 4yjKCd/v+kU45eTnJhvXiwDuWuRUWBMnCbB5Ytl1IIGPDDI+/oB3FxNDURjGlSDlmxAg
 /255CqeEhVWoIn0FYsB45kue0cqsqvIRWAcXJOxv07HecGRlBVVEI/ocg8yD/zGMSyHR
 yyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hxzgsq+yoFWLY6k0DD0wP6nI9bTxnJN1dRCOWQVkrK0=;
 b=WD4Op31sAzdFx9hFZG3RNc7ZSNkLQio5lXIiLRS/egrrCc1LXZVzQAY7l4axdBuCt9
 jvd1aleOtOcFU7wJPRLI54GamQJDT+MeF2nnDg5MsDik4U3sfTsl5tyWxvhvzesg7ttb
 1UXcXdot/s95fWwO8uGc4i8Pff/r3Ym41Lg3aG9YUu/Df5M2P70RFuABXU8eqokhVvU4
 4LtVcrTnC/NEhUTujxxH4E8Us+dqGv0gP0QvMkD2OC68FlxU8rl7lk3HMtsP6s89ukci
 /V/aCmo9EydRCsi9MSodToIAcEC49yTeX5CKh5AReQHUL26CWzlPZmmNlbopOVsAWFfZ
 93bA==
X-Gm-Message-State: APjAAAW40C6U6LEKjH8b9lWwb/FGuo4jBmWgiBf+kpuSXnsfKaIQEI9d
 Kom0oJG0ntHX4Nsf1SHm2FtHuQ==
X-Google-Smtp-Source: APXvYqz6O5fjv8v0FtdUujoKnvG5On6b9KIn2j8/87hCDrZlkT+MGLZFKomTRJDnwPU9TaisO6nnXw==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr12094421wmi.166.1576235655651; 
 Fri, 13 Dec 2019 03:14:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm9738612wrt.82.2019.12.13.03.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 03:14:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E5A11FF87;
 Fri, 13 Dec 2019 11:14:13 +0000 (GMT)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-2-alex.bennee@linaro.org>
 <ca3b67ec-8cf7-26f3-5cfe-7a330e11571e@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 01/13] accel/tcg: introduce TBStatistics structure
In-reply-to: <ca3b67ec-8cf7-26f3-5cfe-7a330e11571e@linaro.org>
Date: Fri, 13 Dec 2019 11:14:13 +0000
Message-ID: <87blscbhq2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>=20
>> To store statistics for each TB, we created a TBStatistics structure
>> which is linked with the TBs. TBStatistics can stay alive after
>> tb_flush and be relinked to a regenerated TB. So the statistics can
>> be accumulated even through flushes.
>>=20
>> The goal is to have all present and future qemu/tcg statistics and
>> meta-data stored in this new structure.
>>=20
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-2-vandersonmr2@gmail.com>
>> [AJB: fix git author, review comments]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> AJB
>>   - move tcg_collect_tb_stats inside tb-stats.c
>>   - add spdx header
>>   - drop tb from tbstats and associated functions
>> ---
>
> The only quibble I have is with
>
>> +void init_tb_stats_htable_if_not(void);
>
> If not what?
>
> I can only imagine that this phrase is intended to finish "if not initial=
ized".
>  But I think it's clearer to just call this "init_tb_stats_htable".

Fixed.

>
>> +void enable_collect_tb_stats(void)
>> +{
>> +    init_tb_stats_htable_if_not();
>
> Why do we need to do this again, since we did this in tb_htable_init?

This is the route if we dynamically enable tb-stats with an already
running system emulation.

--=20
Alex Benn=C3=A9e

