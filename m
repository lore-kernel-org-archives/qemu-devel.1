Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A08208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAb+01qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A08208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvpg-0000kc-Ce
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAvos-0008Jd-Pz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:50:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:46329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAvon-0008M8-1c
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:50:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id d11so2906819ejt.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bUBfWFnHFK4Sbwf8GvU2FpRepm+4AfQNfSiY7GdqAaU=;
 b=XAb+01qdxAu//jN3qVSHwzUguMhDSvC0IeD699mxFgackR2fcbdZWzbM4cXgBFxmyD
 m+5bib+JPL+j/6iQeq2XlRRhlUzDD6N76uNN35uaRHqhZjgSmo/xMJxcbT4Qvj0yWCQg
 wLTg2kr1BjXCk9xLMq11tYWqRo4fi6w19Ij78MKrgLKJJaAJ4FOw8tY3/NqqznxxO0Q8
 h3asFkqTwUPH5gD17Zt4R8I32hS2zhfDO/KUUH/tCSN4rXTaj/dW0KfTmk12IFYwff8h
 6rH61rLCTf2ku7H/IcAd0wIsAa24716qNfKY2DnB7cB/kEAWVYnDijoY2/nBVvDdOuyG
 rwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bUBfWFnHFK4Sbwf8GvU2FpRepm+4AfQNfSiY7GdqAaU=;
 b=F51+z+BY3UUThC2KYcIfoL/BVj6CtCo2gCmO1JEcc97wVb3+6q9BgCphTseOxVkFO3
 D09VAay7CP4a3MIV4OT6nWOwJiC+CUw+WEBizAQr00B8qNkG17P+aV+vez9sDiyS+bCR
 J/5+/pjf2ovmwouOhj59sdBd4YFSNyM48M4ieJPhsRF6EdDfT9zs574rqmkO10sUPmBu
 wFRp3fxCNGRO2w6oq4wAHmsfaOpn+8QJ8e4u1/3aPs8ws4Ts7MDJ/lWpcelNx83+G2DF
 mLKuMMMSUfY/dlDq2FgE/LR1wi4Zav4MdwTXJxWETCM2pu4JKR5JXO45/YgmVu6lV+jd
 +Y9Q==
X-Gm-Message-State: AOAM532jZcirH9mGnphqBfkPh4efOD5gJdYVo8IRAK4yxkjiJ2y9rIhh
 RusGooKFSnGkqEpZeRgOGCpAZPWqA9s+8JV0olk=
X-Google-Smtp-Source: ABdhPJyV2ZGwwbI/e/Iiga16jgCYjTB7G32Z+HTfUBEW/Zz7Q2uPCNrRpDjOxSsYeGIt0rZLIrRCJgl6BnT0L0shhhs=
X-Received: by 2002:a17:906:3816:: with SMTP id
 v22mr15606040ejc.105.1598449821919; 
 Wed, 26 Aug 2020 06:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <9AB9A3F5-8AA6-4F82-9693-D331251AA0CB@gmail.com>
In-Reply-To: <9AB9A3F5-8AA6-4F82-9693-D331251AA0CB@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 17:50:10 +0400
Message-ID: <CAJ+F1CKk_jYqPPsGUPLk+MLBUymSeMNjEKpqRR2e-xQry9N3=Q@mail.gmail.com>
Subject: Re: Issue with submodules on macOS & meson
To: Emmanuel Blot <eblot.com@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d3ae3b05adc8195e"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3ae3b05adc8195e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 5:40 PM Emmanuel Blot <eblot.com@gmail.com> wrote:

> Hi,
>
> Using current master 78dca230 w/ Meson/ninja, build fails with capstone
> dependency.
>
> * ../configure --target-list=3Driscv64-softmmu && ninja
>

You need to run 'make' (at least once - but still by preference for now).
Submodule handling is done by Makefile.

   fails because capstone is automatically enabled @ configure stage,
> but capstone is not installed on the host, and the local capstone/
> submodule is not automatically populated:
>
> cc -Ilibqemu-riscv64-softmmu.fa.p -I. -I.. -Itarget/riscv
> -I../target/riscv -Iqapi -Itrace -Iui -Iui/shader
> -I/usr/local/Cellar/pixman/0.40.0/include/pixman-1
> -I/usr/local/Cellar/glib/2.64.4_2/include
> -I/usr/local/Cellar/glib/2.64.4_2/include/glib-2.0
> -I/usr/local/Cellar/glib/2.64.4_2/lib/glib-2.0/include
> -I/usr/local/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/include
> -I/usr/local/Cellar/gnutls/3.6.14/include
> -I/usr/local/Cellar/nettle/3.6/include
> -I/usr/local/Cellar/libtasn1/4.16.0/include
> -I/usr/local/Cellar/libidn2/2.3.0/include
> -I/usr/local/Cellar/p11-kit/0.23.20_1/include/p11-kit-1
> -I/Users/eblot/Sources/Git/github.com/QEMU/upstream/capstone/include
> -Xclang -fcolor-diagnostics -pipe -Wall -Winvalid-pch -std=3Dgnu99 -O2 -g
> -m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_64 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv -Wold-style-definition
> -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
> -Wexpansion-to-defined -Wno-initializer-overrides
> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int
> -Wno-typedef-redefinition -Wno-tautological-type-limit-compare
> -fstack-protector-strong -iquote
> /Users/eblot/Sources/Git/github.com/QEMU/upstream/tcg/i386 -iquote .
> -iquote /Users/eblot/Sources/Git/github.com/QEMU/upstream -iquote
> /Users/eblot/Sources/Git/github.com/QEMU/upstream/accel/tcg -iquote
> /Users/eblot/Sources/Git/github.com/QEMU/upstream/include -iquote
> /Users/eblot/Sources/Git/github.com/QEMU/upstream/disas/libvixl
> -DNEED_CPU_H '-DCONFIG_TARGET=3D"riscv64-softmmu-config-target.h"'
> '-DCONFIG_DEVICES=3D"riscv64-softmmu-config-devices.h"' -MD -MQ
> libqemu-riscv64-softmmu.fa.p/disas.c.o -MF
> libqemu-riscv64-softmmu.fa.p/disas.c.o.d -o
> libqemu-riscv64-softmmu.fa.p/disas.c.o -c ../disas.c
> In file included from ../disas.c:9:
> /Users/eblot/Sources/Git/
> github.com/QEMU/upstream/include/disas/capstone.h:6:10:
> error: 'capstone.h' file not found with <angled> include; use "quotes"
> instead
> #include <capstone.h>
>           ^~~~~~~~~~~~
>           "capstone.h"
>
> * ../configure --target-list=3Driscv64-softmmu =E2=80=94enable-capstone=
=3Dgit &&
> ninja
>    fails for the same reason (git submodule is not pulled)
>
> * git submodule init && git submodule update capstone && ../configure
> --target-list=3Driscv64-softmmu && ninja
>    fails because capstone.h is now found, but the library is not built:
>
>      ld: library not found for -lcapstone
>      clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>
>     build/capstone is created but stays empty.
>
> * ../configure --target-list=3Driscv64-softmmu =E2=80=94disable-capstone
>     seems ok
>
> A similar issue arises with slirp: slirp is automatically selected while
> not installed on the host and not pulled as a submodule. If the
> submodule is manually pulled, slirp is not built and QEMU fails to build
> because libslirp-version.h is not generated.
>
>     /Users/eblot/Sources/Git/
> github.com/QEMU/upstream/slirp/src/libslirp.h:17:10:
> fatal error: 'libslirp-version.h' file not found
>
> Am I missing something obvious?
>
> I cannot reproduce those issues with v.5.1.0
>
>
> Thanks,
> Emmanuel.
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d3ae3b05adc8195e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 5:40 PM Emm=
anuel Blot &lt;<a href=3D"mailto:eblot.com@gmail.com">eblot.com@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
Using current master 78dca230 w/ Meson/ninja, build fails with capstone <br=
>
dependency.<br>
<br>
* ../configure --target-list=3Driscv64-softmmu &amp;&amp; ninja<br></blockq=
uote><div><br></div><div>You need to run &#39;make&#39; (at least once - bu=
t still by preference for now). Submodule handling is done by Makefile.<br>=
</div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0fails because capstone is automatically enabled @ configure st=
age, <br>
but capstone is not installed on the host, and the local capstone/ <br>
submodule is not automatically populated:<br>
<br>
cc -Ilibqemu-riscv64-softmmu.fa.p -I. -I.. -Itarget/riscv <br>
-I../target/riscv -Iqapi -Itrace -Iui -Iui/shader <br>
-I/usr/local/Cellar/pixman/0.40.0/include/pixman-1 <br>
-I/usr/local/Cellar/glib/2.64.4_2/include <br>
-I/usr/local/Cellar/glib/2.64.4_2/include/glib-2.0 <br>
-I/usr/local/Cellar/glib/2.64.4_2/lib/glib-2.0/include <br>
-I/usr/local/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/include <br>
-I/usr/local/Cellar/gnutls/3.6.14/include <br>
-I/usr/local/Cellar/nettle/3.6/include <br>
-I/usr/local/Cellar/libtasn1/4.16.0/include <br>
-I/usr/local/Cellar/libidn2/2.3.0/include <br>
-I/usr/local/Cellar/p11-kit/0.23.20_1/include/p11-kit-1 <br>
-I/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/capst=
one/include" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream/=
capstone/include</a> <br>
-Xclang -fcolor-diagnostics -pipe -Wall -Winvalid-pch -std=3Dgnu99 -O2 -g <=
br>
-m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_64 -D_GNU_SOURCE <br>
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes <br>
-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes <br>
-fno-strict-aliasing -fno-common -fwrapv -Wold-style-definition <br>
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self <br>
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels <br>
-Wexpansion-to-defined -Wno-initializer-overrides <br>
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int <b=
r>
-Wno-typedef-redefinition -Wno-tautological-type-limit-compare <br>
-fstack-protector-strong -iquote <br>
/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/tcg/i38=
6" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream/tcg/i386</=
a> -iquote . <br>
-iquote /Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream=
" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream</a> -iquote=
 <br>
/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/accel/t=
cg" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream/accel/tcg=
</a> -iquote <br>
/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/include=
" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream/include</a>=
 -iquote <br>
/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/disas/l=
ibvixl" rel=3D"noreferrer" target=3D"_blank">github.com/QEMU/upstream/disas=
/libvixl</a> <br>
-DNEED_CPU_H &#39;-DCONFIG_TARGET=3D&quot;riscv64-softmmu-config-target.h&q=
uot;&#39; <br>
&#39;-DCONFIG_DEVICES=3D&quot;riscv64-softmmu-config-devices.h&quot;&#39; -=
MD -MQ <br>
libqemu-riscv64-softmmu.fa.p/disas.c.o -MF <br>
libqemu-riscv64-softmmu.fa.p/disas.c.o.d -o <br>
libqemu-riscv64-softmmu.fa.p/disas.c.o -c ../disas.c<br>
In file included from ../disas.c:9:<br>
/Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/upstream/include=
/disas/capstone.h:6:10" rel=3D"noreferrer" target=3D"_blank">github.com/QEM=
U/upstream/include/disas/capstone.h:6:10</a>: <br>
error: &#39;capstone.h&#39; file not found with &lt;angled&gt; include; use=
 &quot;quotes&quot; <br>
instead<br>
#include &lt;capstone.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;capstone.h&quot;<br>
<br>
* ../configure --target-list=3Driscv64-softmmu =E2=80=94enable-capstone=3Dg=
it &amp;&amp; <br>
ninja<br>
=C2=A0 =C2=A0fails for the same reason (git submodule is not pulled)<br>
<br>
* git submodule init &amp;&amp; git submodule update capstone &amp;&amp; ..=
/configure <br>
--target-list=3Driscv64-softmmu &amp;&amp; ninja<br>
=C2=A0 =C2=A0fails because capstone.h is now found, but the library is not =
built:<br>
<br>
=C2=A0 =C2=A0 =C2=A0ld: library not found for -lcapstone<br>
=C2=A0 =C2=A0 =C2=A0clang: error: linker command failed with exit code 1 (u=
se -v to see <br>
invocation)<br>
<br>
=C2=A0 =C2=A0 build/capstone is created but stays empty.<br>
<br>
* ../configure --target-list=3Driscv64-softmmu =E2=80=94disable-capstone<br=
>
=C2=A0 =C2=A0 seems ok<br>
<br>
A similar issue arises with slirp: slirp is automatically selected while <b=
r>
not installed on the host and not pulled as a submodule. If the <br>
submodule is manually pulled, slirp is not built and QEMU fails to build <b=
r>
because libslirp-version.h is not generated.<br>
<br>
=C2=A0 =C2=A0 /Users/eblot/Sources/Git/<a href=3D"http://github.com/QEMU/up=
stream/slirp/src/libslirp.h:17:10" rel=3D"noreferrer" target=3D"_blank">git=
hub.com/QEMU/upstream/slirp/src/libslirp.h:17:10</a>: <br>
fatal error: &#39;libslirp-version.h&#39; file not found<br>
<br>
Am I missing something obvious?<br>
<br>
I cannot reproduce those issues with v.5.1.0<br>
<br>
<br>
Thanks,<br>
Emmanuel.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000d3ae3b05adc8195e--

