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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07861C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71AE246A5
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKNdJKCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71AE246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyRj-0001FQ-0i
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyQm-00005f-Ek
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyQk-0006vU-WC
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:27:08 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyQk-0006v9-8L; Sat, 18 Jan 2020 19:27:06 -0500
Received: by mail-io1-xd41.google.com with SMTP id k24so29943583ioc.4;
 Sat, 18 Jan 2020 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaDTQE9Xs/M5JD5bz7OeKEUK7FrITUNeOBAznWlPD0s=;
 b=OKNdJKCfM6s/XO8q5AucRvbJfGh+/GfWv+DJowTMUxq9L8Jxc4MUGCctmdlBKacr+6
 xzubt/7pcuj53HaslAkm5KBnO7tx99OndLQGJKCrD14VJbJyKLTHjbpUdxtmZV2TOvB2
 9DGEXR9EKmz/kAczlVnf71OFeC9RuK2H0XfCOPfcnwSpjh4VBMycXzsXlo9ZLihf4AEi
 zsS6HZCVphkBcz3e6CA/U5B4CwLdPSS4T9bUZoXZgarB9uAnvAp4Qkhx2E43j0YOUWsj
 dP7wEwfoY+bOhDhpEDaFVU+AL4/m/JgE+KCISNpLDGAIrl6mAj7Tn1L7BheM35L9nTCY
 WZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaDTQE9Xs/M5JD5bz7OeKEUK7FrITUNeOBAznWlPD0s=;
 b=kwrojpoe5njlj7UuTxAiKxdCbW+T8aHbg7B/Te3Z9HLOWRPgECUxsK0vd3oc1xM2rQ
 fJW5K2mXX4YxrBFn1WUaGWBbwpJ9Qjgx4jN/ytD1DkiFNGnbgQ0VHvsqqbdV9IWBWxW6
 eVkiOfIHlqDPnJ72sQDV0JO+8vjbrk2L34y/0bf9VF030RNqUF/3kHRmlyv/855xmpqD
 khrlWlqgpHg06qpJpGLVoCKQIMVsxK7O76Hf/bMVsHwYoqQh+ESuKVGWdPS4Codybfo0
 3786zADff4Q6tjlXsEQ8O0n88C95/tGzctdBEEePdi4gz/OAM/Hp5oFKRV8ZbTpAgjvl
 TCxQ==
X-Gm-Message-State: APjAAAWiaivr4xj+AyBGGMI1PS7UqhYUR611fKAG+KuYqbHrtASzAXL6
 +36TNjg9iUnxBxXewOCGYexJrT0vxRVKYweOy7GFCJUC
X-Google-Smtp-Source: APXvYqwrjQ1Skzf7Yi8ID6NpJkv/K3tHsMWNd2V/dbHHtuLBpaj7i+pWnbplKmDRT7nvU1m5I1AaQXruf5LsBC4cfU8=
X-Received: by 2002:a02:856a:: with SMTP id g97mr6430035jai.97.1579393625624; 
 Sat, 18 Jan 2020 16:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20200118191623.32549-1-f4bug@amsat.org>
 <20200118191623.32549-3-f4bug@amsat.org>
In-Reply-To: <20200118191623.32549-3-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 01:26:54 +0100
Message-ID: <CAPan3WpecxTceifvgfpyrO=BHufU1v=2UrCXbfBGXAJx+Dm0pw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000041689059c733c3c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

--000000000000041689059c733c3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2020 at 8:16 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> We need a function to interrupt interactive consoles.
>
> Example: Interrupt U-Boot to set different environment values.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 32 +++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index 0a50fcf2be..d4358eb431 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -56,13 +56,15 @@ def pick_default_qemu_bin(arch=3DNone):
>
>
>  def _console_interaction(test, success_message, failure_message,
> -                         send_string):
> +                         send_string, keep_sending=3DFalse):
> +    assert not keep_sending or send_string
>      console =3D test.vm.console_socket.makefile()
>      console_logger =3D logging.getLogger('console')
>      while True:
>          if send_string:
>              test.vm.console_socket.sendall(send_string.encode())
> -            send_string =3D None # send only once
> +            if not keep_sending:
> +                send_string =3D None # send only once
>          msg =3D console.readline().strip()
>          if not msg:
>              continue
> @@ -74,6 +76,32 @@ def _console_interaction(test, success_message,
> failure_message,
>              fail =3D 'Failure message found in console: %s' %
> failure_message
>              test.fail(fail)
>
> +def interrupt_interactive_console_until_pattern(test, success_message,
> +                                                failure_message=3DNone,
> +                                                interrupt_string=3D'\r')=
:
> +    """
> +    Keep sending a string to interrupt a console prompt, while logging t=
he
> +    console output. Typical use case is to break a boot loader prompt,
> such:
> +
> +        Press a key within 5 seconds to interrupt boot process.
> +        5
> +        4
> +        3
> +        2
> +        1
> +        Booting default image...
> +
> +    :param test: an Avocado test containing a VM that will have its
> console
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    :param interrupt_string: a string to send to the console before tryi=
ng
> +                             to read a new line
> +    """
> +    _console_interaction(test, success_message, failure_message,
> +                         interrupt_string, True)
> +
>  def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
>      """
>      Waits for messages to appear on the console, while logging the conte=
nt
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--000000000000041689059c733c3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 8:16 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">We need a function to interrupt interactive consoles.<br>
<br>
Example: Interrupt U-Boot to set different environment values.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div>Teste=
d-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">niekl=
innenbank@gmail.com</a>&gt; <br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
---<br>
=C2=A0tests/acceptance/avocado_qemu/__init__.py | 32 +++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 30 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py<br>
index 0a50fcf2be..d4358eb431 100644<br>
--- a/tests/acceptance/avocado_qemu/__init__.py<br>
+++ b/tests/acceptance/avocado_qemu/__init__.py<br>
@@ -56,13 +56,15 @@ def pick_default_qemu_bin(arch=3DNone):<br>
<br>
<br>
=C2=A0def _console_interaction(test, success_message, failure_message,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0send_string):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0send_string, keep_sending=3DFalse):<br>
+=C2=A0 =C2=A0 assert not keep_sending or send_string<br>
=C2=A0 =C2=A0 =C2=A0console =3D test.vm.console_socket.makefile()<br>
=C2=A0 =C2=A0 =C2=A0console_logger =3D logging.getLogger(&#39;console&#39;)=
<br>
=C2=A0 =C2=A0 =C2=A0while True:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if send_string:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test.vm.console_socket.send=
all(send_string.encode())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_string =3D None # send only=
 once<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not keep_sending:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_string =3D No=
ne # send only once<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D console.readline().strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not msg:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
@@ -74,6 +76,32 @@ def _console_interaction(test, success_message, failure_=
message,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail =3D &#39;Failure messa=
ge found in console: %s&#39; % failure_message<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test.fail(fail)<br>
<br>
+def interrupt_interactive_console_until_pattern(test, success_message,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 failure_message=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 interrupt_string=3D&#39;\r&#39;):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Keep sending a string to interrupt a console prompt, while l=
ogging the<br>
+=C2=A0 =C2=A0 console output. Typical use case is to break a boot loader p=
rompt, such:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Press a key within 5 seconds to interrupt boot=
 process.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 5<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Booting default image...<br>
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
+=C2=A0 =C2=A0 :param interrupt_string: a string to send to the console bef=
ore trying<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to read a new line<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 _console_interaction(test, success_message, failure_message,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0interrupt_string, True)<br>
+<br>
=C2=A0def wait_for_console_pattern(test, success_message, failure_message=
=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Waits for messages to appear on the console, while logg=
ing the content<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000041689059c733c3c--

