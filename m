Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12216C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D0920738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec7sW3yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3op-00066z-W6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv3oG-0005TQ-FN; Mon, 13 Jul 2020 15:08:16 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:46448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv3oE-00049F-Mr; Mon, 13 Jul 2020 15:08:16 -0400
Received: by mail-il1-x144.google.com with SMTP id p15so4537966ilh.13;
 Mon, 13 Jul 2020 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/uJ30hwEOlZyw1v5xCC7/kjYHKZXjks7CzaBxkMOgUw=;
 b=ec7sW3yCKnw3beXd9saRqZWCQSIC6dGI4fSN2lARO5G64HrYkqHif5nCViqU3z19TU
 ONDzuXVX/yLisouPm5i+zjkt8yG8wZPXnK6z7xBX2jGo7Ia+S0xOCRQK9Ix1F0etNP3K
 Qxpkhh/vDgchOdrQFFbojw9vbaEbV0BeQ+gXrQtbxrKrBiZmJ714hz6rhLHotV81LbGu
 Vuz5eWdvcvbWY3Yk/KsdSfssIFiXCX7SqYJS0xD4JZUaV7AqYIF55/AJKXV9fucMYrJt
 OgIlEx5AtkjWQ0456wueWvUGuzqUhiz5JlhLk10O5ogY3fXVXuXEK7/9Mqj3CVtXWzMK
 Xbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/uJ30hwEOlZyw1v5xCC7/kjYHKZXjks7CzaBxkMOgUw=;
 b=TUyURtlGjNZJVK/5CUSHP5UCoMDqnS5QkLLCpQTBLI6k00BhvgJT6TFtlEEf6M84C/
 0klaMweBo7Hvcv3bQ22M7SQNdC19uEP2Geswb50p7WwvcSD2vZu8Dk73xDPwgsvhpEFy
 9ADfGv7QvlIPf2H7lpozuTziJx3ZumNTOYStVpd2EwetZZMukxARAGedag2aR0UAbpqy
 F5H2t+HBwUe3N2xmGJQVDX/thdlgcMQsPFJCf7PTs2PdU92yCXtJ6zd9oZyfGD+4pSQN
 jkn04U+EVkLl0+ARRwaH7dOkBTiwh6AGeTYIBHwCtANcyRE3Dh9CnSPetcvIs1WGF89Z
 Q/8g==
X-Gm-Message-State: AOAM533tXox/5fFtKQAY18bgsd58FIqmLPi7WQBVp2rOr6MFigr4Fjtc
 Y6RCmZDK5fOA07qxYumXZCvR58yH9KWU4ZavMQU=
X-Google-Smtp-Source: ABdhPJwZ+By2MH36dArE7LBls7cmqKXMu/rGU98nN8bXbyF4SfOUBaok7bNqotpr1/SkKcF3CWnkQHWM0n09hIyM08A=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr1264504ilj.131.1594667293270; 
 Mon, 13 Jul 2020 12:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-4-f4bug@amsat.org>
In-Reply-To: <20200713183209.26308-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 11:58:11 -0700
Message-ID: <CAKmqyKOn6s-_bGOMF946h=Gw9teqVkOs1O7+Kxs-+OaxdArCcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] tests/acceptance/boot_linux: Tag tests using a SD
 card with 'device:sd'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 11:34 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Avocado tags are handy to automatically select tests matching
> the tags. Since these tests use a SD card, tag them.
>
> We can run all the tests using a SD card at once with:
>
>   $ avocado --show=3Dapp run -t u-boot tests/acceptance/
>   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dok \
>     avocado --show=3Dapp \
>       run -t device:sd tests/acceptance/
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_sd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_bionic
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_uboot_netbsd9
>    (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_sd: PASS (19.56 s)
>    (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_bionic: PASS (49.97 s)
>    (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_uboot_netbsd9: PASS (20.06 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 90.02 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/acceptance/boot_linux_console.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 3d02519660..b7e8858c2d 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -620,6 +620,7 @@ def test_arm_orangepi_sd(self):
>          """
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:orangepi-pc
> +        :avocado: tags=3Ddevice:sd
>          """
>          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
>                     'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.=
deb')
> @@ -669,6 +670,7 @@ def test_arm_orangepi_bionic(self):
>          """
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:orangepi-pc
> +        :avocado: tags=3Ddevice:sd
>          """
>
>          # This test download a 196MB compressed image and expand it to 9=
32MB...
> @@ -710,6 +712,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
>          """
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:orangepi-pc
> +        :avocado: tags=3Ddevice:sd
>          """
>          # This test download a 304MB compressed image and expand it to 1=
.3GB...
>          deb_url =3D ('http://snapshot.debian.org/archive/debian/'
> --
> 2.21.3
>
>

