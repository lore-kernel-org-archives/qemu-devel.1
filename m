Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37288C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B0D2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Mfkehnl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B0D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYOm-0005xA-6T
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyYNq-0005Uy-8X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyYNo-0002xs-0t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:51:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48965 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iyYNm-0002fQ-Uy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:51:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48B33y2198z9sRt; Mon,  3 Feb 2020 20:50:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580723454;
 bh=5W49rq1W0sJNHH+SdisZ44Wbd77zaLtmVhiFkJ48OKo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mfkehnl+9hsVCuP4dOE2G41bb2z87WpOkRdqEBLYUN2pZD8AjsyeCeYfJueKfTIa5
 vZXTxVrCRMp2eIGaKn6S0ZdaAN1WKg0LCYKRxTodbQqvCLa0RMazwLgCHzMYG/G0DZ
 G9S7f8b366ir5axoN9zsL7O6WhUAKA/qKJQFpsLM=
Date: Mon, 3 Feb 2020 20:50:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200203095048.GA60221@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 10:12:02AM +0100, Paolo Bonzini wrote:
> On 03/02/20 02:28, David Gibson wrote:
> > But "pseries" is different.  We're implementing the PAPR platform,
> > which describes an OS environment that's presented by a combination of
> > a hypervisor and firmware.  The features it specifies *require*
> > collaboration between the firmware and the hypervisor.
>=20
> Which features are these?

Too many to list really.  In the whole of PAPR, there are probably
dozens of RTAS calls that require hypervisor privilege at some point
along the way.  We probably don't implement that many of them -
there's a bunch of stuff we've never bothered with because Linux
doesn't care.

> > So really, the question isn't whether we implement things in firmware
> > or in qemu.  It's whether we implement the firmware functionality as
> > guest cpu code, which needs to be coded to work with a limited
> > environment, built with a special toolchain, then emulated with TCG.
> > Or, do we just implement it in normal C code, with a full C library,
> > and existing device and backend abstractions inside qemu.
>=20
> ... which is adding almost 2000 lines of new code to the host despite
> the following limitations:

Well.. yeah.. it is kinda larger than I hoped.

But in comparison *just* the qemu specific parts of SLOF are >4000
lines of Forth.  Overall there's about 20k lines of Forth and 33k
lines of C.  And the number of people who both understand Forth and
have the slightest interest in SLOF is, like.. 2 people?  Maybe 3 if
you count Segher's occasional drive-by rants.

> > 4. no networking in OF CI at all;
> > 5. no vga;
> > 6. no disk partitions in CI, i.e. no commas to select a partition -
> > this relies on a bootloader accessing the disk as a whole;
>=20
> and of course:
>=20
> > 7. "interpret" (executes passed forth expression) does nothing as in th=
is
> > environment grub only uses it for switching cursor off and similar task=
s.
>=20
> In other words you're not dropping SLOF, you're really dropping
> OpenFirmware completely.

No argument there.  That is absolutely true, and absolutely
intentional.  The idea is to maintain just what we need of the
OS-facing OF interface.

Frankly, while it has some good ideas, I don't think Open Firmware
wasn't that great a concept overall in the 90s[0] - and it has not really
improved with age.

[0] Incidentally I also think EFI's a pretty crappy concept for almost
    exactly the same reasons, but it has the huge advantage of a much
    more actively developed codebase.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl437PYACgkQbDjKyiDZ
s5ICGQ//Yaq7FDbf7soLzmG1XwdolOrdZy42I+451YvmebMs0shs1uUNL5EfTWj9
H22cYIWeB7/dV5HJT6Jv8NFgqyPVgkfBRiezh3l0WGIGRjPq125GjJ/L2/DIIi7p
aTyX+1P0VsWK6WKBBhpjfGiowOzMIBXGqKLjx7YYuW137F2FLqrpDX20/qtE5s4I
9edF/qiwgUQ/3PY/K1qX/CQmviQwCPwFu24Y5Xa0U7q5uXWgx7IV4eN1Li7lwOlb
FlqsssTngj4gE7ZlIfDYzwEVSx/owvFOIdwwmUYWB+7fkoc5QL+WQIYOn7/q3QGf
gHXd9t3Gi6XPHLroR4WAmG/thzLJ/4Rn5koCaQX00yeVg5MGLrs+jl7yc/1z/lfb
q/z4e1z5U9DoOXQ9tl8Vb0LZ2X70DrgO0ALy0jfb6vGGL7ofcI/wumhf5XX3tAM5
EzsK6Twz4SSTyQUoGudUcJbE62v2URPSWCsuJNCjz4D6nVk48hzi1AHahy5OCRLD
ev1Tnxhekx6Rw4BWjnZvdKXCBInqx+6oNC+/t16vEZwH+v+T0i9TTTf5Yje+u7K1
6d2TPmKNrA2qJKxbMWt+QxS+juzE6vmcWXBwWf6tM9h+YODZYqmcpYkLppbOoDIl
6F1wTpR8RNJipfSwWHEtyuY2p0YpnMajyxHO3g2xa6NltjI7YnI=
=w+N9
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

