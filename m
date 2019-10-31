Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89446CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DBB20650
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYl6mywI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DBB20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ3eX-0003gc-Ae
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 02:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ3dK-0002wB-H3
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ3dJ-0006xR-6F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:08:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ3dI-0006wo-UR
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:08:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id g7so4537001wmk.4
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=k9/6f1hFwKLdErStt2AGxz1lNf/Yhw83lOl0vkitWOc=;
 b=lYl6mywI/lwF2OlVbPhpmEK86DwpUwpsz4l12k7u4JZzSA3J8VBaIXoFXmzOkLS1Qm
 PyApUYfRftJsFMQ5Juju9oA6wegvfAH3yGpgDbgPKQKSHAg679DgAxIDitR3UoWIGi3/
 vVpI0ieCzcczpV2Yv035plSsLBmCyDhqV27Ndymyat81B8WDDCImHXHYLwe5g/huhS4p
 szSgLRDcBj3eBbq/LJWwYKOWFPafMwnkbN6s34faYJYTlc1gpz6yq8f8R7394VZkfn4/
 CMUb/QYxB2B2kvMbYuS7opl4z3ZPjARegypm9hs7nx43LywmlRDDifuU0550dotLzmp0
 RecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=k9/6f1hFwKLdErStt2AGxz1lNf/Yhw83lOl0vkitWOc=;
 b=qmGGKZlogkEej7ICJEnz1lMnb5fD4XDWisgw3OzEW3TpYquuCovFQFMsdSandhrNGG
 ofdpCmLw41qIst3Bm5PXSHWTF47FkkqfRRjwlOos7FSlorWOCDM2dBxUSitn1xl1bdKd
 as3Ec3SfQdJqwZF8e6gI5WKqfDSoYntzBkB84/p/5ir6VWa8HJh1fijcgfLE20KEj7tu
 JwI6SeYFNFT/w01gU2WC/MsCjJ6/JTReK/V3GebeD3p0tz11CZ4zpTRw+RtAMNht1ecA
 YVPFqccngDjayIqhcoHcPJvnGBlUiFwBxoen4HZqmMl2YzKFMZCTBNbpplpxGcuMeihY
 /3Jg==
X-Gm-Message-State: APjAAAWVmagxr1uP8Ltxl5UP10XKA6HiTYq80fj2JkSd2nXx8bFPjYmp
 fQ1jpUgaaB7z+GFsYNr3jKaW0Q==
X-Google-Smtp-Source: APXvYqw7cJleMdtuTpCOeGYwVZAiAW4yf5mugOdKL61W4R24fBN86jJeWqSzTInYF+ob8y8Df1fn+Q==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr3444848wmc.75.1572502111458; 
 Wed, 30 Oct 2019 23:08:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b66sm2659394wmh.39.2019.10.30.23.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 23:08:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A60B41FF87;
 Thu, 31 Oct 2019 06:08:29 +0000 (GMT)
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <20191029232320.12419-3-crosa@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] Acceptance test: update kernel for m68k/q800 test
In-reply-to: <20191029232320.12419-3-crosa@redhat.com>
Date: Thu, 31 Oct 2019 06:08:29 +0000
Message-ID: <87h83p8n1e.fsf@linaro.org>
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

> There's an updated version of the Debian package containing the m68k
> Kernel.
>
> Now, if the package gets updated again, the test won't fail, but will
> be canceled.  A more permanent solution is certainly needed.

At least for open source blobs can't we do something similar to the
firmware and host a blob mirror on our infrastructure as a fallback?

>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index c439fd90fc..8f676d8e92 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -385,14 +385,14 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Dmachine:q800
>          """
>          deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
> -                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.u=
deb')
> -        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
> +                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.u=
deb')
> +        deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>          try:
>              deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>          except OSError as exp:
>              self.cancel(exp)
>          kernel_path =3D self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinux-5.2.0-2-m68k')
> +                                            '/boot/vmlinux-5.3.0-1-m68k')
>
>          self.vm.set_machine('q800')
>          self.vm.set_console()


--
Alex Benn=C3=A9e

