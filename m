Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688CA2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Mg8Tf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688CA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJVd-0002jn-N3
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJV3-0002In-SC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:55:29 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:42973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJV1-00019F-9R
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:55:29 -0400
Received: by mail-lj1-x22a.google.com with SMTP id t6so11264952ljk.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to; bh=FWVbszt9qaFcAHbxkJLARL0GdziLOhfbCC76VmTXQVc=;
 b=L8Mg8Tf3DFvPSvWiNTzGV1BRH7oN23zc15dNIOWBUUvfqgRmINPVeuE+1bt/Xz5lvp
 8l/f2cBjeoLYFAhZtEZcq5ef96CpjPUFVAKkaerduAaIOP1cQ4P1p/4DBjPPihvTm5t1
 OK+kz0d6Bo/tzNP78GbcKZT7gsO9QZ8dgC/z26l8OnXAzpDmdCoZ4varBDnc4Neii8if
 XqVnhufeV6eN4yE3jiM1QQE52D/sMzEGR78FxsC6akp+Hb3VviV1gTumqSU5h7fxZA03
 nLeYG93se3K7giqy6kpRkY9lSxy4ZMtXsGbsohHVFCrPvCNBvGtnkcRXTKluCeCf7IHj
 xsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to;
 bh=FWVbszt9qaFcAHbxkJLARL0GdziLOhfbCC76VmTXQVc=;
 b=RrL0d+nsUOvlK4GymUovGh0tLIMWj7aJxL2PK8Yb4xMKXs/Hs/X0NKd2PH1Uex5/If
 vIWRbvlw5rspMxNnHPk/UzQXf8HZ5CoWY9FOXnjndBJon6NQ3m+SmjhKG+3S+WKiccMq
 05hQuHylLbWBo9r0BL7VAeBkkICuQcWVyngevMa2OIPYrRjwrq6OaHZUVyyleDHAQSc4
 s70blS45v5oCdRzRRYkmxGRQ8W5kxAGcOjdHQDZeFNN/HlQ5lb0IH+oneNUuQPLBT+zh
 U+BEpUjyFdctM5drqrvcKdHxRJYMcPoLKYTCmPNmw122HwLN2SjZPu2FB3Czz/OnIsZI
 2yng==
X-Gm-Message-State: AOAM5305B+iH1lRJmqBCAJwlnB9GzWR2d4vgeCzvfyKIXGSB0phmEBX/
 NtqalTU7gmEIjSz27EDClzhyCmJ4mwOjG9ofK6ezxVfKU+46kA==
X-Google-Smtp-Source: ABdhPJyXpLfCpTfW/11eBFc7nJLmWXLv4dzS7K3wjAXL3CbpRIPQA//TadbFQkdtjSOlsxuZ2n6lvYTHmmWjRyoNJ/c=
X-Received: by 2002:a2e:8642:: with SMTP id i2mr3617046ljj.368.1598302525496; 
 Mon, 24 Aug 2020 13:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-bye0NfiXdLCRfOTrzFKmcT4HwYKrWO63pZyMbRNrJXQ@mail.gmail.com>
 <CAE2XoE8z9tijAdaovHNZ+XWLE8tBdFqbTS-v5hWshUP4bVaW0w@mail.gmail.com>
In-Reply-To: <CAE2XoE8z9tijAdaovHNZ+XWLE8tBdFqbTS-v5hWshUP4bVaW0w@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 04:55:14 +0800
Message-ID: <CAE2XoE-WcY+V2MyY3Gtm0a77UkMrbR7E-VwOaOCG56NhB=EkYw@mail.gmail.com>
Subject: Re: msys2/mingw meson building fixes
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-level <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000046a21f05ada5ce56"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
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

--00000000000046a21f05ada5ce56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After this fixes, the configure succeed, but the make -j10 failed
with
```
$ make -j10
python3 -B /e/CI-Cor-Ready/xemu/qemu.org/meson/meson.py introspect --tests
| python3 -B scripts/mtest2make.py > Makefile.mtest
./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
Makefile.ninja
  GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 meson dtc capstone slirp
  GEN     tests/test-qapi-gen
Traceback (most recent call last):
  File "scripts/mtest2make.py", line 56, in <module>
    executable =3D os.path.relpath(test['cmd'][0])
  File "C:/CI-Tools/msys64/mingw64/lib/python3.8/ntpath.py", line 716, in
relpath
    raise ValueError("path is on mount %r, start on mount %r" % (
ValueError: path is on mount 'C:', start on mount 'E:'
make: *** =E6=AD=A3=E5=9C=A8=E5=88=A0=E9=99=A4=E6=96=87=E4=BB=B6=E2=80=9CMa=
kefile.mtest=E2=80=9D
make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/e/CI-Cor-Ready/xemu/=
qemu.org/slirp=E2=80=9D
  GEN     /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/libslirp-version.h
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/arp_table.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/bootp.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/cksum.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/dhcpv6.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/dnssearch.o
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_overlay.c
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_check.c
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/if.o
  CC      cs.o
  CC      utils.o
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_addresses.c
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_empty_tree.c
  CC      SStream.o
  CC      MCInstrDesc.o
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_strerror.c
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_rw.c
  CC      MCRegisterInfo.o
  CC      arch/ARM/ARMDisassembler.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip_icmp.o
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_sw.c
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_wip.c
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip_input.o
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt_ro.c
         DEP /e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt/fdt.c
  CC      arch/ARM/ARMInstPrinter.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip_output.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip6_icmp.o
  CC      arch/ARM/ARMModule.o
  CC      arch/ARM/ARMMapping.o
  CC      arch/AArch64/AArch64BaseInfo.o
  CC      arch/AArch64/AArch64Disassembler.o
  CC      arch/AArch64/AArch64InstPrinter.o
  CC      arch/AArch64/AArch64Mapping.o
         CC libfdt/fdt.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip6_input.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip6_output.o
  CC      arch/AArch64/AArch64Module.o
  CC      arch/Mips/MipsDisassembler.o
  CC      arch/Mips/MipsInstPrinter.o
         CC libfdt/fdt_ro.o
  CC      arch/Mips/MipsMapping.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/mbuf.o
  CC      arch/Mips/MipsModule.o
  CC      arch/PowerPC/PPCDisassembler.o
  CC      arch/PowerPC/PPCInstPrinter.o
         CC libfdt/fdt_wip.o
  CC      arch/PowerPC/PPCMapping.o
         CC libfdt/fdt_sw.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/misc.o
  CC      arch/PowerPC/PPCModule.o
  CC      arch/Sparc/SparcDisassembler.o
         CC libfdt/fdt_rw.o
  CC      arch/Sparc/SparcInstPrinter.o
  CC      arch/Sparc/SparcMapping.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ncsi.o
  CC      arch/Sparc/SparcModule.o
  CC      arch/SystemZ/SystemZDisassembler.o
         CC libfdt/fdt_strerror.o
  CC      arch/SystemZ/SystemZInstPrinter.o
  CC      arch/SystemZ/SystemZMapping.o
  CC      arch/SystemZ/SystemZModule.o
  CC      arch/SystemZ/SystemZMCTargetDesc.o
         CC libfdt/fdt_empty_tree.o
  CC      arch/X86/X86Disassembler.o
  CC      arch/X86/X86DisassemblerDecoder.o
  CC      arch/X86/X86IntelInstPrinter.o
  CC      arch/X86/X86ATTInstPrinter.o
         CC libfdt/fdt_addresses.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ndp_table.o
         CC libfdt/fdt_overlay.o
  CC      arch/X86/X86Mapping.o
  CC      arch/X86/X86Module.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/sbuf.o
         CC libfdt/fdt_check.o
  CC      arch/XCore/XCoreInstPrinter.o
  CC      arch/XCore/XCoreDisassembler.o
  CC      arch/XCore/XCoreMapping.o
         AR libfdt/libfdt.a
  CC      arch/XCore/XCoreModule.o
  CC      MCInst.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/slirp.o
a - libfdt/fdt.o
a - libfdt/fdt_ro.o
a - libfdt/fdt_wip.o
a - libfdt/fdt_sw.o
a - libfdt/fdt_rw.o
a - libfdt/fdt_strerror.o
a - libfdt/fdt_empty_tree.o
a - libfdt/fdt_addresses.o
a - libfdt/fdt_overlay.o
a - libfdt/fdt_check.o
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ar.exe:
creating libfdt/libfdt.a
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/socket.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/state.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/stream.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_input.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_output.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_subr.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_timer.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tftp.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/udp.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/udp6.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/util.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/version.o
  CC      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/vmstate.o
  AR      capstone.lib
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ar.exe:
creating E:/CI-Cor-Ready/xemu/qemu.org-x64/capstone/capstone.lib
  AR      /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/libslirp.a
make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/e/CI-Cor-Ready/xemu/=
qemu.org/slirp=E2=80=9D
Makefile.ninja:27: *** =E5=A4=9A=E4=B8=AA=E7=9B=AE=E6=A0=87=E5=8C=B9=E9=85=
=8D=E3=80=82 =E5=81=9C=E6=AD=A2=E3=80=82

```

On Tue, Aug 25, 2020 at 4:53 AM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com>
wrote:

>
>
> ---------- Forwarded message ---------
> From: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com>
> Date: Tue, Aug 25, 2020 at 4:50 AM
> Subject: msys2/mingw meson building fixes
> To: qemu-level <qemu-devel@nongnu.org>
>
>
> I've create a pull request for fixes python ninja detection and usage on
> msys2/mingw
> at  https://github.com/mesonbuild/meson/pull/7637
>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo
>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000046a21f05ada5ce56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">After this fixes, the configure succeed, but the make -j10=
 failed<div>with</div><div>```</div><div>$ make -j10<br>python3 -B /e/CI-Co=
r-Ready/xemu/<a href=3D"http://qemu.org/meson/meson.py">qemu.org/meson/meso=
n.py</a> introspect --tests | python3 -B scripts/mtest2make.py &gt; Makefil=
e.mtest<br>./ninjatool -t ninja2make --omit clean dist uninstall &lt; build=
.ninja &gt; Makefile.ninja<br>=C2=A0 GIT =C2=A0 =C2=A0 ui/keycodemapdb test=
s/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 meson dtc capstone =
slirp<br>=C2=A0 GEN =C2=A0 =C2=A0 tests/test-qapi-gen<br>Traceback (most re=
cent call last):<br>=C2=A0 File &quot;scripts/mtest2make.py&quot;, line 56,=
 in &lt;module&gt;<br>=C2=A0 =C2=A0 executable =3D os.path.relpath(test[&#3=
9;cmd&#39;][0])<br>=C2=A0 File &quot;C:/CI-Tools/msys64/mingw64/lib/python3=
.8/ntpath.py&quot;, line 716, in relpath<br>=C2=A0 =C2=A0 raise ValueError(=
&quot;path is on mount %r, start on mount %r&quot; % (<br>ValueError: path =
is on mount &#39;C:&#39;, start on mount &#39;E:&#39;<br>make: *** =E6=AD=
=A3=E5=9C=A8=E5=88=A0=E9=99=A4=E6=96=87=E4=BB=B6=E2=80=9CMakefile.mtest=E2=
=80=9D<br>make[1]: =E8=BF=9B=E5=85=A5=E7=9B=AE=E5=BD=95=E2=80=9C/e/CI-Cor-R=
eady/xemu/<a href=3D"http://qemu.org/slirp">qemu.org/slirp</a>=E2=80=9D<br>=
=C2=A0 GEN =C2=A0 =C2=A0 /e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/libsli=
rp-version.h<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org=
-x64/slirp/src/arp_table.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready=
/xemu/qemu.org-x64/slirp/src/bootp.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI=
-Cor-Ready/xemu/qemu.org-x64/slirp/src/cksum.o<br>=C2=A0 CC =C2=A0 =C2=A0 =
=C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/dhcpv6.o<br>=C2=A0 CC =C2=
=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/dnssearch.o<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a href=3D"http=
://qemu.org/dtc/libfdt/fdt_overlay.c">qemu.org/dtc/libfdt/fdt_overlay.c</a>=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a href=3D"h=
ttp://qemu.org/dtc/libfdt/fdt_check.c">qemu.org/dtc/libfdt/fdt_check.c</a><=
br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/sr=
c/if.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0cs.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=
=A0utils.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a=
 href=3D"http://qemu.org/dtc/libfdt/fdt_addresses.c">qemu.org/dtc/libfdt/fd=
t_addresses.c</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/=
xemu/<a href=3D"http://qemu.org/dtc/libfdt/fdt_empty_tree.c">qemu.org/dtc/l=
ibfdt/fdt_empty_tree.c</a><br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0SStream.o<br>=
=C2=A0 CC =C2=A0 =C2=A0 =C2=A0MCInstrDesc.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0DEP /e/CI-Cor-Ready/xemu/<a href=3D"http://qemu.org/dtc/libfdt/fdt_st=
rerror.c">qemu.org/dtc/libfdt/fdt_strerror.c</a><br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a href=3D"http://qemu.org/dtc/libfdt=
/fdt_rw.c">qemu.org/dtc/libfdt/fdt_rw.c</a><br>=C2=A0 CC =C2=A0 =C2=A0 =C2=
=A0MCRegisterInfo.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/ARM/ARMDisassembl=
er.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/sli=
rp/src/ip_icmp.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/x=
emu/<a href=3D"http://qemu.org/dtc/libfdt/fdt_sw.c">qemu.org/dtc/libfdt/fdt=
_sw.c</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a =
href=3D"http://qemu.org/dtc/libfdt/fdt_wip.c">qemu.org/dtc/libfdt/fdt_wip.c=
</a><br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/sli=
rp/src/ip_input.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/=
xemu/<a href=3D"http://qemu.org/dtc/libfdt/fdt_ro.c">qemu.org/dtc/libfdt/fd=
t_ro.c</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEP /e/CI-Cor-Ready/xemu/<a=
 href=3D"http://qemu.org/dtc/libfdt/fdt.c">qemu.org/dtc/libfdt/fdt.c</a><br=
>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/ARM/ARMInstPrinter.o<br>=C2=A0 CC =C2=
=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip_output.o<br=
>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/=
ip6_icmp.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/ARM/ARMModule.o<br>=C2=A0 =
CC =C2=A0 =C2=A0 =C2=A0arch/ARM/ARMMapping.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=
=A0arch/AArch64/AArch64BaseInfo.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/AAr=
ch64/AArch64Disassembler.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/AArch64/AA=
rch64InstPrinter.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/AArch64/AArch64Map=
ping.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt.o<br>=C2=A0 CC =
=C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/ip6_input.o=
<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/s=
rc/ip6_output.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/AArch64/AArch64Module=
.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Mips/MipsDisassembler.o<br>=C2=A0 =
CC =C2=A0 =C2=A0 =C2=A0arch/Mips/MipsInstPrinter.o<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0CC libfdt/fdt_ro.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Mips/=
MipsMapping.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.or=
g-x64/slirp/src/mbuf.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Mips/MipsModul=
e.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/PowerPC/PPCDisassembler.o<br>=C2=
=A0 CC =C2=A0 =C2=A0 =C2=A0arch/PowerPC/PPCInstPrinter.o<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CC libfdt/fdt_wip.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0ar=
ch/PowerPC/PPCMapping.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt_=
sw.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/sli=
rp/src/misc.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/PowerPC/PPCModule.o<br>=
=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Sparc/SparcDisassembler.o<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt_rw.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=
=A0arch/Sparc/SparcInstPrinter.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Spar=
c/SparcMapping.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu=
.org-x64/slirp/src/ncsi.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Sparc/Sparc=
Module.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/SystemZ/SystemZDisassembler.=
o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt_strerror.o<br>=C2=A0 C=
C =C2=A0 =C2=A0 =C2=A0arch/SystemZ/SystemZInstPrinter.o<br>=C2=A0 CC =C2=A0=
 =C2=A0 =C2=A0arch/SystemZ/SystemZMapping.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=
=A0arch/SystemZ/SystemZModule.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/Syste=
mZ/SystemZMCTargetDesc.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt=
_empty_tree.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/X86/X86Disassembler.o<b=
r>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/X86/X86DisassemblerDecoder.o<br>=C2=A0=
 CC =C2=A0 =C2=A0 =C2=A0arch/X86/X86IntelInstPrinter.o<br>=C2=A0 CC =C2=A0 =
=C2=A0 =C2=A0arch/X86/X86ATTInstPrinter.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0CC libfdt/fdt_addresses.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-=
Ready/xemu/qemu.org-x64/slirp/src/ndp_table.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0CC libfdt/fdt_overlay.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/X86=
/X86Mapping.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/X86/X86Module.o<br>=C2=
=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/sbuf=
.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CC libfdt/fdt_check.o<br>=C2=A0 CC =
=C2=A0 =C2=A0 =C2=A0arch/XCore/XCoreInstPrinter.o<br>=C2=A0 CC =C2=A0 =C2=
=A0 =C2=A0arch/XCore/XCoreDisassembler.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0a=
rch/XCore/XCoreMapping.o<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AR libfdt/lib=
fdt.a<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/XCore/XCoreModule.o<br>=C2=A0 C=
C =C2=A0 =C2=A0 =C2=A0MCInst.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-R=
eady/xemu/qemu.org-x64/slirp/src/slirp.o<br>a - libfdt/fdt.o<br>a - libfdt/=
fdt_ro.o<br>a - libfdt/fdt_wip.o<br>a - libfdt/fdt_sw.o<br>a - libfdt/fdt_r=
w.o<br>a - libfdt/fdt_strerror.o<br>a - libfdt/fdt_empty_tree.o<br>a - libf=
dt/fdt_addresses.o<br>a - libfdt/fdt_overlay.o<br>a - libfdt/fdt_check.o<br=
>C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ar.exe: creating libfdt/libfdt.a<br>=C2=A0 CC =
=C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/socket.o<br=
>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/=
state.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/=
slirp/src/stream.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qe=
mu.org-x64/slirp/src/tcp_input.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor=
-Ready/xemu/qemu.org-x64/slirp/src/tcp_output.o<br>=C2=A0 CC =C2=A0 =C2=A0 =
=C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_subr.o<br>=C2=A0 CC =
=C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/tcp_timer.o=
<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/s=
rc/tftp.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x6=
4/slirp/src/udp.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qem=
u.org-x64/slirp/src/udp6.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready=
/xemu/qemu.org-x64/slirp/src/util.o<br>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/e/CI-=
Cor-Ready/xemu/qemu.org-x64/slirp/src/version.o<br>=C2=A0 CC =C2=A0 =C2=A0 =
=C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/src/vmstate.o<br>=C2=A0 AR =
=C2=A0 =C2=A0 =C2=A0capstone.lib<br>C:/CI-Tools/msys64/mingw64/bin/../lib/g=
cc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ar.exe: cre=
ating E:/CI-Cor-Ready/xemu/qemu.org-x64/capstone/capstone.lib<br>=C2=A0 AR =
=C2=A0 =C2=A0 =C2=A0/e/CI-Cor-Ready/xemu/qemu.org-x64/slirp/libslirp.a<br>m=
ake[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/e/CI-Cor-Ready/xemu/<=
a href=3D"http://qemu.org/slirp">qemu.org/slirp</a>=E2=80=9D<br>Makefile.ni=
nja:27: *** =E5=A4=9A=E4=B8=AA=E7=9B=AE=E6=A0=87=E5=8C=B9=E9=85=8D=E3=80=82=
 =E5=81=9C=E6=AD=A2=E3=80=82<br><br></div><div>```</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 202=
0 at 4:53 AM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailt=
o:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">---------- For=
warded message ---------<br>From: <strong class=3D"gmail_sendername" dir=3D=
"auto">=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)</strong> <span dir=3D"auto=
">&lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggan=
g@gmail.com</a>&gt;</span><br>Date: Tue, Aug 25, 2020 at 4:50 AM<br>Subject=
: msys2/mingw meson building fixes<br>To: qemu-level &lt;<a href=3D"mailto:=
qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a>&gt;<br><=
/div><br><br><div dir=3D"ltr">I&#39;ve create a pull request for fixes pyth=
on ninja detection and usage on msys2/mingw<div>at=C2=A0

<a href=3D"https://github.com/mesonbuild/meson/pull/7637" target=3D"_blank"=
>https://github.com/mesonbuild/meson/pull/7637</a>=C2=A0</div><div>=C2=A0<b=
r></div><div><div><div><br></div>-- <br><div dir=3D"ltr">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>=
</div></div>
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div>=
</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000046a21f05ada5ce56--

