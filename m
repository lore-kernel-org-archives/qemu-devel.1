Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D6B2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hk7sUzKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D6B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7et4-00035h-4a
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7equ-0002Qv-De
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7eqs-0003TK-Vd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:02:32 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:36597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7eqs-0003Sk-Pv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:02:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 67so18130851oto.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tQoknUmao5lqpN1vjsgRPMgN8pn1sF6pEYjivHmtpgg=;
 b=Hk7sUzKVJAKYuVk6rup1S4MHryR8fQtG0Geo7SCF/CxJPs4kThLfzr/2nWc8HAaCnO
 ZEwCOUSGWAwDNYnHlbewOuhQYLVXl3lPDV4zsZM1BxNB4keF5mTLTjYCTsvs6X+f/aHR
 6/2qsnZv6roVsuXMfFVu7l4RqnLe7DFnxtdiow/Nwm24gQyT8EfCoa6dFkU46TnhTQBb
 1TfPT51saXX+tECgQpNbwpnPVk+D5bVfs0UEEdox27NBxnfU42tDNj3Og7lilnpnJB7A
 PWLf4107dE/FVySxdK5fpuwQuvVd8/40hqGky1dHRuYK07CTlEh9kaAOU+xo6XlPj6UG
 E4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tQoknUmao5lqpN1vjsgRPMgN8pn1sF6pEYjivHmtpgg=;
 b=q1K+0CUyvTeBN6/apomi5g1rf/laVVaJOKVgzrUfVOmBXTR2D51n07pxo5DtQ4n+Id
 k3LylzuPttO5P+S3/gWAYgS2OkT4yGjoYq+tRtPfG5gyRk5l4TM47Fu6MWR/Dbbg+du/
 qtsFEcpJxpx3ga00moQym331upXD9Yn3Qpi/8MuP5WFePX4ufVWjlrxZdX92lXfsaW0J
 YXiOhSf7S4vQRN4EGazyfIhgTeUYEdOU1Na/0AdaxjHmht3k753A/Y61M2OqYNcux6Nj
 QZ5fm3Igrb+R3NPauA6yJQTtZmv10bZ+EBmZ7wRtsvnR/8ACljBpZiwPY4heb+8VDImv
 VW6Q==
X-Gm-Message-State: APjAAAWojtI5Jv1bjRj8o5GPFuWCDOk9hyU9kKMLzU8UDFBw5pGIOPsI
 AHwlV6635OtyULpTi8BsFiWpAs2Lr/CiOdGComOL0g==
X-Google-Smtp-Source: APXvYqxi5riV3uIz++I+Iu/qfX2mXQLxz9QPDkbmwW/LIq7vctTT6n2kn2XjtTPsKr3rG/a/ABfE3RLWcq2bYpn7Ms8=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr24291421otk.221.1568116949896; 
 Tue, 10 Sep 2019 05:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190907154744.4136-1-huth@tuxfamily.org>
 <20190907154744.4136-8-huth@tuxfamily.org>
In-Reply-To: <20190907154744.4136-8-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 13:02:18 +0100
Message-ID: <CAFEAcA_NHnNNC8jdVc7CGEQ=PDhDjQfiRb++=ZgdjKUPqi2f=w@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 7/8] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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

On Sat, 7 Sep 2019 at 16:47, Thomas Huth <huth@tuxfamily.org> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Add a test of the NeXTcube framebuffer using the Tesseract OCR
> engine on a screenshot of the framebuffer device.
>
> The test is very quick:
>
>   $ avocado --show=3Dapp,console run tests/acceptance/machine_m68k_nextcu=
be.py
>   JOB ID     : 78844a92424cc495bd068c3874d542d1e20f24bc
>   JOB LOG    : /home/phil/avocado/job-results/job-2019-08-13T13.16-78844a=
9/job.log
>    (1/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_size: PASS (2.16 s)
>    (2/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_ocr_with_tesseract_v3: -
>   ue r pun Honl'=EF=AC=82x ; 5=E2=80=98 55=E2=80=98
>   avg ncaaaaa 25 MHZ, memary jag m
>   Backplane slat =C2=ABa
>   Ethernet address a a r a r3 2
>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 1=
6MB page made stMs )nstalled

By the way, do we know why the output from this test case is
garbled like this ? It suggests that something's not right
somewhere...

thanks
-- PMM

