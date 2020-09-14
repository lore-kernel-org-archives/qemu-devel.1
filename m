Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13AC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE1A208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2GeFylF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE1A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoqU-0002jj-Ru
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHomU-0006ia-0E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:44:30 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHomS-0003MN-Gr
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:44:29 -0400
Received: by mail-ej1-x642.google.com with SMTP id r7so23286928ejs.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9SiCAQeKUAzJKUQvyZCko1wEECMwt01LkprMPg7Sc4k=;
 b=m2GeFylFmAc7t2sjuM3F3rOHTdaM9sTDeVFz4m59pVkoJ4IiGcEv8c/JzFgfOmeDig
 D9JPpeWT1eDmHbl+BoLuqW/xgMMM5FQAtrTwERrBWY8FxEP3RCXZDsB/S9vItLDovtDu
 h+OBL+XkbGgvL+yLKvQbjRgv2g6+TQc6aGlhnwtjfUX3yVsbcTX2stKU9nWgvRsbWk+7
 xbi6DxExmdKIIhNsgnEgE4ATFEUQUgc8clWLYjWKPtjNfkOmNPakgPwRIjw+wqtzE0RG
 R/mv+jtxIlrLB3KqX1eki+X3pv8UJLNAy6VclVgcRMWZ0t/zuICt3x22ISLx3lBivLei
 gLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9SiCAQeKUAzJKUQvyZCko1wEECMwt01LkprMPg7Sc4k=;
 b=B7TiZYMASUoTFPzq21duADMkd8vPmf7XOA9tFHRJFcWw6mVWLkrhcYmo6lSKmprDN6
 vRASqJvg2ytCOGQkg3sRmBezDmCuKukY7yy5e0mKK3V472oB7iAelTbKQBjHF/L0VHIL
 Y/X7wFt7ROm8XRXtX0Q+0FVsyPdwbdD+Sv+noWQvEuqWFEgHpuOwbDnUyhjnkthJW8C7
 6/NfNzxNyT9ID/vZIzlhB9f/KdEI8KmWwnrWAQJ+GoEye0lv9rTTkSXWkXlh0XwFw+5w
 MeuuXaQubKPQ/ms6HbpoYMJcIOoZ89qJMPhqYBMI8omzYDlEfGYxOZI78kL7KsZHTOZ7
 fXlA==
X-Gm-Message-State: AOAM5314GGD2GaVO7kgkebhbRZhpAQZvnLwDWPaLqxkdfx7rwL0er7Ii
 K03KMIHLBWxGHlJHVBA474hA9fi8kRdQFleeL78DlQ==
X-Google-Smtp-Source: ABdhPJzvf5QnzZ2wOrVLTNrtuCKSCTsoA0V20T+8BYLZeOva69kWMQBG93/6ZDEsiAPiW1I04YG6EJKeDtw6FMdXnhA=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr14364265ejb.85.1600091067074; 
 Mon, 14 Sep 2020 06:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200901162046.32670-1-peter.maydell@linaro.org>
 <20200901162046.32670-2-peter.maydell@linaro.org> <87bli81nmc.fsf@linaro.org>
In-Reply-To: <87bli81nmc.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 14:44:15 +0100
Message-ID: <CAFEAcA9Y_hiLBW+Jy2Xg3rD6J6g02G0PwELmbH_9a0pHJ998cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm.risu: Correct VLDR/VSTR U=0 patterns
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 14:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Correct the VLDR and VSTR patterns, which claimed to be setting U=3D0
> > but in fact left it identical to the U=3D1 pattern due to a
> > cut-and-paste error.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Somehow the pre-generated test binaries I have from Alex have
> > U=3D0 insns in them -- I suspect this got fixed locally but never
> > made it upstream ?
>
> Hmm my current set of aarch32 test patterns have U=3D1 throughout. So if
> it did get fixed locally it also got lost.

I'm surprised you don't see test failures due to the memory
constraint not matching up with the encoding...

-- PMM

