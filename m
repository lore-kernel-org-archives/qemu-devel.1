Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA3C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C689221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/9fVV4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C689221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt9W-0001Im-EI
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLt8q-0000tj-RH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:12:24 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:43528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLt8o-0003hK-Di
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:12:24 -0400
Received: by mail-lj1-x236.google.com with SMTP id u4so3315760ljd.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=FPA5oQ2I77fwQasas/gfaGSwOouPuAzUkhl+a7CQq7I=;
 b=u/9fVV4udf1NushNEmHwd1UNnOoHXR7N6gSwkVT9Z7XQsinXGbGkZJvk2GAnVeL7o8
 npWypg7O0sU4YJ/7GMrhEdDSu6DgqteGCErHMTnqmupxToeUYVWS1rHckbmtVhRTq7ol
 uFHyAWeE8jomOODxv9aW1T8tAOYQVB1jFS2cZGTl8vwFrawcdzwp67zUQaM1dnP6aHJN
 +8LW9v9jZt0HzAsvG6E8GP7nNAPVYuQH/JINSROuBPzYpu5vwqV4H4EqkLFGg0KdpVjh
 W8Ix4wzPOQ+51qoSZgEp4n+6yHlIqMCirBbwvwepb17p89fDDKqoU+0Js91VGDGeJ6gZ
 Op4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=FPA5oQ2I77fwQasas/gfaGSwOouPuAzUkhl+a7CQq7I=;
 b=V6/l3EAtJY/gRU88NsYjyUwsUTacgz0GDati3Bn5t44PIbnH//VjGwES5EQ0eZv+8h
 S3GjneSOL6lSx8ZbmRNPbrQaP3K6XZHk+EKzmoEecVwcNk3B5c4HSCD+SkTZ3zmLOnU+
 oDNiXk3zEcqY/oQH7UBVlf8L5cap06KsNrW2ZWfzbJANu+D4Yw/wOAwqQbtv5d9m4N+n
 7BNKYymRLTDRd4CsNyLpO0+0kF4aSbpKMu5RVESUZnd/rr8V7NX/qnf2kqpuI0qP+fqy
 aupteDJkdww70Tpj1KWy/fBKkgAFzBNapvQuYX8W/DMSxqA+RBxVZZ0fkQE2HQYio+vH
 r6Dw==
X-Gm-Message-State: AOAM5307kAXV9ujP4ZOHsLZta3K+i61Ir+uxugHOdApG7AzJM6+sIQJM
 5AblW3jG8BemV0veDOsoxdZ/6G8QmmTeVabS3xbuNiE+Fsxm38WA
X-Google-Smtp-Source: ABdhPJzbNFjuBuiyJO131W9VGOfLf2WJSOfm5RYRuCkw3oaaYxBInRW6Hgypfm83hydQqRwMHycsl/Jh7UF6EBDfXf8=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1777102ljj.120.1601061139502; 
 Fri, 25 Sep 2020 12:12:19 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 26 Sep 2020 03:12:08 +0800
Message-ID: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
Subject: I wanna fixes plugin on windows, any suggestion
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007bd9c105b02818a6"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x236.google.com
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

--0000000000007bd9c105b02818a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

currently the empty.c plugin are failed of linkage error

The fowlloing are the failing message:
Compiling C object tests/plugin/libbb.dll.p/bb.c.obj
Linking target tests/plugin/libempty.dll
Linking target tests/plugin/libinsn.dll
Linking target tests/plugin/libmem.dll
../tests/plugin/bb.c: In function 'vcpu_tb_exec':
../tests/plugin/bb.c:75:29: error: cast from pointer to integer of
different size [-Werror=3Dpointer-to-int-cast]
   75 |     unsigned long n_insns =3D (unsigned long)udata;
      |                             ^
../tests/plugin/bb.c: In function 'vcpu_tb_trans':
../tests/plugin/bb.c:95:46: error: cast to pointer from integer of
different size [-Werror=3Dint-to-pointer-cast]
   95 |                                              (void *)n_insns);
      |                                              ^
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libempty.dll.p/empty.c.obj: in function `qemu_plugin_install':
C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined reference to
`qemu_plugin_register_vcpu_tb_trans_cb'
cc1.exe: all warnings being treated as errors
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=94=99=
=E8=AF=AF 1
make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=90=
=E7=9A=84=E4=BB=BB=E5=8A=A1....
make: *** [Makefile.ninja:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.obj] =
=E9=94=99=E8=AF=AF 1
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libinsn.dll.p/insn.c.obj: in function `vcpu_tb_trans':
C:\work\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference to
`qemu_plugin_tb_n_insns'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: undefined reference to
`qemu_plugin_tb_get_insn'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference to
`qemu_plugin_register_vcpu_insn_exec_inline'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: undefined reference to
`qemu_plugin_register_vcpu_insn_exec_cb'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit':
C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference to
`qemu_plugin_outs'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libinsn.dll.p/insn.c.obj: in function `qemu_plugin_install':
C:\work\xemu\qemu\build/../tests/plugin/insn.c:59: undefined reference to
`qemu_plugin_register_vcpu_tb_trans_cb'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined reference to
`qemu_plugin_register_atexit_cb'
collect2.exe: error: ld returned 1 exit status
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit':
C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined reference to
`qemu_plugin_outs'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem':
C:\work\xemu\qemu\build/../tests/plugin/mem.c:41: undefined reference to
`qemu_plugin_get_hwaddr'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined reference to
`qemu_plugin_hwaddr_is_io'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_tb_trans':
C:\work\xemu\qemu\build/../tests/plugin/mem.c:54: undefined reference to
`qemu_plugin_tb_n_insns'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference to
`qemu_plugin_tb_get_insn'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/mem.c:61: undefined reference to
`qemu_plugin_register_vcpu_mem_inline'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference to
`qemu_plugin_register_vcpu_mem_cb'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install':
C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefined reference to
`qemu_plugin_register_vcpu_tb_trans_cb'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference to
`qemu_plugin_register_atexit_cb'
make: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=94=99=
=E8=AF=AF 1
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=94=99=
=E8=AF=AF 1
make -C /c/work/xemu/qemu/slirp BUILD_DIR=3D"/c/work/xemu/qemu/build/slirp"
PKG_CONFIG=3D"pkg-config" CC=3D"cc" AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib"
CFLAGS=3D"-m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef
-Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
-fwrapv  -Wold-style-declaration -Wold-style-definition -Wtype-limits
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
-fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu99 -Wall"
LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong"
make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/sli=
rp=E2=80=9D
make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=
=E4=BD=95=E4=BA=8B=E3=80=82
make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/sli=
rp=E2=80=9D
make -I/c/work/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D"1"
LIBFDT_lib=3D"" CPPFLAGS=3D"-I/c/work/xemu/qemu/dtc/libfdt" CFLAGS=3D"-g -f=
no-pie
-mthreads -std=3Dgnu99 -Wall -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef
-Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
-fwrapv  -Wold-style-declaration -Wold-style-definition -Wtype-limits
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
-fstack-protector-strong" LDFLAGS=3D"-Wl,--warn-common -m64
 -fstack-protector-strong" ARFLAGS=3D"rv" CC=3D"cc" AR=3D"ar" LD=3D"ld"  li=
bfdt
make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/bui=
ld/dtc=E2=80=9D
make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=
=BB=E4=BD=95=E4=BA=8B=E3=80=82
make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/bui=
ld/dtc=E2=80=9D
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
"C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then printf
'%s\n' qemu-version.h > qemu-version.h.stamp; fi
"ar" csrD libqemuutil.a @libqemuutil.a.rsp
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12652=
a9e7600847543c3524867d85d7.dat"
&& if test -e block.syms; then printf '%s\n' block.syms > block.syms.stamp;
fi
"ar" csrD libblock.fa @libblock.fa.rsp
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac7976=
b6693320b9cb25885f5b2f71c7.dat"
&& if test -e qemu.syms; then printf '%s\n' qemu.syms > qemu.syms.stamp; fi
"c++" @qemu-system-ppc.exe.rsp

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007bd9c105b02818a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div>currently the empty.c plugin are failed of =
linkage error<br></div><div><br></div><div>The fowlloing are the failing me=
ssage:</div><div>Compiling C object tests/plugin/libbb.dll.p/bb.c.obj<br>Li=
nking target tests/plugin/libempty.dll<br>Linking target tests/plugin/libin=
sn.dll<br>Linking target tests/plugin/libmem.dll<br>../tests/plugin/bb.c: I=
n function &#39;vcpu_tb_exec&#39;:<br>../tests/plugin/bb.c:75:29: error: ca=
st from pointer to integer of different size [-Werror=3Dpointer-to-int-cast=
]<br>=C2=A0 =C2=A075 | =C2=A0 =C2=A0 unsigned long n_insns =3D (unsigned lo=
ng)udata;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>../tests/p=
lugin/bb.c: In function &#39;vcpu_tb_trans&#39;:<br>../tests/plugin/bb.c:95=
:46: error: cast to pointer from integer of different size [-Werror=3Dint-t=
o-pointer-cast]<br>=C2=A0 =C2=A095 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)n_insns);<br>=C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>C:/CI-Tools/msys64/mingw64/bin/../lib/g=
cc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: tes=
ts/plugin/libempty.dll.p/empty.c.obj: in function `qemu_plugin_install&#39;=
:<br>C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined referenc=
e to `qemu_plugin_register_vcpu_tb_trans_cb&#39;<br>cc1.exe: all warnings b=
eing treated as errors<br>collect2.exe: error: ld returned 1 exit status<br=
>make: *** [Makefile.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=94=
=99=E8=AF=AF 1<br>make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=
=E5=AE=8C=E6=88=90=E7=9A=84=E4=BB=BB=E5=8A=A1....<br>make: *** [Makefile.ni=
nja:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.obj] =E9=94=99=E8=AF=AF 1<br=
>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ld.exe: tests/plugin/libinsn.dll.p/insn.c.obj:=
 in function `vcpu_tb_trans&#39;:<br>C:\work\xemu\qemu\build/../tests/plugi=
n/insn.c:29: undefined reference to `qemu_plugin_tb_n_insns&#39;<br>C:/CI-T=
ools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin/insn.c=
:33: undefined reference to `qemu_plugin_tb_get_insn&#39;<br>C:/CI-Tools/ms=
ys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w6=
4-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: un=
defined reference to `qemu_plugin_register_vcpu_insn_exec_inline&#39;<br>C:=
/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../=
../x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin/i=
nsn.c:39: undefined reference to `qemu_plugin_register_vcpu_insn_exec_cb&#3=
9;<br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/.=
./../../../x86_64-w64-mingw32/bin/ld.exe: tests/plugin/libinsn.dll.p/insn.c=
.obj: in function `plugin_exit&#39;:<br>C:\work\xemu\qemu\build/../tests/pl=
ugin/insn.c:48: undefined reference to `qemu_plugin_outs&#39;<br>C:/CI-Tool=
s/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_6=
4-w64-mingw32/bin/ld.exe: tests/plugin/libinsn.dll.p/insn.c.obj: in functio=
n `qemu_plugin_install&#39;:<br>C:\work\xemu\qemu\build/../tests/plugin/ins=
n.c:59: undefined reference to `qemu_plugin_register_vcpu_tb_trans_cb&#39;<=
br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plu=
gin/insn.c:60: undefined reference to `qemu_plugin_register_atexit_cb&#39;<=
br>collect2.exe: error: ld returned 1 exit status<br>C:/CI-Tools/msys64/min=
gw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw3=
2/bin/ld.exe: tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit=
&#39;:<br>C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined refer=
ence to `qemu_plugin_outs&#39;<br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc=
/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: tests=
/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem&#39;:<br>C:\work\xemu=
\qemu\build/../tests/plugin/mem.c:41: undefined reference to `qemu_plugin_g=
et_hwaddr&#39;<br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\bui=
ld/../tests/plugin/mem.c:42: undefined reference to `qemu_plugin_hwaddr_is_=
io&#39;<br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.=
2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: tests/plugin/libmem.dll.p/me=
m.c.obj: in function `vcpu_tb_trans&#39;:<br>C:\work\xemu\qemu\build/../tes=
ts/plugin/mem.c:54: undefined reference to `qemu_plugin_tb_n_insns&#39;<br>=
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin=
/mem.c:58: undefined reference to `qemu_plugin_tb_get_insn&#39;<br>C:/CI-To=
ols/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin/mem.c:6=
1: undefined reference to `qemu_plugin_register_vcpu_mem_inline&#39;<br>C:/=
CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../tests/plugin/me=
m.c:65: undefined reference to `qemu_plugin_register_vcpu_mem_cb&#39;<br>C:=
/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../=
../x86_64-w64-mingw32/bin/ld.exe: tests/plugin/libmem.dll.p/mem.c.obj: in f=
unction `qemu_plugin_install&#39;:<br>C:\work\xemu\qemu\build/../tests/plug=
in/mem.c:96: undefined reference to `qemu_plugin_register_vcpu_tb_trans_cb&=
#39;<br>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0=
/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\work\xemu\qemu\build/../test=
s/plugin/mem.c:97: undefined reference to `qemu_plugin_register_atexit_cb&#=
39;<br>make: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=
=94=99=E8=AF=AF 1<br>collect2.exe: error: ld returned 1 exit status<br>make=
: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=94=99=E8=AF=
=AF 1<br>make -C /c/work/xemu/qemu/slirp BUILD_DIR=3D&quot;/c/work/xemu/qem=
u/build/slirp&quot; PKG_CONFIG=3D&quot;pkg-config&quot; CC=3D&quot;cc&quot;=
 AR=3D&quot;ar&quot; 	LD=3D&quot;ld&quot; RANLIB=3D&quot;ranlib&quot; CFLAG=
S=3D&quot;-m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_S=
OURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissi=
ng-prototypes -fno-strict-aliasing -fno-common -fwrapv =C2=A0-Wold-style-de=
claration -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y=
2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-l=
abels -Wexpansion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-=
value -Wno-psabi -fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu9=
9 -Wall&quot; LDFLAGS=3D&quot;-Wl,--warn-common -m64 =C2=A0-fstack-protecto=
r-strong&quot;<br>make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/=
work/xemu/qemu/slirp=E2=80=9D<br>make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=
=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82<br>make[1]: =
=E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/slirp=E2=80=
=9D<br>make -I/c/work/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=
=3D&quot;1&quot; LIBFDT_lib=3D&quot;&quot; CPPFLAGS=3D&quot;-I/c/work/xemu/=
qemu/dtc/libfdt&quot; CFLAGS=3D&quot;-g -fno-pie -mthreads -std=3Dgnu99 -Wa=
ll -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -=
Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prot=
otypes -fno-strict-aliasing -fno-common -fwrapv =C2=A0-Wold-style-declarati=
on -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Win=
it-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -=
Wexpansion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-value -=
Wno-psabi -fstack-protector-strong&quot; LDFLAGS=3D&quot;-Wl,--warn-common =
-m64 =C2=A0-fstack-protector-strong&quot; ARFLAGS=3D&quot;rv&quot; CC=3D&qu=
ot;cc&quot; AR=3D&quot;ar&quot; LD=3D&quot;ld&quot; =C2=A0libfdt<br>make[1]=
: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/build/dtc=
=E2=80=9D<br>make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=
=E5=81=9A=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82<br>make[1]: =E7=A6=BB=E5=BC=
=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/build/dtc=E2=80=9D<br>&quot=
;C:/CI-Tools/msys64/mingw64/bin/python3.exe&quot; &quot;C:/work/xemu/qemu/m=
eson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--capture&=
quot; &quot;qemu-version.h&quot; &quot;--&quot; &quot;sh&quot; &quot;C:/wor=
k/xemu/qemu/scripts/qemu-version.sh&quot; &quot;C:/work/xemu/qemu&quot; &qu=
ot;&quot; &quot;5.1.50&quot; &amp;&amp; if test -e qemu-version.h; then pri=
ntf &#39;%s\n&#39; qemu-version.h &gt; qemu-version.h.stamp; fi<br>&quot;ar=
&quot; csrD libqemuutil.a @libqemuutil.a.rsp<br>&quot;C:/CI-Tools/msys64/mi=
ngw64/bin/python3.exe&quot; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &q=
uot;--internal&quot; &quot;exe&quot; &quot;--unpickle&quot; &quot;C:/work/x=
emu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12652a9e7600847=
543c3524867d85d7.dat&quot; &amp;&amp; if test -e block.syms; then printf &#=
39;%s\n&#39; block.syms &gt; block.syms.stamp; fi<br>&quot;ar&quot; csrD li=
bblock.fa @libblock.fa.rsp<br>&quot;C:/CI-Tools/msys64/mingw64/bin/python3.=
exe&quot; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&quo=
t; &quot;exe&quot; &quot;--unpickle&quot; &quot;C:/work/xemu/qemu/build/mes=
on-private/meson_exe_python3.exe_269c5ec9ac7976b6693320b9cb25885f5b2f71c7.d=
at&quot; &amp;&amp; if test -e qemu.syms; then printf &#39;%s\n&#39; qemu.s=
yms &gt; qemu.syms.stamp; fi<br>&quot;c++&quot; @qemu-system-ppc.exe.rsp<br=
></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br>=
</div></div></div></div></div></div></div>

--0000000000007bd9c105b02818a6--

