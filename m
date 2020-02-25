Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADBC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073B12072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073B12072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cbt-0002QN-8R
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6cbH-0001lm-QC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6cbF-0000gO-DP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:23 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:55655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6cbF-0000fh-1i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:21 -0500
Received: from player760.ha.ovh.net (unknown [10.110.208.89])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id A5D5F1CA770
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 16:58:18 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 879D5FC35C32;
 Tue, 25 Feb 2020 15:58:05 +0000 (UTC)
Date: Tue, 25 Feb 2020 16:58:01 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 06/18] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Message-ID: <20200225165801.14cba74c@bahia.home>
In-Reply-To: <20200225122900.0fe0780b@bahia.home>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-7-david@gibson.dropbear.id.au>
 <20200225122900.0fe0780b@bahia.home>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 4907234744646605286
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
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
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 12:29:00 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 25 Feb 2020 10:37:12 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > For the "pseries" machine, we use "virtual hypervisor" mode where we
> > only model the CPU in non-hypervisor privileged mode.  This means that
> > we need guest physical addresses within the modelled cpu to be treated
> > as absolute physical addresses.
> >=20
> > We used to do that by clearing LPCR[VPM0] and setting LPCR[RMLS] to a h=
igh
> > limit so that the old offset based translation for guest mode applied,
> > which does what we need.  However, POWER9 has removed support for that
> > translation mode, which meant we had some ugly hacks to keep it working.
> >=20
> > We now explicitly handle this sort of translation for virtual hypervisor
> > mode, so the hacks aren't necessary.  We don't need to set VPM0 and RMLS
> > from the machine type code - they're now ignored in vhyp mode.  On the =
cpu
> > side we don't need to allow LPCR[RMLS] to be set on POWER9 in vhyp mode=
 -
> > that was only there to allow the hack on the machine side.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20

Ah wait...

> >  hw/ppc/spapr_cpu_core.c | 6 +-----
> >  target/ppc/mmu-hash64.c | 8 --------
> >  2 files changed, 1 insertion(+), 13 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index d09125d9af..ea5e11f1d9 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -58,14 +58,10 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> >       * we don't get spurious wakups before an RTAS start-cpu call.
> >       * For the same reason, set PSSCR_EC.
> >       */
> > -    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpc=
r_pm);
> > +    lpcr &=3D ~(LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);

... a few lines above, we have a comment that should be dropped as well.

     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
     * real mode accesses, which thankfully defaults to 0 and isn't
     * accessible in guest mode.

My R-b tag stands anyway.

> >      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
> >      env->spr[SPR_PSSCR] |=3D PSSCR_EC;
> > =20
> > -    /* Set RMLS to the max (ie, 16G) */
> > -    lpcr &=3D ~LPCR_RMLS;
> > -    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> > -
> >      ppc_store_lpcr(cpu, lpcr);
> > =20
> >      /* Set a full AMOR so guest can use the AMR as it sees fit */
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index e372c42add..caf47ad6fc 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -1126,14 +1126,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulon=
g val)
> >                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPC=
R_EEE |
> >                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | L=
PCR_TC |
> >                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE=
);
> > -        /*
> > -         * If we have a virtual hypervisor, we need to bring back RMLS=
. It
> > -         * doesn't exist on an actual P9 but that's all we know how to
> > -         * configure with softmmu at the moment
> > -         */
> > -        if (cpu->vhyp) {
> > -            lpcr |=3D (val & LPCR_RMLS);
> > -        }
> >          break;
> >      default:
> >          g_assert_not_reached();
>=20
>=20


