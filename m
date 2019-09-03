Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1159C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB0E206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwJKsSji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB0E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55Je-00013q-Vr
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i55Iu-0000VS-Fm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i55It-0002sb-6j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:40:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i55It-0002sE-1Y; Tue, 03 Sep 2019 05:40:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id y39so6048379ota.7;
 Tue, 03 Sep 2019 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=o8zYjDpvENOIZHwfDTtymFY4TStnbN4syd3UC15nX4k=;
 b=bwJKsSjiM6N8ff8R1RtFHyI39ThZvsVBx9mZ0VAhR6En6LUgw1Hwxd+gbNSrgR5NNw
 dfR+nXVsl5y/3WfhNPRZGMF1BEoks4WxhfphRYTToWKpMSwmczh+CvmJw1HS8X2SY7CY
 b408VD/EpNrkYef/nidjWc6+lj/AdKUXzayHfsVhYjG8bh8sXGthkKNQ7HwEcy4MFAEs
 WqkMiI1qgueL02ul5fRxaIzSgFRaNODLKepYQLQ9xIBPX0bK0947ja+n1EtzUR9DU2ad
 rxR6C05+trllEhGa4Jw51JdMSYC7DsNMCdRGZ3powbGy0AJLmtZ294nk4JaBH4OkNNS9
 OHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=o8zYjDpvENOIZHwfDTtymFY4TStnbN4syd3UC15nX4k=;
 b=EWYc1hTLxY/Tx7Brc3SCdj4O9zjrHcq8M7eYCno4gojyq+xPoUASwGQmZaO/vmkbGv
 Ze1bb/jsvAzeLGSvPYXY/axOEVmPvJj7Wu0AGJRdShyi1g5nMJTBm6hJWTgez0fWIdHV
 sPztFhCL4zbhnZYDk3k/BN/zB/NoqlfOWwZncyE/mdOuZK2Cbm5l/WLsEuxhBUIJUZzt
 ODj7qcQoWR81Fx4EYJwjGWvaftOIls6GkplN4TNlWIZ9lojGRvgspahSoZcLx3sLAugJ
 LaNVI1mNpxpnbD59PMaXcOvfK3Kj3/CfUh7TfTE29CJSzW1OUNpPBJ2c/FUpQ9x1rqzy
 D1+Q==
X-Gm-Message-State: APjAAAXhabvP7YiVO9KEx19RxtnZUMkaGvRw+unDC8qK4QUHj069I80x
 HNCTLYklZgC7zDIQLAbTCsNmTVTOkE5BAUcmzxE=
X-Google-Smtp-Source: APXvYqywBlYovm14cZikODmW3qGnt0n0IdPBGY/KmOzbNbB+3H3+1EBkrQ/o2IpQFbW7elLGRnyrrnt6JNxaXDeb4gc=
X-Received: by 2002:a9d:4912:: with SMTP id e18mr25152892otf.341.1567503646079; 
 Tue, 03 Sep 2019 02:40:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 02:40:45 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 02:40:45 -0700 (PDT)
In-Reply-To: <7f4eac6e-486a-3d99-b533-5fd4ac41864d@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-67-richard.henderson@linaro.org>
 <CAFEAcA9AbEzR97-2gvpPAbGrGHx_AxGgVhh4-BDufTQUX0gM1w@mail.gmail.com>
 <7f4eac6e-486a-3d99-b533-5fd4ac41864d@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 3 Sep 2019 11:40:45 +0200
Message-ID: <CAL1e-=grS02UTTMQ41iMWFCSrUsbE0X7B8GfnLLgjdpD9cOkLw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 66/68] target/arm: Convert T16,
 long branches
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.08.2019. 02.07, "Richard Henderson" <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 8/27/19 2:34 AM, Peter Maydell wrote:
> >> +    tcg_gen_andi_i32(tmp, tmp, -4);
> >
> > Minor nit, but can we use 0xfffffffc like the old code did,
> > to avoid the reader having to do 2s-complement arithmetic
> > in their head to figure out that we're clearing the low 2 bits?
>
> I always preferred "x & -c" for exactly the same reason:
> to avoid the reader having to do 2s compliment arithmetic
> in their head to figure out that we're aligning to c.
>
> But, sure, if you like.
>

I vote for 0xfffffffc.

Aleksandar

> > This would be a good place to put a comment equivalent to that
> > in the old decoder:
> >
> > # thumb_insn_is_16bit() ensures we won't be decoding these as
> > # T16 instructions for a Thumb2 CPU, so these patterns must be
> > # a Thumb1 split BL/BLX.
> >
> >> +BLX_suffix      11101 imm:11                    &i
> >> +BL_BLX_prefix   11110 imm:s11                   &i
> >> +BL_suffix       11111 imm:11                    &i
>
> I had placed that with trans_BL_BLX_prefix, but I suppose this
> is a better place.
>
>
> r~
>
