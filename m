Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC5CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD77620862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAAZE+89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD77620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7IG-0000JI-VD
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Cl-0005Ew-5x
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Cj-0001e9-SH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:57:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Cj-0001cW-Kk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:57:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so5492366wra.6
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oAJs4uCy1H9ENSeCl4CRzN2oC+34FIJc/ldS+iq1uOw=;
 b=BAAZE+89jL3r+TebXXYuMPbheljwlCNCC4oT3MxtUl2bQPPCoig3gMBQtN4Mlsa6f2
 h4gv+nPjG2Lpq9W19Re9nMAtEmK4H3BElw0ai1rWVhrCxmCsXxpIRT/36jWjTnHs5tNu
 e3DfecxLYTxaadW+xGLLhesvvg29i+xyqsSxNAaykx9Cdc0AcqUqOqRyk+jbKwjQkOl2
 ZGpFMC6ZfqKQ5CoEl/F0/Gifidj5MxhBNYlo1jWwTN+KncT9Bre8xgC++otiephO/WpC
 As63OBcd94+VHnBF9+HdN8juGaCTQSuuEthaEXI0v7513MtcNH3m+3R28udkf7SCqwIh
 9uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oAJs4uCy1H9ENSeCl4CRzN2oC+34FIJc/ldS+iq1uOw=;
 b=h9qKVDLpLQvjO2HyA3S77ujVLD2XiR0lCHh1dKEvcp3gOzsQkl7sQv0np+Tltak7my
 E59gblsBZDSbYYVGjlZCO4CESk68ra7wSTqddUzsQZOPs/WQ8rhgfR0HE2OPFdVRFvez
 DlOoZwlNZyDWHIlqJQRCHVGcfpXDGxMFy+pb7v4aR9T9E7QZOfBv3mC0DCxLmP7BDQAd
 toUbO5anrdUPVuDdNs1OOkFKQrKtSvl9LPMEQyeesnlAnPsgQq7uOKd+l5UIts3gwAl1
 oIQqp/LY+kbc0DK2AQtOgcv9DGisMVtV7Fc0kmM1MjBWVK0WobuKbE4FqP0t0kzwf5+/
 UqKQ==
X-Gm-Message-State: APjAAAV0yhX8HAlY7VPD0xfs401O3E901jGO80SF2k/+jA5Svzp8vear
 ne+ab/9pWdjXNSnTlP/SfH2GBUS66sN0wA==
X-Google-Smtp-Source: APXvYqyvfRXMEX/zp9nva7I5qmXUur2VSwuZXNyAjD2ZOEmTOfB6EEt0xdhJrdXmzvpJo+pbV9EmHA==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr4362259wrn.24.1572515839240; 
 Thu, 31 Oct 2019 02:57:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm3574164wmu.12.2019.10.31.02.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 02:57:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6839C1FF87;
 Thu, 31 Oct 2019 09:57:17 +0000 (GMT)
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800 test
In-reply-to: <20191029232320.12419-1-crosa@redhat.com>
Date: Thu, 31 Oct 2019 09:57:17 +0000
Message-ID: <8736f98cg2.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> The boot_linux_console.py:BootLinuxConsole.test_m68k_q800 was very
> recently merged, but between its last review and now, the Kernel
> package used went missing.
>
> This updates the Kernel package, and protects the test from failing
> if it gets updated again.

Queued to testing/next, thanks. I'll roll it up with Daniel's fix to get
green again.

>
> Cleber Rosa (2):
>   Acceptance test: cancel test if m68k kernel packages goes missing
>   Acceptance test: update kernel for m68k/q800 test
>
>  tests/acceptance/boot_linux_console.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)


--
Alex Benn=C3=A9e

