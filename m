Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF6C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C1D206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C1D206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxvC-0006Jq-IN
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jIxuB-0004hN-Em
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jIxuA-0004et-Bx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:08:55 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:36084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jIxuA-0004dp-70
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:08:54 -0400
Received: from player773.ha.ovh.net (unknown [10.108.42.170])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id D48542776D9
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 19:08:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 1608D1103A866;
 Mon, 30 Mar 2020 17:08:45 +0000 (UTC)
Date: Mon, 30 Mar 2020 19:08:44 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 6/7] target/ppc: Extend ppc_radix64_check_prot() with a
 'partition_scoped' bool
Message-ID: <20200330190844.06a2db11@bahia.lan>
In-Reply-To: <20200330094946.24678-7-clg@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-7-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2856126591366109579
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.100
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 11:49:45 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This prepares ground for partition-scoped Radix translation.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-radix64.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 136498111f60..3ae29ed90d49 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -105,7 +105,8 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, int=
 rwx, vaddr eaddr,
> =20
> =20
>  static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pt=
e,
> -                                   int *fault_cause, int *prot)
> +                                   int *fault_cause, int *prot,
> +                                   bool partition_scoped)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      const int need_prot[] =3D { PAGE_READ, PAGE_WRITE, PAGE_EXEC };
> @@ -121,11 +122,11 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 int rwx, uint64_t pte,
>      }
> =20
>      /* Determine permissions allowed by Encoded Access Authority */
> -    if ((pte & R_PTE_EAA_PRIV) && msr_pr) { /* Insufficient Privilege */
> +    if (!partition_scoped && (pte & R_PTE_EAA_PRIV) && msr_pr) {
>          *prot =3D 0;
> -    } else if (msr_pr || (pte & R_PTE_EAA_PRIV)) {
> +    } else if (msr_pr || (pte & R_PTE_EAA_PRIV) || partition_scoped) {
>          *prot =3D ppc_radix64_get_prot_eaa(pte);
> -    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) */
> +    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) && !partition_scoped =
*/
>          *prot =3D ppc_radix64_get_prot_eaa(pte);
>          *prot &=3D ppc_radix64_get_prot_amr(cpu); /* Least combined perm=
issions */
>      }
> @@ -266,7 +267,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>                                  g_raddr, g_page_size, &fault_cause, &pte=
_addr);
> =20
>      if (!(pte & R_PTE_VALID) ||
> -        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot)) {
> +        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, 0)) {

Maybe pass false instead of 0 ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>          /* No valid pte or access denied due to protection */
>          if (cause_excp) {
>              ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);


