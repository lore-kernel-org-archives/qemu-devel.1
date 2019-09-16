Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F86C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E7206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpXp4Ol5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nZq-000414-Q3
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1i9nYQ-0003Fm-7V
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1i9nYN-0005OL-KC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:44:18 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1i9nYK-0005NN-Hi; Mon, 16 Sep 2019 05:44:12 -0400
Received: by mail-io1-xd43.google.com with SMTP id h144so77050501iof.7;
 Mon, 16 Sep 2019 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i0RGqKpJuaiR1nlYvowonww7ZyQt0dj3Lr5DKvIXM4M=;
 b=WpXp4Ol5GjQGpXC6l0iCJzD4QN2i3lEpmmn3WN+vzoQBPdC9bFPTfKfZj7S382qXNW
 EvIgo6agVAAae1zeK/d1khuDccZS2lGrXUlBHd/D2M9DfF5jFS/XYKKm5Q56HcH1Mavx
 iErp15AwiGrG0f945y6N+Ral8o4MdTlI8MRqVwXXKuMzWLVOs1CuGngd2X3fJ7tytBLA
 w2Rl53hz+JA40v6pFzsNz5FOUC+Sp1p2AnQPg8XP/kt7sJIbwrdl/XdcdtfYElCugxrq
 eBMbdRXmVisHAFQC/JOEJmgyloWueY0XFkesYidqdhsLbe0jpoc5R8bJMwPKASwWFsJf
 hWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i0RGqKpJuaiR1nlYvowonww7ZyQt0dj3Lr5DKvIXM4M=;
 b=pD8x2J18iqzNtRLNZ6Pk5p+ZtpLPgFLYODzeh1RP6bFIycJek2ZbfqhPXBmEnwCfra
 tdBlQ5Ep2ksLzBXPR5mao9qGftDtwaYJDsitSd3S6Kw/LmrgPhKL+KQeC0puTPeHZ7s8
 5mL1ixVVvphjzxzKtZDdeGHknQfwpwRYcx+2ucLpD0B5i8ZR/ytZHBFtwbKreEmmd134
 hGzCF3Xuo9fKmSTCwgBSgvueBtBNq8Ogvkig3fBuuPedVkGaWR9wpZm+9MX+TXMzKCAI
 xti6OhoDRxvCGNJcDB1lO70QWLxFJoKhGMSXLSPswPgPElXzfGR2v+0g8nYfexDVzONF
 hzdQ==
X-Gm-Message-State: APjAAAV+G0TUoAwXLnj5MUMoh3efC/TeJsH0RXj6/uQgB+Ef7fZeV/8o
 8s/g6nVazNZO06e4OMSt6ofFEIp4VqL4cMAbTd8=
X-Google-Smtp-Source: APXvYqwPYveBDK26str5zm8IlIw5ZJSkSKrrI90cz3DK5ST/e8vMHjdXvdhbAuYzozHf0C5x1bv8iBhmIttxm3p6VkU=
X-Received: by 2002:a6b:7708:: with SMTP id n8mr15286449iom.198.1568627051884; 
 Mon, 16 Sep 2019 02:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-2-f4bug@amsat.org>
In-Reply-To: <20190915211940.30427-2-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 16 Sep 2019 11:44:00 +0200
Message-ID: <CACXAS8Ahnknn8KHjFjwr+o7Exg7zcYTw2Qfx7ecPKZOeEjKU2Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v2 1/6] tests/acceptance: Add test that
 runs NetBSD 4.0 installer on PRep/40p
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 15, 2019 at 11:19 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> As of this commit, NetBSD 4.0 is very old. However it is enough to
> test the PRep/40p machine.

Not just it's enough, it's also the NetBSD release which definitely
was tested on physical 40p machines.
(It already has reviewed-by maintainer, so I don't suppose you'll need
it, but just in case,
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
)

>
> User case from:
> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Installers after 4.0 doesn't work anymore, not sure if this is a
> problem from the QEMU model or from NetBSD.
> ---
>  MAINTAINERS                      |  1 +
>  tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50eaf005f4..ce809c7dee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1068,6 +1068,7 @@ F: hw/timer/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
>  F: include/hw/timer/m48t59.h
>  F: pc-bios/ppc_rom.bin
> +F: tests/acceptance/machine_ppc_prep_40p.py
>
>  sPAPR
>  M: David Gibson <david@gibson.dropbear.id.au>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep=
_40p.py
> new file mode 100644
> index 0000000000..53f2d2ecf0
> --- /dev/null
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -0,0 +1,63 @@
> +# Functional test that boots a PReP/40p machine and checks its serial co=
nsole.
> +#
> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import logging
> +
> +from avocado import skipIf
> +from avocado_qemu import Test
> +
> +
> +class IbmPrep40pMachine(Test):
> +
> +    timeout =3D 60
> +
> +    # TODO refactor to MachineTest
> +    def wait_for_console_pattern(self, success_message, failure_message=
=3DNone):
> +        """
> +        Waits for messages to appear on the console, while logging the c=
ontent
> +
> +        :param success_message: if this message appears, test succeeds
> +        :param failure_message: if this message appears, test fails
> +        """
> +        console =3D self.vm.console_socket.makefile()
> +        console_logger =3D logging.getLogger('console')
> +        while True:
> +            msg =3D console.readline().strip()
> +            if not msg:
> +                continue
> +            console_logger.debug(msg)
> +            if success_message in msg:
> +                break
> +            if failure_message and failure_message in msg:
> +                fail =3D 'Failure message found in console: %s' % failur=
e_message
> +                self.fail(fail)
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
> +    def test_factory_firmware_and_netbsd(self):
> +        """
> +        :avocado: tags=3Darch:ppc
> +        :avocado: tags=3Dmachine:40p
> +        :avocado: tags=3Dslowness:high
> +        """
> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +                    '7020-40p/P12H0456.IMG')
> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive=
/'
> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0.f=
s')
> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_ha=
sh)
> +
> +        self.vm.set_machine('40p')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', bios_path,
> +                         '-fda', drive_path)
> +        self.vm.launch()
> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST =
2007'
> +        self.wait_for_console_pattern(os_banner)
> +        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
> --
> 2.20.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

