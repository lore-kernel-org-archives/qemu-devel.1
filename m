Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C7C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D98B2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLIYeiYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D98B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXKn-0007Fl-Nw
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icWxq-00036c-Sl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icWxp-0003Fu-Hu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:18 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icWxm-0003ES-MT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:17 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so4578503wre.10
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zJ5VltuwF9J0WFbKN94Y1Ob9y4zVLqrewOvo2Uo7DFE=;
 b=QLIYeiYU6r/iXOiX2fkrEUQteqElWKBaumULHaB3iKUkey25qnA1GhjLfjR1wDEQP1
 hx8fZq/EibeStySdPBj7YshpknIS8X9YIPeAsKXdtdHGHgprzL7pVTq5dVIgz1jB1LMh
 IlmgQBG/GNUIn4EMSxbw9bZspQqcR9frXKLSsraYZUPZiPEbopab2P7ufaRjjuKgU0FI
 poGRW5o1Eq9mtgO+JrFqxsOePGtMqSyg/0m+Q4Uy7dnGN7UdjEGoeNOn8NL4F2oZMPWK
 jByK4Cw9VOFbEW8ZA9zctiDqwYLZUooa6KcMMDvG6kY02p7Cdq0tNcGIifr7MqIRqhXU
 tCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zJ5VltuwF9J0WFbKN94Y1Ob9y4zVLqrewOvo2Uo7DFE=;
 b=a7hKomPSw5zGB3T4lu9XS9IBRbQztFGXpmzM68uhTzkjYT2ft5OUM1TQmZivlc/mjW
 Ki+jMoudOltNjxjyuEnsVL8ym9gcvUHhFcUITVa1vmXNIQFEVg+xFUxgxRNBeUuK7LJ9
 0gRWPtaXEsJhdwdaH3MdrGuSXMD65urMUmt12uBP43ZClOhEqMbtKgDUWGz4kXt1yoMy
 KHn80CSv3ZC1ZR0jLHUTmujzz2QATimpOP+bo10m2sp48x/Z0PwA7fCbmwul+taFAmQz
 ezW7E00zRy6WLCMWprS2X4aMeo5dw9jiUOCgSsaADo3bRh9Nc6Gf/v7kW4/hXdXlLKy8
 /qhw==
X-Gm-Message-State: APjAAAWawzJfNAqYd55YIAy67xzP+6bE5KgMdPfTpz+ahbNEAfY5Ku+i
 MWYSwqnMQpwq5csmHfbI8hk2Yw==
X-Google-Smtp-Source: APXvYqw2O9JOWyddUFdC7e1AquKCVkkhnhIcYQ46QwQwJ+Z7KHzQnrJiAwoIAklgJVb9us82+qtH0A==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr4937147wrh.371.1575474792938; 
 Wed, 04 Dec 2019 07:53:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm7052656wmc.3.2019.12.04.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 07:53:11 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 750701FF87;
 Wed,  4 Dec 2019 15:53:10 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-15-richard.henderson@linaro.org>
 <87y2vs8gf1.fsf@linaro.org>
 <dd46a349-cbe2-d114-90f4-5d9b8c7d6d84@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 14/40] target/arm: Recover 4 bits from TBFLAGs
In-reply-to: <dd46a349-cbe2-d114-90f4-5d9b8c7d6d84@linaro.org>
Date: Wed, 04 Dec 2019 15:53:10 +0000
Message-ID: <8736e084ux.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/4/19 3:43 AM, Alex Benn=C3=A9e wrote:
<snip>
>>>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int ma=
x_insns)
>>>  {
>>> -    DisasContext dc;
>>> +    DisasContext dc =3D { };
>>=20
>> We seemed to have dropped an initialise here which seems unrelated.
>
> Added, not dropped.

But is it related to this patch or fixing another bug?


--=20
Alex Benn=C3=A9e

