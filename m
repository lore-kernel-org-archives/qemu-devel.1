Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E01C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4BA2100A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQDRwf/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4BA2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMvOU-0001uR-6y
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 11:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kMvNf-0001SR-2D
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:47:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kMvNc-0001Fx-Nb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:47:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id x23so1638580wmi.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pYX1FTJcTftBnafFlkHkd2Kuu7TbFP+8hVy7etXY4PA=;
 b=jQDRwf/hqTzEcsmyU0eHLPWur8c8ufy3B+cBbjO1sRxyYEnnNQc5Z4SmlMscm2zuOc
 MlA7JicnLBZC+UepfaePUZpRBD5pBimyGE8VSO5Uz5gIiD2tHCPMqwVvmNtJ6ERjyBJS
 evGHDPIDt0nrWcH55aDfzBVrSv7Mp/ScLiQwvwUHkgJKDUnNz0dZfU4CCmrgMxadOiWp
 AOmFPLD6ryDomAv4v1n2j1/t2ilG/nShNvxvYkPJAGZIxX2V5a8XdFFPveDpdBpoliCU
 e7o3XX4bBJKbOl+UCCM/DEn8oC099KV4tmaeVIhOB6m6uoGDvG2+b3oF4NVWFAYOPUw7
 WUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pYX1FTJcTftBnafFlkHkd2Kuu7TbFP+8hVy7etXY4PA=;
 b=M7qtl7EiUoEMB9vwslSVydH2cd39yFGjtGGQAtqlT6DkrQ6W5jh7cTxMIVwCFQdYxh
 bfsFJG/Jqsb8gDcnIQrqQeygoHU1kf63lNJOHR48H31y4Ar78RjWJcNe/WCILSIr4xeS
 Vbv8kuCa2jH++Z2jbKL7l04OXEO/VkhjsaLYO1xNiCAH72B+ROJXi8+nsxgTdtzL+whm
 hA4ZPiSe/r0lieKcX18sE5H9qQT+QXBTr8pOXPI6tda9RNZnQoAplGfyCc31vjU/VZnl
 wOMtpcv28C8/mKIUsIVWp3Eo+U1LX0ot6WgvqiLQB3ORGZcb1sJn5weYYuRPEOJJkkhX
 NgHg==
X-Gm-Message-State: AOAM530ZR64+fqbw8SzgYv7NK4Q1iXRrmKwDizItW31qvE7e4v+HvbMh
 AWneE23m2pLaWjC5axuip8WQgQ==
X-Google-Smtp-Source: ABdhPJxOvwCGAAHnHF7QWIz9Ncf04d+rTJkjJU59y3XLM+yE1YSqqF3Pj5qXTpwHbifNXFNp3VTm1g==
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr2277193wmf.143.1601308074770; 
 Mon, 28 Sep 2020 08:47:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 63sm2162490wrh.71.2020.09.28.08.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 08:47:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBF5E1FF7E;
 Mon, 28 Sep 2020 16:47:52 +0100 (BST)
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: I wanna fixes plugin on windows, any suggestion
In-reply-to: <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
Date: Mon, 28 Sep 2020 16:47:52 +0100
Message-ID: <87zh59q4wn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/09/20 21:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> currently the empty.c plugin are failed of linkage error
>>=20
>> The fowlloing are the failing message:
>> Compiling C object tests/plugin/libbb.dll.p/bb.c.obj
>> Linking target tests/plugin/libempty.dll
>> Linking target tests/plugin/libinsn.dll
>> Linking target tests/plugin/libmem.dll
>> ../tests/plugin/bb.c: In function 'vcpu_tb_exec':
>> ../tests/plugin/bb.c:75:29: error: cast from pointer to integer of
>> different size [-Werror=3Dpointer-to-int-cast]
>>    75 |     unsigned long n_insns =3D (unsigned long)udata;
>>       |                             ^
>> ../tests/plugin/bb.c: In function 'vcpu_tb_trans':
>> ../tests/plugin/bb.c:95:46: error: cast to pointer from integer of
>> different size [-Werror=3Dint-to-pointer-cast]
>>    95 |                                              (void *)n_insns);
>>       |                                              ^
>
> Plugins cannot work on Windows, because they would be specific to one
> executable as far as I know.  Plugins would have to link with the
> emulator's import library, but there would be one import library per
> emulator.

I'm not sure I follow. There is nothing specific about the QEMU binary
it cares about as long as the API symbols exist. Are you saying each
QEMU binary will have different resolvable names for the external
functions in plugins/api.c?

>
> Paolo
>
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libempty.dll.p/empty.c.obj: in function `qemu_plugin_instal=
l':
>> C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined reference
>> to `qemu_plugin_register_vcpu_tb_trans_cb'
>> cc1.exe: all warnings being treated as errors
>> collect2.exe: error: ld returned 1 exit status
>> make: *** [Makefile.ninja:2433=EF=BC=9Atests/plugin/libempty.dll] =E9=94=
=99=E8=AF=AF 1
>> make: *** =E6=AD=A3=E5=9C=A8=E7=AD=89=E5=BE=85=E6=9C=AA=E5=AE=8C=E6=88=
=90=E7=9A=84=E4=BB=BB=E5=8A=A1....
>> make: *** [Makefile.ninja:2420=EF=BC=9Atests/plugin/libbb.dll.p/bb.c.obj=
] =E9=94=99=E8=AF=AF 1
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libinsn.dll.p/insn.c.obj: in function `vcpu_tb_trans':
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference
>> to `qemu_plugin_tb_n_insns'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: undefined reference
>> to `qemu_plugin_tb_get_insn'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference
>> to `qemu_plugin_register_vcpu_insn_exec_inline'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: undefined reference
>> to `qemu_plugin_register_vcpu_insn_exec_cb'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit':
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference
>> to `qemu_plugin_outs'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libinsn.dll.p/insn.c.obj: in function `qemu_plugin_install':
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:59: undefined reference
>> to `qemu_plugin_register_vcpu_tb_trans_cb'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined reference
>> to `qemu_plugin_register_atexit_cb'
>> collect2.exe: error: ld returned 1 exit status
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit':
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined reference to
>> `qemu_plugin_outs'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem':
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:41: undefined reference to
>> `qemu_plugin_get_hwaddr'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined reference to
>> `qemu_plugin_hwaddr_is_io'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_tb_trans':
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:54: undefined reference to
>> `qemu_plugin_tb_n_insns'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference to
>> `qemu_plugin_tb_get_insn'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:61: undefined reference to
>> `qemu_plugin_register_vcpu_mem_inline'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference to
>> `qemu_plugin_register_vcpu_mem_cb'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> tests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install':
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefined reference to
>> `qemu_plugin_register_vcpu_tb_trans_cb'
>> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
>> C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference to
>> `qemu_plugin_register_atexit_cb'
>> make: *** [Makefile.ninja:2440=EF=BC=9Atests/plugin/libinsn.dll] =E9=94=
=99=E8=AF=AF 1
>> collect2.exe: error: ld returned 1 exit status
>> make: *** [Makefile.ninja:2447=EF=BC=9Atests/plugin/libmem.dll] =E9=94=
=99=E8=AF=AF 1
>> make -C /c/work/xemu/qemu/slirp
>> BUILD_DIR=3D"/c/work/xemu/qemu/build/slirp" PKG_CONFIG=3D"pkg-config"
>> CC=3D"cc" AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D"-m64 -mcx16
>> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
>> -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings
>> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
>>  -Wold-style-declaration -Wold-style-definition -Wtype-limits
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
>> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
>> -fstack-protector-strong -g -fno-pie -mthreads -std=3Dgnu99 -Wall"
>> LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong"
>> make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/=
slirp=E2=80=9D
>> make[1]: =E5=AF=B9=E2=80=9Call=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=BB=
=BB=E4=BD=95=E4=BA=8B=E3=80=82
>> make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/=
slirp=E2=80=9D
>> make -I/c/work/xemu/qemu/dtc VPATH=3D/c/work/xemu/qemu/dtc -C dtc V=3D"1"
>> LIBFDT_lib=3D"" CPPFLAGS=3D"-I/c/work/xemu/qemu/dtc/libfdt" CFLAGS=3D"-g
>> -fno-pie -mthreads -std=3Dgnu99 -Wall -m64 -mcx16 -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
>> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
>> -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
>> -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
>> -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
>> -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong"
>> LDFLAGS=3D"-Wl,--warn-common -m64  -fstack-protector-strong" ARFLAGS=3D"=
rv"
>> CC=3D"cc" AR=3D"ar" LD=3D"ld"  libfdt
>> make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/=
build/dtc=E2=80=9D
>> make[1]: =E5=AF=B9=E2=80=9Clibfdt=E2=80=9D=E6=97=A0=E9=9C=80=E5=81=9A=E4=
=BB=BB=E4=BD=95=E4=BA=8B=E3=80=82
>> make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/=
build/dtc=E2=80=9D
>> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
>> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
>> "qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
>> "C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then
>> printf '%s\n' qemu-version.h > qemu-version.h.stamp; fi
>> "ar" csrD libqemuutil.a @libqemuutil.a.rsp
>> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
>> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
>> "C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12=
652a9e7600847543c3524867d85d7.dat"
>> && if test -e block.syms; then printf '%s\n' block.syms >
>> block.syms.stamp; fi
>> "ar" csrD libblock.fa @libblock.fa.rsp
>> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
>> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
>> "C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac7=
976b6693320b9cb25885f5b2f71c7.dat"
>> && if test -e qemu.syms; then printf '%s\n' qemu.syms > qemu.syms.stamp;=
 fi
>> "c++" @qemu-system-ppc.exe.rsp
>>=20
>> --=20
>>          =E6=AD=A4=E8=87=B4
>> =E7=A4=BC
>> =E7=BD=97=E5=8B=87=E5=88=9A
>> Yours
>>     sincerely,
>> Yonggang Luo


--=20
Alex Benn=C3=A9e

