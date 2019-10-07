Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EAC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C866A2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V33LU7IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C866A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVuN-0004oK-Ou
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHVsc-00036U-U5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHVsb-0001SM-Ov
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:29:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHVsb-0001Rp-II
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:29:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id 21so11475166otj.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=APjVfi5ek3py4tXDArJht53LVorj1fsZu3Ny2nv8cVg=;
 b=V33LU7IV3vG1CEF9lSS63LdyPc2BOsbDKZy8J5tHVc+/+bIGByvZwH5hRqmGPFuxiA
 OTVXcGjtZQX+qlrJ+ZR1NGbREZi4/Dd6DtyZefvBDWPtm7R7YnDi97me+UHkPwzwzi1W
 zBomjDNx1bHztKgrGlfPFYV7FVhLD2dAPY0DB3EMlbOpwIREeW7iQVOJ+Xd1LRgLMOrr
 QgaddqDRGdXRmiHkkhEmR4726OsUfHNtUKPoTyF6u2fDvjDEQiWtnJIbrirB2Gcaefd7
 +jzQYeMaYCGT83+WyBwrWvTSV7dzFqDEQ7wLZX3RWpzPXKr/5YSMAYfjkiJKQOeJffa9
 RmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=APjVfi5ek3py4tXDArJht53LVorj1fsZu3Ny2nv8cVg=;
 b=BjqZ/Czk/wtkgovcGkAbnObFGCW9+70KciIEf/CXMMBRnjSOnk3FnhUtcZwbt+7bpd
 TWoEkDqakJk1/1jSOQCDdyw85oHrLVS9tg5ymr2GseKvTG/MYCADDShuANKaS+APKWWZ
 6S2EMLQVik4nAo8uRXnOlBQLJnMMhW+e4TIq285rASihwmmcTGQlZhfcb2gYClrxUET8
 E2wTrjnGGwxBUfUlKwN+ph8ccLJnKWVPq016tV7ppnRjgGv9XkOoHNReeKd8pDu/KusP
 z02zSmsK7B9BZp7OZ945ImYRvHgiMobXvjjxGPn5Rtz5Qm7330JNUmxDZWLQMxtFysCG
 7cLQ==
X-Gm-Message-State: APjAAAWY35Y/DjMlWgXjGGpxW+ufjKQ9GvliYGiEZEPPhtve6QJQAPJ2
 YZIw5YW2Ehv7IC3LCvaQhxdtM0GkEYeevA1J6KeZTw==
X-Google-Smtp-Source: APXvYqxadBaVWPotumxWd3JVcX0vA/XdXIrjRfXk7vp55OLMdHSI77vc/lNq+rhA2JmzhfdjtdPojISgQ6Q7E4DqoN8=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr21878846otq.91.1570465740656; 
 Mon, 07 Oct 2019 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
In-Reply-To: <20191005154748.21718-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 17:28:49 +0100
Message-ID: <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXNzZQ==?= <contact@fredericb.info>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 at 16:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> This test boots a Linux kernel on a smdkc210 board and verify
> the serial output is working.
>
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test

Thanks for putting this test case together, very helpful.

> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv5.cpio.gz')

Do our other acceptance tests download random third-party
(ie "not a well-known distro") binaries for the tests ?
It seems a bit hazardous for reproducability and trustability
reasons...

thanks
-- PMM

