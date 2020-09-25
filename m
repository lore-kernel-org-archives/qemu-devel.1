Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186BC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B329221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7WhL15J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B329221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtKf-0006u8-BP
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLtJi-0006SJ-7b
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:23:38 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:38152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLtJe-0004tO-4G
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:23:37 -0400
Received: by mail-lj1-x22d.google.com with SMTP id w3so3374560ljo.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=veHmGfRPLEJAXe3w8tMhHVaHExXuW7WV+Zdtv1Nl1Tk=;
 b=M7WhL15Jx/dKHaLFL/yCKGOwZ38KCLM54EZdx/r71XHn1eiMlQF4bpl15fVVwMrDzY
 krU8FkkosSVkjVmSESepWn9gNYLvqRvctCvO5WDA3yqaLz4UDFyTQiRnV5BQEm+SqGu8
 QX4gmXRtix8I7eatsM6c5avKsUarmJ3AAcaeCcgu5LCD9eY9jn4nfghAR8iPYZm7bQLp
 NUX6DOI3VVMK1ng3EEotiN8WaqCBiUCvS0RHAjF0w1jCxj9ludOXQbnl9u9G/gzz+8ZL
 jbwq5bjy7N6HJD9oy9/QFRI1Nr0U2un9afWN7taeDr8jhGfAtn7lBdCole9xZPsL0Qce
 wKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=veHmGfRPLEJAXe3w8tMhHVaHExXuW7WV+Zdtv1Nl1Tk=;
 b=n9FCce9hYooTEtoZPsGiFz2MwrkIpPWr/EZM/Vv/iAP/Lagrtb+EDP5Qaj++RQhCWT
 i1vhZFVLQIAQL16sB9lWap8wqNh1NwTvrxPCc33MUSS41s4droZwLzRoLToy8aOU4Krz
 jrY5rq3D0SVnQDTBgHEtGj3JoDACZGlrA2kY+U0EI1d6Gw5bLkOrU0uotG9CvvFFtkl3
 0bZzqzsgIcFcL+zxxCRM/zCfiJ58SeFrHxPV9cXY34UdJxn5O6qG4xa1m0A7tqH9ffOx
 PYJvwY1I6NO4hxYRS+27EtQf9m9/3yFRSmp/gkmAsPa0jG9wXrxTujWTpD7eAvgCGbtT
 8VqA==
X-Gm-Message-State: AOAM533DHQl3u72ZyzEePgFyRmA/MwxNSr5qJmQrokNEkxQkizfbquTP
 A4dPcYy9pF8XeRp9RMgjwADwdjOIGNZmatVkDaQ=
X-Google-Smtp-Source: ABdhPJxv7ovrdw6kvCmCk9Xzmf7vCLNgjsZf7LMF3rLlHgrCrgdNdH4YV0WNo/xjW8UzbWjkYo614WlAEF0QpHbl4NQ=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1788096ljj.120.1601061812391; 
 Fri, 25 Sep 2020 12:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
In-Reply-To: <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 26 Sep 2020 03:23:21 +0800
Message-ID: <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009753a705b0284061"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22d.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009753a705b0284061
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 3:20 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 21:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > currently the empty.c plugin are failed of linkage error
> >
> > The fowlloing are the failing message:
> > Compiling C object tests/plugin/libbb.dll.p/bb.c.obj
> > Linking target tests/plugin/libempty.dll
> > Linking target tests/plugin/libinsn.dll
> > Linking target tests/plugin/libmem.dll
> > ../tests/plugin/bb.c: In function 'vcpu_tb_exec':
> > ../tests/plugin/bb.c:75:29: error: cast from pointer to integer of
> > different size [-Werror=3Dpointer-to-int-cast]
> >    75 |     unsigned long n_insns =3D (unsigned long)udata;
> >       |                             ^
> > ../tests/plugin/bb.c: In function 'vcpu_tb_trans':
> > ../tests/plugin/bb.c:95:46: error: cast to pointer from integer of
> > different size [-Werror=3Dint-to-pointer-cast]
> >    95 |                                              (void *)n_insns);
> >       |                                              ^
>
> Plugins cannot work on Windows, because they would be specific to one
> executable as far as I know.  Plugins would have to link with the
> emulator's import library, but there would be one import library per
> emulator.
That's what I am tring to fixes? what does  one import library per
emulator, can we do this like NodeJS does?
 NodeJS have NAPI support across platform. They create a windows .lib from
node.exe
>
> Paolo
>
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libempty.dll.p/empty.c.obj: in function
`qemu_plugin_install':
> > C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined reference
> > to `qemu_plugin_register_vcpu_tb_trans_cb'
> > cc1.exe: all warnings being treated as errors
> > collect2.exe: error: ld returned 1 exit status
> > make: *** [Makefile.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=
=94=99=E8=AF=AF 1
> > make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=
=90=E7=9A=84=E4=BB=BB=E5=8A=A1....
> > make: *** [Makefile.ninja:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.ob=
j] =E9=94=99=E8=AF=AF 1
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libinsn.dll.p/insn.c.obj: in function `vcpu_tb_trans':
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference
> > to `qemu_plugin_tb_n_insns'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: undefined reference
> > to `qemu_plugin_tb_get_insn'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference
> > to `qemu_plugin_register_vcpu_insn_exec_inline'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: undefined reference
> > to `qemu_plugin_register_vcpu_insn_exec_cb'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit':
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference
> > to `qemu_plugin_outs'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libinsn.dll.p/insn.c.obj: in function
`qemu_plugin_install':
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:59: undefined reference
> > to `qemu_plugin_register_vcpu_tb_trans_cb'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined reference
> > to `qemu_plugin_register_atexit_cb'
> > collect2.exe: error: ld returned 1 exit status
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit':
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined reference t=
o
> > `qemu_plugin_outs'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem':
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:41: undefined reference t=
o
> > `qemu_plugin_get_hwaddr'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined reference t=
o
> > `qemu_plugin_hwaddr_is_io'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_tb_trans':
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:54: undefined reference t=
o
> > `qemu_plugin_tb_n_insns'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference t=
o
> > `qemu_plugin_tb_get_insn'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:61: undefined reference t=
o
> > `qemu_plugin_register_vcpu_mem_inline'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference t=
o
> > `qemu_plugin_register_vcpu_mem_cb'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > tests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install':
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefined reference t=
o
> > `qemu_plugin_register_vcpu_tb_trans_cb'
> >
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> > C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference t=
o
> > `qemu_plugin_register_atexit_cb'
> > make: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=94=
=99=E8=AF=AF 1
> > collect2.exe: error: ld returned 1 exit status
> > make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=94=
=99=E8=AF=AF 1
> > make -C /c/work/xemu/qemu/slirp
> > BUILD_DIR=3D"/c/work/xemu/qemu/build/slirp" PKG_CONFIG=3D"pkg-config"
> > CC=3D"cc" AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D"-m64 -mcx16
> > -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> > -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings
> > -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> >  -Wold-style-declaration -Wold-style-definition -Wtype-limits
> > -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> > -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
> > -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
> > -fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu99 -Wall"
> > LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong"
> > make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu=
/slirp=E2=80=9D
> > make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=
=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82
> > make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu=
/slirp=E2=80=9D
> > make -I/c/work/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D"=
1"
> > LIBFDT_lib=3D"" CPPFLAGS=3D"-I/c/work/xemu/qemu/dtc/libfdt" CFLAGS=3D"-=
g
> > -fno-pie -mthreads -std=3Dgnu99 -Wall -m64 -mcx16 -D_GNU_SOURCE
> > -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> > -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> > -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
> > -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
> > -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
> > -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
> > -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong"
> > LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong" ARFLAGS=3D=
"rv"
> > CC=3D"cc" AR=3D"ar" LD=3D"ld"  libfdt
> > make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu=
/build/dtc=E2=80=9D
> > make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=
=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82
> > make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu=
/build/dtc=E2=80=9D
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> > "qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
> > "C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then
> > printf '%s\n' qemu-version.h > qemu-version.h.stamp; fi
> > "ar" csrD libqemuutil.a @libqemuutil.a.rsp
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> >
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12652=
a9e7600847543c3524867d85d7.dat"
> > && if test -e block.syms; then printf '%s\n' block.syms >
> > block.syms.stamp; fi
> > "ar" csrD libblock.fa @libblock.fa.rsp
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> >
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac7976=
b6693320b9cb25885f5b2f71c7.dat"
> > && if test -e qemu.syms; then printf '%s\n' qemu.syms >
qemu.syms.stamp; fi
> > "c++" @qemu-system-ppc.exe.rsp
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009753a705b0284061
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Sep 26, 2020 at 3:20 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 25/09/20 21:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt; currently the empty.c plugin are failed of linkage err=
or<br>&gt; &gt;<br>&gt; &gt; The fowlloing are the failing message:<br>&gt;=
 &gt; Compiling C object tests/plugin/libbb.dll.p/bb.c.obj<br>&gt; &gt; Lin=
king target tests/plugin/libempty.dll<br>&gt; &gt; Linking target tests/plu=
gin/libinsn.dll<br>&gt; &gt; Linking target tests/plugin/libmem.dll<br>&gt;=
 &gt; ../tests/plugin/bb.c: In function &#39;vcpu_tb_exec&#39;:<br>&gt; &gt=
; ../tests/plugin/bb.c:75:29: error: cast from pointer to integer of<br>&gt=
; &gt; different size [-Werror=3Dpointer-to-int-cast]<br>&gt; &gt; =C2=A0 =
=C2=A075 | =C2=A0 =C2=A0 unsigned long n_insns =3D (unsigned long)udata;<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>&gt; &gt; ../=
tests/plugin/bb.c: In function &#39;vcpu_tb_trans&#39;:<br>&gt; &gt; ../tes=
ts/plugin/bb.c:95:46: error: cast to pointer from integer of<br>&gt; &gt; d=
ifferent size [-Werror=3Dint-to-pointer-cast]<br>&gt; &gt; =C2=A0 =C2=A095 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(void *)n_insns);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^<br>&gt;<br>&gt; Plugins cannot work on Windows, because they would =
be specific to one<br>&gt; executable as far as I know.=C2=A0 Plugins would=
 have to link with the<br>&gt; emulator&#39;s import library, but there wou=
ld be one import library per<br>&gt; emulator.<div>That&#39;s what I am tri=
ng to fixes? what does=C2=A0 one import library per<br>emulator, can we do =
this like NodeJS does?</div><div>=C2=A0NodeJS have NAPI support across plat=
form. They create a windows .lib from</div><div>node.exe<br>&gt;<br>&gt; Pa=
olo<br>&gt;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w=
64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; t=
ests/plugin/libempty.dll.p/empty.c.obj: in function `qemu_plugin_install&#3=
9;:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefi=
ned reference<br>&gt; &gt; to `qemu_plugin_register_vcpu_tb_trans_cb&#39;<b=
r>&gt; &gt; cc1.exe: all warnings being treated as errors<br>&gt; &gt; coll=
ect2.exe: error: ld returned 1 exit status<br>&gt; &gt; make: *** [Makefile=
.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=94=99=E8=AF=AF 1<br>&gt;=
 &gt; make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=
=88=90=E7=9A=84=E4=BB=BB=E5=8A=A1....<br>&gt; &gt; make: *** [Makefile.ninj=
a:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.obj] =E9=94=99=E8=AF=AF 1<br>&=
gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.=
0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; tests/plugin/libi=
nsn.dll.p/insn.c.obj: in function `vcpu_tb_trans&#39;:<br>&gt; &gt; C:\work=
\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference<br>&gt; &gt=
; to `qemu_plugin_tb_n_insns&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/b=
in/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/=
ld.exe:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: und=
efined reference<br>&gt; &gt; to `qemu_plugin_tb_get_insn&#39;<br>&gt; &gt;=
 C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; C:\work\xemu\qemu\build/.=
./tests/plugin/insn.c:36: undefined reference<br>&gt; &gt; to `qemu_plugin_=
register_vcpu_insn_exec_inline&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64=
/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bi=
n/ld.exe:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: u=
ndefined reference<br>&gt; &gt; to `qemu_plugin_register_vcpu_insn_exec_cb&=
#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; tests/pl=
ugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit&#39;:<br>&gt; &gt; =
C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference<br>&=
gt; &gt; to `qemu_plugin_outs&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/=
bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin=
/ld.exe:<br>&gt; &gt; tests/plugin/libinsn.dll.p/insn.c.obj: in function `q=
emu_plugin_install&#39;:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plug=
in/insn.c:59: undefined reference<br>&gt; &gt; to `qemu_plugin_register_vcp=
u_tb_trans_cb&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x=
86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt;=
 &gt; C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined referenc=
e<br>&gt; &gt; to `qemu_plugin_register_atexit_cb&#39;<br>&gt; &gt; collect=
2.exe: error: ld returned 1 exit status<br>&gt; &gt; C:/CI-Tools/msys64/min=
gw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw3=
2/bin/ld.exe:<br>&gt; &gt; tests/plugin/libmem.dll.p/mem.c.obj: in function=
 `plugin_exit&#39;:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/me=
m.c:33: undefined reference to<br>&gt; &gt; `qemu_plugin_outs&#39;<br>&gt; =
&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/..=
/../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; tests/plugin/libmem.d=
ll.p/mem.c.obj: in function `vcpu_mem&#39;:<br>&gt; &gt; C:\work\xemu\qemu\=
build/../tests/plugin/mem.c:41: undefined reference to<br>&gt; &gt; `qemu_p=
lugin_get_hwaddr&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gc=
c/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&=
gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined refere=
nce to<br>&gt; &gt; `qemu_plugin_hwaddr_is_io&#39;<br>&gt; &gt; C:/CI-Tools=
/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64=
-w64-mingw32/bin/ld.exe:<br>&gt; &gt; tests/plugin/libmem.dll.p/mem.c.obj: =
in function `vcpu_tb_trans&#39;:<br>&gt; &gt; C:\work\xemu\qemu\build/../te=
sts/plugin/mem.c:54: undefined reference to<br>&gt; &gt; `qemu_plugin_tb_n_=
insns&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w6=
4-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; C:=
\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference to<br>&=
gt; &gt; `qemu_plugin_tb_get_insn&#39;<br>&gt; &gt; C:/CI-Tools/msys64/ming=
w64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32=
/bin/ld.exe:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:61:=
 undefined reference to<br>&gt; &gt; `qemu_plugin_register_vcpu_mem_inline&=
#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt; C:\work\=
xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference to<br>&gt; &g=
t; `qemu_plugin_register_vcpu_mem_cb&#39;<br>&gt; &gt; C:/CI-Tools/msys64/m=
ingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-ming=
w32/bin/ld.exe:<br>&gt; &gt; tests/plugin/libmem.dll.p/mem.c.obj: in functi=
on `qemu_plugin_install&#39;:<br>&gt; &gt; C:\work\xemu\qemu\build/../tests=
/plugin/mem.c:96: undefined reference to<br>&gt; &gt; `qemu_plugin_register=
_vcpu_tb_trans_cb&#39;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/bin/../lib/g=
cc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>=
&gt; &gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined refer=
ence to<br>&gt; &gt; `qemu_plugin_register_atexit_cb&#39;<br>&gt; &gt; make=
: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=94=99=E8=
=AF=AF 1<br>&gt; &gt; collect2.exe: error: ld returned 1 exit status<br>&gt=
; &gt; make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=
=94=99=E8=AF=AF 1<br>&gt; &gt; make -C /c/work/xemu/qemu/slirp<br>&gt; &gt;=
 BUILD_DIR=3D&quot;/c/work/xemu/qemu/build/slirp&quot; PKG_CONFIG=3D&quot;p=
kg-config&quot;<br>&gt; &gt; CC=3D&quot;cc&quot; AR=3D&quot;ar&quot; LD=3D&=
quot;ld&quot; RANLIB=3D&quot;ranlib&quot; CFLAGS=3D&quot;-m64 -mcx16<br>&gt=
; &gt; -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE<br>&gt; &=
gt; -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings<br>&gt; &=
gt; -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv<br>&gt; &=
gt; =C2=A0-Wold-style-declaration -Wold-style-definition -Wtype-limits<br>&=
gt; &gt; -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers<br=
>&gt; &gt; -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defi=
ned<br>&gt; &gt; -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-p=
sabi<br>&gt; &gt; -fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu=
99 -Wall&quot;<br>&gt; &gt; LDFLAGS=3D&quot;-Wl,--warn-common -m64 =C2=A0-f=
stack-protector-strong&quot;<br>&gt; &gt; make[1]: =E8=BF=9B=E5=85=A5=E7=9B=
=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/slirp=E2=80=9D<br>&gt; &gt; make[1]:=
 =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=E4=BD=
=95=E4=BA=8B=E3=80=82<br>&gt; &gt; make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=
=BD=95=E2=80=9C/c/work/xemu/qemu/slirp=E2=80=9D<br>&gt; &gt; make -I/c/work=
/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D&quot;1&quot;<br>&g=
t; &gt; LIBFDT_lib=3D&quot;&quot; CPPFLAGS=3D&quot;-I/c/work/xemu/qemu/dtc/=
libfdt&quot; CFLAGS=3D&quot;-g<br>&gt; &gt; -fno-pie -mthreads -std=3Dgnu99=
 -Wall -m64 -mcx16 -D_GNU_SOURCE<br>&gt; &gt; -D_FILE_OFFSET_BITS=3D64 -D_L=
ARGEFILE_SOURCE -Wstrict-prototypes<br>&gt; &gt; -Wredundant-decls -Wundef =
-Wwrite-strings -Wmissing-prototypes<br>&gt; &gt; -fno-strict-aliasing -fno=
-common -fwrapv =C2=A0-Wold-style-declaration<br>&gt; &gt; -Wold-style-defi=
nition -Wtype-limits -Wformat-security -Wformat-y2k<br>&gt; &gt; -Winit-sel=
f -Wignored-qualifiers -Wempty-body -Wnested-externs<br>&gt; &gt; -Wendif-l=
abels -Wexpansion-to-defined -Wno-missing-include-dirs<br>&gt; &gt; -Wno-sh=
ift-negative-value -Wno-psabi -fstack-protector-strong&quot;<br>&gt; &gt; L=
DFLAGS=3D&quot;-Wl,--warn-common -m64 =C2=A0-fstack-protector-strong&quot; =
ARFLAGS=3D&quot;rv&quot;<br>&gt; &gt; CC=3D&quot;cc&quot; AR=3D&quot;ar&quo=
t; LD=3D&quot;ld&quot; =C2=A0libfdt<br>&gt; &gt; make[1]: =E8=BF=9B=E5=85=
=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/build/dtc=E2=80=9D<br>&gt; =
&gt; make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=
=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82<br>&gt; &gt; make[1]: =E7=A6=BB=E5=BC=
=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/build/dtc=E2=80=9D<br>&gt; =
&gt; &quot;C:/CI-Tools/msys64/mingw64/bin/python3.exe&quot;<br>&gt; &gt; &q=
uot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&quot; &quot;exe=
&quot; &quot;--capture&quot;<br>&gt; &gt; &quot;qemu-version.h&quot; &quot;=
--&quot; &quot;sh&quot; &quot;C:/work/xemu/qemu/scripts/qemu-version.sh&quo=
t;<br>&gt; &gt; &quot;C:/work/xemu/qemu&quot; &quot;&quot; &quot;5.1.50&quo=
t; &amp;&amp; if test -e qemu-version.h; then<br>&gt; &gt; printf &#39;%s\n=
&#39; qemu-version.h &gt; qemu-version.h.stamp; fi<br>&gt; &gt; &quot;ar&qu=
ot; csrD libqemuutil.a @libqemuutil.a.rsp<br>&gt; &gt; &quot;C:/CI-Tools/ms=
ys64/mingw64/bin/python3.exe&quot;<br>&gt; &gt; &quot;C:/work/xemu/qemu/mes=
on/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--unpickle&q=
uot;<br>&gt; &gt; &quot;C:/work/xemu/qemu/build/meson-private/meson_exe_pyt=
hon3.exe_2b18a272e12652a9e7600847543c3524867d85d7.dat&quot;<br>&gt; &gt; &a=
mp;&amp; if test -e block.syms; then printf &#39;%s\n&#39; block.syms &gt;<=
br>&gt; &gt; block.syms.stamp; fi<br>&gt; &gt; &quot;ar&quot; csrD libblock=
.fa @libblock.fa.rsp<br>&gt; &gt; &quot;C:/CI-Tools/msys64/mingw64/bin/pyth=
on3.exe&quot;<br>&gt; &gt; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &qu=
ot;--internal&quot; &quot;exe&quot; &quot;--unpickle&quot;<br>&gt; &gt; &qu=
ot;C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac79=
76b6693320b9cb25885f5b2f71c7.dat&quot;<br>&gt; &gt; &amp;&amp; if test -e q=
emu.syms; then printf &#39;%s\n&#39; qemu.syms &gt; qemu.syms.stamp; fi<br>=
&gt; &gt; &quot;c++&quot; @qemu-system-ppc.exe.rsp<br>&gt; &gt;<br>&gt; &gt=
; --<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>&=
gt; &gt; =E7=A4=BC<br>&gt; &gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>&gt; &gt; Yo=
urs<br>&gt; &gt; =C2=A0 =C2=A0 sincerely,<br>&gt; &gt; Yonggang Luo<br>&gt;=
<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=
=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerel=
y,<br>Yonggang Luo</div></div>

--0000000000009753a705b0284061--

