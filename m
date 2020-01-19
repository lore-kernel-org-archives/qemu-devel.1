Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D01C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1386E246A5
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djnIq15a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1386E246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyQk-0008G3-55
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyPx-0007NM-0Z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyPv-0006aP-9K
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:26:16 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyPu-0006a3-Vl; Sat, 18 Jan 2020 19:26:15 -0500
Received: by mail-il1-x143.google.com with SMTP id x5so24429133ila.6;
 Sat, 18 Jan 2020 16:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qDV4Wi5Ca+D+V+mozqNEyUEFxt41+syqpRtjs+GEEMk=;
 b=djnIq15ayRaYwu66sOh4tk7Ozlnulmbd+Ih4e9Hy4oAhzEUQyiO+rcszBUt+oEVL9Q
 IV0tgkLG8+N7LlGUAD7xKY4OaYTa7kd9wyoXME4iEN3A0J5LCFNh6ylI8NxBncwUK9/X
 3NdPgUUHaRFsg6y0xf/aJcmxdwt6YVXJdxBia5Ifp3Msa5Qa2/qpeVFRnoJCQBcSpem6
 ukCdnX6WBH6SmHaWKMjwGlzM/p5PVN1wY6ZWH1ZNCS7kGPVG2EOtGrFN/Iw+l6GlO426
 IplMq9R6edxrwDeFxmpZLPx7ibaYgNzc7mFSqbn9vDKWo1gzf4V7RKZr7O2jgT/bZr/3
 TfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qDV4Wi5Ca+D+V+mozqNEyUEFxt41+syqpRtjs+GEEMk=;
 b=FTKcH+6V1eoR8F/kwdltyS58NBvrQiHc2ynuJa9tI8l1yvOynx8BRIQsKTzh0Xhj2t
 BpFG187NVf0hSp4H6nRs4SqJ7XTmogeLEj9MRawZE/RQ4IlfJg+GIxV7I3ZviC8h+qOi
 niTcdZWaDDUdJ8dXBjkR25xaeKLYw29iJzbCbDnNpivU6RirYrwpyu2vmI/VxLQZBLuQ
 mkXE9XZ0jXqOSMHwFYZWolOiqz6xygXQQmbK7fuqamgv/1SDgyL61DqUvJoBxzUvdEh+
 YLJ3Nv7a4uclTbGAHEbyziyj3J/2AkjFINUhYaNFWfEDXFXqLQ7zJS9r3IUsdqtP0Lof
 AVrg==
X-Gm-Message-State: APjAAAU117Hgc4uJHy7Z5Ftfl0/uVA/9dxAAEpeYI4/TR3cBdGOn7HpF
 8RQo9iW6GPIQw+FnBP6UlZJ5KFw3PcYb4RzxvDE=
X-Google-Smtp-Source: APXvYqy13B4OouWIplBMz7f9mS70IKUoQB82jqsyzIwtieFZX8RxqHdg+C7+4axfT1Me0K6HybR+enXWLn3gyST6gjo=
X-Received: by 2002:a92:af08:: with SMTP id n8mr4713173ili.217.1579393574185; 
 Sat, 18 Jan 2020 16:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20200118191623.32549-1-f4bug@amsat.org>
 <20200118191623.32549-2-f4bug@amsat.org>
In-Reply-To: <20200118191623.32549-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 01:26:02 +0100
Message-ID: <CAPan3WqEd10j4SJ_HE3zN+STGVHnM7j8MWh72G7vL8E99FJCLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Acceptance tests: Extract _console_interaction()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f43205059c733837"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f43205059c733837
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2020 at 8:16 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Since we are going to re-use the code shared between
> wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
> extract the common part into a local function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++----------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index 6618ea67c1..0a50fcf2be 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):
>          return qemu_bin_from_src_dir_path
>
>
> -def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> -    """
> -    Waits for messages to appear on the console, while logging the conte=
nt
> -
> -    :param test: an Avocado test containing a VM that will have its
> console
> -                 read and probed for a success or failure message
> -    :type test: :class:`avocado_qemu.Test`
> -    :param success_message: if this message appears, test succeeds
> -    :param failure_message: if this message appears, test fails
> -    """
> +def _console_interaction(test, success_message, failure_message,
> +                         send_string):
>      console =3D test.vm.console_socket.makefile()
>      console_logger =3D logging.getLogger('console')
>      while True:
> +        if send_string:
> +            test.vm.console_socket.sendall(send_string.encode())
> +            send_string =3D None # send only once
>          msg =3D console.readline().strip()
>          if not msg:
>              continue
> @@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message,
> failure_message=3DNone):
>              fail =3D 'Failure message found in console: %s' %
> failure_message
>              test.fail(fail)
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
> +    _console_interaction(test, success_message, failure_message, None)
>
>  def exec_command_and_wait_for_pattern(test, command,
>                                        success_message,
> failure_message=3DNone):
> @@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
>      :param success_message: if this message appears, test succeeds
>      :param failure_message: if this message appears, test fails
>      """
> -    command +=3D '\r'
> -    test.vm.console_socket.sendall(command.encode())
> -    wait_for_console_pattern(test, success_message, failure_message)
> -
> +    _console_interaction(test, success_message, failure_message, command
> + '\r')
>
>  class Test(avocado.Test):
>      def _get_unique_tag_val(self, tag_name):
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--000000000000f43205059c733837
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 8:16 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Since we are going to re-use the code shared between<br>
wait_for_console_pattern() and exec_command_and_wait_for_pattern(),<br>
extract the common part into a local function.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div>Teste=
d-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">niekl=
innenbank@gmail.com</a>&gt; <br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
---<br>
=C2=A0tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++---------=
-<br>
=C2=A01 file changed, 17 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py<br>
index 6618ea67c1..0a50fcf2be 100644<br>
--- a/tests/acceptance/avocado_qemu/__init__.py<br>
+++ b/tests/acceptance/avocado_qemu/__init__.py<br>
@@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return qemu_bin_from_src_dir_path<br>
<br>
<br>
-def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 Waits for messages to appear on the console, while logging t=
he content<br>
-<br>
-=C2=A0 =C2=A0 :param test: an Avocado test containing a VM that will have =
its console<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read and pro=
bed for a success or failure message<br>
-=C2=A0 =C2=A0 :type test: :class:`avocado_qemu.Test`<br>
-=C2=A0 =C2=A0 :param success_message: if this message appears, test succee=
ds<br>
-=C2=A0 =C2=A0 :param failure_message: if this message appears, test fails<=
br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+def _console_interaction(test, success_message, failure_message,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0send_string):<br>
=C2=A0 =C2=A0 =C2=A0console =3D test.vm.console_socket.makefile()<br>
=C2=A0 =C2=A0 =C2=A0console_logger =3D logging.getLogger(&#39;console&#39;)=
<br>
=C2=A0 =C2=A0 =C2=A0while True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if send_string:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test.vm.console_socket.sendall(s=
end_string.encode())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_string =3D None # send only=
 once<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D console.readline().strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not msg:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
@@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message, fail=
ure_message=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail =3D &#39;Failure messa=
ge found in console: %s&#39; % failure_message<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test.fail(fail)<br>
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
+=C2=A0 =C2=A0 _console_interaction(test, success_message, failure_message,=
 None)<br>
<br>
=C2=A0def exec_command_and_wait_for_pattern(test, command,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success_m=
essage, failure_message=3DNone):<br>
@@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,<br=
>
=C2=A0 =C2=A0 =C2=A0:param success_message: if this message appears, test s=
ucceeds<br>
=C2=A0 =C2=A0 =C2=A0:param failure_message: if this message appears, test f=
ails<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 command +=3D &#39;\r&#39;<br>
-=C2=A0 =C2=A0 test.vm.console_socket.sendall(command.encode())<br>
-=C2=A0 =C2=A0 wait_for_console_pattern(test, success_message, failure_mess=
age)<br>
-<br>
+=C2=A0 =C2=A0 _console_interaction(test, success_message, failure_message,=
 command + &#39;\r&#39;)<br>
<br>
=C2=A0class Test(avocado.Test):<br>
=C2=A0 =C2=A0 =C2=A0def _get_unique_tag_val(self, tag_name):<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f43205059c733837--

