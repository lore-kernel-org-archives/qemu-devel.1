Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A06206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="junQKRsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A06206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEpqD-0000lT-FH
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 02:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplf-0005Nr-A7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplb-0000rA-J9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:30 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52289 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hEplS-0000lD-61; Fri, 12 Apr 2019 02:34:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gSm42RdMz9s8m; Fri, 12 Apr 2019 16:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555050852;
	bh=z0SKgYzTI48+gmzI8uC02nuE/l9BEyyG8hRh3uaCg9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=junQKRshADYHnhJgX0wZlnxmrXksNU2/HpRsEqz26x5FfQWrT0eTHCAMFouCHXOM6
	UKOb85QJVzhLXvBw620JsqCQ3mNI3ekETO0VTW9WfSctbobVfcQAmxLAlbZfawpWmd
	rrA+jOWs1W4e6iYjhWzMHf0a24cFF3KWVo/aqhNk=
Date: Fri, 12 Apr 2019 15:55:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190412055512.GB8005@umbus.fritz.box>
References: <20190411102025.22559-1-cohuck@redhat.com>
	<20190411212405.407918b8@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20190411212405.407918b8@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-4.1] hw: add compat machines
 for 4.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412055512.gU93rk3XGjTb8QsqXFzsz0RywTYIuPuR7BCajOa0CfE@z>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 09:24:05PM +0200, Greg Kurz wrote:
> On Thu, 11 Apr 2019 12:20:25 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > Add 4.1 machine types for arm/i440fx/q35/s390x/spapr.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
>=20
> For spapr part:
>=20
> Acked-by: Greg Kurz <groug@kaod.org>

and

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywKD4ACgkQbDjKyiDZ
s5IC8Q/+MMOIOiDJkyqN1x+qrWTjqUigmYmOrDKEZQYUmjpqTMQWn328JHBhYU/c
BCC2mrGljioeOo4vzkF+2J+aJuy5eeX/+JIH4AUnuuEUT+kG5DnUvVWO5PVoW4vG
fTAZ8vQs6LIJ9enqTbqepkNwfC58u0LwmUPO5pjYZKMrLNgL+x035r3FNX8gkNOj
0xlUm541BDxxYfznTNEePvgHYaA8sI0PbCzu8PTcOO/4TUTzTFQTu2ZBbYBL5qCI
S6MGs3aCdehGHda4B/0OnsyTDhgjLFhE37bRpqd4Us9Oicsy18WXEok9GkiD7/CS
unjL3wkTyiHVCtVLpPASm8MmnIdE4zIBGho2NBzADB4K5Tm+uJTrTmf2Vj+7BpYF
VdoLyZvyP6vjOpQSia8ixLnx3zgL914/3XInKo9Nr8RIi5C7WNbCx41PF9dwUWJ8
1PDaPXiud0YZV+6bd7A8OHmZab6AXKxCJXTZQLsGW9gCFIkopVG02Bz8FqOgjOGl
eW5v/VDNPBSPgkGWxn88fekHdrgckZs3IQpBYfGMtKQJASQnulEGjOKthIDwEWqJ
eb60nA1ExQMyDj7z0ds3v1bVrsHdhJCJG0U1eE2xruSj7yEku6O16AH/S+QzXA6y
X9yZN6nWZSBAkz0pNqRX0Vp3zf4i6d2UWrk1x96Ue+X/gYC2Vew=
=3SX5
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--

