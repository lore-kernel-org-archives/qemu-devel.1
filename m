Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BADC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF7E212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGFpAMk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF7E212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT88Z-000559-BG
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT7t5-00077p-H0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:22:03 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT7t2-0004EJ-Io
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:22:03 -0400
Received: by mail-lf1-x141.google.com with SMTP id r127so4654124lff.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=WWCer4MxTJGlPPXE+r1o40+eRR95T1PJ0Q1TQVa8GtA=;
 b=dGFpAMk2Iw0kAw00E3FepMQw+lm9UbLq2K590f/Y9+sOZjs+uDK/ubn8wuh/wsdQ5U
 +6OaqzZQDlFB6Yt8tNirMshXXzQd+E+55OQgPY2qrqQ0q+Rshknwq+nx+KHC/v/rtXZU
 PGE9HyHv3TjsyM4VvB+UJWZjDtStKiRAZ/yK1ezYyz4UU/uybHeYRoq20dNnFuRcEcrN
 qgsx5i+pcVkdWXXOB1rEp2rHBiC5x5DMzXf3ryPCo5MrNG4UBv9Ac1Xgs0EyTGibJBK9
 MT+h+r7ekCgINi4bkPYH8cCPFQ92uQna4Sr4+XHuET+/mjad5SVrij7JVBTqaDFxdz/X
 3qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WWCer4MxTJGlPPXE+r1o40+eRR95T1PJ0Q1TQVa8GtA=;
 b=le0jFtWSn3RuDhnNqL4HOSTjXEiS9XorSXlsEi9QhGPjcN6MBKemBCxrX/oT7CNd+B
 h1/qNyOLfevVyVmaFAT5sr/N9mWSXOeeXvOKWCX526OFisHY5DvpKmLGMA6PIr8LzIuR
 0ZG+eu55E63lvox6436zE1ZfN9TBP2vV2ll/97jQydeJftBWhiDFWmIEq5WFWZUupudZ
 ixrCl9VRqI8fHt88zg3FWfOQWYLFWwaX80uADddDaKPZ1en3m1RNnRSuikm2WPSxC/yj
 n8Bnry8IARhyacp5VPK1jwKBQOeRNzCRwhz/3Oz5N+hAYYooc0QkgvQhiGE150SFJEf7
 OeVA==
X-Gm-Message-State: AOAM531Vb/msYl8O5ycpS30agbUePU1JL+iMt2xrVf4GGvaYweYfX8KP
 0VchhgeBL4cFRTo7tyW+RoQ2zLoAlZDbCF/UdH8=
X-Google-Smtp-Source: ABdhPJwIMgOJEzPcl6vrE5C1BIoKdu1xJ5PWz+45WJYpo8IT/KsmHECilBVe46OtugPncrLAEwz2NWNN0LadamcyurA=
X-Received: by 2002:a19:8a84:: with SMTP id m126mr1409269lfd.377.1602786114211; 
 Thu, 15 Oct 2020 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 02:21:42 +0800
Message-ID: <CAE2XoE896rKcAsWJrLHDROQfz5xhA=AU=pWC8FqWRjaFNT1Dhg@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd134705b1b9b8bb"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fd134705b1b9b8bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 9:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
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
> Paolo Bonzini (7):
>   tests/Makefile.include: unbreak non-tcg builds
>   make: run shell with pipefail
>   tests: add missing generated sources to testqapi
>   configure: move QEMU_INCLUDES to meson
>   dockerfiles: enable Centos 8 PowerTools
>   add ninja to dockerfiles, CI configurations and test VMs
>   build: replace ninjatool with ninja
>
>  .cirrus.yml                                |    6 +-
>  .travis.yml                                |   13 +
>  Makefile                                   |   42 +-
>  configure                                  |   29 +-
>  docs/devel/build-system.rst                |    6 +-
>  meson.build                                |   34 +-
>  scripts/mtest2make.py                      |    4 +-
>  scripts/ninjatool.py                       | 1008 --------------------
>  tests/Makefile.include                     |    2 +-
>  tests/docker/dockerfiles/centos7.docker    |    1 +
>  tests/docker/dockerfiles/centos8.docker    |    4 +
>  tests/docker/dockerfiles/debian10.docker   |    1 +
>  tests/docker/dockerfiles/fedora.docker     |    1 +
>  tests/docker/dockerfiles/travis.docker     |    2 +-
>  tests/docker/dockerfiles/ubuntu.docker     |    1 +
>  tests/docker/dockerfiles/ubuntu1804.docker |    1 +
>  tests/docker/dockerfiles/ubuntu2004.docker |    1 +
>  tests/include/meson.build                  |    8 +-
>  tests/meson.build                          |   14 +-
>  tests/vm/centos                            |    2 +-
>  tests/vm/centos.aarch64                    |    2 +-
>  tests/vm/fedora                            |    2 +-
>  tests/vm/freebsd                           |    1 +
>  tests/vm/netbsd                            |    1 +
>  tests/vm/openbsd                           |    1 +
>  tests/vm/ubuntu.aarch64                    |    2 +-
>  tests/vm/ubuntu.i386                       |    2 +-
>  27 files changed, 121 insertions(+), 1070 deletions(-)
>  delete mode 100755 scripts/ninjatool.py
>
> --
> 2.26.2
>
>
That's good, it's broken my locally rST doc build
```
[226/1564] Generating input-keymap-qnum-to-qcode.c.inc with a custom
command (wrapped by meson to capture output)
[227/1564] Generating input-keymap-qcode-to-qnum.c.inc with a custom
command (wrapped by meson to capture output)
[228/1564] Generating shared QAPI source files with a custom command
[229/1564] Generating input-keymap-qcode-to-linux.c.inc with a custom
command (wrapped by meson to capture output)
[230/1564] Generating input-keymap-win32-to-qcode.c.inc with a custom
command (wrapped by meson to capture output)
[231/1564] Generating QAPI rST doc with a custom command
FAILED: tests/qapi-schema/doc-good.txt
"/mingw64/bin/sphinx-build" "-Dversion=3D5.1.50" "-Drelease=3D" "-W" "-b"
"text" "-E" "-c" "C:/work/xemu/qemu/docs" "-D" "master_doc=3Ddoc-good"
"C:/work/xemu/qemu/tests/qapi-schema"
"C:/work/xemu/qemu/build/tests/qapi-schema"
CreateProcess failed: The system cannot find the file specified.
[232/1564] Generating input-keymap-qcode-to-atset1.c.inc with a custom
command (wrapped by meson to capture output)
[233/1564] Generating generated-helpers-wrappers.h with a custom command
(wrapped by meson to capture output)
ninja: fatal: GetOverlappedResult: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=D0=A7=EF=BF=BD=EF=BF=BD


make: *** [Makefile:87=EF=BC=9Arun-ninja] =E9=94=99=E8=AF=AF 1
/mingw64/bin/ninja -v -j1   tests/check-block-qdict.exe
tests/check-qdict.exe tests/check-qjson.exe tests/check-qlist.exe
tests/check-qlit.exe tests/check-qnull.exe tests/check-qnum.exe
tests/check-qobject.exe tests/check-qom-interface.exe
tests/check-qom-proplist.exe tests/check-qstring.exe tests/ptimer-test.exe
tests/qapi-schema/doc-good.ref.nocr tests/qapi-schema/doc-good.txt.nocr
tests/rcutorture.exe tests/test-aio-multithread.exe tests/test-aio.exe
tests/test-authz-list.exe tests/test-authz-listfile.exe
tests/test-authz-simple.exe tests/test-base64.exe tests/test-bdrv-drain.exe
tests/test-bdrv-graph-mod.exe tests/test-bitcnt.exe tests/test-bitmap.exe
tests/test-bitops.exe tests/test-block-backend.exe
tests/test-block-iothread.exe tests/test-blockjob-txn.exe
tests/test-blockjob.exe tests/test-bufferiszero.exe tests/test-char.exe
tests/test-clone-visitor.exe tests/test-coroutine.exe
tests/test-crypto-afsplit.exe tests/test-crypto-block.exe
tests/test-crypto-cipher.exe tests/test-crypto-hash.exe
tests/test-crypto-hmac.exe tests/test-crypto-ivgen.exe
tests/test-crypto-pbkdf.exe tests/test-crypto-secret.exe
tests/test-cutils.exe tests/test-hbitmap.exe tests/test-int128.exe
tests/test-io-channel-buffer.exe tests/test-io-channel-command.exe
tests/test-io-channel-file.exe tests/test-io-channel-socket.exe
tests/test-io-task.exe tests/test-iov.exe tests/test-keyval.exe
tests/test-logging.exe tests/test-mul64.exe tests/test-opts-visitor.exe
tests/test-qapi-util.exe tests/test-qdev-global-props.exe
tests/test-qdist.exe tests/test-qemu-opts.exe tests/test-qgraph.exe
tests/test-qht.exe tests/test-qmp-cmds.exe tests/test-qmp-event.exe
tests/test-qobject-input-visitor.exe tests/test-qobject-output-visitor.exe
tests/test-rcu-list.exe tests/test-rcu-simpleq.exe tests/test-rcu-slist.exe
tests/test-rcu-tailq.exe tests/test-replication.exe tests/test-shift128.exe
tests/test-string-input-visitor.exe tests/test-string-output-visitor.exe
tests/test-thread-pool.exe tests/test-throttle.exe
tests/test-timed-average.exe tests/test-util-sockets.exe
tests/test-uuid.exe tests/test-visitor-serialization.exe
tests/test-vmstate.exe tests/test-write-threshold.exe
tests/test-x86-cpuid.exe tests/test-xbzrle.exe | cat
```
That's because currently  sphinx-build  are found in configure not in
meson, maybe it's worth to move the sphinx related thing into meson totally=
.
--

         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fd134705b1b9b8bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Oct 14, 2020 at 9:58 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; This pull request is the last build system change for 5.2 fr=
om<br>&gt; me, and it is simple: similar to how we are invoking<br>&gt; ROM=
 or tests/tcg &quot;make&quot; from the main Makefile, we now invoke ninja<=
br>&gt; to build QEMU.=C2=A0 Unlike those cases, however, build.ninja targe=
ts are<br>&gt; forwarded transparently.<br>&gt;<br>&gt; The advantages cove=
r various areas:<br>&gt;<br>&gt; - maintainability: we drop scripts/ninjato=
ol.py, which is<br>&gt; a large and hairy piece of code, and generally remo=
ve one<br>&gt; thing that can go wrong and one thing that is unique to QEMU=
;<br>&gt;<br>&gt; - platform support: we remove the requirement for GNU mak=
e<br>&gt; 3.82, which was annoying on Mac.=C2=A0 We also avoid bugs on Wind=
ows<br>&gt; due to meson emitting Windows rather than POSIX escapes (as<br>=
&gt; expected by Ninja) and ninjatool ignoring the difference;<br>&gt;<br>&=
gt; - speed: invoking &quot;configure&quot; does not have to generate<br>&g=
t; 44k lines of rules, while invoking &quot;Make&quot; does not anymore hav=
e<br>&gt; to parse 44k lines of rules.<br>&gt;<br>&gt; - ease of use: Ninja=
 tracks command lines, hence the problem<br>&gt; of static library changing=
 the objects they hold goes away<br>&gt;<br>&gt; Paolo<br>&gt;<br>&gt; Paol=
o Bonzini (7):<br>&gt; =C2=A0 tests/Makefile.include: unbreak non-tcg build=
s<br>&gt; =C2=A0 make: run shell with pipefail<br>&gt; =C2=A0 tests: add mi=
ssing generated sources to testqapi<br>&gt; =C2=A0 configure: move QEMU_INC=
LUDES to meson<br>&gt; =C2=A0 dockerfiles: enable Centos 8 PowerTools<br>&g=
t; =C2=A0 add ninja to dockerfiles, CI configurations and test VMs<br>&gt; =
=C2=A0 build: replace ninjatool with ninja<br>&gt;<br>&gt; =C2=A0.cirrus.ym=
l =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +-<br>&gt; =C2=A0.tr=
avis.yml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 13 +<br>&gt; =C2=A0Ma=
kefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 42 +-<br>&gt;=
 =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 29 +=
-<br>&gt; =C2=A0docs/devel/build-system.rst =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +-<br>&gt; =C2=A0meson.build =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 34 +-<br>&gt; =C2=A0scripts/mtes=
t2make.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A04 +-<br>&gt; =C2=A0scripts/ninjatool.py =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 100=
8 --------------------<br>&gt; =C2=A0tests/Makefile.include =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-=
<br>&gt; =C2=A0tests/docker/dockerfiles/centos7.docker =C2=A0 =C2=A0| =C2=
=A0 =C2=A01 +<br>&gt; =C2=A0tests/docker/dockerfiles/centos8.docker =C2=A0 =
=C2=A0| =C2=A0 =C2=A04 +<br>&gt; =C2=A0tests/docker/dockerfiles/debian10.do=
cker =C2=A0 | =C2=A0 =C2=A01 +<br>&gt; =C2=A0tests/docker/dockerfiles/fedor=
a.docker =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +<br>&gt; =C2=A0tests/docker/docker=
files/travis.docker =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-<br>&gt; =C2=A0tests/d=
ocker/dockerfiles/ubuntu.docker =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +<br>&gt; =
=C2=A0tests/docker/dockerfiles/ubuntu1804.docker | =C2=A0 =C2=A01 +<br>&gt;=
 =C2=A0tests/docker/dockerfiles/ubuntu2004.docker | =C2=A0 =C2=A01 +<br>&gt=
; =C2=A0tests/include/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 +-<br>&gt; =C2=A0tests/meson.build =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 14 +-<br>&gt; =C2=A0tests/vm/centos =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A02 +-<br>&gt; =C2=A0tests/vm/centos.aarch64 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-<br>&gt; =C2=A0tests/vm/fedora =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-<br>&gt; =C2=A0tests/vm/freebsd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +<=
br>&gt; =C2=A0tests/vm/netbsd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +<br>&=
gt; =C2=A0tests/vm/openbsd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +<br>&gt; =C2=
=A0tests/vm/ubuntu.aarch64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-<br>&gt; =C2=A0tests/vm/ubuntu.i386=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A02 +-<br>&gt; =C2=A027 files changed, 121 insertions(+), =
1070 deletions(-)<br>&gt; =C2=A0delete mode 100755 scripts/ninjatool.py<br>=
&gt;<br>&gt; --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br>That&#39;s good, it&#39;s=
 broken my locally rST doc build=C2=A0<div>```</div><div>[226/1564] Generat=
ing input-keymap-qnum-to-qcode.c.inc with a custom command (wrapped by meso=
n to capture output)<br>[227/1564] Generating input-keymap-qcode-to-qnum.c.=
inc with a custom command (wrapped by meson to capture output)<br>[228/1564=
] Generating shared QAPI source files with a custom command<br>[229/1564] G=
enerating input-keymap-qcode-to-linux.c.inc with a custom command (wrapped =
by meson to capture output)<br>[230/1564] Generating input-keymap-win32-to-=
qcode.c.inc with a custom command (wrapped by meson to capture output)<br>[=
231/1564] Generating QAPI rST doc with a custom command<br>FAILED: tests/qa=
pi-schema/doc-good.txt<br>&quot;/mingw64/bin/sphinx-build&quot; &quot;-Dver=
sion=3D5.1.50&quot; &quot;-Drelease=3D&quot; &quot;-W&quot; &quot;-b&quot; =
&quot;text&quot; &quot;-E&quot; &quot;-c&quot; &quot;C:/work/xemu/qemu/docs=
&quot; &quot;-D&quot; &quot;master_doc=3Ddoc-good&quot; &quot;C:/work/xemu/=
qemu/tests/qapi-schema&quot; &quot;C:/work/xemu/qemu/build/tests/qapi-schem=
a&quot;<br>CreateProcess failed: The system cannot find the file specified.=
<br>[232/1564] Generating input-keymap-qcode-to-atset1.c.inc with a custom =
command (wrapped by meson to capture output)<br>[233/1564] Generating gener=
ated-helpers-wrappers.h with a custom command (wrapped by meson to capture =
output)<br>ninja: fatal: GetOverlappedResult: =EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=D0=A7=EF=BF=BD=EF=BF=BD<br><br><br>make: *** [Makefile:8=
7=EF=BC=9Arun-ninja] =E9=94=99=E8=AF=AF 1<br>/mingw64/bin/ninja -v -j1 =C2=
=A0 tests/check-block-qdict.exe tests/check-qdict.exe tests/check-qjson.exe=
 tests/check-qlist.exe tests/check-qlit.exe tests/check-qnull.exe tests/che=
ck-qnum.exe tests/check-qobject.exe tests/check-qom-interface.exe tests/che=
ck-qom-proplist.exe tests/check-qstring.exe tests/ptimer-test.exe tests/qap=
i-schema/doc-good.ref.nocr tests/qapi-schema/doc-good.txt.nocr tests/rcutor=
ture.exe tests/test-aio-multithread.exe tests/test-aio.exe tests/test-authz=
-list.exe tests/test-authz-listfile.exe tests/test-authz-simple.exe tests/t=
est-base64.exe tests/test-bdrv-drain.exe tests/test-bdrv-graph-mod.exe test=
s/test-bitcnt.exe tests/test-bitmap.exe tests/test-bitops.exe tests/test-bl=
ock-backend.exe tests/test-block-iothread.exe tests/test-blockjob-txn.exe t=
ests/test-blockjob.exe tests/test-bufferiszero.exe tests/test-char.exe test=
s/test-clone-visitor.exe tests/test-coroutine.exe tests/test-crypto-afsplit=
.exe tests/test-crypto-block.exe tests/test-crypto-cipher.exe tests/test-cr=
ypto-hash.exe tests/test-crypto-hmac.exe tests/test-crypto-ivgen.exe tests/=
test-crypto-pbkdf.exe tests/test-crypto-secret.exe tests/test-cutils.exe te=
sts/test-hbitmap.exe tests/test-int128.exe tests/test-io-channel-buffer.exe=
 tests/test-io-channel-command.exe tests/test-io-channel-file.exe tests/tes=
t-io-channel-socket.exe tests/test-io-task.exe tests/test-iov.exe tests/tes=
t-keyval.exe tests/test-logging.exe tests/test-mul64.exe tests/test-opts-vi=
sitor.exe tests/test-qapi-util.exe tests/test-qdev-global-props.exe tests/t=
est-qdist.exe tests/test-qemu-opts.exe tests/test-qgraph.exe tests/test-qht=
.exe tests/test-qmp-cmds.exe tests/test-qmp-event.exe tests/test-qobject-in=
put-visitor.exe tests/test-qobject-output-visitor.exe tests/test-rcu-list.e=
xe tests/test-rcu-simpleq.exe tests/test-rcu-slist.exe tests/test-rcu-tailq=
.exe tests/test-replication.exe tests/test-shift128.exe tests/test-string-i=
nput-visitor.exe tests/test-string-output-visitor.exe tests/test-thread-poo=
l.exe tests/test-throttle.exe tests/test-timed-average.exe tests/test-util-=
sockets.exe tests/test-uuid.exe tests/test-visitor-serialization.exe tests/=
test-vmstate.exe tests/test-write-threshold.exe tests/test-x86-cpuid.exe te=
sts/test-xbzrle.exe | cat<br></div><div>```<br>That&#39;s because currently=
=C2=A0

sphinx-build=C2=A0 are found in configure not in meson, maybe it&#39;s wort=
h to move the sphinx related thing into meson totally.<br>--</div><div><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div>

--000000000000fd134705b1b9b8bb--

