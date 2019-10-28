Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719EBCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FA1208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ9fAWLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FA1208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPBPK-0001BQ-Et
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 16:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPBKf-00043A-K1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPBKa-00082I-Mb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:09:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPBKX-000818-Hu
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572293371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Nrk4jz3vEx0LPq18ulHuYF8ZrRufPh0F1ItpDNL1dE=;
 b=RQ9fAWLox6OvYnXLIXDreHmp47Xt6ja4sRNhNlNnvmmv+jNiX/QaNhB26EqfUy+BLVr4/8
 wa4ALAIRyCif3OGi3+0zuaTRncYvBodJpdsZDWHVorX/X0BOhOrX7Vw8tKbKep3C1/iowm
 +fU6l45GsZe86/5LaThH6E6mZDiKeuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-qP1iVzIDMtOeRWIfnc-fgg-1; Mon, 28 Oct 2019 16:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA77107AD28;
 Mon, 28 Oct 2019 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47DA4600C9;
 Mon, 28 Oct 2019 20:09:17 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:09:15 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 18/26] tests/boot_console: Test booting HP-UX firmware
 upgrade
Message-ID: <20191028200915.GB26898@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-19-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-19-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qP1iVzIDMtOeRWIfnc-fgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:33AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Add a test which boots a HP-UX firmware upgrade CD-ROM.
> It exercise the PCI LSI53C895A SCSI controller.
>=20
> The ISO image comes from:
> https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/ke=
rnels/712/PF_C7120023
>=20
> This test is very quick, less than 3s:
>=20
>   $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dyes \
>     avocado --show=3Dapp,console run -t arch:hppa \
>       tests/acceptance/boot_linux_console.py
>   console: Firmware Version 6.1
>   console: Duplex Console IO Dependent Code (IODC) revision 1
>   console: Memory Test/Initialization Completed
>   console: --------------------------------------------------------------=
----------------
>   console: (c) Copyright 2017-2018 Helge Deller <deller@gmx.de> and SeaBI=
OS developers.
>   console: --------------------------------------------------------------=
----------------
>   console: Processor   Speed            State           Coprocessor State=
  Cache Size
>   console: ---------  --------   ---------------------  -----------------=
  ----------
>   console: 0      250 MHz    Active                 Functional           =
 0 KB
>   console: Available memory:     512 MB
>   console: Good memory required: 16 MB
>   console: Primary boot path:    FWSCSI.0.0
>   console: Alternate boot path:  FWSCSI.2.0
>   console: Console path:         SERIAL_1.9600.8.none
>   console: Keyboard path:        PS2
>   console: Available boot devices:
>   console: 1. DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+]
>   console: Booting from DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.=
5+]
>   console: Booting...
>   console: Boot IO Dependent Code (IODC) revision 153
>   console: HARD Booted.
>   console: ISL Revision A.00.25 November 18, 1992
>   console: ISL booting  ODE UPDATE ; stable off ; RUN
>   console: Loading...
>   console: **************************************************************=
*************
>   console: ******                                                        =
       ******
>   console: ******             Offline Diagnostic Environment             =
       ******
>   console: ******                                                        =
       ******
>   console: ******      (C) Copyright Hewlett-Packard Co 1993             =
       ******
>   console: ******                    All Rights Reserved                 =
       ******
>   console: ******                                                        =
       ******
>   console: ******  HP shall not be liable for any damages resulting from =
the    ******
>   console: ******  use of this program.                                  =
       ******
>   console: ******                                                        =
       ******
>   console: ******                TC  Version A.00.15                     =
       ******
>   console: ******                SysLib Version A.00.44                  =
       ******
>   console: ******                                                        =
       ******
>   console: **************************************************************=
*************
>   console: Type HELP for command information.
>   console: ISL_CMD> UPDATE ; stable off ; RUN
>   console: **************************************************************=
*************
>   console: ******                                                        =
       ******
>   console: ******                           PDC UPDATER                  =
       ******
>   console: ******                                                        =
       ******
>   console: ******    Copyright (C) 1993, 1994, 1995 by Hewlett-Packard Co=
mpany  ******
>   console: ******                         Version A.00.19                =
       ******
>   console: ******                                                        =
       ******
>   console: **************************************************************=
*************
>   console: Type HELP for command information.
>   console: Stable Storage will NOT be updated
>   console: STARTING EXECUTION OF UPDATE
>   console: Unrecognized MODEL TYPE =3D 502
>   console: ERROR 0001
>   console: UPDATE PAUSED> exit
>   console: UPDATE>
>   console: UPDATE> ls
>   console: Modules on this boot media are:
>   console: filename    type    size     created   description
>   console: --------------------------------------------------------------=
---------------
>   console: DAGGER      DATA    118      96/02/15  ?
>   console: IMAGE1A     DATA    512      96/02/15  ?
>   console: IMAGE1B     DATA    388      96/02/15  ?
>   console: UPDATE> exit
>   console: THIS UTILITY WILL NOW RESET THE SYSTEM.....
>   PASS (2.39 s)
>   JOB TIME   : 2.54 s
>=20
> Suggested-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2:
> - check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
>=20
> I know this is not a 'Linux' test, but all our console functions
> reside in this file and I don't want to duplicate again.
> Maybe we could rename this file as 'boot_console_tests.py' or
> extract the console related functions.
> ---
>  tests/acceptance/boot_linux_console.py | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index f94dc4bbca..67b396169b 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -13,6 +13,7 @@ import lzma
>  import gzip
>  import shutil
> =20
> +from avocado import skipUnless
>  from avocado_qemu import MachineTest
>  from avocado_qemu import exec_command_and_wait_for_pattern
>  from avocado_qemu import wait_for_console_pattern
> @@ -357,3 +358,29 @@ class BootLinuxConsole(MachineTest):
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_hppa_fwupdate(self):
> +        """
> +        :avocado: tags=3Darch:hppa
> +        :avocado: tags=3Ddevice:lsi53c895a
> +        """
> +        cdrom_url =3D ('https://github.com/philmd/qemu-testing-blob/raw/=
ec1b741/'
> +                     'hppa/hp9000/712/C7120023.frm')
> +        cdrom_hash =3D '17944dee46f768791953009bcda551be5ab9fac9'
> +        cdrom_path =3D self.fetch_asset(cdrom_url, asset_hash=3Dcdrom_ha=
sh)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-cdrom', cdrom_path,
> +                         '-boot', 'd',
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Unrecognized MODEL TYPE =3D 502')
> +
> +        exec_command_and_wait_for_pattern(self, 'exit',
> +                                                'UPDATE>')

OK, so this also gets stuck (like the previous tests I mentioned that
wouldn't get passed a given "prompt" point).  Adding a newline to the
command (in addition to the carriage return) does the trick, that is:

---

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index bdece76723..6fdb308a6e 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -93,7 +93,7 @@ def exec_command_and_wait_for_pattern(test, command,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
-    command +=3D '\r'
+    command +=3D '\n\r'
     test.vm.console_socket.sendall(command.encode())
     wait_for_console_pattern(test, success_message, failure_message)
=20

---

I'm guessing that different systems will interpret the end of
line differently.  Any other ideas?

- Cleber.

> +        exec_command_and_wait_for_pattern(self, 'ls',
> +                                                'IMAGE1B')
> +        exec_command_and_wait_for_pattern(self, 'exit',
> +                                                'THIS UTILITY WILL NOW '
> +                                                'RESET THE SYSTEM.....')
> --=20
> 2.21.0
>=20


