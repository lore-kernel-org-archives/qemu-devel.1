Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70035C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F112176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F112176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YPs-0008Ao-G3
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6YP7-0007bI-4e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6YP4-0005V0-Az
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:29:32 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:35503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6YP4-00053l-2E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:29:30 -0500
Received: from player789.ha.ovh.net (unknown [10.108.57.141])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 633CB2019D1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:29:19 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 774A9FC5E58F;
 Tue, 25 Feb 2020 11:29:01 +0000 (UTC)
Date: Tue, 25 Feb 2020 12:29:00 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 06/18] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Message-ID: <20200225122900.0fe0780b@bahia.home>
In-Reply-To: <20200224233724.46415-7-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-7-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 364228620848962022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.65
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:12 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> For the "pseries" machine, we use "virtual hypervisor" mode where we
> only model the CPU in non-hypervisor privileged mode.  This means that
> we need guest physical addresses within the modelled cpu to be treated
> as absolute physical addresses.
>=20
> We used to do that by clearing LPCR[VPM0] and setting LPCR[RMLS] to a high
> limit so that the old offset based translation for guest mode applied,
> which does what we need.  However, POWER9 has removed support for that
> translation mode, which meant we had some ugly hacks to keep it working.
>=20
> We now explicitly handle this sort of translation for virtual hypervisor
> mode, so the hacks aren't necessary.  We don't need to set VPM0 and RMLS
> from the machine type code - they're now ignored in vhyp mode.  On the cpu
> side we don't need to allow LPCR[RMLS] to be set on POWER9 in vhyp mode -
> that was only there to allow the hack on the machine side.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_cpu_core.c | 6 +-----
>  target/ppc/mmu-hash64.c | 8 --------
>  2 files changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d09125d9af..ea5e11f1d9 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -58,14 +58,10 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>       * we don't get spurious wakups before an RTAS start-cpu call.
>       * For the same reason, set PSSCR_EC.
>       */
> -    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_=
pm);
> +    lpcr &=3D ~(LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
>      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
>      env->spr[SPR_PSSCR] |=3D PSSCR_EC;
> =20
> -    /* Set RMLS to the max (ie, 16G) */
> -    lpcr &=3D ~LPCR_RMLS;
> -    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> -
>      ppc_store_lpcr(cpu, lpcr);
> =20
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index e372c42add..caf47ad6fc 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1126,14 +1126,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong =
val)
>                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
>                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
>                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
> -        /*
> -         * If we have a virtual hypervisor, we need to bring back RMLS. =
It
> -         * doesn't exist on an actual P9 but that's all we know how to
> -         * configure with softmmu at the moment
> -         */
> -        if (cpu->vhyp) {
> -            lpcr |=3D (val & LPCR_RMLS);
> -        }
>          break;
>      default:
>          g_assert_not_reached();


