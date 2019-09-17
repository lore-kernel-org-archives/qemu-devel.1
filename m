Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE578C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9CF20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3Sp0sRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9CF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAKdm-0005qs-KT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAKae-0003pC-Hj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAKad-0003SC-45
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:00:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAKac-0003Rk-Tj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:00:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so4572833wrm.12
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LGy2cn9zLDHoNaJvOgkuVbYy/cSRwtirZsI1/TGsB2M=;
 b=b3Sp0sRw3s4dK8/BOSaQ1Q7hNXB3t1F9Iw/EVkJ20dyM6e7WfYkgbxRgZo0JJCrsom
 sOmwyXtC1+VitCPfeOz58wRrLNBcA5k93056HCSMd2wSO96AjnqzNPlCSjh0ObZdvltk
 EKVAyLIkGVT0v9f6T6fnQ3X4GFW+XCmQhxtt/YOX1Gd4kFGE9LwoxkPwEa5no5eod9Ob
 CSda7m51/vtKcbtgGOuJhBCD2GlcCbTA2Jrm45R2Bye31q0Z59RUNmt+KebXP598AkRO
 S2P5UNEt0/bCB3p0gG9I7tbTYHAvD3LVXL6+OIo7IoBHHmg8lIyqem6cKR9ecdPIZUYu
 dZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LGy2cn9zLDHoNaJvOgkuVbYy/cSRwtirZsI1/TGsB2M=;
 b=bDuy+FfG1GAQYP+BqgyMKoOWToi/XGhHXGkvzZ1eMli2GYRa2xgrXQZ+DoCX+JSGlF
 LfnGa4EXO+/ttsl+xuBFIhLWI+B0y2qNCN6NiYPY2NahqDj+0yYegIOUNlkUqiE4Ie3D
 D7be4bMTOpzSQO1Yw44W+C/yT1J7gAMewJSKFbu8jtFV5Bp95nc7K9SRrpW10x52VZUS
 kpDX3vlDedfOaNAnnSJfp1f7YlATR6rfI3utr7iuXwOpf+GqM01D8Hbqa28u0uceK44z
 yhQb3VAuvW1je9hQiZ+wLhKOOSYlPqVFsHTxvRCmecBgcK3eZTRMOyShzr6sYyHHjQti
 yNTA==
X-Gm-Message-State: APjAAAUnaOmaBvCBJGk2l2b31yZXuYhOMksBZgvWDqC246vr4LgREfhu
 lSGTrMuU4GlHbZrA3kgy/kIjHw==
X-Google-Smtp-Source: APXvYqze7iyOuzXW7xvPIUvKU2B9U52vCsizQTAVMaLTVT0yPx+a1Ld5ST03c2O0wpxQi8cm2coEVg==
X-Received: by 2002:adf:e951:: with SMTP id m17mr409233wrn.154.1568754045622; 
 Tue, 17 Sep 2019 14:00:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm5207408wrh.5.2019.09.17.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 14:00:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7AAFC1FF87;
 Tue, 17 Sep 2019 22:00:44 +0100 (BST)
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-8-alex.bennee@linaro.org>
 <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org>
Date: Tue, 17 Sep 2019 22:00:44 +0100
Message-ID: <877e661vur.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 7/9] tests/tcg: add float_madds test to
 multiarch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/17/19 2:41 PM, Alex Benn=C3=A9e wrote:
>> +    /* From https://bugs.launchpad.net/qemu/+bug/1841491 */
>> +    add_f32_const(0x1.ffffffffffffcp-1022);
>> +    add_f32_const(0x1.0000000000001p-1);
>> +    add_f32_const(0x0.0000000000001p-1022);
>
> These three constants do not fit in float32.
>
>> +    add_f32_const(0x8p-152);
>> +    add_f32_const(0x8p-152);
>> +    add_f32_const(0x8p-152);
>
> Why are you adding 3 of the same?

To replicate the 1841491 test case where the same number is used for
a/b/c
>
>> +        for (j =3D 0; j < nums; j++) {
>> +            for (k =3D 0; k < 3; k++) {
>> +                a =3D get_f32(j + ((k)%3));
>> +                b =3D get_f32(j + ((k+1)%3));
>> +                c =3D get_f32(j + ((k+2)%3));
>
> How does this not overflow nums?
> There does not appear to be an assert on overflow in get_f<N>.

get_f<N> wraps the index with a mod op.

>
>> +#if defined(__arm__)
>> +                r =3D __builtin_fmaf(a, b, c);
>> +#else
>> +                r =3D __builtin_fmaf(a, b, c);
>> +#endif
>
> Eh?

Ahh I was going to hardcode the arm madd instruction in as the builtin
wasn't expanding. I tried setting -march in the CFLAGS but that didn't
trigger it either on my buster arm-hf compiler. Any ideas how to get the
compiler to do the right thing?

>
>> +/* Number of constants in each table */
>> +int get_num_f16();
>> +int get_num_f32();
>> +int get_num_f64();
>
> This is not c++; you want (void) to indicate no arguments.

ok.

>
>
> r~


--
Alex Benn=C3=A9e

