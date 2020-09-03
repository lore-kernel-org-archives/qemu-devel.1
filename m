Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C5C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EB6206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoqfsQHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EB6206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlPi-00035P-H0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDlNw-0000yR-Ma
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:24 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:41831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDlNt-0007f5-Ru
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:24 -0400
Received: by mail-lf1-x12a.google.com with SMTP id y17so1476501lfa.8
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=0RpRYgXzjbSonhKXJR7sMM8vcaiOwmgO1vq7TGDHJvU=;
 b=QoqfsQHK7AfUKZ8QQOf8F7GNqD0ZFXbJCUcutgAeWOYo1mUzuieCPjBUcH9VsJgmqr
 5zhrUAcPWiDtyfC2sDACwrg2yp7r1HufE70HwFKzCRFWyUe1khtHBe+xuC4PSinRJ581
 28LpRz37slLFQN1KDLUAq+QD/2aeo88EC8B0DBvurrFc+7lSbFlAtEzCqNvKELUEjYsx
 A8BsagQyOv+IEAUQa+O5jzfGL9wbWwa4dcKna0jlV2/dhq1GyotdzzfTi3iScxuVHWZk
 cRfw/eNW5IX5SyofKWCnYkXF+RWIFhYOnUUW7GASCUIm/JBBZgETiERNKrt211R783qY
 HBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=0RpRYgXzjbSonhKXJR7sMM8vcaiOwmgO1vq7TGDHJvU=;
 b=nRKs+RrrftTY4rV2G3YM554KVgioNBhdNsknktA4igO74RFE8sRe7kAPw7oDgk7wi1
 ycRbHJrRtCss8nOoE4dWZ0wr5OSMycQbF6gJztPqWAN/bAW1jYIJbmyzBvP63M0JyWoo
 5dz3YitU+um+C9XcHkVEx52emv1CCUtrwDOXuhz+lznXkH8Oyl7IflBvVbLNmkpixIQ+
 JgeVjgr5UjBj8Vbvl1SziUFfDQclCw3EY76EKIytdCJImYPp7/RLcLDmRpY///sfH4Ys
 jRQYEbdt6yNbUquS7jQtJ+8lMEHFncnf4SbX56/mwkWs5bUDbV2zLyqy4op7qtiDyXir
 5e/Q==
X-Gm-Message-State: AOAM533XFLX6G9MRy/eDwnxk7RCSySnoH/u7UyufGlk43pdgoe3mx4Ya
 7MGNBn4n5ALROcdzXfnNVlSNz+QgP7x+oVWfoKs+e743Kbkhv6+G
X-Google-Smtp-Source: ABdhPJwIC2VyPGP9KsFh6+7CXnIioH1Hran6JgcKrYu5Gh+WcMRSqiWEN030Kj8gEOnjUKSjiAf3iVg6IJq0CdDYEx0=
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr805608lfl.117.1599124698962;
 Thu, 03 Sep 2020 02:18:18 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 17:18:07 +0800
Message-ID: <CAE2XoE_TJ2T2eN82km0pYqDiqOpsd=waH4EmCe==0k=GYpj3Xg@mail.gmail.com>
Subject: make -i check resut for msys2
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a21f7205ae653b1e"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12a.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a21f7205ae653b1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ make -i check
Regenerating build files.
Directory does not contain a valid build tree:
C:/work/xemu/qemu/build
make: [Makefile.ninja:5217=EF=BC=9Abuild.ninja] =E9=94=99=E8=AF=AF 1 (=E5=
=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/sli=
rp=E2=80=9D
make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=
=E4=BD=95=E4=BA=8B=E3=80=82
make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/sli=
rp=E2=80=9D
Generating qemu-version.h with a meson_exe.py custom command
Running test decodetree
Running test QAPI schema regression tests
Running test QAPI doc
Running test QAPI schema regression tests
Running test QAPI doc
  LINK    tests/test-aio-multithread.exe
  LINK    tests/test-bdrv-drain.exe
  CC      tests/test-qht-par.o
  LINK    tests/test-qht-par.exe
  TEST    check-unit: tests/check-qdict.exe
  TEST    check-unit: tests/check-block-qdict.exe
  TEST    check-unit: tests/check-qnum.exe
  TEST    check-unit: tests/check-qstring.exe
  TEST    check-unit: tests/check-qlist.exe
  TEST    check-unit: tests/check-qnull.exe
  TEST    check-unit: tests/check-qobject.exe
  TEST    check-unit: tests/check-qjson.exe
  TEST    check-unit: tests/check-qlit.exe
  TEST    check-unit: tests/test-qobject-output-visitor.exe
  TEST    check-unit: tests/test-clone-visitor.exe
  TEST    check-unit: tests/test-qobject-input-visitor.exe
  TEST    check-unit: tests/test-qmp-cmds.exe
  TEST    check-unit: tests/test-string-input-visitor.exe
  TEST    check-unit: tests/test-string-output-visitor.exe
  TEST    check-unit: tests/test-qmp-event.exe
  TEST    check-unit: tests/test-opts-visitor.exe
  TEST    check-unit: tests/test-coroutine.exe
  TEST    check-unit: tests/test-visitor-serialization.exe
  TEST    check-unit: tests/test-iov.exe
  TEST    check-unit: tests/test-bitmap.exe
  TEST    check-unit: tests/test-aio.exe
  TEST    check-unit: tests/test-aio-multithread.exe

(C:\work\xemu\qemu\build\tests\test-aio-multithread.exe:15216):
GLib-CRITICAL **: 17:11:56.670: g_source_remove_poll: assertion
'!SOURCE_DESTROYED (source)' failed
ERROR test-aio-multithread.exe - Bail out! GLib-FATAL-CRITICAL:
g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-throttle.exe
  TEST    check-unit: tests/test-thread-pool.exe
  TEST    check-unit: tests/test-hbitmap.exe
  TEST    check-unit: tests/test-bdrv-drain.exe

(C:\work\xemu\qemu\build\tests\test-bdrv-drain.exe:9152): GLib-CRITICAL **:
17:12:01.403: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)'
failed
ERROR test-bdrv-drain.exe - Bail out! GLib-FATAL-CRITICAL:
g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-bdrv-graph-mod.exe
  TEST    check-unit: tests/test-blockjob.exe
  TEST    check-unit: tests/test-blockjob-txn.exe
  TEST    check-unit: tests/test-block-backend.exe
  TEST    check-unit: tests/test-block-iothread.exe
  TEST    check-unit: tests/test-x86-cpuid.exe
  TEST    check-unit: tests/test-xbzrle.exe
  TEST    check-unit: tests/test-cutils.exe
  TEST    check-unit: tests/test-shift128.exe
  TEST    check-unit: tests/test-mul64.exe
  TEST    check-unit: tests/test-int128.exe
  TEST    check-unit: tests/rcutorture.exe
  TEST    check-unit: tests/test-rcu-list.exe
  TEST    check-unit: tests/test-rcu-simpleq.exe
  TEST    check-unit: tests/test-rcu-tailq.exe
  TEST    check-unit: tests/test-rcu-slist.exe
  TEST    check-unit: tests/test-qdist.exe
  TEST    check-unit: tests/test-qht.exe
  TEST    check-unit: tests/test-qht-par.exe
=E7=B3=BB=E7=BB=9F=E6=89=BE=E4=B8=8D=E5=88=B0=E6=8C=87=E5=AE=9A=E7=9A=84=E8=
=B7=AF=E5=BE=84=E3=80=82
**
ERROR:C:/work/xemu/qemu/tests/test-qht-par.c:20:test_qht: assertion failed
(rc =3D=3D 0): (1 =3D=3D 0)
ERROR test-qht-par.exe - Bail out!
ERROR:C:/work/xemu/qemu/tests/test-qht-par.c:20:test_qht: assertion failed
(rc =3D=3D 0): (1 =3D=3D 0)
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-bitops.exe
  TEST    check-unit: tests/test-bitcnt.exe
  TEST    check-unit: tests/test-qgraph.exe
  TEST    check-unit: tests/check-qom-interface.exe
  TEST    check-unit: tests/check-qom-proplist.exe
  TEST    check-unit: tests/test-qemu-opts.exe
  TEST    check-unit: tests/test-keyval.exe
  TEST    check-unit: tests/test-write-threshold.exe
  TEST    check-unit: tests/test-crypto-hash.exe
  TEST    check-unit: tests/test-crypto-hmac.exe
  TEST    check-unit: tests/test-crypto-cipher.exe
  TEST    check-unit: tests/test-crypto-secret.exe
  TEST    check-unit: tests/test-crypto-tlscredsx509.exe
ERROR test-crypto-tlscredsx509.exe - missing test plan
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-crypto-tlssession.exe
ERROR test-crypto-tlssession.exe - missing test plan
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-qdev-global-props.exe
**
ERROR:C:/work/xemu/qemu/tests/test-qdev-global-props.c:253:test_dynamic_glo=
balprop:
stderr of child process (/qdev/properties/dynamic/global/subprocess) failed
to match: *warning: global dynamic-prop-type-bad.prop3 has invalid class
name
*
stderr was:
warning: global dynamic-prop-type-bad.prop3 has invalid class name
warning: global nohotplug-type.prop5=3D105 not used
warning: global nondevice-type.prop6 has invalid class name

ERROR test-qdev-global-props.exe - Bail out!
ERROR:C:/work/xemu/qemu/tests/test-qdev-global-props.c:253:test_dynamic_glo=
balprop:
stderr of child process (/qdev/properties/dynamic/global/subprocess) failed
to match: *warning: global dynamic-prop-type-bad.prop3 has invalid class
name
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-timed-average.exe
  TEST    check-unit: tests/test-util-sockets.exe
ERROR test-util-sockets.exe - missing test plan
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-authz-simple.exe
  TEST    check-unit: tests/test-authz-list.exe
  TEST    check-unit: tests/test-authz-listfile.exe
  TEST    check-unit: tests/test-io-task.exe
  TEST    check-unit: tests/test-io-channel-socket.exe
ERROR test-io-channel-socket.exe - missing test plan
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-io-channel-file.exe
**
ERROR:C:/work/xemu/qemu/tests/test-io-channel-file.c:59:test_io_channel_fil=
e_helper:
assertion failed (TEST_MASK & ~mask =3D=3D st.st_mode & 0777): (384 =3D=3D =
438)
ERROR test-io-channel-file.exe - Bail out!
ERROR:C:/work/xemu/qemu/tests/test-io-channel-file.c:59:test_io_channel_fil=
e_helper:
assertion failed (TEST_MASK & ~mask =3D=3D st.st_mode & 0777): (384 =3D=3D =
438)

make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-io-channel-tls.exe
ERROR test-io-channel-tls.exe - missing test plan
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-io-channel-command.exe
  TEST    check-unit: tests/test-io-channel-buffer.exe
  TEST    check-unit: tests/test-base64.exe
  TEST    check-unit: tests/test-crypto-pbkdf.exe
  TEST    check-unit: tests/test-crypto-ivgen.exe
  TEST    check-unit: tests/test-crypto-afsplit.exe
  TEST    check-unit: tests/test-crypto-block.exe
  TEST    check-unit: tests/test-logging.exe
**
ERROR:C:/work/xemu/qemu/tests/test-logging.c:190:rmdir_full: assertion
failed: (g_remove(entry_path) =3D=3D 0)
ERROR test-logging.exe - Bail out!
ERROR:C:/work/xemu/qemu/tests/test-logging.c:190:rmdir_full: assertion
failed: (g_remove(entry_path) =3D=3D 0)
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-replication.exe
**
ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp: assertion
failed: (fd >=3D 0)
ERROR test-replication.exe - Bail out!
ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp: assertion
failed: (fd >=3D 0)
make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
  TEST    check-unit: tests/test-bufferiszero.exe
  TEST    check-unit: tests/test-uuid.exe
  TEST    check-unit: tests/ptimer-test.exe
  TEST    check-unit: tests/test-qapi-util.exe


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a21f7205ae653b1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>$ make -i check<br>Regenerating build files.<br>Direc=
tory does not contain a valid build tree:<br>C:/work/xemu/qemu/build<br>mak=
e: [Makefile.ninja:5217=EF=BC=9Abuild.ninja] =E9=94=99=E8=AF=AF 1 (=E5=B7=
=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=
=BD=95=E2=80=9C/c/work/xemu/qemu/slirp=E2=80=9D<br>make[1]: =E5=AF=B9=E2=80=
=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=
=82<br>make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/q=
emu/slirp=E2=80=9D<br>Generating qemu-version.h with a meson_exe.py custom =
command<br>Running test decodetree<br>Running test QAPI schema regression t=
ests<br>Running test QAPI doc<br>Running test QAPI schema regression tests<=
br>Running test QAPI doc<br>=C2=A0 LINK =C2=A0 =C2=A0tests/test-aio-multith=
read.exe<br>=C2=A0 LINK =C2=A0 =C2=A0tests/test-bdrv-drain.exe<br>=C2=A0 CC=
 =C2=A0 =C2=A0 =C2=A0tests/test-qht-par.o<br>=C2=A0 LINK =C2=A0 =C2=A0tests=
/test-qht-par.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check-qdict=
.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check-block-qdict.exe<br=
>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check-qnum.exe<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/check-qstring.exe<br>=C2=A0 TEST =C2=A0 =C2=
=A0check-unit: tests/check-qlist.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit=
: tests/check-qnull.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check=
-qobject.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check-qjson.exe<=
br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/check-qlit.exe<br>=C2=A0 TEST=
 =C2=A0 =C2=A0check-unit: tests/test-qobject-output-visitor.exe<br>=C2=A0 T=
EST =C2=A0 =C2=A0check-unit: tests/test-clone-visitor.exe<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/test-qobject-input-visitor.exe<br>=C2=A0 TES=
T =C2=A0 =C2=A0check-unit: tests/test-qmp-cmds.exe<br>=C2=A0 TEST =C2=A0 =
=C2=A0check-unit: tests/test-string-input-visitor.exe<br>=C2=A0 TEST =C2=A0=
 =C2=A0check-unit: tests/test-string-output-visitor.exe<br>=C2=A0 TEST =C2=
=A0 =C2=A0check-unit: tests/test-qmp-event.exe<br>=C2=A0 TEST =C2=A0 =C2=A0=
check-unit: tests/test-opts-visitor.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-u=
nit: tests/test-coroutine.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests=
/test-visitor-serialization.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tes=
ts/test-iov.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-bitmap.e=
xe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-aio.exe<br>=C2=A0 TES=
T =C2=A0 =C2=A0check-unit: tests/test-aio-multithread.exe<br><br>(C:\work\x=
emu\qemu\build\tests\test-aio-multithread.exe:15216): GLib-CRITICAL **: 17:=
11:56.670: g_source_remove_poll: assertion &#39;!SOURCE_DESTROYED (source)&=
#39; failed<br>ERROR test-aio-multithread.exe - Bail out! GLib-FATAL-CRITIC=
AL: g_source_remove_poll: assertion &#39;!SOURCE_DESTROYED (source)&#39; fa=
iled<br>make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-u=
nit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 T=
EST =C2=A0 =C2=A0check-unit: tests/test-throttle.exe<br>=C2=A0 TEST =C2=A0 =
=C2=A0check-unit: tests/test-thread-pool.exe<br>=C2=A0 TEST =C2=A0 =C2=A0ch=
eck-unit: tests/test-hbitmap.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: te=
sts/test-bdrv-drain.exe<br><br>(C:\work\xemu\qemu\build\tests\test-bdrv-dra=
in.exe:9152): GLib-CRITICAL **: 17:12:01.403: g_source_remove_poll: asserti=
on &#39;!SOURCE_DESTROYED (source)&#39; failed<br>ERROR test-bdrv-drain.exe=
 - Bail out! GLib-FATAL-CRITICAL: g_source_remove_poll: assertion &#39;!SOU=
RCE_DESTROYED (source)&#39; failed<br>make: [C:/work/xemu/qemu/tests/Makefi=
le.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=
=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-bdrv-=
graph-mod.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-blockjob.e=
xe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-blockjob-txn.exe<br>=
=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-block-backend.exe<br>=C2=A0=
 TEST =C2=A0 =C2=A0check-unit: tests/test-block-iothread.exe<br>=C2=A0 TEST=
 =C2=A0 =C2=A0check-unit: tests/test-x86-cpuid.exe<br>=C2=A0 TEST =C2=A0 =
=C2=A0check-unit: tests/test-xbzrle.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-u=
nit: tests/test-cutils.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/te=
st-shift128.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-mul64.ex=
e<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-int128.exe<br>=C2=A0 T=
EST =C2=A0 =C2=A0check-unit: tests/rcutorture.exe<br>=C2=A0 TEST =C2=A0 =C2=
=A0check-unit: tests/test-rcu-list.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-un=
it: tests/test-rcu-simpleq.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: test=
s/test-rcu-tailq.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-rcu=
-slist.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-qdist.exe<br>=
=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-qht.exe<br>=C2=A0 TEST =C2=
=A0 =C2=A0check-unit: tests/test-qht-par.exe<br>=E7=B3=BB=E7=BB=9F=E6=89=BE=
=E4=B8=8D=E5=88=B0=E6=8C=87=E5=AE=9A=E7=9A=84=E8=B7=AF=E5=BE=84=E3=80=82<br=
>**<br>ERROR:C:/work/xemu/qemu/tests/test-qht-par.c:20:test_qht: assertion =
failed (rc =3D=3D 0): (1 =3D=3D 0)<br>ERROR test-qht-par.exe - Bail out! ER=
ROR:C:/work/xemu/qemu/tests/test-qht-par.c:20:test_qht: assertion failed (r=
c =3D=3D 0): (1 =3D=3D 0)<br>make: [C:/work/xemu/qemu/tests/Makefile.includ=
e:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=
=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-bitops.exe<br>=
=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-bitcnt.exe<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/test-qgraph.exe<br>=C2=A0 TEST =C2=A0 =C2=A0=
check-unit: tests/check-qom-interface.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check=
-unit: tests/check-qom-proplist.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit:=
 tests/test-qemu-opts.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/tes=
t-keyval.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-write-thres=
hold.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-crypto-hash.exe=
<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-crypto-hmac.exe<br>=C2=
=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-crypto-cipher.exe<br>=C2=A0 TE=
ST =C2=A0 =C2=A0check-unit: tests/test-crypto-secret.exe<br>=C2=A0 TEST =C2=
=A0 =C2=A0check-unit: tests/test-crypto-tlscredsx509.exe<br>ERROR test-cryp=
to-tlscredsx509.exe - missing test plan<br>make: [C:/work/xemu/qemu/tests/M=
akefile.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=
=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test=
-crypto-tlssession.exe<br>ERROR test-crypto-tlssession.exe - missing test p=
lan<br>make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-un=
it] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TE=
ST =C2=A0 =C2=A0check-unit: tests/test-qdev-global-props.exe<br>**<br>ERROR=
:C:/work/xemu/qemu/tests/test-qdev-global-props.c:253:test_dynamic_globalpr=
op: stderr of child process (/qdev/properties/dynamic/global/subprocess) fa=
iled to match: *warning: global dynamic-prop-type-bad.prop3 has invalid cla=
ss name<br>*<br>stderr was:<br>warning: global dynamic-prop-type-bad.prop3 =
has invalid class name<br>warning: global nohotplug-type.prop5=3D105 not us=
ed<br>warning: global nondevice-type.prop6 has invalid class name<br><br>ER=
ROR test-qdev-global-props.exe - Bail out! ERROR:C:/work/xemu/qemu/tests/te=
st-qdev-global-props.c:253:test_dynamic_globalprop: stderr of child process=
 (/qdev/properties/dynamic/global/subprocess) failed to match: *warning: gl=
obal dynamic-prop-type-bad.prop3 has invalid class name<br>make: [C:/work/x=
emu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF =
1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-u=
nit: tests/test-timed-average.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: t=
ests/test-util-sockets.exe<br>ERROR test-util-sockets.exe - missing test pl=
an<br>make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-uni=
t] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TES=
T =C2=A0 =C2=A0check-unit: tests/test-authz-simple.exe<br>=C2=A0 TEST =C2=
=A0 =C2=A0check-unit: tests/test-authz-list.exe<br>=C2=A0 TEST =C2=A0 =C2=
=A0check-unit: tests/test-authz-listfile.exe<br>=C2=A0 TEST =C2=A0 =C2=A0ch=
eck-unit: tests/test-io-task.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: te=
sts/test-io-channel-socket.exe<br>ERROR test-io-channel-socket.exe - missin=
g test plan<br>make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9A=
check-unit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=
=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-io-channel-file.exe<br>**<b=
r>ERROR:C:/work/xemu/qemu/tests/test-io-channel-file.c:59:test_io_channel_f=
ile_helper: assertion failed (TEST_MASK &amp; ~mask =3D=3D st.st_mode &amp;=
 0777): (384 =3D=3D 438)<br>ERROR test-io-channel-file.exe - Bail out! ERRO=
R:C:/work/xemu/qemu/tests/test-io-channel-file.c:59:test_io_channel_file_he=
lper: assertion failed (TEST_MASK &amp; ~mask =3D=3D st.st_mode &amp; 0777)=
: (384 =3D=3D 438) =C2=A0 =C2=A0 =C2=A0 <br>make: [C:/work/xemu/qemu/tests/=
Makefile.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=
=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test=
-io-channel-tls.exe<br>ERROR test-io-channel-tls.exe - missing test plan<br=
>make: [C:/work/xemu/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/test-io-channel-command.exe<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/test-io-channel-buffer.exe<br>=C2=A0 TEST =
=C2=A0 =C2=A0check-unit: tests/test-base64.exe<br>=C2=A0 TEST =C2=A0 =C2=A0=
check-unit: tests/test-crypto-pbkdf.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-u=
nit: tests/test-crypto-ivgen.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: te=
sts/test-crypto-afsplit.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/t=
est-crypto-block.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-log=
ging.exe<br>**<br>ERROR:C:/work/xemu/qemu/tests/test-logging.c:190:rmdir_fu=
ll: assertion failed: (g_remove(entry_path) =3D=3D 0)<br>ERROR test-logging=
.exe - Bail out! ERROR:C:/work/xemu/qemu/tests/test-logging.c:190:rmdir_ful=
l: assertion failed: (g_remove(entry_path) =3D=3D 0)<br>make: [C:/work/xemu=
/qemu/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=
=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit=
: tests/test-replication.exe<br>**<br>ERROR:C:/work/xemu/qemu/tests/test-re=
plication.c:136:make_temp: assertion failed: (fd &gt;=3D 0)<br>ERROR test-r=
eplication.exe - Bail out! ERROR:C:/work/xemu/qemu/tests/test-replication.c=
:136:make_temp: assertion failed: (fd &gt;=3D 0)<br>make: [C:/work/xemu/qem=
u/tests/Makefile.include:426=EF=BC=9Acheck-unit] =E9=94=99=E8=AF=AF 1 (=E5=
=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: t=
ests/test-bufferiszero.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/te=
st-uuid.exe<br>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/ptimer-test.exe<b=
r>=C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-qapi-util.exe<br></div><d=
iv><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000a21f7205ae653b1e--

