Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1118A20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXVthN8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1118A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSdV-0007Rq-97
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kDSba-0004xA-9O
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:15:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:44729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kDSbX-0000nA-Ve
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:15:13 -0400
Received: by mail-ej1-x62a.google.com with SMTP id a15so3921469ejf.11
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1zA3pnoQ0P7klP53llBV38v8HGqYWpkLL0JFolIipjU=;
 b=KXVthN8bRiUuPf48hiKp6vmhNJgtfyNFFJhJcFcFPX9JGKTBrrP7Tegt+t44xht1rd
 6Ac+jAYXVX3ZMRqPqqGD+MLIMrGh9OST8cIlgSL4f+ks6stLaXTcVuaxuxu4W2OOvj67
 9UCUc/vaAK6054yb1IilPPuFZFiauxWX7Hr76uFUPtDmeAWLl1kkYrcNjdkqywZdUD2b
 frtONVIoCTV0io5+ENj6sv+HXiS9tA0alLHu5n5aYH2xuvxVQMkG7NKxNUvS3JIjWink
 19s4c6lHPmLftUPMrl1ni+iNeot0LVxHadTwa/LNPqZBpr6ILC8ngR4arQphFWVbihIh
 DZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1zA3pnoQ0P7klP53llBV38v8HGqYWpkLL0JFolIipjU=;
 b=lrebNRButMBkVZxEai/PxN4pBw5rFWDqhseh1f0Gt5KeqvLh+9gYjMXu7/JC5w6RrB
 Q+tFQQsHRnPPyi29Q0gguR/xdnr75J2cnduTf8kHA8DBIx9GmPlOcnTQTldX474CwPbQ
 532WT4clMkBNg8pFolaIjWSTCALy+eLWs8vECGh05X2FkVG+u44Ze3Ohi8M+/8cWqOV/
 sJwyzZpaC5skkBttIzv8X/DNBl9Tn1peMrCMimDFC+vDdaUtsrnYi4ZIi0KpGp7MLL0Q
 ndRvK9OK0xvlCjwjAPO/md6WNmrE3Abh0Eb9ZusdYVyORYTNCY730TlfZIX4ZoMzyUaF
 e72w==
X-Gm-Message-State: AOAM5310sEf/6EzeunA2tmg7Axhp/YPE2kCzBY6tkRbVv6k+RyNtZKDZ
 AoO0Ir/mFaMYVO+ACWcDHrvH2VTu5Ui/Q0OcvOA=
X-Google-Smtp-Source: ABdhPJzDRKVgYrdd/g+pe47tFULS7ILDxFHaYCWcVga5knrun1WcnclsaopPGC5pVfXHLesG/JINhQADFnS3qJhdF+c=
X-Received: by 2002:a17:906:a88a:: with SMTP id
 ha10mr6643705ejb.532.1599052510506; 
 Wed, 02 Sep 2020 06:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125917.26021-1-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Sep 2020 17:14:58 +0400
Message-ID: <CAJ+F1C+x0EQj3KJoEV+4ksb8r473Z_Vk7wN=gx0ua8JHXjh1EQ@mail.gmail.com>
Subject: Re: [PATCH 00/39] Next round of Meson fixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ddb29805ae546c2c"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62a.google.com
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

--000000000000ddb29805ae546c2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

On Wed, Sep 2, 2020 at 5:08 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> This is the final set of patches that I would like to have in 5.2
> as far as the Meson conversion is concerned.
>
> Patch 1 is a cross-compilation bugfix from Thomas.
>
> Patches 2..5 rework the "make check" generator so that outputs
> of successful tests are hidden, and so that if a test appears
> in multiple suites it is not run multiple times by "make check".
>
> Patch 6..10 are miscellaneous bugfixes.
>
> Patches 11..25 convert the check-unit testsuite.
>
> Patches 26..39 remove some of the now-dead code from the configure
> script and the Makefile, introducing some simplification whenever symbols
> are not needed anymore in the Makefile.
>
> Marc-Andr=C3=A9 Lureau (14):
>   meson: build qapi tests library
>   meson: declare tasn1 dependency
>   meson: declare keyutils dependency
>   meson: convert qht-bench
>   tests: qga has virtio-serial by default when host has it
>

When you respin, please drop this patch. While the intention is good
hopefully, it's not actually correct :)

thanks

  meson: convert the unit tests
>   meson: move keyutils dependency check
>   meson: remove old socket_scm_helper rule
>   meson: convert vhost-user-bridge
>   meson: convert atomic*-bench
>   tests: do not print benchmark output to stdout
>   tests/migration/stress: remove unused exit_success
>   meson: fix migration/stress compilation with glibc>=3D2.30
>   meson: convert migration/initrd-stress
>
> Paolo Bonzini (24):
>   mtest2make: split environment from test command
>   mtest2make: split working directory from test command
>   mtest2make: hide output of successful tests
>   mtest2make: unify tests that appear in multiple suites
>   meson: remove b_lundef option
>   configure: do not include absolute paths in -I and -L paths
>   configure: include cross sdl2-config in meson cross file
>   ninjatool: use constant names for stamp files
>   meson: fix libqos linking
>   meson: convert the speed tests
>   configure: remove dead code for in-tree builds
>   meson: compute config_all_devices directly
>   Makefile: remove dead variables and includes
>   Makefile: inline the relevant parts of rules.mak
>   configure: move disassembler configuration to meson
>   configure: move C++ compiler handling to meson
>   meson: keep all compiler flags detection together
>   configure: move -ldl test to meson
>   configure: remove unnecessary libm test
>   configure: do not look for install(1)
>   meson: get glib compilation flags from GLIB_CFLAGS
>   configure: do not include dependency flags in QEMU_CFLAGS and LIBS
>   configure: drop dead variables
>   docs: suggest Meson replacements for various configure functions
>
> Thomas Huth (1):
>   configure: Add system =3D 'linux' for meson when cross-compiling
>
>  .gitignore                       |   2 -
>  Makefile                         |  63 ++---
>  Makefile.objs                    |  34 ---
>  accel/tcg/meson.build            |   2 +-
>  configure                        | 331 ++-----------------------
>  disas/meson.build                |   4 +-
>  docs/devel/build-system.rst      |  18 +-
>  hw/arm/meson.build               |   2 +-
>  hw/riscv/meson.build             |   2 +-
>  meson.build                      | 135 ++++++++---
>  monitor/meson.build              |   2 +-
>  rules.mak                        | 158 ------------
>  scripts/empty.c                  |   6 +
>  scripts/grepy.sh                 |   3 -
>  scripts/mtest2make.py            |  95 ++++----
>  scripts/ninjatool.py             |   8 +-
>  scripts/test-driver.py           |  35 +++
>  tests/Makefile.include           | 405 +------------------------------
>  tests/benchmark-crypto-cipher.c  |   8 +-
>  tests/benchmark-crypto-hash.c    |   2 +-
>  tests/benchmark-crypto-hmac.c    |   8 +-
>  tests/include/meson.build        |  16 ++
>  tests/meson.build                | 259 ++++++++++++++++++++
>  tests/migration/initrd-stress.sh |  10 +
>  tests/migration/meson.build      |  14 ++
>  tests/migration/stress.c         |  15 +-
>  tests/qtest/libqos/meson.build   |   9 +-
>  tests/tcg/Makefile.qemu          |   2 -
>  tests/test-crypto-secret.c       |  10 +-
>  tests/test-qga.c                 |   4 +-
>  30 files changed, 588 insertions(+), 1074 deletions(-)
>  delete mode 100644 Makefile.objs
>  delete mode 100644 rules.mak
>  create mode 100644 scripts/empty.c
>  delete mode 100755 scripts/grepy.sh
>  create mode 100644 scripts/test-driver.py
>  create mode 100644 tests/include/meson.build
>  create mode 100755 tests/migration/initrd-stress.sh
>  create mode 100644 tests/migration/meson.build
>
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ddb29805ae546c2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 5:08 P=
M Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">This is the final set of patches that I would like to have in 5.2<br>
as far as the Meson conversion is concerned.<br>
<br>
Patch 1 is a cross-compilation bugfix from Thomas.<br>
<br>
Patches 2..5 rework the &quot;make check&quot; generator so that outputs<br=
>
of successful tests are hidden, and so that if a test appears<br>
in multiple suites it is not run multiple times by &quot;make check&quot;.<=
br>
<br>
Patch 6..10 are miscellaneous bugfixes.<br>
<br>
Patches 11..25 convert the check-unit testsuite.<br>
<br>
Patches 26..39 remove some of the now-dead code from the configure<br>
script and the Makefile, introducing some simplification whenever symbols<b=
r>
are not needed anymore in the Makefile.<br>
<br>
Marc-Andr=C3=A9 Lureau (14):<br>
=C2=A0 meson: build qapi tests library<br>
=C2=A0 meson: declare tasn1 dependency<br>
=C2=A0 meson: declare keyutils dependency<br>
=C2=A0 meson: convert qht-bench<br>
=C2=A0 tests: qga has virtio-serial by default when host has it<br></blockq=
uote><div><br></div><div>When you respin, please drop this patch. While the=
 intention is good hopefully, it&#39;s not actually correct :)</div><div><b=
r></div><div>thanks<br></div><div> <br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
=C2=A0 meson: convert the unit tests<br>
=C2=A0 meson: move keyutils dependency check<br>
=C2=A0 meson: remove old socket_scm_helper rule<br>
=C2=A0 meson: convert vhost-user-bridge<br>
=C2=A0 meson: convert atomic*-bench<br>
=C2=A0 tests: do not print benchmark output to stdout<br>
=C2=A0 tests/migration/stress: remove unused exit_success<br>
=C2=A0 meson: fix migration/stress compilation with glibc&gt;=3D2.30<br>
=C2=A0 meson: convert migration/initrd-stress<br>
<br>
Paolo Bonzini (24):<br>
=C2=A0 mtest2make: split environment from test command<br>
=C2=A0 mtest2make: split working directory from test command<br>
=C2=A0 mtest2make: hide output of successful tests<br>
=C2=A0 mtest2make: unify tests that appear in multiple suites<br>
=C2=A0 meson: remove b_lundef option<br>
=C2=A0 configure: do not include absolute paths in -I and -L paths<br>
=C2=A0 configure: include cross sdl2-config in meson cross file<br>
=C2=A0 ninjatool: use constant names for stamp files<br>
=C2=A0 meson: fix libqos linking<br>
=C2=A0 meson: convert the speed tests<br>
=C2=A0 configure: remove dead code for in-tree builds<br>
=C2=A0 meson: compute config_all_devices directly<br>
=C2=A0 Makefile: remove dead variables and includes<br>
=C2=A0 Makefile: inline the relevant parts of rules.mak<br>
=C2=A0 configure: move disassembler configuration to meson<br>
=C2=A0 configure: move C++ compiler handling to meson<br>
=C2=A0 meson: keep all compiler flags detection together<br>
=C2=A0 configure: move -ldl test to meson<br>
=C2=A0 configure: remove unnecessary libm test<br>
=C2=A0 configure: do not look for install(1)<br>
=C2=A0 meson: get glib compilation flags from GLIB_CFLAGS<br>
=C2=A0 configure: do not include dependency flags in QEMU_CFLAGS and LIBS<b=
r>
=C2=A0 configure: drop dead variables<br>
=C2=A0 docs: suggest Meson replacements for various configure functions<br>
<br>
Thomas Huth (1):<br>
=C2=A0 configure: Add system =3D &#39;linux&#39; for meson when cross-compi=
ling<br>
<br>
=C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 63 ++---<br>
=C2=A0Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 34 ---<br>
=C2=A0accel/tcg/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 331 ++-----------------------<br>
=C2=A0disas/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0hw/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 135 ++++++++---<br>
=C2=A0monitor/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0rules.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 158 ------------<br>
=C2=A0scripts/empty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0scripts/grepy.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 -<br>
=C2=A0scripts/mtest2make.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 95 ++++----<br>
=C2=A0scripts/ninjatool.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
=C2=A0scripts/test-driver.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 35 +++<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 405 =
+------------------------------<br>
=C2=A0tests/benchmark-crypto-cipher.c=C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A0tests/benchmark-crypto-hash.c=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0tests/benchmark-crypto-hmac.c=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A0tests/include/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 ++<br=
>
=C2=A0tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 259 ++++++++++++++++++++<br>
=C2=A0tests/migration/initrd-stress.sh |=C2=A0 10 +<br>
=C2=A0tests/migration/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 ++<br>
=C2=A0tests/migration/stress.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 =
+-<br>
=C2=A0tests/qtest/libqos/meson.build=C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
=C2=A0tests/tcg/Makefile.qemu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 -<br>
=C2=A0tests/test-crypto-secret.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br=
>
=C2=A0tests/test-qga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A030 files changed, 588 insertions(+), 1074 deletions(-)<br>
=C2=A0delete mode 100644 Makefile.objs<br>
=C2=A0delete mode 100644 rules.mak<br>
=C2=A0create mode 100644 scripts/empty.c<br>
=C2=A0delete mode 100755 scripts/grepy.sh<br>
=C2=A0create mode 100644 scripts/test-driver.py<br>
=C2=A0create mode 100644 tests/include/meson.build<br>
=C2=A0create mode 100755 tests/migration/initrd-stress.sh<br>
=C2=A0create mode 100644 tests/migration/meson.build<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ddb29805ae546c2c--

