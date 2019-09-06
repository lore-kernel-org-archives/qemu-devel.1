Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCED214DE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPd9ijRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCED214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6GYK-0007lJ-Hx
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6GXD-000773-Uh
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6GXC-0001mF-JD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:52:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6GXC-0001lg-Cn
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:52:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id o184so7638822wme.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=g9fR9xI4q1l87jm0NN/kPxBQzWqYFtjJ8dDkexskJT4=;
 b=GPd9ijRjJkxpwilZRROE84i0laycN3ucyRpsDQQpeU/34Gk9dsU5M15+y6JJAsfU+Y
 d+tC0hUuLmSNxDQXKq9K4oouirhgwJ/8agxBF0IXZNJvcfI7T0OjAr/+tPpBXCgkbwAd
 y5sa/yVl2OtJ6wvXuGFGaBagIU98xywdpxRTyAuE5WBESsxINSCCKp2uTKRaN1eB1q7x
 OqUZpUs8vYRR/FO0eKMhyzqYB9hOkGfYJRmJm2cw944+SCP6TO6ET9jNp+DHRTBGt//F
 tG7KVlbpRBva0jhnzDeEQx6cjtXJYTBmMLheZ4zsCU3Gj4IPvpVG2omsw1ru+jXr4Mxt
 AQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=g9fR9xI4q1l87jm0NN/kPxBQzWqYFtjJ8dDkexskJT4=;
 b=da4Vztjaf/0ir0FodPCQYJhjmz2xR3h04su5CvjtuE2RrF5Dhq10reYMIrmd9p4n5V
 gnDXwdWw72mrV8wXGD/QOiMtGZgnYjrdryxo0fRjbM3BwYcHItwBzwvTPHX8ignGNBxv
 29a1U39MpXXCmauw+B+UPMRHP1Yogm6jpgm/BGs1em9H8MM4C4iUjsdgpB/A+VAeo7TJ
 uimvPilqTkqxR4EmJKWiAErN/44F2WaJvDxz8XvR7p88H1Vwe5Iu/TeSpvwUyEIddhv9
 CwNBHm2J+xQGqP78VzG9Odkc3qTpDWNIK7M03hTzLBhCx0xJbsquxKGFFclWLb/a7bop
 H5Kg==
X-Gm-Message-State: APjAAAXekKykYL8hdbOMeHPZSCXsImyV3A+OakcsWecDhMU0oIOooKdl
 CAmmuAXnNddg+h4DxRC1KW7D7A==
X-Google-Smtp-Source: APXvYqyFJ+3jARS1LlpMt8hosYmFhtIVDGJDf6dlGyM42CUg+Mje5tkkhgCnz3lMe0oOPbtrLQahKA==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr7538987wmk.129.1567785145035; 
 Fri, 06 Sep 2019 08:52:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm9987801wmf.38.2019.09.06.08.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 08:52:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C1FF1FF87;
 Fri,  6 Sep 2019 16:52:23 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-3-richard.henderson@linaro.org>
 <875zm692za.fsf@linaro.org>
 <f8112d1c-49f4-9e90-bbc2-280d91e8d8fc@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <f8112d1c-49f4-9e90-bbc2-280d91e8d8fc@linaro.org>
Date: Fri, 06 Sep 2019 16:52:23 +0100
Message-ID: <878sr1zako.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 02/17] target/arm: Split out
 rebuild_hflags_a64
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/5/19 11:28 AM, Alex Benn=C3=A9e wrote:
>>> -
>>> -        if (cpu_isar_feature(aa64_bti, cpu)) {
>>> -            /* Note that SCTLR_EL[23].BT =3D=3D SCTLR_BT1.  */
>>> -            if (sctlr & (current_el =3D=3D 0 ? SCTLR_BT0 : SCTLR_BT1))=
 {
>>> -                flags =3D FIELD_DP32(flags, TBFLAG_A64, BT, 1);
>>> -            }
>>> +        flags =3D rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
>>> +        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>>>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>>
>> It seems off to only hoist part of the BTI flag check into the helper,
>> was it just missed or is there a reason? If so it could probably do with
>> an additional comment.
>
> The part of the bti stuff that is hoisted is solely based on system regis=
ters.
>  The BTYPE field is in PSTATE and is a very different kind of animal -- in
> particular, it is not set by MSR.
>
> But also, comments in cpu.h say which fields are (not) cached in hflags, =
and
> BTYPE is so documented.
>
> Is your proposed comment really helpful here going forward, or do you just
> think it's weird reviewing this patch, since not all BTI is treated the s=
ame
> after the patch?

It was just weird seeing the isar_feature test twice. A mention in the
commit "not all bti related flags will be cached so we have to test the
feature twice" or something like that will suffice.

>
>
> r~


--
Alex Benn=C3=A9e

