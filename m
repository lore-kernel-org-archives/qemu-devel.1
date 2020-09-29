Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A755C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 01:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720BF20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 01:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FThGW02h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720BF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN4tX-0001gO-CT
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 21:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kN4sw-0001Hf-VY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:56:55 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:39944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kN4su-00028Z-8e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:56:54 -0400
Received: by mail-lj1-x231.google.com with SMTP id s205so2649953lja.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8tLyDh4D5pZIWQCmtIKVZ+d9zV/CYvaoOuapYlT29VU=;
 b=FThGW02hDe/O5t8Y8mC5lG2V3JGD5WFuc7daWgGLDhjayN4yDLVeICqh8jVPXdN7sL
 umXCbXcs9avzH9vDmvy1KplnInaWPQLOcixgo08iXwg1mFqdhqNXkPaIn2hEQE7vAy02
 E1vYfWeN9eR2D2Lnet6nywfMXzH9vgf57ofc0pkTHm+LaegDTiYfWmtUo8o3YFMPL84t
 sF+225FNiT6m+fq2LHWM7xEoaCPKAt4gh9cyhYiY0rf6MZUtCfU0Nxly7IOGhitCfDVL
 bEFqWxjOJ80E4d8IVbhtn6ftQc0z1G3I42RuHfzJoezQzEtxyEGbw1ccu7Ibi5+FKImt
 bD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8tLyDh4D5pZIWQCmtIKVZ+d9zV/CYvaoOuapYlT29VU=;
 b=JVHA/40gDLiVS5eGrO3cgwq65uK09am8NyK9SGCxpWpiQMjg/PImF/+aFyPqPJoqVO
 1gbjjuftogHmBcu0uAh7xREUpOYt2nkkHAcGGm+nq56O0sdd0bMSWpVb8QrgFeyzyHyM
 aG4CAmxoc9iOV/tFeE8dnibpzSnPPe9yXcRnBwnvJZ93lG+zQkqAuSkXLlwOpSd6Vpc6
 Q75HtYoHVtpybCKjLV7KgWEaiPoYABH9bTJ1GLFX7CxwdVq9b15w0vEACbluzKhleKxa
 8th6HZMjEwmlkr8TjVhVvFFiMDSeoJgq2jSb8+IR8xfl8gxgMcxue8F7MhhHygUu4jxx
 FTMQ==
X-Gm-Message-State: AOAM532gTQaqqRJ+u+e6QFopUdffHB65m2E6Coa3IDyi4kmk5ugEj/93
 xfmvX+2Ngnht1wu4xRh+FBoy0wcr3u/vhW5SrYw=
X-Google-Smtp-Source: ABdhPJwm4w2Rl/tUaojPGXyQj5VR3tYVfJ4YlxWG5E8CeXur/EV+cEg+ye51tnGv37f2qQSuBQsKdqQirj6o6DylssQ=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr438302ljj.447.1601344606583;
 Mon, 28 Sep 2020 18:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com> <87zh59q4wn.fsf@linaro.org>
In-Reply-To: <87zh59q4wn.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2020 09:56:37 +0800
Message-ID: <CAE2XoE-htxjyykfmqKVNQ7b7-kK8LyP7bOu2Z6SF4ta_+69euQ@mail.gmail.com>
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000070404205b06a1835"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x231.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000070404205b06a1835
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 11:47 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 25/09/20 21:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >> currently the empty.c plugin are failed of linkage error
> >>
> >> The fowlloing are the failing message:
> >> Compiling C object tests/plugin/libbb.dll.p/bb.c.obj
> >> Linking target tests/plugin/libempty.dll
> >> Linking target tests/plugin/libinsn.dll
> >> Linking target tests/plugin/libmem.dll
> >> ../tests/plugin/bb.c: In function 'vcpu_tb_exec':
> >> ../tests/plugin/bb.c:75:29: error: cast from pointer to integer of
> >> different size [-Werror=3Dpointer-to-int-cast]
> >>    75 |     unsigned long n_insns =3D (unsigned long)udata;
> >>       |                             ^
> >> ../tests/plugin/bb.c: In function 'vcpu_tb_trans':
> >> ../tests/plugin/bb.c:95:46: error: cast to pointer from integer of
> >> different size [-Werror=3Dint-to-pointer-cast]
> >>    95 |                                              (void *)n_insns);
> >>       |                                              ^
> >
> > Plugins cannot work on Windows, because they would be specific to one
> > executable as far as I know.  Plugins would have to link with the
> > emulator's import library, but there would be one import library per
> > emulator.
>
> I'm not sure I follow. There is nothing specific about the QEMU binary
> it cares about as long as the API symbols exist. Are you saying each
> QEMU binary will have different resolvable names for the external
> functions in plugins/api.c?
Hi, I've submit patches to fix the issue on win32, please have a look, it's
have some advantage
that we doesn't need the configure procedure anymore, and the .symobls
files are also no need
anymore, like the the OpenGL does.
>
> >
> > Paolo
> >
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libempty.dll.p/empty.c.obj: in function
`qemu_plugin_install':
> >> C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined referenc=
e
> >> to `qemu_plugin_register_vcpu_tb_trans_cb'
> >> cc1.exe: all warnings being treated as errors
> >> collect2.exe: error: ld returned 1 exit status
> >> make: *** [Makefile.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=
=94=99=E8=AF=AF 1
> >> make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=
=90=E7=9A=84=E4=BB=BB=E5=8A=A1....
> >> make: *** [Makefile.ninja:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.o=
bj] =E9=94=99=E8=AF=AF 1
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libinsn.dll.p/insn.c.obj: in function `vcpu_tb_trans':
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference
> >> to `qemu_plugin_tb_n_insns'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: undefined reference
> >> to `qemu_plugin_tb_get_insn'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference
> >> to `qemu_plugin_register_vcpu_insn_exec_inline'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: undefined reference
> >> to `qemu_plugin_register_vcpu_insn_exec_cb'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit':
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference
> >> to `qemu_plugin_outs'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libinsn.dll.p/insn.c.obj: in function
`qemu_plugin_install':
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:59: undefined reference
> >> to `qemu_plugin_register_vcpu_tb_trans_cb'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined reference
> >> to `qemu_plugin_register_atexit_cb'
> >> collect2.exe: error: ld returned 1 exit status
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit':
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined reference
to
> >> `qemu_plugin_outs'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem':
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:41: undefined reference
to
> >> `qemu_plugin_get_hwaddr'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined reference
to
> >> `qemu_plugin_hwaddr_is_io'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_tb_trans':
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:54: undefined reference
to
> >> `qemu_plugin_tb_n_insns'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference
to
> >> `qemu_plugin_tb_get_insn'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:61: undefined reference
to
> >> `qemu_plugin_register_vcpu_mem_inline'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference
to
> >> `qemu_plugin_register_vcpu_mem_cb'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> tests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install'=
:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefined reference
to
> >> `qemu_plugin_register_vcpu_tb_trans_cb'
> >>
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
> >> C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference
to
> >> `qemu_plugin_register_atexit_cb'
> >> make: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=
=94=99=E8=AF=AF 1
> >> collect2.exe: error: ld returned 1 exit status
> >> make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=94=
=99=E8=AF=AF 1
> >> make -C /c/work/xemu/qemu/slirp
> >> BUILD_DIR=3D"/c/work/xemu/qemu/build/slirp" PKG_CONFIG=3D"pkg-config"
> >> CC=3D"cc" AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D"-m64 -mcx16
> >> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> >> -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings
> >> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> >>  -Wold-style-declaration -Wold-style-definition -Wtype-limits
> >> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> >> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
> >> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
> >> -fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu99 -Wall"
> >> LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong"
> >> make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qem=
u/slirp=E2=80=9D
> >> make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=
=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82
> >> make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qem=
u/slirp=E2=80=9D
> >> make -I/c/work/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D=
"1"
> >> LIBFDT_lib=3D"" CPPFLAGS=3D"-I/c/work/xemu/qemu/dtc/libfdt" CFLAGS=3D"=
-g
> >> -fno-pie -mthreads -std=3Dgnu99 -Wall -m64 -mcx16 -D_GNU_SOURCE
> >> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> >> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> >> -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
> >> -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
> >> -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
> >> -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
> >> -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong"
> >> LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong" ARFLAGS=
=3D"rv"
> >> CC=3D"cc" AR=3D"ar" LD=3D"ld"  libfdt
> >> make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qem=
u/build/dtc=E2=80=9D
> >> make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=
=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82
> >> make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qem=
u/build/dtc=E2=80=9D
> >> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> >> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> >> "qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
> >> "C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then
> >> printf '%s\n' qemu-version.h > qemu-version.h.stamp; fi
> >> "ar" csrD libqemuutil.a @libqemuutil.a.rsp
> >> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> >> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> >>
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12652=
a9e7600847543c3524867d85d7.dat"
> >> && if test -e block.syms; then printf '%s\n' block.syms >
> >> block.syms.stamp; fi
> >> "ar" csrD libblock.fa @libblock.fa.rsp
> >> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> >> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> >>
"C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac7976=
b6693320b9cb25885f5b2f71c7.dat"
> >> && if test -e qemu.syms; then printf '%s\n' qemu.syms >
qemu.syms.stamp; fi
> >> "c++" @qemu-system-ppc.exe.rsp
> >>
> >> --
> >>          =E6=AD=A4=E8=87=B4
> >> =E7=A4=BC
> >> =E7=BD=97=E5=8B=87=E5=88=9A
> >> Yours
> >>     sincerely,
> >> Yonggang Luo
>
>
> --
> Alex Benn=C3=A9e



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000070404205b06a1835
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2020 at 11:47 PM Alex Benn=C3=A9e =
&lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt;<br>&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzi=
ni@redhat.com">pbonzini@redhat.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; On =
25/09/20 21:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &g=
t;&gt; currently the empty.c plugin are failed of linkage error<br>&gt; &gt=
;&gt;<br>&gt; &gt;&gt; The fowlloing are the failing message:<br>&gt; &gt;&=
gt; Compiling C object tests/plugin/libbb.dll.p/bb.c.obj<br>&gt; &gt;&gt; L=
inking target tests/plugin/libempty.dll<br>&gt; &gt;&gt; Linking target tes=
ts/plugin/libinsn.dll<br>&gt; &gt;&gt; Linking target tests/plugin/libmem.d=
ll<br>&gt; &gt;&gt; ../tests/plugin/bb.c: In function &#39;vcpu_tb_exec&#39=
;:<br>&gt; &gt;&gt; ../tests/plugin/bb.c:75:29: error: cast from pointer to=
 integer of<br>&gt; &gt;&gt; different size [-Werror=3Dpointer-to-int-cast]=
<br>&gt; &gt;&gt; =C2=A0 =C2=A075 | =C2=A0 =C2=A0 unsigned long n_insns =3D=
 (unsigned long)udata;<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^<br>&gt; &gt;&gt; ../tests/plugin/bb.c: In function &#39;vcp=
u_tb_trans&#39;:<br>&gt; &gt;&gt; ../tests/plugin/bb.c:95:46: error: cast t=
o pointer from integer of<br>&gt; &gt;&gt; different size [-Werror=3Dint-to=
-pointer-cast]<br>&gt; &gt;&gt; =C2=A0 =C2=A095 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)n_ins=
ns);<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>&gt; &gt;<b=
r>&gt; &gt; Plugins cannot work on Windows, because they would be specific =
to one<br>&gt; &gt; executable as far as I know.=C2=A0 Plugins would have t=
o link with the<br>&gt; &gt; emulator&#39;s import library, but there would=
 be one import library per<br>&gt; &gt; emulator.<br>&gt;<br>&gt; I&#39;m n=
ot sure I follow. There is nothing specific about the QEMU binary<br>&gt; i=
t cares about as long as the API symbols exist. Are you saying each<br>&gt;=
 QEMU binary will have different resolvable names for the external<br>&gt; =
functions in plugins/api.c?<div>Hi, I&#39;ve submit patches to fix the issu=
e on win32, please have a look, it&#39;s have some advantage</div><div>that=
 we doesn&#39;t need the configure procedure anymore, and the .symobls file=
s are also no need</div><div>anymore, like the the OpenGL does.<br>&gt;<br>=
&gt; &gt;<br>&gt; &gt; Paolo<br>&gt; &gt;<br>&gt; &gt;&gt; C:/CI-Tools/msys=
64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-=
mingw32/bin/ld.exe:<br>&gt; &gt;&gt; tests/plugin/libempty.dll.p/empty.c.ob=
j: in function `qemu_plugin_install&#39;:<br>&gt; &gt;&gt; C:\work\xemu\qem=
u\build/../tests/plugin/empty.c:30: undefined reference<br>&gt; &gt;&gt; to=
 `qemu_plugin_register_vcpu_tb_trans_cb&#39;<br>&gt; &gt;&gt; cc1.exe: all =
warnings being treated as errors<br>&gt; &gt;&gt; collect2.exe: error: ld r=
eturned 1 exit status<br>&gt; &gt;&gt; make: *** [Makefile.ninja:2433=EF=BC=
=9Atests/plugin/libempty.dll] =E9=94=99=E8=AF=AF 1<br>&gt; &gt;&gt; make: *=
** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=90=E7=9A=84=
=E4=BB=BB=E5=8A=A1....<br>&gt; &gt;&gt; make: *** [Makefile.ninja:2420=EF=
=BC=9Atests/plugin/libbb.dll.p/bb.c.obj] =E9=94=99=E8=AF=AF 1<br>&gt; &gt;&=
gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../=
../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; tests/plugin/libin=
sn.dll.p/insn.c.obj: in function `vcpu_tb_trans&#39;:<br>&gt; &gt;&gt; C:\w=
ork\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference<br>&gt; =
&gt;&gt; to `qemu_plugin_tb_n_insns&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys6=
4/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-m=
ingw32/bin/ld.exe:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin=
/insn.c:33: undefined reference<br>&gt; &gt;&gt; to `qemu_plugin_tb_get_ins=
n&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w6=
4-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt=
; C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference<br=
>&gt; &gt;&gt; to `qemu_plugin_register_vcpu_insn_exec_inline&#39;<br>&gt; =
&gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.=
0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; C:\work\xemu\=
qemu\build/../tests/plugin/insn.c:39: undefined reference<br>&gt; &gt;&gt; =
to `qemu_plugin_register_vcpu_insn_exec_cb&#39;<br>&gt; &gt;&gt; C:/CI-Tool=
s/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_6=
4-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; tests/plugin/libinsn.dll.p/insn.=
c.obj: in function `plugin_exit&#39;:<br>&gt; &gt;&gt; C:\work\xemu\qemu\bu=
ild/../tests/plugin/insn.c:48: undefined reference<br>&gt; &gt;&gt; to `qem=
u_plugin_outs&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/g=
cc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>=
&gt; &gt;&gt; tests/plugin/libinsn.dll.p/insn.c.obj: in function `qemu_plug=
in_install&#39;:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin/i=
nsn.c:59: undefined reference<br>&gt; &gt;&gt; to `qemu_plugin_register_vcp=
u_tb_trans_cb&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/g=
cc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>=
&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined =
reference<br>&gt; &gt;&gt; to `qemu_plugin_register_atexit_cb&#39;<br>&gt; =
&gt;&gt; collect2.exe: error: ld returned 1 exit status<br>&gt; &gt;&gt; C:=
/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../=
../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; tests/plugin/libmem.dll.=
p/mem.c.obj: in function `plugin_exit&#39;:<br>&gt; &gt;&gt; C:\work\xemu\q=
emu\build/../tests/plugin/mem.c:33: undefined reference to<br>&gt; &gt;&gt;=
 `qemu_plugin_outs&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../=
lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe=
:<br>&gt; &gt;&gt; tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_m=
em&#39;:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:41:=
 undefined reference to<br>&gt; &gt;&gt; `qemu_plugin_get_hwaddr&#39;<br>&g=
t; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10=
.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; C:\work\xe=
mu\qemu\build/../tests/plugin/mem.c:42: undefined reference to<br>&gt; &gt;=
&gt; `qemu_plugin_hwaddr_is_io&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/min=
gw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw3=
2/bin/ld.exe:<br>&gt; &gt;&gt; tests/plugin/libmem.dll.p/mem.c.obj: in func=
tion `vcpu_tb_trans&#39;:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests=
/plugin/mem.c:54: undefined reference to<br>&gt; &gt;&gt; `qemu_plugin_tb_n=
_insns&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_=
64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &g=
t;&gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined referenc=
e to<br>&gt; &gt;&gt; `qemu_plugin_tb_get_insn&#39;<br>&gt; &gt;&gt; C:/CI-=
Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x=
86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../t=
ests/plugin/mem.c:61: undefined reference to<br>&gt; &gt;&gt; `qemu_plugin_=
register_vcpu_mem_inline&#39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/b=
in/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/=
ld.exe:<br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: =
undefined reference to<br>&gt; &gt;&gt; `qemu_plugin_register_vcpu_mem_cb&#=
39;<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-m=
ingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; t=
ests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install&#39;:<=
br>&gt; &gt;&gt; C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefine=
d reference to<br>&gt; &gt;&gt; `qemu_plugin_register_vcpu_tb_trans_cb&#39;=
<br>&gt; &gt;&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:<br>&gt; &gt;&gt; C:\w=
ork\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference to<br>&gt=
; &gt;&gt; `qemu_plugin_register_atexit_cb&#39;<br>&gt; &gt;&gt; make: *** =
[Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=94=99=E8=AF=AF 1=
<br>&gt; &gt;&gt; collect2.exe: error: ld returned 1 exit status<br>&gt; &g=
t;&gt; make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=
=94=99=E8=AF=AF 1<br>&gt; &gt;&gt; make -C /c/work/xemu/qemu/slirp<br>&gt; =
&gt;&gt; BUILD_DIR=3D&quot;/c/work/xemu/qemu/build/slirp&quot; PKG_CONFIG=
=3D&quot;pkg-config&quot;<br>&gt; &gt;&gt; CC=3D&quot;cc&quot; AR=3D&quot;a=
r&quot; LD=3D&quot;ld&quot; RANLIB=3D&quot;ranlib&quot; CFLAGS=3D&quot;-m64=
 -mcx16<br>&gt; &gt;&gt; -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFIL=
E_SOURCE<br>&gt; &gt;&gt; -Wstrict-prototypes -Wredundant-decls -Wundef -Ww=
rite-strings<br>&gt; &gt;&gt; -Wmissing-prototypes -fno-strict-aliasing -fn=
o-common -fwrapv<br>&gt; &gt;&gt; =C2=A0-Wold-style-declaration -Wold-style=
-definition -Wtype-limits<br>&gt; &gt;&gt; -Wformat-security -Wformat-y2k -=
Winit-self -Wignored-qualifiers<br>&gt; &gt;&gt; -Wempty-body -Wnested-exte=
rns -Wendif-labels -Wexpansion-to-defined<br>&gt; &gt;&gt; -Wno-missing-inc=
lude-dirs -Wno-shift-negative-value -Wno-psabi<br>&gt; &gt;&gt; -fstack-pro=
tector-strong -g -fno-pie -mthreads -std=3Dgnu99 -Wall&quot;<br>&gt; &gt;&g=
t; LDFLAGS=3D&quot;-Wl,--warn-common -m64 =C2=A0-fstack-protector-strong&qu=
ot;<br>&gt; &gt;&gt; make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C=
/c/work/xemu/qemu/slirp=E2=80=9D<br>&gt; &gt;&gt; make[1]: =E5=AF=B9=E2=80=
=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=
=82<br>&gt; &gt;&gt; make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C=
/c/work/xemu/qemu/slirp=E2=80=9D<br>&gt; &gt;&gt; make -I/c/work/xemu/qemu/=
dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D&quot;1&quot;<br>&gt; &gt;&gt;=
 LIBFDT_lib=3D&quot;&quot; CPPFLAGS=3D&quot;-I/c/work/xemu/qemu/dtc/libfdt&=
quot; CFLAGS=3D&quot;-g<br>&gt; &gt;&gt; -fno-pie -mthreads -std=3Dgnu99 -W=
all -m64 -mcx16 -D_GNU_SOURCE<br>&gt; &gt;&gt; -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -Wstrict-prototypes<br>&gt; &gt;&gt; -Wredundant-decls -Wu=
ndef -Wwrite-strings -Wmissing-prototypes<br>&gt; &gt;&gt; -fno-strict-alia=
sing -fno-common -fwrapv =C2=A0-Wold-style-declaration<br>&gt; &gt;&gt; -Wo=
ld-style-definition -Wtype-limits -Wformat-security -Wformat-y2k<br>&gt; &g=
t;&gt; -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs<br>&g=
t; &gt;&gt; -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs=
<br>&gt; &gt;&gt; -Wno-shift-negative-value -Wno-psabi -fstack-protector-st=
rong&quot;<br>&gt; &gt;&gt; LDFLAGS=3D&quot;-Wl,--warn-common -m64 =C2=A0-f=
stack-protector-strong&quot; ARFLAGS=3D&quot;rv&quot;<br>&gt; &gt;&gt; CC=
=3D&quot;cc&quot; AR=3D&quot;ar&quot; LD=3D&quot;ld&quot; =C2=A0libfdt<br>&=
gt; &gt;&gt; make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/=
xemu/qemu/build/dtc=E2=80=9D<br>&gt; &gt;&gt; make[1]: =E5=AF=B9=E2=80=9Cli=
bfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=BB=E4=BD=95=E4=BA=8B=E3=80=
=82<br>&gt; &gt;&gt; make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C=
/c/work/xemu/qemu/build/dtc=E2=80=9D<br>&gt; &gt;&gt; &quot;C:/CI-Tools/msy=
s64/mingw64/bin/python3.exe&quot;<br>&gt; &gt;&gt; &quot;C:/work/xemu/qemu/=
meson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--capture=
&quot;<br>&gt; &gt;&gt; &quot;qemu-version.h&quot; &quot;--&quot; &quot;sh&=
quot; &quot;C:/work/xemu/qemu/scripts/qemu-version.sh&quot;<br>&gt; &gt;&gt=
; &quot;C:/work/xemu/qemu&quot; &quot;&quot; &quot;5.1.50&quot; &amp;&amp; =
if test -e qemu-version.h; then<br>&gt; &gt;&gt; printf &#39;%s\n&#39; qemu=
-version.h &gt; qemu-version.h.stamp; fi<br>&gt; &gt;&gt; &quot;ar&quot; cs=
rD libqemuutil.a @libqemuutil.a.rsp<br>&gt; &gt;&gt; &quot;C:/CI-Tools/msys=
64/mingw64/bin/python3.exe&quot;<br>&gt; &gt;&gt; &quot;C:/work/xemu/qemu/m=
eson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--unpickle=
&quot;<br>&gt; &gt;&gt; &quot;C:/work/xemu/qemu/build/meson-private/meson_e=
xe_python3.exe_2b18a272e12652a9e7600847543c3524867d85d7.dat&quot;<br>&gt; &=
gt;&gt; &amp;&amp; if test -e block.syms; then printf &#39;%s\n&#39; block.=
syms &gt;<br>&gt; &gt;&gt; block.syms.stamp; fi<br>&gt; &gt;&gt; &quot;ar&q=
uot; csrD libblock.fa @libblock.fa.rsp<br>&gt; &gt;&gt; &quot;C:/CI-Tools/m=
sys64/mingw64/bin/python3.exe&quot;<br>&gt; &gt;&gt; &quot;C:/work/xemu/qem=
u/meson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--unpic=
kle&quot;<br>&gt; &gt;&gt; &quot;C:/work/xemu/qemu/build/meson-private/meso=
n_exe_python3.exe_269c5ec9ac7976b6693320b9cb25885f5b2f71c7.dat&quot;<br>&gt=
; &gt;&gt; &amp;&amp; if test -e qemu.syms; then printf &#39;%s\n&#39; qemu=
.syms &gt; qemu.syms.stamp; fi<br>&gt; &gt;&gt; &quot;c++&quot; @qemu-syste=
m-ppc.exe.rsp<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; --<br>&gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>&gt; &gt;&gt; =E7=A4=BC<br=
>&gt; &gt;&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>&gt; &gt;&gt; Yours<br>&gt; &=
gt;&gt; =C2=A0 =C2=A0 sincerely,<br>&gt; &gt;&gt; Yonggang Luo<br>&gt;<br>&=
gt;<br>&gt; --<br>&gt; Alex Benn=C3=A9e<br><br><br><br>--<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=
=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000070404205b06a1835--

