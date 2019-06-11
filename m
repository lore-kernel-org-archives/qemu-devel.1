Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7280C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B890D2089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LZ3cENS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B890D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafwm-0007Dv-V5
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haftH-00051p-K5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haftC-0007sK-6F
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:28:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36227 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haft7-0007g7-Tg; Tue, 11 Jun 2019 08:28:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NTmn5W8nz9sDX; Tue, 11 Jun 2019 22:28:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560256089;
 bh=jBy4RI7VaJtYMRPV41sR+BW+U87+Kq0WIDre0lUpkaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LZ3cENS4Q7NaQMeasuIRhidcnSzwIvrRkVOhhKjw3tj4stp8NQJE/aRRvuBSJ0xfn
 S8Rht613ojXHs67AEPgpBpuNHXaKIXQ+sVNIHzgOGwQ6M+70FskdPCcJLC4AWH/7fv
 1gimpIZgF687qA8i9kqJtsxZ9duXQSOJgPrBpCaM=
Date: Tue, 11 Jun 2019 15:26:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190611052607.GC3998@umbus.fritz.box>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
 <20190607001901.GC3760@umbus.fritz.box>
 <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 10:17:58AM +0200, C=E9dric Le Goater wrote:
> On 07/06/2019 02:19, David Gibson wrote:
> > On Thu, Jun 06, 2019 at 07:08:59PM +0200, Greg Kurz wrote:
> >> If KVM is too old to support XIVE native exploitation mode, we might e=
nd
> >> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-ke=
rnel
> >> XICS is available, which is the case most of the time.
> >=20
> > This is intentional.  A predictable guest environment trumps performanc=
e.
>=20
> I don't agree.=20
>=20
> If the user does not specify any specific interrupt mode, we should favor=
=20
> the faster one.

In principle that sounds good, but it doesn't work that way, and can't
with anything resembling the current model.  The user can't specify a
specific interrupt mode to be used, they can only specify what modes
will be available to the guest, and "dual" means *both* are available.

Otherwise we will get inconsistent behaviour - potentially triggering
different guest bugs - on what's allegedly the same qemu
configuration. It gets worse if you consider edge cases like migrating
between the initial machine setup and CAS

> Here is the current matrix (with this patch) for guests running on an=20
> old KVM, that is without KVM XIVE support. Let's discuss on what we
> want.=20
>=20
>                         kernel_irqchip
>=20
>            (default)=20
> ic-mode     allowed           off            on=20
>=20
> dual        XICS KVM       XICS emul.(3)   XICS KVM         (default mode)

This should be as per "xive" - emul, emul, error (assuming POWER9 and
a a xive capable guest).  Otherwise we're presenting different guest
environments to the guest based on something that's not visible in the
qemu parameters.

We've done that a bunch of times in the past, and many of them have
bitten us in the arse later on.

> xics        XICS KVM       XICS emul.      XICS KVM   =20
> xive        XIVE emul.(1)  XIVE emul.     QEMU failure (2)
>=20
>=20
> (1) QEMU warns with "warning: kernel_irqchip requested but unavailable:=
=20
>     IRQ_XIVE capability must be present for KVM"=20
> (2) QEMU fails with "kernel_irqchip requested but unavailable:=20
>     IRQ_XIVE capability must be present for KVM"=20
> (3) That is wrong I think, we should get XIVE emulated.
>=20
>=20
> what you would want is XIVE emulation when ic-mode=3Ddual and=20
> kernel_irqchip=3Dallowed, which is the behavior with this patch (but there
> are reboot bugs)
>=20
> =20
> >> Also, an old KVM may not allow to destroy and re-create the KVM XICS, =
which
> >> is precisely what "dual" does during machine reset. This causes QEMU t=
o try
> >> to switch to emulated XICS and to crash because RTAS call de-registrat=
ion
> >> isn't handled correctly. We could possibly fix that, but again we would
> >> still end up with an emulated XICS or XIVE.
> >=20
> > Ugh, that's a problem.
>=20
> Yes. It's another problem around the way we cleanup the allocated resourc=
es.
> It should be another patch.

Agreed.

> >> "dual" is definitely not a good choice with older KVMs. Internally for=
ce
> >> XICS when we detect this.
> >=20
> > But this is not an acceptable solution.  Silently changing the guest
> > visible environment based on host capabilities is never ok.=20
>=20
> If the host (KVM) doesn't have a capability, what is the point of trying=
=20
> to use it if we can do better. I know you are considering KVM/QEMU as a
> whole but who would run with kernel_irqchip=3Doff ?

PAPR option negotiation via CAS is already confusing, with just the
guest and qemu as participants.  If the host kernel is also a
participant it's just asking for hard to reproduce bugs.

> > We must
> > either give the guest environment that the user has requested, or fail
> > outright.
>=20
> 'dual' mode means both and the user is not requesting XIVE. We are changi=
ng=20
> the priority of choices from :
>=20
>  1. KVM XIVE
>  2. QEMU XIVE
>  3. KVM XICS
>  4. QEMU XICS
>=20
> to:
>=20
>  1. KVM XIVE
>  2. KVM XICS
>  3. QEMU XIVE
>  4. QEMU XICS
>=20
> which is better I think.

If we were designing the whole environment from scratch, maybe.  But
the way things work at the moment, negotiation between qemu and the
host kernel and qemu and the guest kernel must be separate phases.
That makes the priority you describe impossible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz/O2wACgkQbDjKyiDZ
s5KVMA/8DPYPiNFk2oMU2GM7c/05Cih3J1XkuDFCLc+KyXxP6LJj8T7N1CuUEaoT
GACClUznCkUvgBpevxN0Wz0Gu9REQMzYc9haVmROSyD+GLarj7Wobl+KzRqrXz8U
jpEY4TYxAzCicRfVbp2iYy/9WNGDtLdZAjjDSNlg6elOeGO0cqV6BBeybRq98W6k
aEq/vdTv1V89T4Au0pWWu0PdN0KT2aOZb1e30yRUeNy+apSzgS2sRR5XGf1d/Iwu
7roA6vTYUT+eVotr/uzLtzj/+Rfkq2Pq6canV2pJM4luJ/ovFtWhyc/4WIai5jtQ
pNitMdVtw47vv7SPDwh0qSU2hZQpS0uAIUzw8auHEspayI0MtY2yFn4M7uFR90qu
/sHVLRoK/ytWeWNWqB8yQ19Y8ybKb+6q9mCrzbMUCsLuK1H42GuYPW3U+uCUXDcK
7a9oO7U3vIUyYfndSzpfeRMVK8BTWVDMhOMYHfjsq9/3WMOdVwY5RyxtWbiqyTCP
2sxwgpuKOTFWJ6hwMUZWqB0qXTl9uDz2E23Akd8wPHYzzkBvpLB40KI7yNGtiPrB
lTrpNQHN4AdJkEBQ8GCwoy+Z3dkEZVYUx4K1DI2gpvNUpLjR5p50GtC/S3LWYrYY
/nvTBmI0zL3Z+UbBUJpqnFwO3Fb/ENwl70XmBwp7JLV2zu16TWw=
=pDNl
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

