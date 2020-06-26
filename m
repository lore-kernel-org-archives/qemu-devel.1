Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC26C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F4C20768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jnCzMNrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F4C20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joh9O-00077J-8P
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 01:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joh8g-0006Zx-CW; Fri, 26 Jun 2020 01:43:02 -0400
Received: from ozlabs.org ([203.11.71.1]:54163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joh8c-0000Nw-C7; Fri, 26 Jun 2020 01:43:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tQlJ01lyz9sSc; Fri, 26 Jun 2020 15:42:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593150172;
 bh=iD16IXZFAh5RfUbHS6Y8juImA3EwRSNNnBkAvImyly8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jnCzMNrl9l+rYL0vvU4apLkftlDgf4oR3XP9LeauFpGiSGevGFzoZbmbH9ArEW5zm
 nMpFsHUCAoXadFvTJPPuUu2P+DiFS2+c58GA3qqftCN29Vham5qzeKyAqFVBGsDIVT
 RTpOMcUvnbfnSb/RjChs9xSPU2MmB5o/rKWz/jXM=
Date: Fri, 26 Jun 2020 14:42:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200626044259.GK172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
 <20200619114526.6a6f70c6.cohuck@redhat.com>
 <79890826-f67c-2228-e98d-25d2168be3da@redhat.com>
 <20200619120530.256c36cb.cohuck@redhat.com>
 <358d48e5-4c57-808b-50da-275f5e2a352c@redhat.com>
 <20200622140254.0dbe5d8c.cohuck@redhat.com>
 <20200625052518.GD172395@umbus.fritz.box>
 <025fb54b-60b7-a58b-e3d7-1bbaad152c5c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <025fb54b-60b7-a58b-e3d7-1bbaad152c5c@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 00:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 09:06:05AM +0200, David Hildenbrand wrote:
> >> Still unsure how to bring this new machine property and the cpu feature
> >> together. Would be great to have the same interface everywhere, but
> >> having two distinct command line objects depend on each other sucks.
> >=20
> > Kinda, but the reality is that hardware - virtual and otherwise -
> > frequently doesn't have entirely orthogonal configuration for each of
> > its components.  This is by no means new in that regard.
> >=20
> >> Automatically setting the feature bit if pv is supported complicates
> >> things further.
> >=20
> > AIUI, on s390 the "unpack" feature is available by default on recent
> > models.  In that case you could do this:
> >=20
> >  * Don't modify either cpu or HTL options based on each other
> >  * Bail out if the user specifies a non "unpack" secure CPU along with
> >    the HTL option
> >=20
> > Cases of note:
> >  - User specifies an old CPU model + htl
> >    or explicitly sets unpack=3Doff + htl
> > 	=3D> fails with an error, correctly
> >  - User specifies modern/default cpu + htl, with secure aware guest
> >  	=3D> works as a secure guest
> >  - User specifies modern/default cpu + htl, with non secure aware guest
> > 	=3D> works, though not secure (and maybe slower than neccessary)
> >  - User specifies modern/default cpu, no htl, with non-secure guest
> >  	=3D> works, "unpack" feature is present but unused
> >  - User specifies modern/default cpu, no htl, secure guest
> >   	=3D> this is the worst one.  It kind of works by accident if
> > 	   you've also  manually specified whatever virtio (and
> > 	   anything else) options are necessary. Ugly, but no
> > 	   different from the situation right now, IIUC
> >=20
> >> (Is there any requirement that the machine object has been already set
> >> up before the cpu features are processed? Or the other way around?)
> >=20
> > CPUs are usually created by the machine, so I believe we can count on
> > the machine object being there first.
>=20
> CPU model initialization is one of the first things machine
> initialization code does on s390x.

As it is for most platforms, but still, the values of machine
properties are available to you at this point.

> static void ccw_init(MachineState *machine)
> {
>     [... memory init ...]
>     s390_sclp_init();
>     s390_memory_init(machine->ram);
>     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>     s390_init_cpus(machine);
>     [...]
> }
>=20
> >=20
> >> Does this have any implications when probing with the 'none' machine?
> >=20
> > I'm not sure.  In your case, I guess the cpu bit would still show up
> > as before, so it would tell you base feature availability, but not
> > whether you can use the new configuration option.
> >=20
> > Since the HTL option is generic, you could still set it on the "none"
> > machine, though it wouldn't really have any effect.  That is, if you
> > could create a suitable object to point it at, which would depend on
> > ... details.
> >=20
>=20
> The important point is that we never want the (expanded) host cpu model
> look different when either specifying or not specifying the HTL
> property.

Ah, yes, I see your point.  So my current suggestion will satisfy
that, basically it is:

cpu has unpack (inc. by default) && htl specified
	=3D> works (allowing secure), as expected

!cpu has unpack && htl specified
	=3D> bails out with an error

!cpu has unpack && !htl specified
	=3D> works for a non-secure guest, as expected
	=3D> guest will fail if it attempts to go secure

cpu has unpack && !htl specified
	=3D> works as expected for a non-secure guest (unpack feature is
	   present, but unused)
	=3D> secure guest may work "by accident", but only if all virtio
	   properties have the right values, which is the user's
	   problem

That last case is kinda ugly, but I think it's tolerable.

> We don't want to run into issues where libvirt probes and gets
> host model X, but when using that probed model (automatically) for a
> guest domain, we suddenly cannot run X anymore.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl71fNMACgkQbDjKyiDZ
s5Jn7g/7B85dO80x9MKReXN358gRZcNMYr3LcZ+HlyE7pMOyKFQ7vvFKN8BSEmYP
Y6MOR0P+i4kusGH5Y/HfKMBintgZoljg/ibJ/Nhpt2x9g2jrBai4heJ1IIY9MMjs
HxDTXLZCxIauYIL3HYHOf7UAjdWnnrvQGX2cqY6vCKS4J7RrAs5+DPI+xHhpBh66
/+8gkZbcEdz7l55rjSsJ2h238hMzFmCNzu3pJlx/CviQNp1ScSu3aOT9LkRFfIBL
TlSCey5xnudp5uQSHhsEZjMflJUqlZtQ1zOyqFmOEQ5QpBnU9oLZqRY2SenJumps
05Imr/lJg1EeRw2hZXugcc1o1G5rQkfJXAgQd5ikxGxtCGC1ly5xsWepyjGaEw5Y
d5VDo2g/al3lLm07V6xJ0MSHpTWxksX23S4P0iH6iPFLxA1yqLjU2rqNhcpZ9X3q
n59CEam7H8kPo5xsS+4TkpGGB0bgXX4/uRNv4L+nYQ5z6p7ruhTbt4EeTCphbqR1
9JAB0gIkXZzWpDyW8gTXPs86lT+04619xQKK1QuAmRgqDadYmPt8/NefbX7qGbln
MrL7wPHP9vH2Ei1xeVg2QSPGYCLk4kIQknktwPScVq1sVQm4QFbmFaS3ug8dAjWB
DCGZ4aUGyqgIFVDNgmX7mydhH1YZUnOn406Jd8Pa11SA25GMJoU=
=86Td
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--

