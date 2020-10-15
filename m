Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED75218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbFwVRZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED75218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwdT-0007PR-Ch
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kSwYY-00060E-Ma
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:16:06 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kSwYI-0007aU-R4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:16:06 -0400
Received: by mail-ot1-x335.google.com with SMTP id d28so1945843ote.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u2AdtgGZjJ/MZvnuzSUgIRCOvopaM5akLDS9y8CwciM=;
 b=FbFwVRZrfpilUENWQsAPvw1m1mLYXGaclwT93lqJnxnGVuqqDIKCdw/KcLIdOxFPb0
 KVroBJf/DKGypj5E7KsDwJSPy3/8Rb0QyExhwkPDdjcfqbvybrgjZPTZ5Mkj8x4XrMZY
 HsyAsSqcaxpFuIrhcQ3CUYdYE8KnF/4UeRgLR4CHZ2JWiiuRMHimTKQp69ldMW/fPbov
 38CbNIFu5Ri8bWbMHIEjZwFosxWMNXtbogxvnJUS8A3mFKOYkc0c4NtNHn1TWZVl/r2z
 DEOuIyEQjNwILtjfbaF6S0zMuhwLxB+hn9Qh2DqU7X6WmyuFTfaZHt5CW4vwci0NiYd/
 0tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u2AdtgGZjJ/MZvnuzSUgIRCOvopaM5akLDS9y8CwciM=;
 b=G6rPDfcxcrUIqqQGtY7ocI1SAxjCcMj8kRVpgOusPA3U6I5Cz2RGg8TJN8b4YkSAFl
 D8/7aFM8kopX4FYeqdMtWScwUG8A48ovLBa24lVHtT3V/AfMl5jgDpHxfT9RavahQw9O
 XK3dn8ZihnkwXeU0sWjWaLjuwNYLmq5vdv5LkCkGdNNqSciT0hfSwJCqNJN9XlPF3uch
 Ua9KtaKByW23K5h6gpNlC+E7g8gyfoIQzhtTBpUa4wiyfs2F/mYWh2AjINijqObRByTK
 q+j1AtUVIGV3lulqP+ecqAawQtl21QQnd+7QIr0YS1biNQAMPqr6p6ZtvwejoejI1fzR
 BOFw==
X-Gm-Message-State: AOAM531rkGATS/qOy8eI19XaW4gOVmZ73WaCAz/07PnWI9CJCUNrHDf/
 iu0HSPZapFfb85tHgTGOJ0eXX0RJHT0v/emqh0E=
X-Google-Smtp-Source: ABdhPJzNMqojNaCaBdLu91tMNAPhgvSJwlG9DBEhmX1OfUwX2MY+SNP/j6bO9hPQKpTamVs5c2zYli1Wk0hAU0FkE2Q=
X-Received: by 2002:a9d:3f06:: with SMTP id m6mr1493540otc.173.1602742549168; 
 Wed, 14 Oct 2020 23:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 15 Oct 2020 08:15:37 +0200
Message-ID: <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004f470805b1af9441"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004f470805b1af9441
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 14, 2020 at 3:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> This pull request is the last build system change for 5.2 from
> me, and it is simple: similar to how we are invoking
> ROM or tests/tcg "make" from the main Makefile, we now invoke ninja
> to build QEMU.  Unlike those cases, however, build.ninja targets are
> forwarded transparently.
>
> The advantages cover various areas:
>
> - maintainability: we drop scripts/ninjatool.py, which is
> a large and hairy piece of code, and generally remove one
> thing that can go wrong and one thing that is unique to QEMU;
>
> - platform support: we remove the requirement for GNU make
> 3.82, which was annoying on Mac.  We also avoid bugs on Windows
> due to meson emitting Windows rather than POSIX escapes (as
> expected by Ninja) and ninjatool ignoring the difference;
>
> - speed: invoking "configure" does not have to generate
> 44k lines of rules, while invoking "Make" does not anymore have
> to parse 44k lines of rules.
>
> - ease of use: Ninja tracks command lines, hence the problem
> of static library changing the objects they hold goes away
>
> Paolo
>
>
Hi,

I still have some issues when compiling on Windows with msys2/mingw64 after
this patch set. Command line:

mkdir build && cd build && ../configure --cross-prefix=x86_64-w64-mingw32-
--target-list=ppc-softmmu --enable-gtk --enable-sdl

Traceback (most recent call last):
  File "C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/mesonmain.py",
line 131, in run
    return options.run_func(options)
  File "C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/msetup.py",
line 245, in run
    app.generate()
  File "C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/msetup.py",
line 159, in generate
    self._generate(env)
  File "C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/msetup.py",
line 215, in _generate
    intr.backend.generate()
  File
"C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/backend/ninjabackend.py",
line 483, in generate
    ninja = environment.detect_ninja_command_and_version(log=True)
  File
"C:/msys64/home/hsp/src/qemu-master/meson/mesonbuild/environment.py", line
177, in detect_ninja_command_and_version
    name = os.path.basename(n)
  File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 231, in basename
    return split(p)[1]
  File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 200, in split
    p = os.fspath(p)
TypeError: expected str, bytes or os.PathLike object, not NoneType

ERROR: meson setup failed

When I set --ninja=ninja explicitly, this error does not occur:
Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE

However, compiling then runs into a problem:
$ make -j8
/mingw64/bin/python3 -B /home/hsp/src/qemu-master/meson/meson.py introspect
--targets --tests --benchmarks | /mingw64/bin/python3 -B
scripts/mtest2make.py > Makefile.mtest
{ echo 'ninja-targets = \'; ninja -t targets all | sed 's/:.*//; $!s/$/
\\/'; } > Makefile.ninja
ninja  -j8   all | cat
make[1]: *** No rule to make target 'multiboot.bin', needed by 'all'.  Stop.
make: *** [Makefile:171: pc-bios/optionrom/all] Error 2
make: *** Waiting for unfinished jobs....

The problem with optionrom was already present earlier and could be fixed
by applying:
https://patchwork.ozlabs.org/project/qemu-devel/list/?series=202798

That patch set does by now not apply cleanly anymore.

Best,
Howard

--0000000000004f470805b1af9441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 14, 2020 at 3:57 PM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonz=
ini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">This pull request is the last build system change for 5.2 fro=
m<br>
me, and it is simple: similar to how we are invoking<br>
ROM or tests/tcg &quot;make&quot; from the main Makefile, we now invoke nin=
ja<br>
to build QEMU.=C2=A0 Unlike those cases, however, build.ninja targets are<b=
r>
forwarded transparently.<br>
<br>
The advantages cover various areas:<br>
<br>
- maintainability: we drop scripts/ninjatool.py, which is<br>
a large and hairy piece of code, and generally remove one<br>
thing that can go wrong and one thing that is unique to QEMU;<br>
<br>
- platform support: we remove the requirement for GNU make<br>
3.82, which was annoying on Mac.=C2=A0 We also avoid bugs on Windows<br>
due to meson emitting Windows rather than POSIX escapes (as<br>
expected by Ninja) and ninjatool ignoring the difference;<br>
<br>
- speed: invoking &quot;configure&quot; does not have to generate<br>
44k lines of rules, while invoking &quot;Make&quot; does not anymore have<b=
r>
to parse 44k lines of rules.<br>
<br>
- ease of use: Ninja tracks command lines, hence the problem<br>
of static library changing the objects they hold goes away<br>
<br>
Paolo<br>
<br></blockquote><div>=C2=A0</div><div>Hi,</div><div><br></div><div>I still=
 have some issues when compiling on Windows with msys2/mingw64 after this p=
atch set. Command line:</div><div><br></div><div>mkdir build &amp;&amp; cd =
build &amp;&amp; ../configure --cross-prefix=3Dx86_64-w64-mingw32- --target=
-list=3Dppc-softmmu --enable-gtk --enable-sdl</div><div><br></div><div>Trac=
eback (most recent call last):<br>=C2=A0 File &quot;C:/msys64/home/hsp/src/=
qemu-master/meson/mesonbuild/mesonmain.py&quot;, line 131, in run<br>=C2=A0=
 =C2=A0 return options.run_func(options)<br>=C2=A0 File &quot;C:/msys64/hom=
e/hsp/src/qemu-master/meson/mesonbuild/msetup.py&quot;, line 245, in run<br=
>=C2=A0 =C2=A0 app.generate()<br>=C2=A0 File &quot;C:/msys64/home/hsp/src/q=
emu-master/meson/mesonbuild/msetup.py&quot;, line 159, in generate<br>=C2=
=A0 =C2=A0 self._generate(env)<br>=C2=A0 File &quot;C:/msys64/home/hsp/src/=
qemu-master/meson/mesonbuild/msetup.py&quot;, line 215, in _generate<br>=C2=
=A0 =C2=A0 intr.backend.generate()<br>=C2=A0 File &quot;C:/msys64/home/hsp/=
src/qemu-master/meson/mesonbuild/backend/ninjabackend.py&quot;, line 483, i=
n generate<br>=C2=A0 =C2=A0 ninja =3D environment.detect_ninja_command_and_=
version(log=3DTrue)<br>=C2=A0 File &quot;C:/msys64/home/hsp/src/qemu-master=
/meson/mesonbuild/environment.py&quot;, line 177, in detect_ninja_command_a=
nd_version<br>=C2=A0 =C2=A0 name =3D os.path.basename(n)<br>=C2=A0 File &qu=
ot;C:/msys64/mingw64/lib/python3.8/ntpath.py&quot;, line 231, in basename<b=
r>=C2=A0 =C2=A0 return split(p)[1]<br>=C2=A0 File &quot;C:/msys64/mingw64/l=
ib/python3.8/ntpath.py&quot;, line 200, in split<br>=C2=A0 =C2=A0 p =3D os.=
fspath(p)<br>TypeError: expected str, bytes or os.PathLike object, not None=
Type<br><br>ERROR: meson setup failed<br></div><div><br></div><div>When I s=
et --ninja=3Dninja explicitly, this error does not occur:</div><div>Found n=
inja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE</div><div><br></div><div=
>However, compiling then runs into a problem:<br></div><div>$ make -j8<br>/=
mingw64/bin/python3 -B /home/hsp/src/qemu-master/meson/meson.py introspect =
--targets --tests --benchmarks | /mingw64/bin/python3 -B scripts/mtest2make=
.py &gt; Makefile.mtest<br>{ echo &#39;ninja-targets =3D \&#39;; ninja -t t=
argets all | sed &#39;s/:.*//; $!s/$/ \\/&#39;; } &gt; Makefile.ninja<br>ni=
nja =C2=A0-j8 =C2=A0 all | cat<br>make[1]: *** No rule to make target &#39;=
multiboot.bin&#39;, needed by &#39;all&#39;.=C2=A0 Stop.<br>make: *** [Make=
file:171: pc-bios/optionrom/all] Error 2<br>make: *** Waiting for unfinishe=
d jobs....<br></div><div><br></div><div>The problem with optionrom was alre=
ady present earlier and could be fixed by applying:</div><div> =20
<div><a href=3D"https://patchwork.ozlabs.org/project/qemu-devel/list/?serie=
s=3D202798" target=3D"_blank">https://patchwork.ozlabs.org/project/qemu-dev=
el/list/?series=3D202798</a></div><div><br></div><div>That patch set does b=
y now not apply cleanly anymore.<br></div><div><br></div><div>Best,</div><d=
iv>Howard<br></div>

</div></div></div>

--0000000000004f470805b1af9441--

