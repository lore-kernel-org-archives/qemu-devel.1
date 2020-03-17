Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03ACC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CD5206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gKYSOItg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CD5206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELFI-0006lO-Ry
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jELEO-0005xL-0d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jELEM-0006Tk-L7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:02:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59105 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jELEL-0006FP-ST; Tue, 17 Mar 2020 19:02:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hpbZ3pGcz9sNg; Wed, 18 Mar 2020 10:02:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584486154;
 bh=3CeX7xVRqkXIUfHNtrgLmS946GhMDIODPBg+pZQE0fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gKYSOItgcT5qy81qi3OcUVYGn2XakpmU+k18/pZUV09SEERAKFvOem9hTSasCKyQG
 4WK+Z1qBmjRy5aQRcY1SAWvgLFShyEWb4oiB9wAn2rsoAkOVdwVwkxIoW+e1y6lkpQ
 e7B1S/zROhtcKbUFvn9kJp0xWarQgzGPYpqf3iqs=
Date: Wed, 18 Mar 2020 09:46:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Programmingkid <programmingkidx@gmail.com>
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset 	to
 take an alternate vector
Message-ID: <20200317224615.GO20264@umbus.fritz.box>
References: <mailman.138.1584442890.3017.qemu-ppc@nongnu.org>
 <34ABB38A-B887-41B5-9108-25DA6ADB4B24@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpgPcFyQO6wM49Um"
Content-Disposition: inline
In-Reply-To: <34ABB38A-B887-41B5-9108-25DA6ADB4B24@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, Greg Kurz <groug@kaod.org>,
 npiggin@gmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IpgPcFyQO6wM49Um
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 11:06:15AM -0400, Programmingkid wrote:
>=20
> > On Mar 17, 2020, at 7:01 AM, qemu-ppc-request@nongnu.org wrote:
> >=20
> > Message: 3
> > Date: Tue, 17 Mar 2020 11:47:32 +0100
> > From: C=E9dric Le Goater <clg@kaod.org>
> > To: David Gibson <david@gibson.dropbear.id.au>, Nicholas Piggin
> > 	<npiggin@gmail.com>
> > Cc: qemu-ppc@nongnu.org, Aravinda Prasad <arawinda.p@gmail.com>,
> > 	Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
> > 	qemu-devel@nongnu.org
> > Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset
> > 	to take an alternate vector
> > Message-ID: <097148e5-78be-a294-236d-160fb5c29d4a@kaod.org>
> > Content-Type: text/plain; charset=3Dwindows-1252
> >=20
> > On 3/17/20 12:34 AM, David Gibson wrote:
> >> On Tue, Mar 17, 2020 at 09:28:24AM +1000, Nicholas Piggin wrote:
> >>> C=E9dric Le Goater's on March 17, 2020 4:15 am:
> >>>> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> >>>>> Provide for an alternate delivery location, -1 defaults to the
> >>>>> architected address.
> >>>>=20
> >>>> I don't know what is the best approach, to override the vector addr
> >>>> computed by powerpc_excp() or use a machine class handler with=20
> >>>> cpu->vhyp.
> >>>=20
> >>> Yeah it's getting a bit ad hoc and inconsistent with machine check
> >>> etc, I just figured get something minimal in there now. The whole
> >>> exception delivery needs a spring clean though.
> >>=20
>=20
> Currently Mac OS 9 will not restart. When someone goes to restart it
> the screen will turn black and stay that way. Could this patch solve
> this problem?

No.  It's unlikely to be related, and at this stage is used
exclusively to implement the FWNMI stuff for the pseries machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IpgPcFyQO6wM49Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5xUzcACgkQbDjKyiDZ
s5LB1xAAniP/vIdBAfrnbWuELTFzkhcL+ydrVozHyZ6/Ri18inc3MhMdePmtr8tj
atU1DbHUWoI6Adtot32eF+u3GPjHWzlS9H8DhzHyKPljyeQZ4EnAhP//xGkfSXE0
/aaR+mwKx2BWnTA5mpy7gody6jQrP6xd6WQYTTGOhCvsFHTyAhwKCFutDQD2ShPU
ygCA5N3tfd0Yvl1hUOwJNpU28KXrAM1dWpoC/lsoMvzDIXn3/J5QdPS8GUd9NvaP
HCNxUzeeNgqOiaVtu5w3nGrkH3q3zUezvyM2XhHSV7sniiFyc6aT7dFdoUUDAUY7
BNMlSHzUCvh3w/xj4o/KarZ783vryveXgExKfknhTA767ZeJMRDfNiiT9sqH0ps9
hwhCK0x+UW/HQZgqvejR2noYZ1w5M9wKYx9lQIdfwSSVDR3RbLeTLCl1GzxgpjAw
1tmAEw/C4uX93/WQ0DI92Ye/Euxcw9VnFSjSU8cr++M2BkU8PHjBNOxhUyDMyvNM
tUk+0teDGu2188G7Lc4SeEpoYU7WP0yxp6J4Pnz/v+T/6VHOpqBMyNBu6a1DDYVT
fHDHHE1FltxWngh9hDEgIjry7c7pWmqynCztu84h4vgUN9XOBRmSkfyfPHdP7Eik
/w8bQSlVSzRX+cT9H2hhkQ54wQtbxoTs+RTDdUZKmFSrDxyo/Rw=
=kZqM
-----END PGP SIGNATURE-----

--IpgPcFyQO6wM49Um--

