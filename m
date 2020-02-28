Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18713C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75C1246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F0s8CfRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75C1246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mkV-0006ek-3k
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nevilad@yahoo.com>) id 1j7mjn-00069I-Va
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nevilad@yahoo.com>) id 1j7mjl-0000M0-UQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:59:59 -0500
Received: from sonic310-11.consmr.mail.ir2.yahoo.com ([77.238.177.32]:45445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nevilad@yahoo.com>) id 1j7mjl-0000J7-Nc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1582923595; bh=7uxKgR/4Bt0taBXYRLRkq2kSBEO6uFIUfYS5cxzvEXQ=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=F0s8CfRdmH8mZBKGp418OWk4ppP285rbRslKJRIDhxlinS/8RqbvDWv5YH9esIs/7TZv81cxl9OwtWOacjNxkGRzAXVoCSUL9bnwNlPxd19JF6tbSEx+fVGfaqdwDhT1GpEZ99ThQW6vJ0is3hUtamzGCc6dJ87GrNDjLVKiCUgiBSSb9+PQpTzTGmSBiCn+0zrGGya30VWstFkOoTpK4gy2vV1Jfr+4wyj4PTomt0lbtDcHNGcw9YH4bAVNACAQCos6Azoe3lGgXpAql9RGujCW/FdjNsc14Wi33od4yPJaxkeSP9VCAZKJ+HjEnPNT/s2ZywaSvSsQsDvI3DI2mA==
X-YMail-OSG: XD1hVh8VM1kWwWsIbER1CFnHVgraKbEdFKD3pU8CRAzOXi4FjmbwDw51n6OYgjU
 NavWU6Ch9x3ThKZqYkydbWMUEJpEeWFCk21RLDWsbRyCDngmwvNGRCVIJN.WF_wet5eo93N5kBdO
 dNB1gK4m2lcS2_Qv0dudAQveo7iSjocPIreDYVGBI7gYMbDKW6AVtfe6EdDy1gN1cxc.psBaEoU2
 4G63fe9vB8vwzSNEKNxlrFZasJl4VCoeSfilCWqvvKZ4qLwrRvwnwVO_FQCJ.Gqefnd11l2fjfa5
 GnCkfkJ8doKHClYnsU4yvM1U.EKSOENETFvEo1F.OQaAqKbPC.HX6h5DsJ5G0yU8f84Jn.UTI1aM
 myVp6_K1qst7ZHWwuqv.M1XtW4m9KL9.6ouesgkNSU3rorVZsVI.YS9ssSySjtk7jUzb03ynrzFm
 aBaXMQZcaP7P.Cvk9R39Sd1Te3geq2ZlN2soefd4imVMmj832wKs9u26F_7bnG5sj4Ya13J3QSv9
 6pZTcZZ_SJNK.ZzEkpuQ7JvM377KZWoXZfifowesRKdknRHH0X9zD2hJPPDKa82ur7Ba1sO__QPf
 hCTWDUsaN_4awMKMOaO9Xp.aDbUmbe9XxufFRTb6R8M4YlRIYr2dd_ayyYozIZqlYH_5QBgDQRuT
 5O9pcnUqaoF9sDvcVGIywGvlZ_aqy_R_vzYheVgiqhf7oBOkDl1fjswH8sFxdrqA9NUQwF3YEsL4
 z4yJ795Rrc2DUQRd.DsL5oG9G3iK7759zQh0jL06vg0z3IUXWawXYOVZ.5tQDeIPGZ8MngK45A44
 rOcQaxem236GnQ6SEaJp.Qe30cl69kkWnbXO0Bfo2ZnmfgeJUIIKZaUpfpxYcZbzCfswypfeV0hq
 xjndihe9vP4IyYeJJLPbJkP2F3Qf7SwK34VbGMecmw3C6862TrqE8V_MtouR5TSTPP4GDtZ_yBFQ
 mZnM3vmvEBeLi5OrlO2Imd47TeQFb2vDgy_kZtW5iKPJqP2xQuQ.7LtiKOjnSHvLTZp41Q9Vl43g
 n7g2qbEept1JEPNlRaH2wVc8RNxTQz8NoKJteTJUnJuPjAFzDXF_5q5qEKIQOXXdpiGSyuyfll6a
 2Zz12Qnbsflx5bFnKYgQFjUBElafJmlHDjMBdu47bEGlRXphFsbVq6Lfq7gE68RjHi8vLafFIKrG
 VRo74suxlgfMSzTyf8ajp4cRsIaBtVzUCSItx43LpzySDXAgyr2Ni7gjujockgeTjCR9iH5bhMRt
 ZpQD2rcdnvrXXMAT_2WePg6MfKDBhqw3vw1PtiFEH8wVGLNgVQP2ECJ2H89kMvnYsVe586Z.zlm_
 BclZull77FNnq0nV3Yqvw_nY-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 28 Feb 2020 20:59:55 +0000
Date: Fri, 28 Feb 2020 20:59:52 +0000 (UTC)
From: Alexey Romko <nevilad@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wenchao.wang@intel.com" <wenchao.wang@intel.com>, 
 "colin.xu@intel.com" <colin.xu@intel.com>
Message-ID: <1786823015.3514736.1582923592218@mail.yahoo.com>
Subject: [PATCH] Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl interface
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1786823015.3514736.1582923592218.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNorrin Mozilla/5.0 (Windows NT 6.1)
 AppleWebKit/537.36 (KHTML,
 like Gecko) Chrome/78.0.3904.108 Safari/537.36 OPR/65.0.3467.72
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 77.238.177.32
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl interface, part of HAX P=
R 204

Signed-off-by: Alexey Romko <nevilad@yahoo.com>
---
=C2=A0target/i386/hax-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 ++++++++++++++++=
++++++++++++----
=C2=A0target/i386/hax-i386.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
=C2=A0target/i386/hax-interface.h |=C2=A0 2 ++
=C2=A03 files changed, 31 insertions(+), 5 deletions(-)


diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a8b6e5aeb8..0bdd309665 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -45,7 +45,7 @@
=C2=A0 =C2=A0 =C2=A0} while (0)
=C2=A0
=C2=A0/* Current version */
-const uint32_t hax_cur_version =3D 0x4; /* API v4: unmapping and MMIO move=
s */
+const uint32_t hax_cur_version =3D 0x5; /* API v5: supports CR8/EFER/PAT *=
/
=C2=A0/* Minimum HAX kernel version */
=C2=A0const uint32_t hax_min_version =3D 0x4; /* API v4: supports unmapping=
 */
=C2=A0
@@ -137,6 +137,7 @@ static int hax_version_support(struct hax_state *hax)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
+=C2=A0 =C2=A0 hax_global.cur_api_version =3D version.cur_version;
=C2=A0 =C2=A0 =C2=A0return 1;
=C2=A0}
=C2=A0
@@ -845,12 +846,24 @@ static int hax_sync_vcpu_register(CPUArchState *env, =
int set)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr2 =3D env->cr[2];
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr3 =3D env->cr[3];
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr4 =3D env->cr[4];
+
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X86CPU *x86_cpu =3D X86_CPU(cs);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs._cr8 =3D cpu_get_apic_tpr(x86_cpu-=
>apic_state);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hax_set_segments(env, &regs);
=C2=A0 =C2=A0 =C2=A0} else {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[0] =3D regs._cr0;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[2] =3D regs._cr2;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[3] =3D regs._cr3;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[4] =3D regs._cr4;
+
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 //if( hax_global.cur_api_version >=3D 0x5 ) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //no need to update TPR from regs._cr8,=
 since all changes are notified.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 //}
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hax_get_segments(env, &regs);
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
@@ -881,14 +894,18 @@ static int hax_get_msrs(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_SYSENTER_ESP;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_SYSENTER_EIP;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_TSC;
-#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_EFER;
+#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_STAR;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_LSTAR;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_CSTAR;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_FMASK;
=C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_KERNELGSBASE;
=C2=A0#endif
+=C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
+=C2=A0 =C2=A0 =C2=A0 msrs[n++].entry =3D MSR_PAT;
+=C2=A0 =C2=A0 }
+
=C2=A0 =C2=A0 =C2=A0md.nr_msr =3D n;
=C2=A0 =C2=A0 =C2=A0ret =3D hax_sync_msr(env, &md, 0);
=C2=A0 =C2=A0 =C2=A0if (ret < 0) {
@@ -909,10 +926,10 @@ static int hax_get_msrs(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_IA32_TSC:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->tsc =3D msrs[i].value;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
-#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_EFER:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->efer =3D msrs[i].value=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
+#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_STAR:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->star =3D msrs[i].value=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
@@ -929,6 +946,9 @@ static int hax_get_msrs(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->kernelgsbase =3D msrs[=
i].value;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
=C2=A0#endif
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MSR_PAT:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->pat =3D msrs[i].value;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
@@ -947,14 +967,18 @@ static int hax_set_msrs(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_ESP, en=
v->sysenter_esp);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_EIP, en=
v->sysenter_eip);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_TSC, env->tsc);
-#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_EFER, env->efer);
+#ifdef TARGET_X86_64
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_STAR, env->star);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_LSTAR, env->lstar);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_CSTAR, env->cstar);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask);
=C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, env->ke=
rnelgsbase);
=C2=A0#endif
+=C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
+=C2=A0 =C2=A0 =C2=A0 hax_msr_entry_set(&msrs[n++], MSR_PAT, env->pat);
+=C2=A0 =C2=A0 }
+
=C2=A0 =C2=A0 =C2=A0md.nr_msr =3D n;
=C2=A0 =C2=A0 =C2=A0md.done =3D 0;
=C2=A0
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 54e9d8b057..9515803184 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -34,7 +34,7 @@ struct hax_vcpu_state {
=C2=A0
=C2=A0struct hax_state {
=C2=A0 =C2=A0 =C2=A0hax_fd fd; /* the global hax device interface */
-=C2=A0 =C2=A0 uint32_t version;
+=C2=A0 =C2=A0 uint32_t cur_api_version;
=C2=A0 =C2=A0 =C2=A0struct hax_vm *vm;
=C2=A0 =C2=A0 =C2=A0uint64_t mem_quota;
=C2=A0 =C2=A0 =C2=A0bool supports_64bit_ramblock;
diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
index 537ae084e9..c87aedbc2e 100644
--- a/target/i386/hax-interface.h
+++ b/target/i386/hax-interface.h
@@ -218,6 +218,8 @@ struct vcpu_state_t {
=C2=A0 =C2=A0 =C2=A0uint32_t _activity_state;
=C2=A0 =C2=A0 =C2=A0uint32_t pad;
=C2=A0 =C2=A0 =C2=A0interruptibility_state_t _interruptibility_state;
+
+=C2=A0 =C2=A0 uint64_t _cr8;
=C2=A0};
=C2=A0
=C2=A0/* HAX exit status */
--=C2=A0
2.15.0.windows.1

