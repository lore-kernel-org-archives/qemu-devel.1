Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A89C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017E922314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dklvFt4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017E922314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkVa-0006Jk-6X
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 22:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSE-0002ZK-Ow
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSC-0006Gv-G8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52929 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itkSB-00069B-NQ; Mon, 20 Jan 2020 22:43:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vXF5znQz9sRk; Tue, 21 Jan 2020 14:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579578221;
 bh=IL28vbsxJD+xNHZVccIrpbDXRHZqH2KQ5C9QVLEmht4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dklvFt4ez2hRONwHGLmN3dwsUw5qSdYDiu1qnCvQzE0zS5L4gU+s28ZVZ5wTDcS5Z
 /jTnn4KBsIU6hOd5aaeeLdEWbdirSm7o4cdxF2mTvsbK2abW7WRjfabaDn8pyQT55G
 TRy/eUBn9I2l9acmX5dNgaCVadFMT6dBaPPoq45U=
Date: Tue, 21 Jan 2020 14:41:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200121034126.GB265522@umbus.fritz.box>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 07:10:47PM +0100, C=C3=A9dric Le Goater wrote:
> On 1/15/20 6:48 PM, Greg Kurz wrote:
> > Migration can potentially race with CAS reboot. If the migration thread
> > completes migration after CAS has set spapr->cas_reboot but before the
> > mainloop could pick up the reset request and reset the machine, the
> > guest is migrated unrebooted and the destination doesn't reboot it
> > either because it isn't aware a CAS reboot was needed (eg, because a
> > device was added before CAS). This likely result in a broken or hung
> > guest.
> >=20
> > Even if it is small, the window between CAS and CAS reboot is enough to
> > re-qualify spapr->cas_reboot as state that we should migrate. Add a new
> > subsection for that and always send it when a CAS reboot is pending.
> > This may cause migration to older QEMUs to fail but it is still better
> > than end up with a broken guest.
> >=20
> > The destination cannot honour the CAS reboot request from a post load
> > handler because this must be done after the guest is fully restored.
> > It is thus done from a VM change state handler.
> >=20
> > Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Nice work ! That was quite complex to catch !

It is a very nice analysis.  However, I'm disinclined to merge this
for the time being.

My preferred approach would be to just eliminate CAS reboots
altogether, since that has other benefits.  I'm feeling like this
isn't super-urgent, since CAS reboots are extremely rare in practice,
now that we've eliminated the one for the irq switchover.

However, if it's not looking like we'll be ready to do that as the
qemu-5.0 release approaches, then I'll be more than willing to
reconsider this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4mcuYACgkQbDjKyiDZ
s5KhWhAAwfifalIuzoezNhnsPhzdJyXjjyQXvrU3kPK3sef8Hxs+jMYNFxhH7wpp
zt8S6yWsi65FPA/plky5x8M4VmaUyjNJAKz6SEAFn7MtMPu2RBMmAAQcG17BV7im
ckK0bNRpwRxqLajtDEQM6fVEpNiYU08Ct7h+ZA6mseoOOkU9Ol8D0HjpTWRwBIxg
BSFj8Y0/vXFGYYSqDGYQJKtuCiYeqPhN6TtxazKhhotOUiAUcAw0T26qpGsKA6Bc
baKpJw1p7ebk/ysXvGq+oIUJPmKKye+7YAiBOsB/HW/3pOlKXQyhP4FNL4i8i8d6
/ixll+dAPohD40urxHQQIp0cemMVV7w/w17qFN8rfKa2PqWxjFDRmuuhX4A0QZuX
BYm3s4eJ8YfftHatHqfs25530V+skrH5Ls1gch2PGovg+bDCKTb2lpw1WH9zksu5
osBTESXpXXQs13z+rzdAwdBqalwhnMZh2e11COeRa1rwqcmf/O3YfqwFfYW25qvV
RN6o7sZYW74RpkTLj276o5fk90+fL8xHs8UAPCk2UV3iaWjaca+j8Y+8yHtXsOSh
/PenUOeOuJ6Sipltr1NIkfNPY3xxB/mBfQ+DE4zLbpq4ZKe2wZUhRUTGp5dMbPfJ
2je8Xb4MTWKummGXWO355g1QLz8X5es5NyNsSvwqVP6spLNlXiQ=
=Ro2T
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

