Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C96C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C53206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNks5X5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C53206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilzbc-0002v7-Uf
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 13:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilzat-0002U0-Uz
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilzas-0002S7-2j
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:16:43 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilzar-0002Rl-Ti
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:16:42 -0500
Received: by mail-qt1-x842.google.com with SMTP id e6so30159026qtq.7
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dGRcDE+48+A3OatIVUGFJsHNqPfsUw/jJbt1IOEvK3c=;
 b=DNks5X5JKaf/GaBlswPKb5nw+HUiw6xhbYatNf1opfecZ8rKA8aWMu/YxikY2qztJK
 FWcW7JY1tI1SO8+FO7n7Ce0yYol4M5ffnvidv0azSxqHlEYWKbupF+6DGvzDyYEw5If5
 lCJQtFOaazfXmFWm7tPMs/1dxYpmLIsDiEFFtNMhkJ1kn/2iwmqqCI9ZTJR9qukEpkm+
 2a9HDj2acNlJsNXv4BYLIVJ03MKHed3/wx9RgmXI2xvKbJdZp43JtJr4P7ZEe+p57X+0
 HkI31FJFif+D1pDc+g3eGjMtnGCF39G1EWgNX9JkWSdhr7xLa9+uIgypdPPjUTXpnoxS
 CQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dGRcDE+48+A3OatIVUGFJsHNqPfsUw/jJbt1IOEvK3c=;
 b=CF5OSkyATptUsLmAw2OlfHGG61gINpbdS9Ajwp+PekrAiHReXLEA0fLG7V8peTeNmw
 6eDNTiVXNAKf5Z9S19V0Q0+JfRNvMju9IGov6Iu7pqNbtWjBY4F4JWmtPrlrUYvy5Dzo
 +Zmfe6DVv9kQAk5hTQf9JNb7x9BPdRCokl96CTBHIHCUNR0BDYjZODHRo8F+MsxkDMpG
 XIGck8hCo/4J/DQComynEZGFfjdg2MlwxmeisoLFQi8K96r1Zja3VUt4UJ/ZfNZtOcvi
 HZg5br96+eXrM9ZzHlfxGoXVr7LMPRMMjMBQQyOQahMjSMQ3xrUdlqAfizfBvoFkQWGs
 kmAw==
X-Gm-Message-State: APjAAAVfQMf9iqZLMzMtA6Mhvn2W/StHkUvFqFf0oDP+SlCAQFFS7zGQ
 Y/KcVIWDkR7Qr35DeYRzyoic8q6XF2QpOBSIhDw=
X-Google-Smtp-Source: APXvYqxRuRaIdModR2wb+pluOKw/YuWkDdI63HqpTi1dBzvJPnsBaMj8JOlCti50n7MzXaDWLIsJNF04Kg07+fSonvY=
X-Received: by 2002:ac8:1769:: with SMTP id u38mr48691733qtk.160.1577729800937; 
 Mon, 30 Dec 2019 10:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20191229215158.5788-1-mrolnik@gmail.com>
 <20191229215158.5788-21-mrolnik@gmail.com>
 <ce09e537-9d44-7d99-9ce2-23145f8270a7@redhat.com>
In-Reply-To: <ce09e537-9d44-7d99-9ce2-23145f8270a7@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 30 Dec 2019 20:15:59 +0200
Message-ID: <CAK4993i6SMJ-ERUfAEiMVuw6QM=wqYut1d=EVEAGt82jL4S98A@mail.gmail.com>
Subject: Re: [PATCH v40 20/21] target/avr: Add Avocado test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000056244c059aefd843"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000056244c059aefd843
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wainer.

thanks for reviewing.

1. when `self.vm.shutdown()` is not called `self.vm.get_log()` returns
`ERROR: argument of type 'NoneType' is not iterable`
2. I will remove the unnecessary imports

Thanks,
Michael Rolnik


On Mon, Dec 30, 2019 at 7:37 PM Wainer dos Santos Moschetta <
wainersm@redhat.com> wrote:

> Hi Michael,
>
> On 12/29/19 7:51 PM, Michael Rolnik wrote:
> > The test is based on
> > https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
> > demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out=
.
> > it also demostrates that timer and IRQ are working
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   tests/acceptance/machine_avr6.py | 58 +++++++++++++++++++++++++++++++=
+
> >   1 file changed, 58 insertions(+)
> >   create mode 100644 tests/acceptance/machine_avr6.py
> >
> > diff --git a/tests/acceptance/machine_avr6.py
> b/tests/acceptance/machine_avr6.py
> > new file mode 100644
> > index 0000000000..7a7d8afc29
> > --- /dev/null
> > +++ b/tests/acceptance/machine_avr6.py
> > @@ -0,0 +1,58 @@
> > +#
> > +# QEMU AVR
> > +#
> > +# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
> > +#
> > +# This program is free software: you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation, either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> > +#
> > +
> > +import logging
> > +import time
> > +import distutils.spawn
> > +
> > +from avocado import skipUnless
> > +from avocado_qemu import Test
> > +from avocado.utils import process
>
> Please remove unused imports: logging, distutils.spawn, skipUnless and
> process.
>
> > +
> > +class AVR6Machine(Test):
>
> It helps others reading this if you document the test purpose here.
> Besides it makes the pylinter happier. ;)
>
> > +    timeout =3D 5
> > +
> > +    def test_freertos(self):
> > +        """
> > +        :avocado: tags=3Darch:avr
> > +        :avocado: tags=3Dmachine:sample
> > +        """
> > +        """
> > +
> https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_=
ATMega2560_GCC/demo.elf
> > +        constantly prints out
> 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> > +        """
> > +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> > +        rom_sha1=3D '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
> > +        rom_url +=3D '/raw/'
> > +        rom_url +=3D rom_sha1
> > +        rom_url +=3D '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
> > +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> > +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> > +
> > +        self.vm.set_machine('sample')
> > +        self.vm.add_args('-bios', rom_path)
> > +        self.vm.add_args('-nographic')
> > +        self.vm.launch()
> > +
> > +        time.sleep(2)
> > +        self.vm.shutdown()
>
> Do you really need to shutdown the VM here? Because it will be shut down
> later on avocado_qemu.Test.tearDown() anyway.
>
> > +
> > +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> > +
> > +        self.assertIn(match, self.vm.get_log())
>
> It is a matter of taste, but I would simply do:
>
> self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
>
>                       self.vm.get_log())
>
> Thanks for writing this acceptance test!
>
> - Wainer
>
>

--=20
Best Regards,
Michael Rolnik

--00000000000056244c059aefd843
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Wainer.<div><br></div><div>thanks for reviewing.</=
div><div><br></div><div>1. when `self.vm.shutdown()` is not called `self.vm=
.get_log()` returns `ERROR: argument of type &#39;NoneType&#39; is not iter=
able`</div><div>2. I will remove the unnecessary imports</div><div><br></di=
v><div>Thanks,</div><div>Michael Rolnik</div><div><br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30,=
 2019 at 7:37 PM Wainer dos Santos Moschetta &lt;<a href=3D"mailto:wainersm=
@redhat.com">wainersm@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Michael,<br>
<br>
On 12/29/19 7:51 PM, Michael Rolnik wrote:<br>
&gt; The test is based on<br>
&gt; <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/master/free=
-rtos/Demo" rel=3D"noreferrer" target=3D"_blank">https://github.com/seharri=
s/qemu-avr-tests/tree/master/free-rtos/Demo</a><br>
&gt; demo which. If working correctly, prints &#39;ABCDEFGHIJKLMNOPQRSTUVWX=
&#39; out.<br>
&gt; it also demostrates that timer and IRQ are working<br>
&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; Acked-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/acceptance/machine_avr6.py | 58 ++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 58 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/acceptance/machine_avr6.py<br>
&gt;<br>
&gt; diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machi=
ne_avr6.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..7a7d8afc29<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/acceptance/machine_avr6.py<br>
&gt; @@ -0,0 +1,58 @@<br>
&gt; +#<br>
&gt; +# QEMU AVR<br>
&gt; +#<br>
&gt; +# Copyright (c) 2019 Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gma=
il.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; +#<br>
&gt; +# This program is free software: you can redistribute it and/or modif=
y<br>
&gt; +# it under the terms of the GNU General Public License as published b=
y<br>
&gt; +# the Free Software Foundation, either version 2 of the License, or<b=
r>
&gt; +# (at your option) any later version.<br>
&gt; +#<br>
&gt; +# This program is distributed in the hope that it will be useful,<br>
&gt; +# but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<=
br>
&gt; +# GNU General Public License for more details.<br>
&gt; +#<br>
&gt; +# You should have received a copy of the GNU General Public License<b=
r>
&gt; +# along with this program.=C2=A0 If not, see &lt;<a href=3D"http://ww=
w.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.or=
g/licenses/</a>&gt;.<br>
&gt; +#<br>
&gt; +<br>
&gt; +import logging<br>
&gt; +import time<br>
&gt; +import distutils.spawn<br>
&gt; +<br>
&gt; +from avocado import skipUnless<br>
&gt; +from avocado_qemu import Test<br>
&gt; +from avocado.utils import process<br>
<br>
Please remove unused imports: logging, distutils.spawn, skipUnless and <br>
process.<br>
<br>
&gt; +<br>
&gt; +class AVR6Machine(Test):<br>
<br>
It helps others reading this if you document the test purpose here. <br>
Besides it makes the pylinter happier. ;)<br>
<br>
&gt; +=C2=A0 =C2=A0 timeout =3D 5<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_freertos(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:avr<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:sample<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/seharris/qe=
mu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/seharris/qemu-avr-tests/ra=
w/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 constantly prints out &#39;ABCDEFGHIJKLMN=
OPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url =3D &#39;<a href=3D"https://githu=
b.com/seharris/qemu-avr-tests" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/seharris/qemu-avr-tests</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_sha1=3D &#39;36c3e67b8755dcf37e06af67=
30ef5d477b8ed16d&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url +=3D &#39;/raw/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url +=3D rom_sha1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url +=3D &#39;/free-rtos/Demo/AVR_ATM=
ega2560_GCC/demo.elf&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_hash =3D &#39;7eb521f511ca8f2622e0a3c=
5e8dd686efbb911d4&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_path =3D self.fetch_asset(rom_url, as=
set_hash=3Drom_hash)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;sample&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-bios&#39;, rom_pat=
h)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-nographic&#39;)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.shutdown()<br>
<br>
Do you really need to shutdown the VM here? Because it will be shut down <b=
r>
later on avocado_qemu.Test.tearDown() anyway.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D &#39;ABCDEFGHIJKLMNOPQRSTUVWXAB=
CDEFGHIJKLMNOPQRSTUVWX&#39;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(match, self.vm.get_log())<b=
r>
<br>
It is a matter of taste, but I would simply do:<br>
<br>
self.assertIn(&#39;ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX&#39;,<b=
r>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.get_log())<br>
<br>
Thanks for writing this acceptance test!<br>
<br>
- Wainer<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000056244c059aefd843--

