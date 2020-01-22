Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB58C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6111207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BzIQJrsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6111207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6jP-0006ZX-Hp
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6iG-0005Ug-OH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6iF-0001Xk-FQ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:29:52 -0500
Received: from ozlabs.org ([203.11.71.1]:36753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iu6iE-0001Tp-AR; Tue, 21 Jan 2020 22:29:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 482W9j5PLtz9sRd; Wed, 22 Jan 2020 14:29:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579663785;
 bh=mgOS3iNapx962bKlT142OWk87/3lrBBfp37HaOYydJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BzIQJrsvccl+6Oo2bjpq24Vv+0BOFCbNvpa5MKs+GYd0dgYX+YriqAoXjqtdW5K46
 GcoOa3uiFSkZrME7yj9yD3JgiCa9Mh6ed+NYYJjYH02FLhOAQs8WTfUPTN77cM6C6a
 CRqQiiIEQB+oa198OehsGSzpdVTzwyBrzlZX2+CQ=
Date: Wed, 22 Jan 2020 14:26:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
Message-ID: <20200122032659.GG2347@umbus.fritz.box>
References: <20190717054655.14104-1-npiggin@gmail.com>
 <87h81vdtv2.fsf@linaro.org>
 <1579604990.qzk2f3181l.astroid@bobo.none>
 <87ftg827ug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <87ftg827ug.fsf@linaro.org>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 02:37:59PM +0000, Alex Benn=E9e wrote:
>=20
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
> > Alex Benn=E9e's on December 20, 2019 11:11 pm:
> >>
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>
> >>> This is a bit of proof of concept in case mttcg becomes more important
> >>> yield could be handled like this. You can have by accident or deliber=
ately
> >>> force vCPUs onto the same physical CPU and cause inversion issues whe=
n the
> >>> lock holder was preempted by the waiter. This is lightly tested but n=
ot
> >>> to the point of measuring performance difference.
> >>
> >> Sorry I'm so late replying.
> >
> > That's fine if you'll also forgive me :)
> >
> >> Really this comes down to what EXCP_YIELD semantics are meant to mean.
> >> For ARM it's a hint operation because we also have WFE which should ha=
lt
> >> until there is some sort of change of state. In those cases exiting the
> >> main-loop and sitting in wait_for_io should be the correct response. If
> >> a vCPU is suspended waiting on the halt condition doesn't it have the
> >> same effect?
> >
> > For powerpc H_CONFER, the vCPU does not want to wait for ever, but just
> > give up a some time slice on the physical CPU and allow other vCPUs to
> > run. But it's not necessary that one does run (if they are all sleeping,
> > the hypervisor must prevent deadlock). How would you wait on such a
> > conditon?
>=20
> Isn't H_CONFER a hypercall rather than instruction though? In QEMU's TCG
> emulation case I would expect it just to exit to the (guest) hypervisor
> which then schedules the next (guest) vCPU. It shouldn't be something
> QEMU has to deal with.

That's true if you're emulating a whole system complete with
hypervisor under TCG, which is what the "pnv" machine type does.

However, a more common use of qemu is the "pseries" machine type,
which emulates only a guest (in the cpu architectural sense) with qemu
taking the place of the hypervisor as well as emulating the cpus.  In
that case the H_CONFER hypercall goes to qemu.

> If you are running QEMU as a KVM monitor this is still outside of it's
> scope as all the scheduling shenanigans are dealt with inside the
> kernel.
>=20
> From QEMU's TCG point of view we want to concern ourselves with what the
> real hardware would do - which I think in this case is drop to the
> hypervisor and let it sort it out.

Right, but with the "pseries" machine type qemu *is* the hypervisor.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4nwQMACgkQbDjKyiDZ
s5LRehAAh6RVqKMfU2u3xMfDvlTUE9P2cZVgzINbJVRdvOt5ljQP0P22ov/C231g
N9656yjCVwp6gVe9bIOrfQ5O+qTFls+pgkFl9oSFPO6uFKP3JW2cW7xZkogAHnYF
/oqwj9i30i4ePiPScC2d6llUUt4HTpyaIXQhLuo/9asfkh1xhm59ohF9VaLKwMwo
OQKgu9U21DD7sQJJOcJWVUSIeWBtjE2XBqj9X4JmPAY5CurHivGic86vmubmDyOb
V1CPTf+ecE92tt7gudi7nQEGvM9qhSwpnxJvtpXyTxOeCgYC6OzmniEBEAO9lCzD
gMKbgWWhtifhWO86xZuhwT/+6zs+EdQRzR8TCBeoOX/sOq5t+t8Opv6a9SJwbI+q
YajLqBli42kRSfK63YHg7ohFxArqsuSWaVMMD04v9BGB/f7sSPrhOCnKvkPAwPzL
6s8WGjNyv48UN4WMZ2ufeDXTwBSft6qUSyYbXVW8kf+xdPJ0v3kVCmSK/fdMNR8X
/M4guXGg+DGh1RurmMQSSh+STqfaCPl8yNa2MK28kGl49BKu79Si8X3E+vzbsGqm
7E0cGZRR3CSFTC9oonFU5yAdPPJWj7xmummMy8+YP4JxLkCtgGlMmLCyOU6dnk59
X0nijKHRb3ANYIdgc+u3exEaMdobY3pOk+KHAqSlbbP3A9RB3+k=
=Wq6T
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--

