Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FF5C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 01:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA7F23BC5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 01:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zrh47rXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA7F23BC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW9ep-0002tI-Gt
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 21:15:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hW9dp-0002QU-1d
	for qemu-devel@nongnu.org; Wed, 29 May 2019 21:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hW9dn-0001P4-Cs
	for qemu-devel@nongnu.org; Wed, 29 May 2019 21:14:01 -0400
Received: from ozlabs.org ([203.11.71.1]:39159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hW9dm-0001N6-Pg; Wed, 29 May 2019 21:13:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DqNF4J7bz9s4V; Thu, 30 May 2019 11:13:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559178829;
	bh=2zdirkXmz4iNSV6dUkhSQ9/X3cqanrR3IAchPSqnn80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zrh47rXOPZec6BKkTgXJWIlPGKtV1AE+1EauaCiNhZjiPV2PJcKM6nxo+Oouz6PRX
	2ORH+Ut69SJMWWVqMHVdm04BzsOAOJwFBnqC9Z7ofHvfhP7k8hmjxqSCW61kqXQ8kd
	6npu6RIERiPsiE0Qu3QusREpTzSTDiNuN+tu+ByM=
Date: Thu, 30 May 2019 11:13:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190530011341.GB2017@umbus.fritz.box>
References: <20190520204340.832-1-maxiwell@linux.ibm.com>
	<20190520204340.832-2-maxiwell@linux.ibm.com>
	<20190522232952.GN30423@umbus.fritz.box>
	<20190523201851.llsufz6dfs3gzyc6@maxibm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20190523201851.llsufz6dfs3gzyc6@maxibm>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Do not re-read the
 clock on pre_save handler on migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2019 at 05:18:51PM -0300, Maxiwell S. Garcia wrote:
> On Thu, May 23, 2019 at 09:29:52AM +1000, David Gibson wrote:
> > On Mon, May 20, 2019 at 05:43:40PM -0300, Maxiwell S. Garcia wrote:
> > > This handler was added in the commit:
> > >   42043e4f1241: spapr: clock should count only if vm is running
> > >=20
> > > In a scenario without migration, this pre_save handler is not
> > > triggered, so the 'stop/cont' commands save and restore the clock
> > > in the function 'cpu_ppc_clock_vm_state_change.' The SW clock
> > > in the guest doesn't know about this pause.
> > >=20
> > > If the command 'migrate' is called between 'stop' and 'cont',
> > > the pre_save handler re-read the clock, and the SW clock in the
> > > guest will know about the pause between 'stop' and 'migrate.'
> > > If the guest is running a workload like HTC, a side-effect of
> > > this is a lot of process stall messages (with call traces) in
> > > the kernel guest.
> > >=20
> > > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> >=20
> > What affect will this have on the clock for the case of migrations
> > without a stop/cont around?
>=20
> The guest timebase is saved when the VM stop running and restored when
> the VM starts running again (cpu_ppc_clock_vm_state_change handler).
> Migrations without stop/cont save the clock when the VM go to the
> FINISH_MIGRATE state.

Right... which means the clock is effectively stopped for the
migration downtime window while we transfer the final state.  That
means the guest clock will drift from wall clock by a couple of
hundred ms across the migration which is not correct.

> > The complicated thing here is that for
> > *explicit* stops/continues we want to freeze the clock, however for
> > the implicit stop/continue during migration downtime, we want to keep
> > the clock running (logically), so that the guest time of day doesn't
> > get out of sync on migration.
> >=20
>=20
> Not sure if the *implicit* word here is about commands from the libvirt
> or any other orchestrator.

By implicit I mean the stopping of the VM which qemu does to transfer
the final part of the state, rather than because of an explicit
stop/cont command.

> QEMU itself doesn't know the intent behind the
> command stop/cont. So, If we are using a guest to process a workload and
> the manager tool decide to migrate our VM transparently, it's unpleasant
> to see a lot of process stalls with call traces in the kernel log.

If you have a lot of process stalls across a migration, that suggests
your permitted downtime window is *way* too long.

> The high-level tools could sync the SW clock with the HW clock if this
> behavior is required, keeping the QEMU stop/cont and stop/migrate/cont
> consistent.
>=20
> > > ---
> > >  hw/ppc/ppc.c | 24 ------------------------
> > >  1 file changed, 24 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > > index ad20584f26..3fb50cbeee 100644
> > > --- a/hw/ppc/ppc.c
> > > +++ b/hw/ppc/ppc.c
> > > @@ -1056,35 +1056,11 @@ void cpu_ppc_clock_vm_state_change(void *opaq=
ue, int running,
> > >      }
> > >  }
> > > =20
> > > -/*
> > > - * When migrating, read the clock just before migration,
> > > - * so that the guest clock counts during the events
> > > - * between:
> > > - *
> > > - *  * vm_stop()
> > > - *  *
> > > - *  * pre_save()
> > > - *
> > > - *  This reduces clock difference on migration from 5s
> > > - *  to 0.1s (when max_downtime =3D=3D 5s), because sending the
> > > - *  final pages of memory (which happens between vm_stop()
> > > - *  and pre_save()) takes max_downtime.
> >=20
> > Urgh.. this comment is confusing - 5s would be a ludicrously long
> > max_downtime by modern standards.
> >=20
> > > - */
> > > -static int timebase_pre_save(void *opaque)
> > > -{
> > > -    PPCTimebase *tb =3D opaque;
> > > -
> > > -    timebase_save(tb);
> > > -
> > > -    return 0;
> > > -}
> > > -
> > >  const VMStateDescription vmstate_ppc_timebase =3D {
> > >      .name =3D "timebase",
> > >      .version_id =3D 1,
> > >      .minimum_version_id =3D 1,
> > >      .minimum_version_id_old =3D 1,
> > > -    .pre_save =3D timebase_pre_save,
> > >      .fields      =3D (VMStateField []) {
> > >          VMSTATE_UINT64(guest_timebase, PPCTimebase),
> > >          VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzvLkIACgkQbDjKyiDZ
s5L8bQ//QxGv2Z8GCDaUTyl0/6xw5rRcYY1cvIVoWzfLi0Q9u+Y3uk4Iq0heZZme
c9HEq7JOywImamfT0FRqdHcpTsiXRNx5ssubL7hlB19brk+kaS2bcDNul+ko0k8r
Du1y7AAcvh2sqZmAEUYFDObg8TGNLkj6sFZMTRJHsRSTiqZhUUaGXmOVbJCeOtSt
vPEbdapTvZR2g3NF/clVW7+9Tgyhi84EQlayln6pNqfQ05tGiP6cAdGhGcL1ZdUl
fwuSN00TaqZv3tKOPMt9WTD1m/j1OPCm80N1NMlpd7aSlepO/wZJ2I7H7PWMD6a4
nVcsTlBIuAxNNBXAGnP0e3nF1hKp+ypj/PzbJ5aDkamMuOak1P53fCcZkNPleFpp
efSDYBIK1aYSxhkoxcFQngO1faVsRxKZwBzUbBcHnXQ1fQOAjPRq6TBaLCf9QUwO
3bHmYZf1fPgC+qR2N0zg+fBS2tpc1h/aHEO564AERB+z8w5STYRXLfUvgeD1mr9V
5KGvUrssZNkcs1xzad/oUs/sA4ImvmlJvax0j2HROeSp5php3/pxFLfGk17zdvqi
gqUDYzlFrMYnobAC7DtI12ZXR2V1ESn1sXDdqWrNZUM4kriuKcEbKAZ8NlMoruQk
mI7hdnSVQjee55T4vJs/Q887lCEs1oCYsKG7MecCAnFMBAQvjG8=
=KKs5
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

