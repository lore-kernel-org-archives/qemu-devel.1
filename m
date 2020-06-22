Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F835C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4462071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R74N3JLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4462071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNit-0003VJ-Ak
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nevilad@yahoo.com>) id 1jnNhT-0001xf-Ep
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:45:31 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com ([77.238.178.96]:36022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nevilad@yahoo.com>) id 1jnNhR-0007Zr-2K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1592837124; bh=xXHpcIPLnTMCGSUtPFqmz/FoGjKzs7ThX+FkeUTuxdM=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=R74N3JLtsulDoBaYQib8Ag74tB2cfj7zrLJD0zb6gqhP+mACFaTW+N8jD+c9f5s27ZbWhAXky38MctlWc0HuDfblxKnc2vYf614B3JPn8GJhCJOtG9JyTFiSKNgy7/ZRUPSahqsLHLXscYKH7xvrqX1B/NtPvGECOxrKDwetXzCsB3K1+MMcO9ro8LwpyfSF/mMRVRMvp6hE1KDYze0/Hp9qJlMi1QPyob8GsN8kEafgc4R6rhUG48eDaWDVg+Fxi4T5voNPlkd0T0/kOPzB0NgliroRsstZSMjHz3p5FA2xQ4USKynwU//QlDBTjRL2Sh8v9KQyStWN1fu/6ET0aw==
X-YMail-OSG: hb6nA1MVM1k0mU2Kw4v0EudvhJ4fwoMPK3LFtU2dCY6Hd2fVfkTzgF3v6p4MuW8
 bPO6vO.3goqTW9rqUHnHWc0eyWy.bX0nOW4XAIuQuFMFwO5Hk7jBiYvCqS84uKHWCSWCDisxalVt
 iTyGpfbouY9QJZ5dqDpcOd7bY3U59PPKu.hWXjI4haWc33qXQUbTauvEjVDohXP9.B5hl9buWjx7
 pI0eBkquUSAe_.faIBj5H8P7Y7cMFTltvF457mF6jIzIdV3CQKV8VQMSHaiuOgl5D.U7XCQMTIdS
 HiApfz8FppWxjGB3ODYuyEhGSfTXK_cfzR2s9Qn5xJJ1VUv6CItvCy5fOWJSkd0tHs4BfTeFHSxH
 9Yv7RfO58oUTBWioeCBqmzXSyPAItrNj.I.yJdelagUiL.qwZK7saXl3Jgfr9.Yrs0tkNywrU.3g
 _Ve.9pIoRu6kI._Jikp6wwD3ICrfr7awcioExlGYtBdkxrTz0cMjIwLcYeuXH6WcS4JNjlxGPcR.
 kP1b1YZjmg609NO6se17fDo2Y6uX0_9YrNzTfZ_H.YpZ5nHC8tvDRmikDHJ.ek8AXdvAb2MHJ7mW
 MlcxUrPEgx.xWxb3vCxJPSrw04YibRVq..519AYKXjkmynvP5LBnew8hjYmq7a6B4R.Ehe50i8SD
 AvnX.ripEJl4mehE.1eNH8qG2bIQtdc7hb3m5aQa4XzFDGxJsfvRAerMnVIusBYp3QLEEJbsibXl
 u8DqexIrCU33VtKDVESojIUGQrpgE40pUN9wx6oCqVAHU21O_XqOIyilt56Bry3eEnrL7BuwdER0
 vUN79vLWeSQQc5G62dpo3yh7zKpWyn3NFRYjw7jo_sz3v7FbqYd0KTvM6YwklwtgbbveiVE_BcAA
 LMeKbQujasvtOZE7_q2zg_0enN_B1V2NaAizcTuc5mhmHyNhqZ55egbaTQXpaWg9w_YnMgrB9RXk
 7HrV_Koy6ZEmi8NuGvxLTl1BtqERJNUbrC.6RmcA5XDnIpEgYayUH3ObiZUzplPMMHfYAcTcnZk8
 ZOxjQUvROAzXbAGpQGRlRsag6NfH9NkkspmoDutJXOtBFjwtCWZASO7_o3mTEV_T.ZeQZfaiTLEc
 S.ew8D.n.AlGep_z1hd9cKcG1xG6knC5pPFGXyqE8w4.2uqaqO4ZY2puXgQiEb4IM7lXoan.VVgj
 91lLi.H0lwSQwcRaCITk4EQhVnwZmTSiTzr6B95ruJ9_JPZPhQMMnd7q0PCfd7hLx4OaM54xzaKk
 qPA85Gg8oWZgq.V2aGAjoCeJSVD3.dW9phgRgiLQPWN_R8MshP212CbD54zkxD8iEBuhngXpPjBW
 Dfpl9bzo4ckUgOtWoKDWsTk9.U_VK6ZL8KPf4CFpVbDuIr70OIGE.IDuBOBCDFzlDGg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 22 Jun 2020 14:45:24 +0000
Date: Mon, 22 Jun 2020 14:45:20 +0000 (UTC)
From: Alexey Romko <nevilad@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "haxm-team@intel.com" <haxm-team@intel.com>
Message-ID: <545115443.3540457.1592837120032@mail.yahoo.com>
Subject: [PATCH] Bug 1855617 Save registers to haxm when vcpu_dirty flag is
 set and clear it. vcpu_dirty flag was set in initialization code and not
 cleared, so read attempts were skipped and snapshots didn't contain
 correct  register values.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <545115443.3540457.1592837120032.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNorrin Mozilla/5.0 (Windows NT 6.1;
 ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138
 Safari/537.36
Received-SPF: pass client-ip=77.238.178.96; envelope-from=nevilad@yahoo.com;
 helo=sonic312-25.consmr.mail.ir2.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 10:45:24
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bug 1855617 Save registers to haxm when vcpu_dirty flag is
set and clear it. vcpu_dirty flag was set in initialization code and not
cleared, so read attempts were skipped and snapshots didn't contain correct
register values.

Signed-off-by: Alexey Romko <nevilad@yahoo.com>
---
=C2=A0target/i386/hax-all.c | 16 +++++++++++-----
=C2=A01 file changed, 11 insertions(+), 5 deletions(-)


diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index f9c83fff25..8aea72db07 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -504,16 +504,15 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DPRINTF("\nhax_vcpu_hax_exec: handling IN=
IT for %d\n",
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu->cpu_inde=
x);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_cpu_synchronize_state(cpu);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_cpu_init(x86_cpu);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_vcpu_sync_state(env, 1);
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
=C2=A0 =C2=A0 =C2=A0if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DPRINTF("hax_vcpu_hax_exec: handling SIPI=
 for %d\n",
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu->cpu_inde=
x);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_vcpu_sync_state(env, 0);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_cpu_synchronize_state(cpu);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_cpu_sipi(x86_cpu);
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_vcpu_sync_state(env, 1);
=C2=A0 =C2=A0 =C2=A0}
=C2=A0
=C2=A0 =C2=A0 =C2=A0if (cpu->halted) {
@@ -534,6 +533,11 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu->vcpu_dirty) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_vcpu_sync_state(env, 1);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu->vcpu_dirty =3D false;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hax_vcpu_interrupt(env);
=C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock_iothread();
@@ -621,8 +625,10 @@ static void do_hax_cpu_synchronize_state(CPUState *cpu=
, run_on_cpu_data arg)
=C2=A0{
=C2=A0 =C2=A0 =C2=A0CPUArchState *env =3D cpu->env_ptr;
=C2=A0
-=C2=A0 =C2=A0 hax_arch_get_registers(env);
-=C2=A0 =C2=A0 cpu->vcpu_dirty =3D true;
+=C2=A0 =C2=A0 if (!cpu->vcpu_dirty) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hax_arch_get_registers(env);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu->vcpu_dirty =3D true;
+=C2=A0 =C2=A0 }
=C2=A0}
=C2=A0
=C2=A0void hax_cpu_synchronize_state(CPUState *cpu)
--=C2=A0
2.15.0.windows.1

