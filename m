Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9C2206D5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNgMV+3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9C2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Ue-0007kf-KQ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1Sx-0006QV-VX
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:46:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1Sw-0007yI-62
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:46:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id r26so10285552wmh.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zeg1isCk/qA15Nm8XJ//2/bcp2eI0rlW3j2tOTx8cFg=;
 b=mNgMV+3to1jAspW72+9rQCzpUFmL0hFu8D4NSJ8zZIzOTKIkfwDygd2ZDsGbNsIa5n
 4ETE4ol86MfEZiXplLnakmSlK3LmKqlElweTKKbkf8D2sPCFsgVoL9Qtwud/AaTFiTtM
 haznP9anbYkKhm6aviLXazBGJGV3eek9G3a189H2I+n4bGu0yU4ur5Hc4VjyhsbkBkWZ
 sIFK6xxY60XnoXHFciqYPpq851WJLz0ER6ReF5UP2bW64EaQz93dSF/JKSo/gCcpWpwR
 y4jAbR9QUfNF/H9wOu8lk7biL0M5fPe5DVTQCkutPCnfMAET2hPDonKNbsGqSUZSs68G
 XsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zeg1isCk/qA15Nm8XJ//2/bcp2eI0rlW3j2tOTx8cFg=;
 b=cLeUqs3vtw948eDPwHLrhAFd+IEp5fZQ/xB5Id4RTm79wzNbZmjnOfucxOZlt2X8Ge
 S4+BwUVoen32YraAqT4R0ZzSIdDF6y8zz7YQ3Nr1fGlgjV9K8sgixWhZQ7NTBwnnFUvv
 hMscEfKWi2xgDZLjEonDGkBDHW6Em1VywOXDbnYzigTfcMirbggx8rX8guelcbV0WjEi
 jBk47vNlqYE73tDg/+flDqlhgNCFojDGbXiRe5AtkXmD1gwBV66ivm5/g2nX3g8Xa0po
 onXKqb5fjoo0iXhgaZDWCDEwNR6AGT2qmACalu9qKww8beme/CHXLF1PyBi8eTTT9VCS
 ++Iw==
X-Gm-Message-State: AGi0PuYSpeBP/fufYRDg/ZffCGJnwWELcsgiq4/5lASsmbJpIm5Fy7Ux
 Ob7hSsNLGUS7ZV+xv3zwQLcYJkL11+keq350r3Q=
X-Google-Smtp-Source: APiQypJ3a/GnVTNavr/YqLa//bJaveHv64RQQCCDMj1MEEaZFVw5xhyEagcqDZxhFDFslNNb+pWju0btFqaBPQX2WdA=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr17313372wmc.168.1588938412505; 
 Fri, 08 May 2020 04:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-14-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-14-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 13:46:39 +0200
Message-ID: <CAHiYmc4sNYYO=diSrXFUyWY15FeyNPiOXqQStnnEMF9As7h=QA@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] KVM: MIPS: Add more MMIO load/store instructions
 emulation
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:16 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> This patch add more MMIO load/store instructions emulation, which can
> be observed in QXL and some other device drivers:
>
> 1, LWL, LWR, LDW, LDR, SWL, SWR, SDL and SDR for all MIPS;
> 2, GSLBX, GSLHX, GSLWX, GSLDX, GSSBX, GSSHX, GSSWX and GSSDX for
>    Loongson-3.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kvm/emulate.c | 480 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 470 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 3946499..71316fa 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1604,6 +1604,7 @@ enum emulation_result kvm_mips_emulate_store(union =
mips_instruction inst,
>         enum emulation_result er;
>         u32 rt;
>         void *data =3D run->mmio.data;
> +       unsigned int imme;
>         unsigned long curr_pc;
>
>         /*
> @@ -1661,6 +1662,211 @@ enum emulation_result kvm_mips_emulate_store(unio=
n mips_instruction inst,
>                           vcpu->arch.gprs[rt], *(u8 *)data);
>                 break;
>
> +       case swl_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x3);
> +               run->mmio.len =3D 4;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x3;
> +               switch (imme) {
> +               case 0:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xffffff00) |
> +                                       (vcpu->arch.gprs[rt] >> 24);
> +                       break;
> +               case 1:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xffff0000) |
> +                                       (vcpu->arch.gprs[rt] >> 16);
> +                       break;
> +               case 2:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xff000000) |
> +                                       (vcpu->arch.gprs[rt] >> 8);
> +                       break;
> +               case 3:
> +                       *(u32 *)data =3D vcpu->arch.gprs[rt];
> +                       break;
> +               default:
> +                       break;
> +               }
> +
> +               kvm_debug("[%#lx] OP_SWL: eaddr: %#lx, gpr: %#lx, data: %=
#x\n",
> +                         vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
> +                         vcpu->arch.gprs[rt], *(u32 *)data);
> +               break;
> +
> +       case swr_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x3);
> +               run->mmio.len =3D 4;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x3;
> +               switch (imme) {
> +               case 0:
> +                       *(u32 *)data =3D vcpu->arch.gprs[rt];
> +                       break;
> +               case 1:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xff) |
> +                                       (vcpu->arch.gprs[rt] << 8);
> +                       break;
> +               case 2:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xffff) |
> +                                       (vcpu->arch.gprs[rt] << 16);
> +                       break;
> +               case 3:
> +                       *(u32 *)data =3D ((*(u32 *)data) & 0xffffff) |
> +                                       (vcpu->arch.gprs[rt] << 24);
> +                       break;
> +               default:
> +                       break;
> +               }
> +
> +               kvm_debug("[%#lx] OP_SWR: eaddr: %#lx, gpr: %#lx, data: %=
#x\n",
> +                         vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
> +                         vcpu->arch.gprs[rt], *(u32 *)data);
> +               break;
> +
> +       case sdl_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x7);
> +
> +               run->mmio.len =3D 8;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x7;
> +               switch (imme) {
> +               case 0:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffffff=
ff00) |
> +                                       ((vcpu->arch.gprs[rt] >> 56) & 0x=
ff);
> +                       break;
> +               case 1:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffffff=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 48) & 0x=
ffff);
> +                       break;
> +               case 2:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffff00=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 40) & 0x=
ffffff);
> +                       break;
> +               case 3:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffff0000=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 32) & 0x=
ffffffff);
> +                       break;
> +               case 4:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffff000000=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 24) & 0x=
ffffffffff);
> +                       break;
> +               case 5:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffff00000000=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 16) & 0x=
ffffffffffff);
> +                       break;
> +               case 6:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xff0000000000=
0000) |
> +                                       ((vcpu->arch.gprs[rt] >> 8) & 0xf=
fffffffffffff);
> +                       break;
> +               case 7:
> +                       *(u64 *)data =3D vcpu->arch.gprs[rt];
> +                       break;
> +               default:
> +                       break;
> +               }
> +
> +               kvm_debug("[%#lx] OP_SDL: eaddr: %#lx, gpr: %#lx, data: %=
llx\n",
> +                         vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
> +                         vcpu->arch.gprs[rt], *(u64 *)data);
> +               break;
> +
> +       case sdr_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x7);
> +
> +               run->mmio.len =3D 8;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x7;
> +               switch (imme) {
> +               case 0:
> +                       *(u64 *)data =3D vcpu->arch.gprs[rt];
> +                       break;
> +               case 1:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xff) |
> +                                       (vcpu->arch.gprs[rt] << 8);
> +                       break;
> +               case 2:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffff) |
> +                                       (vcpu->arch.gprs[rt] << 16);
> +                       break;
> +               case 3:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffff) |
> +                                       (vcpu->arch.gprs[rt] << 24);
> +                       break;
> +               case 4:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffff) |
> +                                       (vcpu->arch.gprs[rt] << 32);
> +                       break;
> +               case 5:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffff) =
|
> +                                       (vcpu->arch.gprs[rt] << 40);
> +                       break;
> +               case 6:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffffff=
) |
> +                                       (vcpu->arch.gprs[rt] << 48);
> +                       break;
> +               case 7:
> +                       *(u64 *)data =3D ((*(u64 *)data) & 0xffffffffffff=
ff) |
> +                                       (vcpu->arch.gprs[rt] << 56);
> +                       break;
> +               default:
> +                       break;
> +               }
> +
> +               kvm_debug("[%#lx] OP_SDR: eaddr: %#lx, gpr: %#lx, data: %=
llx\n",
> +                         vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
> +                         vcpu->arch.gprs[rt], *(u64 *)data);
> +               break;
> +
> +#ifdef CONFIG_CPU_LOONGSON64
> +       case sdc2_op:
> +               rt =3D inst.loongson3_lsdc2_format.rt;
> +               switch (inst.loongson3_lsdc2_format.opcode1) {
> +               /*
> +                * Loongson-3 overridden sdc2 instructions.
> +                * opcode1              instruction
> +                *   0x0          gssbx: store 1 bytes from GPR
> +                *   0x1          gsshx: store 2 bytes from GPR
> +                *   0x2          gsswx: store 4 bytes from GPR
> +                *   0x3          gssdx: store 8 bytes from GPR
> +                */
> +               case 0x0:
> +                       run->mmio.len =3D 1;
> +                       *(u8 *)data =3D vcpu->arch.gprs[rt];
> +
> +                       kvm_debug("[%#lx] OP_GSSBX: eaddr: %#lx, gpr: %#l=
x, data: %#x\n",
> +                                 vcpu->arch.pc, vcpu->arch.host_cp0_badv=
addr,
> +                                 vcpu->arch.gprs[rt], *(u8 *)data);
> +                       break;
> +               case 0x1:
> +                       run->mmio.len =3D 2;
> +                       *(u16 *)data =3D vcpu->arch.gprs[rt];
> +
> +                       kvm_debug("[%#lx] OP_GSSSHX: eaddr: %#lx, gpr: %#=
lx, data: %#x\n",
> +                                 vcpu->arch.pc, vcpu->arch.host_cp0_badv=
addr,
> +                                 vcpu->arch.gprs[rt], *(u16 *)data);
> +                       break;
> +               case 0x2:
> +                       run->mmio.len =3D 4;
> +                       *(u32 *)data =3D vcpu->arch.gprs[rt];
> +
> +                       kvm_debug("[%#lx] OP_GSSWX: eaddr: %#lx, gpr: %#l=
x, data: %#x\n",
> +                                 vcpu->arch.pc, vcpu->arch.host_cp0_badv=
addr,
> +                                 vcpu->arch.gprs[rt], *(u32 *)data);
> +                       break;
> +               case 0x3:
> +                       run->mmio.len =3D 8;
> +                       *(u64 *)data =3D vcpu->arch.gprs[rt];
> +
> +                       kvm_debug("[%#lx] OP_GSSDX: eaddr: %#lx, gpr: %#l=
x, data: %#llx\n",
> +                                 vcpu->arch.pc, vcpu->arch.host_cp0_badv=
addr,
> +                                 vcpu->arch.gprs[rt], *(u64 *)data);
> +                       break;
> +               default:
> +                       kvm_err("Godson Exteneded GS-Store not yet suppor=
ted (inst=3D0x%08x)\n",
> +                               inst.word);
> +                       break;
> +               }
> +               break;
> +#endif
>         default:
>                 kvm_err("Store not yet supported (inst=3D0x%08x)\n",
>                         inst.word);
> @@ -1695,6 +1901,7 @@ enum emulation_result kvm_mips_emulate_load(union m=
ips_instruction inst,
>         enum emulation_result er;
>         unsigned long curr_pc;
>         u32 op, rt;
> +       unsigned int imme;
>
>         rt =3D inst.i_format.rt;
>         op =3D inst.i_format.opcode;
> @@ -1747,6 +1954,162 @@ enum emulation_result kvm_mips_emulate_load(union=
 mips_instruction inst,
>                 run->mmio.len =3D 1;
>                 break;
>
> +       case lwl_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x3);
> +
> +               run->mmio.len =3D 4;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x3;
> +               switch (imme) {
> +               case 0:
> +                       vcpu->mmio_needed =3D 3;  /* 1 byte */
> +                       break;
> +               case 1:
> +                       vcpu->mmio_needed =3D 4;  /* 2 bytes */
> +                       break;
> +               case 2:
> +                       vcpu->mmio_needed =3D 5;  /* 3 bytes */
> +                       break;
> +               case 3:
> +                       vcpu->mmio_needed =3D 6;  /* 4 bytes */
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +
> +       case lwr_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x3);
> +
> +               run->mmio.len =3D 4;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x3;
> +               switch (imme) {
> +               case 0:
> +                       vcpu->mmio_needed =3D 7;  /* 4 bytes */
> +                       break;
> +               case 1:
> +                       vcpu->mmio_needed =3D 8;  /* 3 bytes */
> +                       break;
> +               case 2:
> +                       vcpu->mmio_needed =3D 9;  /* 2 bytes */
> +                       break;
> +               case 3:
> +                       vcpu->mmio_needed =3D 10; /* 1 byte */
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +
> +       case ldl_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x7);
> +
> +               run->mmio.len =3D 8;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x7;
> +               switch (imme) {
> +               case 0:
> +                       vcpu->mmio_needed =3D 11; /* 1 byte */
> +                       break;
> +               case 1:
> +                       vcpu->mmio_needed =3D 12; /* 2 bytes */
> +                       break;
> +               case 2:
> +                       vcpu->mmio_needed =3D 13; /* 3 bytes */
> +                       break;
> +               case 3:
> +                       vcpu->mmio_needed =3D 14; /* 4 bytes */
> +                       break;
> +               case 4:
> +                       vcpu->mmio_needed =3D 15; /* 5 bytes */
> +                       break;
> +               case 5:
> +                       vcpu->mmio_needed =3D 16; /* 6 bytes */
> +                       break;
> +               case 6:
> +                       vcpu->mmio_needed =3D 17; /* 7 bytes */
> +                       break;
> +               case 7:
> +                       vcpu->mmio_needed =3D 18; /* 8 bytes */
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +
> +       case ldr_op:
> +               run->mmio.phys_addr =3D kvm_mips_callbacks->gva_to_gpa(
> +                                       vcpu->arch.host_cp0_badvaddr) & (=
~0x7);
> +
> +               run->mmio.len =3D 8;
> +               imme =3D vcpu->arch.host_cp0_badvaddr & 0x7;
> +               switch (imme) {
> +               case 0:
> +                       vcpu->mmio_needed =3D 19; /* 8 bytes */
> +                       break;
> +               case 1:
> +                       vcpu->mmio_needed =3D 20; /* 7 bytes */
> +                       break;
> +               case 2:
> +                       vcpu->mmio_needed =3D 21; /* 6 bytes */
> +                       break;
> +               case 3:
> +                       vcpu->mmio_needed =3D 22; /* 5 bytes */
> +                       break;
> +               case 4:
> +                       vcpu->mmio_needed =3D 23; /* 4 bytes */
> +                       break;
> +               case 5:
> +                       vcpu->mmio_needed =3D 24; /* 3 bytes */
> +                       break;
> +               case 6:
> +                       vcpu->mmio_needed =3D 25; /* 2 bytes */
> +                       break;
> +               case 7:
> +                       vcpu->mmio_needed =3D 26; /* 1 byte */
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +
> +#ifdef CONFIG_CPU_LOONGSON64
> +       case ldc2_op:
> +               rt =3D inst.loongson3_lsdc2_format.rt;
> +               switch (inst.loongson3_lsdc2_format.opcode1) {
> +               /*
> +                * Loongson-3 overridden ldc2 instructions.
> +                * opcode1              instruction
> +                *   0x0          gslbx: store 1 bytes from GPR
> +                *   0x1          gslhx: store 2 bytes from GPR
> +                *   0x2          gslwx: store 4 bytes from GPR
> +                *   0x3          gsldx: store 8 bytes from GPR
> +                */
> +               case 0x0:
> +                       run->mmio.len =3D 1;
> +                       vcpu->mmio_needed =3D 27; /* signed */
> +                       break;
> +               case 0x1:
> +                       run->mmio.len =3D 2;
> +                       vcpu->mmio_needed =3D 28; /* signed */
> +                       break;
> +               case 0x2:
> +                       run->mmio.len =3D 4;
> +                       vcpu->mmio_needed =3D 29; /* signed */
> +                       break;
> +               case 0x3:
> +                       run->mmio.len =3D 8;
> +                       vcpu->mmio_needed =3D 30; /* signed */
> +                       break;
> +               default:
> +                       kvm_err("Godson Exteneded GS-Load for float not y=
et supported (inst=3D0x%08x)\n",
> +                               inst.word);
> +                       break;
> +               }
> +               break;
> +#endif
> +
>         default:
>                 kvm_err("Load not yet supported (inst=3D0x%08x)\n",
>                         inst.word);
> @@ -2612,28 +2975,125 @@ enum emulation_result kvm_mips_complete_mmio_loa=
d(struct kvm_vcpu *vcpu,
>
>         switch (run->mmio.len) {
>         case 8:
> -               *gpr =3D *(s64 *)run->mmio.data;
> +               switch (vcpu->mmio_needed) {
> +               case 11:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffffffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xff) << 56)=
;
> +                       break;
> +               case 12:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffff) << 4=
8);
> +                       break;
> +               case 13:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffffff) <<=
 40);
> +                       break;
> +               case 14:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffffffff) =
<< 32);
> +                       break;
> +               case 15:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffffffffff=
) << 24);
> +                       break;
> +               case 16:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffffffffff=
ff) << 16);
> +                       break;
> +               case 17:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ff) |
> +                               (((*(s64 *)run->mmio.data) & 0xffffffffff=
ffff) << 8);
> +                       break;
> +               case 18:
> +               case 19:
> +                       *gpr =3D *(s64 *)run->mmio.data;
> +                       break;
> +               case 20:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ff00000000000000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 8) & 0xff=
ffffffffffff);
> +                       break;
> +               case 21:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffff000000000000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 16) & 0xf=
fffffffffff);
> +                       break;
> +               case 22:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffff0000000000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 24) & 0xf=
fffffffff);
> +                       break;
> +               case 23:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffff00000000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 32) & 0xf=
fffffff);
> +                       break;
> +               case 24:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffff000000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 40) & 0xf=
fffff);
> +                       break;
> +               case 25:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffffff0000) |
> +                               ((((*(s64 *)run->mmio.data)) >> 48) & 0xf=
fff);
> +                       break;
> +               case 26:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffffffffffff00) |
> +                               ((((*(s64 *)run->mmio.data)) >> 56) & 0xf=
f);
> +                       break;
> +               default:
> +                       *gpr =3D *(s64 *)run->mmio.data;
> +               }
>                 break;
>
>         case 4:
> -               if (vcpu->mmio_needed =3D=3D 2)
> -                       *gpr =3D *(s32 *)run->mmio.data;
> -               else
> +               switch (vcpu->mmio_needed) {
> +               case 1:
>                         *gpr =3D *(u32 *)run->mmio.data;
> +                       break;
> +               case 2:
> +                       *gpr =3D *(s32 *)run->mmio.data;
> +                       break;
> +               case 3:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffff) |
> +                               (((*(s32 *)run->mmio.data) & 0xff) << 24)=
;
> +                       break;
> +               case 4:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffff) |
> +                               (((*(s32 *)run->mmio.data) & 0xffff) << 1=
6);
> +                       break;
> +               case 5:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ff) |
> +                               (((*(s32 *)run->mmio.data) & 0xffffff) <<=
 8);
> +                       break;
> +               case 6:
> +               case 7:
> +                       *gpr =3D *(s32 *)run->mmio.data;
> +                       break;
> +               case 8:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ff000000) |
> +                               ((((*(s32 *)run->mmio.data)) >> 8) & 0xff=
ffff);
> +                       break;
> +               case 9:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffff0000) |
> +                               ((((*(s32 *)run->mmio.data)) >> 16) & 0xf=
fff);
> +                       break;
> +               case 10:
> +                       *gpr =3D (vcpu->arch.gprs[vcpu->arch.io_gpr] & 0x=
ffffff00) |
> +                               ((((*(s32 *)run->mmio.data)) >> 24) & 0xf=
f);
> +                       break;
> +               default:
> +                       *gpr =3D *(s32 *)run->mmio.data;
> +               }
>                 break;
>
>         case 2:
> -               if (vcpu->mmio_needed =3D=3D 2)
> -                       *gpr =3D *(s16 *) run->mmio.data;
> -               else
> +               if (vcpu->mmio_needed =3D=3D 1)
>                         *gpr =3D *(u16 *)run->mmio.data;
> +               else
> +                       *gpr =3D *(s16 *)run->mmio.data;
>
>                 break;
>         case 1:
> -               if (vcpu->mmio_needed =3D=3D 2)
> -                       *gpr =3D *(s8 *) run->mmio.data;
> +               if (vcpu->mmio_needed =3D=3D 1)
> +                       *gpr =3D *(u8 *)run->mmio.data;
>                 else
> -                       *gpr =3D *(u8 *) run->mmio.data;
> +                       *gpr =3D *(s8 *)run->mmio.data;
>                 break;
>         }
>
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

