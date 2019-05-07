Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7435620825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OURU7Syc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7435620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO8ja-0001Ys-CX
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 18:38:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO8ip-0001Fi-W7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO8ip-00061J-2L
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:38:03 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO8io-0005yS-T4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:38:03 -0400
Received: by mail-oi1-x229.google.com with SMTP id v10so13687286oib.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:from:date:message-id:subject:to:cc
	:content-transfer-encoding;
	bh=eBYifXrDSkS4KxOTwaCrGoK3eQar9G2fCjRjrK6uAcw=;
	b=OURU7SycCTmFjmbpa4cuT7UREHHsBYjP74YP9m5DWTZofiPwcKd73bFMt6pfmF8VRq
	WdPHJRvRRFXVDnwRTm60StkGbr7fhqW1C9F2BnfTByx2OL9uAdWhu8ITszai8HMZkfTJ
	jxJzMqbir3B4e1JzpQEBTgDccYuDCAzgvj58kDowW10cXFmRJM0xdCuC33wg7JGkPAQv
	dTluxismAgnt0K25ob57rzCZw3IPt+YqwSuHiZGqXpd1cvkr8UnHwgqGXUMhvGINPWLr
	6CrAKj6uviSdVR+teuvK6p9fCKYfcjb9D3PCR3PSmkAAHkQHQ45xo2nJJiR+vcKS23bv
	GReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
	:content-transfer-encoding;
	bh=eBYifXrDSkS4KxOTwaCrGoK3eQar9G2fCjRjrK6uAcw=;
	b=i6ghuYxQd3a0wdNCaP77O561QbssHAQX0pWXC7a7kebKj1yS0Lf2qlmVdAac1VP4Hd
	Xo/0vTcwbNGLHUGZ9o1kQGa79rrvt7Hkd3nWzzFv359NiNUjFjH61TGMNw5o7eIfvWqn
	53Dspn5p35WyPENWVDL8HqANJFAM/i5J2OEX9fwrUVE/hRAq0vVv8kNsJYDy21buFf02
	ao81vby8PpMSaeIDKr9vYb9txp4lAsc9wVUeNrUOoDZdAfD1YPKYGKp7/fcxCCm8uZJe
	N0EC9LxP2IviIGWXDYPmmntmWFez7LnpXMmET1CjYXbgbMOEXHWfOaRBdWteO+FA3Myz
	OVmQ==
X-Gm-Message-State: APjAAAUVXXfxJMhM3NGXFAJv9Fx0bR9h05qwWFx4i/+Mo6yOYNR9Wv+0
	xdY3f8Rwc6g8levhc9Ep6xoUdJWhO6JqPdlLVQFJIh4gdz0=
X-Google-Smtp-Source: APXvYqw5zREXG6n11cWKZfWI2+jWeNYrTBBklFjQ62fY5em6ejaslJXEEMCAd91GDZ9/TgyCRoiPIcByt1Lw+bELTwU=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr16337oif.98.1557268681604;
	Tue, 07 May 2019 15:38:01 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 23:37:50 +0100
Message-ID: <CAFEAcA9nd6Xta8CGSRp605i9bcpeKsj+h4r5gbpot4_iNKXyRg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: [Qemu-devel] qapi-scheme/unicode-str test failure due to mismatch
 between e-acute and \xe9
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just ran into this test failure:

PYTHONPATH=3D/home/linux1/qemu/scripts python3 -B
/home/linux1/qemu/tests/qapi-schema/test-qapi.py
/home/linux1/qemu/tests/qapi-schema/unicode-str.json
>tests/qapi-schema/unicode-str.test.out
2>tests/qapi-schema/unicode-str.test.err; echo $?
>tests/qapi-schema/unicode-str.test.exit
--- /home/linux1/qemu/tests/qapi-schema/unicode-str.err    2017-07-06
10:23:13.601812330 -0400
+++ -    2019-05-07 18:32:31.533125931 -0400
@@ -1 +1 @@
-tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9'
+tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe9'
/home/linux1/qemu/tests/Makefile.include:1105: recipe for target
'check-tests/qapi-schema/unicode-str.json' failed
make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
make: Leaving directory '/home/linux1/qemu/build/all'

but oddly only when I ran 'make check' by logging directly
into this machine (usually I run the tests automatically
via ssh and scripting), which suggests it may depend
on the locale settings. Does anybody recognize this ?
I think LANG=3DC fails, but LANG=3DC.UTF-8 passes.

Ideally our test suite should not depend on the locale
or environment settings of the user running it.

thanks
-- PMM

