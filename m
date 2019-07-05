Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B090C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C686021670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TjobpU1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C686021670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjGRy-0004JO-3d
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 01:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hjGQf-0003RT-VB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hjGQe-0000ZC-J5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:06:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hjGQd-0000WY-4N; Fri, 05 Jul 2019 01:06:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45g2r70Zgnz9sPG; Fri,  5 Jul 2019 15:06:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562303191;
 bh=VQ6xA+Ar9vgdwtvfGu9OYlPPKkCO7+lC2B5gwOA77Vg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TjobpU1CCocuUzyR8u84H4d32PJzaHxKoB1VvTjnTighrILOv1lkchfC8KIx50NSd
 CaNsKMXpLnE5lMHrClpPzkwQ0tRo+K6a+xn9bJwagWYe+6RKhIg6db/xOIryIECm0b
 BCQBB5iGcqAggb/llJFcFtYj0Mcb3QiLnNe6ET7s=
Date: Fri, 5 Jul 2019 14:56:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190705045623.GB3266@umbus.fritz.box>
References: <156217621200.562209.8968691631915806468.stgit@bahia.lan>
 <20190704002357.GR9442@umbus.fritz.box>
 <20190704101204.4968e0a1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20190704101204.4968e0a1@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH for-4.2] xics/kvm: Convert assert() to
 error_setg()
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 10:12:04AM +0200, Greg Kurz wrote:
> On Thu, 4 Jul 2019 10:23:57 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jul 03, 2019 at 07:50:12PM +0200, Greg Kurz wrote:
> > > ics_set_kvm_state_one() is called either during reset, in which case
> > > both 'saved priority' and 'current priority' are equal to 0xff, or
> > > during migration. In the latter case, 'saved priority' may differ
> > > from 'current priority' only if the interrupt had been masked with
> > > the ibm,int-off RTAS call. Instead of aborting QEMU, print out an
> > > error and exit.
> >=20
> > What's the rationale for this?  Doesn't hitting this indicate an error
> > in the qemu code, for which an abort is the usual response?
> >=20
>=20
> This error can be hit by the destination during migration if the
> incoming stream is corrupted. Aborting in this case would mislead
> the user into suspecting a bug in the destination QEMU, which isn't
> the case.

Rather than a bug in the source qemu?  I guess so.

> Appart from that, when the in-kernel XICS is in use, only two functions
> manipulate the ICS state: ics_set_kvm_state_one() and ics_get_kvm_state().
> The code is trivial enough that I don't see a great value in the assert
> in the first place... BTW, it comes from the commit:
>=20
> commit 11ad93f68195f68cc94d988f2aa50b4d190ee52a
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Thu Sep 26 16:18:44 2013 +1000
>=20
>     xics-kvm: Support for in-kernel XICS interrupt controller
>=20
> Maybe you remember some context that justified the assert at the
> time ?

It was probably mostly about documenting the invariants that are
supposed to apply here.

>=20
> > >=20
> > > Based-on: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > This isn't a bugfix, hence targetting 4.2, but it depends on an actual
> > > fix for 4.1, as mentionned in the Based-on tag.
> > > ---
> > >  hw/intc/xics_kvm.c |   17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > > index 2df1f3e92c7e..f8758b928250 100644
> > > --- a/hw/intc/xics_kvm.c
> > > +++ b/hw/intc/xics_kvm.c
> > > @@ -255,8 +255,21 @@ int ics_set_kvm_state_one(ICSState *ics, int src=
no, Error **errp)
> > >      state =3D irq->server;
> > >      state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
> > >          << KVM_XICS_PRIORITY_SHIFT;
> > > -    if (irq->priority !=3D irq->saved_priority) {
> > > -        assert(irq->priority =3D=3D 0xff);
> > > +
> > > +    /*
> > > +     * An interrupt can be masked either because the ICS is resettin=
g, in
> > > +     * which case we expect 'current priority' and 'saved priority' =
to be
> > > +     * equal to 0xff, or because the guest has called the ibm,int-of=
f RTAS
> > > +     * call, in which case we we have recorded the priority the inte=
rrupt
> > > +     * had before it was masked in 'saved priority'. If the interrup=
t isn't
> > > +     * masked, 'saved priority' and 'current priority' are equal (see
> > > +     * ics_get_kvm_state()). Make sure we restore a sane state, othe=
rwise
> > > +     * fail migration.
> > > +     */
> > > +    if (irq->priority !=3D irq->saved_priority && irq->priority !=3D=
 0xff) {
> > > +        error_setg(errp, "Corrupted state detected for interrupt sou=
rce %d",
> > > +                   srcno);
> > > +        return -EINVAL;
> > >      }
> > > =20
> > >      if (irq->priority =3D=3D 0xff) {
> > >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0e2HUACgkQbDjKyiDZ
s5Jvxw//ZW6indkRCdPn/TduwkHImkDECbmaG7NdULEArGtWECsJDlWPKN+iy7fA
SAWW+xgJUfw+Vk4eh0iyI/dqaKtVcb8o426V4Ce8glBEtRWg0DwHzCQjtdAna3Ms
azNtSvpRD4YFwfXl5UUQvbhnDa45Ws4Z1S5c8c0/nIBSlEzYwiuSH7oSPWpEPMk8
n/gR1oByytGPIR6NneZrEmlSsXhJyO6T/pxmg0gr67QWNAY1oCur/3MdXRIIS4AK
krvrzykyaFpuuRRwqc1lJ0sd2N+XlIw71yCo1le4y6+UaFJo8630sR8fDVeXSRYc
g3IA0MN8L080XIStT4DJPyumZc1nfDFFFCs/Hp87VvGKGZLtYds7wsAjAznPTQEE
eQbRtCIw3a+VONcp5P9NjlFLblzcHYkNYAihZboH4veGbBrm1PXGnTD+j79CErKN
QtmfwCSyZXsGMyzJWJMM7T8LpggES7Eot+YHbDVZpRrjXfwHqvbgN5NB/9Qk/Jzf
0mHpfUUKn3A7LmeWqkKf6CjjaXLQnej6gnBA5Ri7eoJ/w3CFeXkvCw6IdCziXz0q
wfJ/n0c23ezUKVS8DK228FmsAjV6kN/wCH0P4WUxP1RAVGA5uajJAXQei7jCa/3W
bh2gCZkblHyMb+HeB3d2SGM0s9VsnAr2Y2B8CBySZhje3SQcwOU=
=dcUA
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

