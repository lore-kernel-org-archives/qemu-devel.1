Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24170C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D529D2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="enj5hELr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D529D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6Dr-0004Ob-0m
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nevilad@yahoo.com>) id 1jK6DC-0003wz-EV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nevilad@yahoo.com>) id 1jK6DA-0000HW-AJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:13:14 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com ([77.238.176.99]:38920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nevilad@yahoo.com>) id 1jK6D9-0000Fy-TP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1585858389; bh=An9Mx6dnva6qDrcr5riuEert1xQa15oiZG3EGWqR2gc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject;
 b=enj5hELrqgAQpJ+hoQygyk9SFlEIoEw0xLZQNG37qRSXnTUzPUudwFgOAgOUSe1CSqPAvlCnbPeLZDZXqiRibwSzk9R1+mDkYsu//Uy7koOS/o7lm94WTOYm52AqT3d6zDfFC9Dv0PFpXPhuddpAvk5N+lben3zQfmkGoC0oi85yS/4KtblOsBABMxlBgAS3Pq9qRvHbia1wzgpcDqe6Ks0iYqmcY1PNQR6CgPgZcx23zKLeyGYkaiQE01hEx3ixKb/XVP0W2N3SCvzjdAhzfN99anjOXEREBVE+IwVRiWLm64pUTyfPgoNdr5mjOaNiaebCGtYVRmUiL302Aw6dfQ==
X-YMail-OSG: JD3ZFcwVM1nKCP9TwINpxbxkXFLKmM5JLknHw6URTEwoswHjDYBPa284QF9pN8L
 b2IrngLjJHBeEkSqdLHQOr89qUbYRlAGlvdKuQmm.trOEGjFASjMnkidNdfkKEwSkn30IlJ1KhEr
 davgtzu2glOMSZPeY4E7bR.Pk5cVuOv0JkrwZErfD3prBXadwX_PqcpBMZJXG7e63ZtJ7VLmpj2C
 NxkQ6yx85bZRVXbD4CIXzCKzJJ4pZiSJLqQcTFsT0DOjEr6XSamwTFedRYNCrGXpxfNTdQUzgsVL
 ZOoaLPeJOitdNY243Xw7EwzfbJlhSj5qAa0Zaal8xCynlSHDNwXXPEUGG7_I0HiI1qcUG7rzeHgc
 .uufX0HB35GJfmCZDDbHB9pTcB.SFexXopKuof2rT4kPqvYfdi6hTwaZN0mnpdt4HL19_XS6IK3E
 3X_X6Xt_nKyjQYSM9DbBTaex8MHnbNWlqHLLhpNyug0H72euDIgEeLpYJhsfZhtUwSDskgr2i0Xu
 tq0KH9Vc_dpBG457G1FnaiTOOmRx7xSSMXfEGGtovYvn0Tg8sPhySrmKXUbaI.rkw2F74lV4u9Uu
 lsoyxibLUyVde2j6zj5Ea_g3YeCNSPikHMllTND.Ik7NzykxxXe3jJfSsrCSxU.O1QHq_RLzpQtm
 P.BMnNMaAsTSFwcrDYKJ99ABnYstiNJlwEHEi5dySwReMjY9p16j7PNlEbbQ1jcgX_NuuCnnEMZu
 0me0etWElgO62XTCSlCkveuOctyGB2.oXC0hfEaPG13n8GoI_2iGA9neWZjaThPC8MY1jxtaM0Sj
 fzJFPM2vPciR7FDsSRZDRcz8e8rtnLYUbVVvGSJSWYNgGOIFCDm86AZ7cJAyzeUohDAieoCTnVX7
 V8nCiV6TqZYd2eb10RsllYXayuUuxcQXQ4jgKhQ4lyC3iukMhuk2U4iB39v_JdAOVijqWmOw8OBj
 O.NJah437UYlAPLMS0YIAhxbVYU9uSymg2pJb4DvYagXrfz.gYS.rZVMcH.YGXtGsoxCccYS_ReU
 us_pji9_sB03NCPw5oaNG5epNiODSOC.nZ7.q2HO3Bpkmnv0kokU54u0V.zofRf6NKtLBV4IlBW7
 TAaZC4N6nb6N0sI0lz5cTCUoCShp4C38YR7q7nsXhw1t4DUjDFTkzjOpirpMneFciUvHlCZgM6mi
 4zMLrO9_hsaCEF1k3wBWh93yZQrubGu4ZUugyvsuWWsBIQ1v4p9vWQQGaxCsxUYxTC8RSaHjT2oJ
 6tKeahBWF5zH5nBsGnTEhT6E6dVC0XvmP4UOk8JpDAJkoXW3ktuXhm6mWYngMThk6zgTBDi46yEu
 YLzdiT05OVjski2Kq3ZPA4daA5uyz30qtSqa632Ha1PqMy6yO3DtloXgkD1oIY6oJq5jxsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 2 Apr 2020 20:13:09 +0000
Date: Thu, 2 Apr 2020 20:12:36 +0000 (UTC)
From: Alexey Romko <nevilad@yahoo.com>
To: <"wenchao.wang@intel.com colin.xu"@intel.com>, 
 Colin Xu <colin.xu@intel.com>
Cc: qemu-devel@nongnu.org
Message-ID: <1585594358.2390477.1585858356908@mail.yahoo.com>
In-Reply-To: <765908e2-a829-3863-ea74-5264134f1c55@intel.com>
References: <1786823015.3514736.1582923592218.ref@mail.yahoo.com>
 <1786823015.3514736.1582923592218@mail.yahoo.com>
 <765908e2-a829-3863-ea74-5264134f1c55@intel.com>
Subject: Re: [PATCH] Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.15585 YMailNorrin Mozilla/5.0 (Windows NT 6.1)
 AppleWebKit/537.36 (KHTML,
 like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 77.238.176.99
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

Hi,

>If I remembered correctly, this patch together with the HAXM patch in=C2=
=A0github will cause some regression in SMP case

Only on MacOS host. Since there are problems in logging in MacOS, we can't =
figure yet the source of the problem. We can find the problem by trial and =
error, but this can be done after haxm is released.

> why Windows can't boot without the change.

Windows can boot without any MSR/CR8 saves to haxm, but when you want to us=
e snapshots you should save and restore these since windows changes and use=
s these. Currently snapshots are not working on windows (see=C2=A0https://b=
ugs.launchpad.net/qemu/+bug/1855617). I've tested snapshots on a modified v=
ersion of haxm+qemu when a agent in the guest executes vmcall instruction, =
this event is returned by haxm to qemu, registers and MSRs are synchronized=
 and snapshot created. Snapshot restore is done in standart way.

>Like CR8 (TPR), is there logic that need to be handled when TPR is=C2=A0re=
ad/write?

I've created CR8 read/write handling in haxm, but it is not yet submitted i=
n a PR. Originally the haxm PR was for x86 and x64 windows, but the x64 did=
 not work. I decided to do a one time interface change and not commit all t=
hese changes by pieces.=C2=A0 CR8 is needed by MacOS too. I plan to submit =
a PR for it's support after haxm release too.


Colin Xu <colin.xu@intel.com> wrote:=20


Sorry for missing this one.

If I remembered correctly, this patch together with the HAXM patch in=20
github will cause some regression in SMP case. So we'd like to fully=20
understand the technique details to make proper change, not only for a=20
very specific purpose, i.e. boot Windows on Windows.

This patch together with PR#204 doens't change the IOCTL interface=20
itself, but extend set/get regs with a version check, so the description=20
here isn't quite clear.
And the change looks just sync the qemu/haxm status but no more. Could=20
you provide more details that why Windows can't boot without the change.=20
Like CR8 (TPR), is there logic that need to be handled when TPR is=20
read/write?

On 2/29/2020 04:59, Alexey Romko wrote:
> Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl interface, part of HAX=
 PR 204
>
> Signed-off-by: Alexey Romko <nevilad@yahoo.com>
> ---
>=C2=A0 =C2=A0target/i386/hax-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 ++++++++=
++++++++++++++++++++----
>=C2=A0 =C2=A0target/i386/hax-i386.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>=C2=A0 =C2=A0target/i386/hax-interface.h |=C2=A0 2 ++
>=C2=A0 =C2=A03 files changed, 31 insertions(+), 5 deletions(-)
>
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index a8b6e5aeb8..0bdd309665 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -45,7 +45,7 @@
>=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (0)
>=C2=A0=20
>=C2=A0 =C2=A0/* Current version */
> -const uint32_t hax_cur_version =3D 0x4; /* API v4: unmapping and MMIO mo=
ves */
> +const uint32_t hax_cur_version =3D 0x5; /* API v5: supports CR8/EFER/PAT=
 */
>=C2=A0 =C2=A0/* Minimum HAX kernel version */
>=C2=A0 =C2=A0const uint32_t hax_min_version =3D 0x4; /* API v4: supports u=
nmapping */
>=C2=A0=20
> @@ -137,6 +137,7 @@ static int hax_version_support(struct hax_state *hax)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0=20
> +=C2=A0 =C2=A0 hax_global.cur_api_version =3D version.cur_version;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
>=C2=A0 =C2=A0}
>=C2=A0=20
> @@ -845,12 +846,24 @@ static int hax_sync_vcpu_register(CPUArchState *env=
, int set)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr2 =3D env->cr[2];
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr3 =3D env->cr[3];
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regs._cr4 =3D env->cr[4];
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X86CPU *x86_cpu =3D X86_CPU(cs);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs._cr8 =3D cpu_get_apic_tpr(x86_cp=
u->apic_state);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hax_set_segments(env, &regs);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[0] =3D regs._cr0;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[2] =3D regs._cr2;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[3] =3D regs._cr3;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cr[4] =3D regs._cr4;
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 //if( hax_global.cur_api_version >=3D 0x5 ) =
{
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //no need to update TPR from regs._cr=
8, since all changes are notified.
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 //}
> +
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hax_get_segments(env, &regs);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0=20
> @@ -881,14 +894,18 @@ static int hax_get_msrs(CPUArchState *env)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_SYSENTER_ESP;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_SYSENTER_EIP;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_IA32_TSC;
> -#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_EFER;
> +#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_STAR;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_LSTAR;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_CSTAR;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_FMASK;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0msrs[n++].entry =3D MSR_KERNELGSBASE;
>=C2=A0 =C2=A0#endif
> +=C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
> +=C2=A0 =C2=A0 =C2=A0 msrs[n++].entry =3D MSR_PAT;
> +=C2=A0 =C2=A0 }
> +
>=C2=A0 =C2=A0 =C2=A0 =C2=A0md.nr_msr =3D n;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D hax_sync_msr(env, &md, 0);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {
> @@ -909,10 +926,10 @@ static int hax_get_msrs(CPUArchState *env)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_IA32_TSC:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->tsc =3D msrs[i=
].value;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> -#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_EFER:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->efer =3D msrs[=
i].value;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> +#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MSR_STAR:
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->star =3D msrs[=
i].value;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> @@ -929,6 +946,9 @@ static int hax_get_msrs(CPUArchState *env)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->kernelgsbase =
=3D msrs[i].value;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>=C2=A0 =C2=A0#endif
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MSR_PAT:
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->pat =3D msrs[i].value;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0=20
> @@ -947,14 +967,18 @@ static int hax_set_msrs(CPUArchState *env)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER=
_ESP, env->sysenter_esp);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER=
_EIP, env->sysenter_eip);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_IA32_TSC, env=
->tsc);
> -#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_EFER, env->ef=
er);
> +#ifdef TARGET_X86_64
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_STAR, env->st=
ar);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_LSTAR, env->l=
star);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_CSTAR, env->c=
star);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->f=
mask);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE,=
 env->kernelgsbase);
>=C2=A0 =C2=A0#endif
> +=C2=A0 =C2=A0 if( hax_global.cur_api_version >=3D 0x5 ) {
> +=C2=A0 =C2=A0 =C2=A0 hax_msr_entry_set(&msrs[n++], MSR_PAT, env->pat);
> +=C2=A0 =C2=A0 }
> +
>=C2=A0 =C2=A0 =C2=A0 =C2=A0md.nr_msr =3D n;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0md.done =3D 0;
>=C2=A0=20
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 54e9d8b057..9515803184 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -34,7 +34,7 @@ struct hax_vcpu_state {
>=C2=A0=20
>=C2=A0 =C2=A0struct hax_state {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0hax_fd fd; /* the global hax device interface *=
/
> -=C2=A0 =C2=A0 uint32_t version;
> +=C2=A0 =C2=A0 uint32_t cur_api_version;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0struct hax_vm *vm;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t mem_quota;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0bool supports_64bit_ramblock;
> diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
> index 537ae084e9..c87aedbc2e 100644
> --- a/target/i386/hax-interface.h
> +++ b/target/i386/hax-interface.h
> @@ -218,6 +218,8 @@ struct vcpu_state_t {
>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t _activity_state;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pad;
>=C2=A0 =C2=A0 =C2=A0 =C2=A0interruptibility_state_t _interruptibility_stat=
e;
> +
> +=C2=A0 =C2=A0 uint64_t _cr8;
>=C2=A0 =C2=A0};
>=C2=A0=20
>=C2=A0 =C2=A0/* HAX exit status */
> --=20
> 2.15.0.windows.1

>
--=20
Best Regards,
Colin Xu



