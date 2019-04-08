Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58CC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D620880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OhAwfq21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLwG-0005gG-Jt
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:31:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuO-0004QQ-1u
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuM-0007a8-Al
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40931 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuK-0007WO-9d; Mon, 08 Apr 2019 00:29:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9g0J6Tz9sRV; Mon,  8 Apr 2019 14:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697751;
	bh=am+KzcEyhedUh5lf+YMEEUWp0ljbRhVp/UtknfXOo+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhAwfq21SY9w69NxQ44zVrnom9SYvwwevaCmnk4P4C3jayhvWApwU+aYb8gRE9ZAD
	YTdftg/u8J+CO7lBCnhkN8SnnJfBmK5fXUcMGlA5sJD+GpzkmgQHCrxh4C680pUJ+P
	R7jUCCtS5FAumHvcvmnh/vLMrpfwGlxVWi/3yh88=
Date: Mon, 8 Apr 2019 13:50:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408035010.GE16627@umbus.fritz.box>
References: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
	<20190401225214.GA9231@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20190401225214.GA9231@umbus.fritz.box>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-4.0 0/2] spapr: Fix extended
 config space accesses
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
Cc: Marcel Apfelbaum <marcel@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408035011.ZwG1WYnKf9DXGsbKBvB5e0VYbr3cSlsZHNAZbf6YNu8@z>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 09:52:14AM +1100, David Gibson wrote:
> On Mon, Apr 01, 2019 at 07:54:57PM +0200, Greg Kurz wrote:
> > Recent commit c2077e2ca0da7 added stricter checks that now prevent
> > a guest to access the extended config space of a PCIe device connected
> > attached to a PHB on a pseries machine.
> >=20
> > PAPR compatible PHBs act like legacy PCI busses, but they do allow acce=
ss
> > to the full 4k config space of PCIe devices. As discussed several times=
 on
> > the list ([1] and [2]), we cannot really change PAPR PHB to have a true
> > PCIe root bus since it would call for massive and unwanted changes in
> > libvirt.
> >=20
> > This series tries to address the issue with a new PCI bus class method
> > that tells if the PCI bus supports extended config space accesses,
> > instead of relying on pci_bus_is_express() which wants a PCIe root bus.
> > A new legacy PCI bus type is added to implement the PAPR behaviour.
> >=20
> > Note that this fixes a potential 4.0 regression, hence the for-4.0 tag.
> >=20
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07377.html
> >     https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02839.html
> >=20
> > [2] https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00034.html
>=20
> So, I actually had some patches I'd been working on that address both
> the c2077e2ca0da7 issue and the PAPR fixup in what I think is a
> cleaner manner.  Can't remember now if I posted and they got lost, or
> I didn't get around to posting.
>=20
> Nonetheless, at this point we're fixing a real regression on PAPR.
> I'll look at cleaning this up post 4.0.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbe
>=20
> I can take this through my tree if people are ok with that.

Never got a reply on this, but I see these have not yet been merged
via another path.  These fix a real regression for the pseries machine
so I've put them into my tree with the intention to send a pull
request tomorrow, even though they do largely touch generic code.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqxPIACgkQbDjKyiDZ
s5IIOw//RNJVZpE8LB/YnFINQtk+mhy05pfKoIB/yIzKheQBXeVbEfu7HRDbWuTm
2CkNulhzISWvC+bY7eM/c2WwCOIFdhGmr4i5HlBJ98XkbsTjsVPOLJUqry52Fg0I
175nk5iS8BpxUIco6Bqopo5tOoJ0dlV8YLYdvehuUrAch/0CsEClpIYAml0CiMaY
cuhVVHbdart4hxdDeGUpwq4lBRD3WpSGtBQhVGu5iXzG4GNl562WIzyucd59b9Sv
F9zlC9EuPB5rewSXvUCrl4YFFODq7OvWue4Qk/HEHqYNDD3NN1YyzmjodDIDeEyq
mCy1wZGgD8xGoGii0wPVzIrzczZOxFRuowGPk2oLdbzyHKbyh0Mt9QNfOpY9O+0G
BzD6teQJhlMREV6ZE7Ua7JvNYN+vZYp6z1TXcMxFrAdkvhA5yNhvdGABvFXCQuX9
W1wly4wbu/gD+x67vTr81WpopZE9BmmRet5BFtqNoCxwCXUcgRg4zuXbM/V+NzbP
2E0HTk0qSoNKAwhakc6bKzP41aYNJoadAsqQgS9Kr0GTTxicvDtiXH8HLlbDzwzl
gNsrRciQ02Jdf+ldemeMz1ohe+b7rx7ofOGuZmNwDjnIUQ8ybfV0LwY0nOootb2Y
bOhf3r4qBfpzEiTLYnyJuJOndulbpwGcu55FSvpF8GpeqDp+IBw=
=5NRs
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

