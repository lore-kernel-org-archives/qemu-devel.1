Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB50C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC3A2190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AeocdkuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC3A2190D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpX8m-0006yQ-7C
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 08:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpX8Z-0006U3-Ta
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpX8X-00050R-Vg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:09:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43907 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpX8U-0004a7-7f; Mon, 22 Jul 2019 08:09:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sgQX1GvXz9sBZ; Mon, 22 Jul 2019 22:09:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563797380;
 bh=dXyVDnMxFrKL98/xC3t8+affOBdD0Qd7h0bY2iS9dsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AeocdkuZLSQg7O+e4jhyct3uUqbAzCtS9HkybC2eUwNqmOKTcqWlBZgsKxVfRBCGt
 BZYkRa1eLuznQESBq+NwgYuyWjshxbkuqh7q2tLmkpVsoiSMvaWhuKciqZEu6AK9rE
 9hZ+57zXEYwfKmSG0vzNOvM9kfauC2OYeBwJiJJg=
Date: Mon, 22 Jul 2019 21:42:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190722114203.GI25073@umbus.fritz.box>
References: <20190722053215.20808-1-npiggin@gmail.com>
 <20190722083939.GG25073@umbus.fritz.box>
 <585a8a2b-6ed2-dd44-bc38-7669f0357528@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <585a8a2b-6ed2-dd44-bc38-7669f0357528@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 01:20:08PM +0200, Paolo Bonzini wrote:
> On 22/07/19 10:39, David Gibson wrote:
> > On Mon, Jul 22, 2019 at 03:32:12PM +1000, Nicholas Piggin wrote:
> >> Hi, this series is rebased on top of the qmp event fix, and takes
> >> Paolo's suggestion to implement ->wakeup for i386 before adding
> >> ppc, which makes it much nicer.
> >>
> >> If the first two patches can be agreed on initially and merged, I
> >> can take the third patch through the ppc list after that.
> >=20
> > LGTM.  Now, what tree(s) do we merge this through?
>=20
> I have just spotted a volunteer!

Well, merging an i386 patch through the ppc tree is kinda weird, but
yeah, I can do that.
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Paolo
>=20
> >>
> >> Thanks,
> >> Nick
> >>
> >> Nicholas Piggin (3):
> >>   machine: Add wakeup method to MachineClass
> >>   i386: use machine class ->wakeup method
> >>   spapr: Implement ibm,suspend-me
> >>
> >>  hw/i386/pc.c           |  8 ++++++++
> >>  hw/ppc/spapr.c         |  7 +++++++
> >>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
> >>  include/hw/boards.h    |  1 +
> >>  include/hw/ppc/spapr.h |  3 ++-
> >>  vl.c                   | 16 +++++++++++++++-
> >>  6 files changed, 65 insertions(+), 2 deletions(-)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01oQkACgkQbDjKyiDZ
s5Iv3Q/+Kiw5ybmXHr/NcSDyuZt725VYbQUEwVxJFnPBNqBJluINsIsbqBP04Bd3
y9D6nx8BQb9S3+Od8RSLG5W9UKTvatxQbYR4NgINibwbn17M6G8ODXrfG0Tb0Out
DCDRSdlk64Im7sNnRlG8qajSpxzgEtS3HK0q5bTVFAYfLjT8Rj/39+QVVSzpoHCp
f/7yXHXQIkhx4Uwtim9KihcACEkHmWbFe9NewTzsNssi2X+rN2hw1wr1O5byEECt
l8qGcE0MMVzIj89WSwjPfmXB2yGDZgFwYF/3hHBKWxcaT9vrIAkkhaz1g+vP8kCD
nrI3Iggrzl6TUA8JDlJHhJsn6siB/b8tEDi4QGkC7HYyNJe3AQj67owo/yw5Ooh9
LoOhs1OZheDH8EDDgCj/euGJpBtXs2tIsdB0bNtRfS6Rq+vYxwwUdWhZkhfLW1pe
SjCR7ToeopCPlFE/UQDqb5HFTh6oy0sNtno5Zq8MuR6dBjXqMasd85CfR53BEytA
6lVRAt6/9yqMbVWvlAlIDfWjrp47BjKcjEed5pmz9j2D4jctMzNic4Yf8ylmMTYs
kmRlkMlS/z55pqoXhamh7EYGIlN90nEoyTbDPtYUFzv46ceFW4Z3DlkJuZoUQThV
TlXgIypWBvvuJ+6sOnLagzo+07otFIDV4YxJ/wvwaug5YjbEfr0=
=vS3E
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--

