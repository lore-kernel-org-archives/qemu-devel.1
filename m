Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2524B2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOCNtL8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbDZ-0007vH-WA
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNZN9-00057O-41
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNZN6-0003Dm-OY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:25:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNZN6-0003Da-Ep
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:25:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id b16so9244722otk.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=syid6krUsPxfc4GmRUpyI794bOgLFo56CLg1zf/h6MY=;
 b=bOCNtL8K5SdGMnD7ZGnIK3aSJfYlQDbhrzugBaBds2sBNaK+Sq21okTi1AY65bmo+Y
 55LkeoOsw1HNr6xLVdyAGdu6MN7r5oUfU/ivDn4tHQNzxtRwhdUpxpCJc+wweEk28xpV
 pLYMIpAj2BCx29juApR11gP5gZuf+CH6zngBmeVYoiEWUa93GVMzfek1R9C0x+4RC78T
 qtavjENtk1mCgSKGWOxjfFr0K5qZoyKoaGhPk5BjGid81dgSjmRlxGh8kbW91NBpgRUr
 6u1diA6PTzXNn59y7We26l/DljI5LY9aufZiPRJ8JxQsvBIlZmwgPjY52zk8wv8AXYXk
 vQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=syid6krUsPxfc4GmRUpyI794bOgLFo56CLg1zf/h6MY=;
 b=L/Brn9XfXnNEdxwC7LfEQ3mxAlBRJnLADa5+TVc5tNfssJdXV/TihJZGt7QWKM/OuN
 ZptjC1aPOhcegipyFHhl/zyGfdMxKwE8m4uDQ+Vad7jgB9m4+2YJWNaDiXUZVu43lMcY
 oXY3DVKctDBJaslfmStbA95fjoWz5O2yd9OAZnTBJ8csuyqcrw1H96bWNYtK0qUeFyCY
 jlYnuX0v9XRTjgzFh2LyBzqH84MWTT6jzlTK6RL7czt6WKr6QLKqvX/YzifYrg0yWx1s
 ppOlayIVaLSiI2vygkI8iUKn5IuzPxMk0ilYLvVjvXSJVNzymJuV27Ej5IYql9b+1czg
 h5rg==
X-Gm-Message-State: APjAAAVgIGz1FVxi/9itF4KxiEUMG2QxGJGW/j6m7Yg9SRmZq7Ccdgu9
 mLfuvtD/SSYJAgZFW8ZiQwX82/Ofopr7LCrDnAU=
X-Google-Smtp-Source: APXvYqwhiqctyT3qTRn4DDTRMhsDZDLaMVjelTLR9Q2ZDVloN8EcheOQ+djUtUOiWMcANoIEnPsAcyIdfueZJyTPrCM=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr10475126otl.64.1571909131528; 
 Thu, 24 Oct 2019 02:25:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 24 Oct 2019 02:25:31
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-2-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 24 Oct 2019 11:25:31 +0200
Message-ID: <CAL1e-=hkEQCHHfnNh3=zDEDrYMsTh1DVqBsbWP54XdZ_GnNiNQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] Acceptance tests: refactor
 wait_for_console_pattern
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000676d1d0595a49df6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000676d1d0595a49df6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> From: Cleber Rosa <crosa@redhat.com>
>
> The same utility method is already present in two different test
> files, so let's consolidate it into a single utility function.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Message-Id: <20190916164011.7653-1-crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: failure_message is optional]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++++++++++++
>  tests/acceptance/boot_linux_console.py    | 27 +++++------------------
>  tests/acceptance/linux_ssh_mips_malta.py  | 18 +++------------
>  3 files changed, 33 insertions(+), 37 deletions(-)
>
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index bd41e0443c..e3101cba30 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -8,6 +8,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>
> +import logging
>  import os
>  import sys
>  import uuid
> @@ -53,6 +54,30 @@ def pick_default_qemu_bin(arch=3DNone):
>          return qemu_bin_from_src_dir_path
>
>
> +def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its
> console
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    console =3D test.vm.console_socket.makefile()
> +    console_logger =3D logging.getLogger('console')
> +    while True:
> +        msg =3D console.readline().strip()
> +        if not msg:
> +            continue
> +        console_logger.debug(msg)
> +        if success_message in msg:
> +            break
> +        if failure_message and failure_message in msg:
> +            fail =3D 'Failure message found in console: %s' %
> failure_message
> +            test.fail(fail)
> +
> +
>  class Test(avocado.Test):
>      def setUp(self):
>          self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 8a9a314ab4..8897e0c253 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,12 +9,12 @@
>  # later.  See the COPYING file in the top-level directory.
>
>  import os
> -import logging
>  import lzma
>  import gzip
>  import shutil
>
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
>
> @@ -29,31 +29,14 @@ class BootLinuxConsole(Test):
>
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Kernel panic - not
> syncing'):
> -        """
> -        Waits for messages to appear on the console, while logging the
> content
> -
> -        :param success_message: if this message appears, test succeeds
> -        :param failure_message: if this message appears, test fails
> -        """
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline().strip()
> -            if not msg:
> -                continue
> -            console_logger.debug(msg)
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' %
> failure_message
> -                self.fail(fail)
> +    def wait_for_console_pattern(self, success_message):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message=3D'Kernel panic - not
> syncing')
>
>      def exec_command_and_wait_for_pattern(self, command,
> success_message):
>          command +=3D '\n'
>          self.vm.console_socket.sendall(command.encode())
> -        self.wait_for_console_pattern(success_message)
> +        wait_for_console_pattern(self, success_message)
>
>      def extract_from_deb(self, deb, path):
>          """
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index 25a1df5098..ffbb06f846 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -13,6 +13,7 @@ import time
>
>  from avocado import skipUnless
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
>  from avocado.utils import ssh
> @@ -40,19 +41,6 @@ class LinuxSSH(Test):
>      def setUp(self):
>          super(LinuxSSH, self).setUp()
>
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Oops'):
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline()
> -            console_logger.debug(msg.strip())
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' %
> failure_message
> -                self.fail(fail)
> -
>      def get_portfwd(self):
>          res =3D self.vm.command('human-monitor-command',
>                                command_line=3D'info usernet')
> @@ -109,7 +97,7 @@ class LinuxSSH(Test):
>
>          self.log.info('VM launched, waiting for sshd')
>          console_pattern =3D 'Starting OpenBSD Secure Shell server: sshd'
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern, 'Oops')
>          self.log.info('sshd ready')
>
>          self.ssh_connect('root', 'root')
> @@ -117,7 +105,7 @@ class LinuxSSH(Test):
>      def shutdown_via_ssh(self):
>          self.ssh_command('poweroff')
>          self.ssh_disconnect_vm()
> -        self.wait_for_console_pattern('Power down')
> +        wait_for_console_pattern(self, 'Power down', 'Oops')
>
>      def ssh_command_output_contains(self, cmd, exp):
>          stdout, _ =3D self.ssh_command(cmd)
> --
> 2.21.0
>
>
>

--000000000000676d1d0595a49df6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">From: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.c=
om">crosa@redhat.com</a>&gt;<br>
<br>
The same utility method is already present in two different test<br>
files, so let&#39;s consolidate it into a single utility function.<br>
<br>
Signed-off-by: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.com">crosa@re=
dhat.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190916164011.7653-1-crosa@redhat.com">2=
0190916164011.7653-1-crosa@redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt;<br>
[PMD: failure_message is optional]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/avocado_qemu/<wbr>__init__.py | 25 +++++++++++++++++=
++++<br>
=C2=A0tests/acceptance/boot_linux_<wbr>console.py=C2=A0 =C2=A0 | 27 +++++--=
----------------<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py=C2=A0 | 18 +++---------=
---<br>
=C2=A03 files changed, 33 insertions(+), 37 deletions(-)<br>
<br></blockquote><div><br></div><div><br></div><div><div id=3D"cvcmsg_16de4=
b6417ee4d84" class=3D"yh  " style=3D"border-top-left-radius:0px;border-top-=
right-radius:0px;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=
=3D"cvcfullmsg_16de4b6417ee4d84"><div id=3D"cvcmsgbod_16de4b6417ee4d84" cla=
ss=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><div><span st=
yle=3D"color:rgb(34,34,34)">Reviewed-by: Aleksandar Markovic &lt;</span><a =
href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp=
.com</a><span style=3D"color:rgb(34,34,34)">&gt;</span></div><div style=3D"=
clear:both"></div></div><div style=3D"clear:both"></div><div><div class=3D"=
M j T b hc Aj S" tabindex=3D"0"><div class=3D"V j hf"></div></div></div><di=
v style=3D"clear:both"></div></div></div></div></div><div id=3D"cvcmsg_16de=
4b7a4e116812" class=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" i=
d=3D"cvcfullmsg_16de4b7a4e116812"><div class=3D"M j Zi Mi  " tabindex=3D"0"=
><div id=3D"cvcreply_16de4b7a4e116812" class=3D"M j T b hc xh S  " tabindex=
=3D"0"><div class=3D"V j td"></div></div></div></div></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/avocado_<wbr>qemu/__init__.py b/tests/accepta=
nce/avocado_<wbr>qemu/__init__.py<br>
index bd41e0443c..e3101cba30 100644<br>
--- a/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
+++ b/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
@@ -8,6 +8,7 @@<br>
=C2=A0# This work is licensed under the terms of the GNU GPL, version 2 or<=
br>
=C2=A0# later.=C2=A0 See the COPYING file in the top-level directory.<br>
<br>
+import logging<br>
=C2=A0import os<br>
=C2=A0import sys<br>
=C2=A0import uuid<br>
@@ -53,6 +54,30 @@ def pick_default_qemu_bin(arch=3D<wbr>None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return qemu_bin_from_src_dir_path<br>
<br>
<br>
+def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Waits for messages to appear on the console, while logging t=
he content<br>
+<br>
+=C2=A0 =C2=A0 :param test: an Avocado test containing a VM that will have =
its console<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read and pro=
bed for a success or failure message<br>
+=C2=A0 =C2=A0 :type test: :class:`avocado_qemu.Test`<br>
+=C2=A0 =C2=A0 :param success_message: if this message appears, test succee=
ds<br>
+=C2=A0 =C2=A0 :param failure_message: if this message appears, test fails<=
br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 console =3D test.vm.console_socket.<wbr>makefile()<br>
+=C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;console&#39;)<br>
+=C2=A0 =C2=A0 while True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline().strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message and failure_message in msg:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Failure message fo=
und in console: %s&#39; % failure_message<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test.fail(fail)<br>
+<br>
+<br>
=C2=A0class Test(avocado.Test):<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._vms =3D {}<br>
diff --git a/tests/acceptance/boot_linux_<wbr>console.py b/tests/acceptance=
/boot_linux_<wbr>console.py<br>
index 8a9a314ab4..8897e0c253 100644<br>
--- a/tests/acceptance/boot_linux_<wbr>console.py<br>
+++ b/tests/acceptance/boot_linux_<wbr>console.py<br>
@@ -9,12 +9,12 @@<br>
=C2=A0# later.=C2=A0 See the COPYING file in the top-level directory.<br>
<br>
=C2=A0import os<br>
-import logging<br>
=C2=A0import lzma<br>
=C2=A0import gzip<br>
=C2=A0import shutil<br>
<br>
=C2=A0from avocado_qemu import Test<br>
+from avocado_qemu import wait_for_console_pattern<br>
=C2=A0from avocado.utils import process<br>
=C2=A0from avocado.utils import archive<br>
<br>
@@ -29,31 +29,14 @@ class BootLinuxConsole(Test):<br>
<br>
=C2=A0 =C2=A0 =C2=A0KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#3=
9;<br>
<br>
-=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Kernel =
panic - not syncing&#39;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Waits for messages to appear on the console, w=
hile logging the content<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :param success_message: if this message appear=
s, test succeeds<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :param failure_message: if this message appear=
s, test fails<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console =3D self.vm.console_socket.<wbr>makefi=
le()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;cons=
ole&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline().strip=
()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Fail=
ure message found in console: %s&#39; % failure_message<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(fail)<br=
>
+=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, success_message=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Kernel =
panic - not syncing&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def exec_command_and_wait_for_<wbr>pattern(self, comman=
d, success_message):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command +=3D &#39;\n&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.console_socket.<wbr>sendall(comma=
nd.encode())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>success_mes=
sage)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, success_message=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def extract_from_deb(self, deb, path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index 25a1df5098..ffbb06f846 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -13,6 +13,7 @@ import time<br>
<br>
=C2=A0from avocado import skipUnless<br>
=C2=A0from avocado_qemu import Test<br>
+from avocado_qemu import wait_for_console_pattern<br>
=C2=A0from avocado.utils import process<br>
=C2=A0from avocado.utils import archive<br>
=C2=A0from avocado.utils import ssh<br>
@@ -40,19 +41,6 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super(LinuxSSH, self).setUp()<br>
<br>
-=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Oops&#3=
9;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console =3D self.vm.console_socket.<wbr>makefi=
le()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;cons=
ole&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg.<wbr>st=
rip())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Fail=
ure message found in console: %s&#39; % failure_message<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(fail)<br=
>
-<br>
=C2=A0 =C2=A0 =C2=A0def get_portfwd(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D self.vm.command(&#39;human-<wbr>m=
onitor-command&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command_line=3D&#39;info usernet&#39;=
)<br>
@@ -109,7 +97,7 @@ class LinuxSSH(Test):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.log.info" target=
=3D"_blank">self.log.info</a>(&#39;VM launched, waiting for sshd&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0console_pattern =3D &#39;Starting OpenBSD=
 Secure Shell server: sshd&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>console_pat=
tern)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, console_pattern=
, &#39;Oops&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.log.info" target=
=3D"_blank">self.log.info</a>(&#39;sshd ready&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_connect(&#39;root&#39;, &#39;roo=
t&#39;)<br>
@@ -117,7 +105,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0def shutdown_via_ssh(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command(&#39;poweroff&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_disconnect_vm()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>&#39;Power =
down&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Power down=
&#39;, &#39;Oops&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def ssh_command_output_contains(<wbr>self, cmd, exp):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout, _ =3D self.ssh_command(cmd)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000676d1d0595a49df6--

