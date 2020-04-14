Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A00C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DE22072A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JrX7f+VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DE22072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOBPx-0007Wp-Kp
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 22:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMx-0002yZ-8j
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMw-0003a4-0k
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:32:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35559 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1jOBMv-0003US-Lq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:32:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 491TxP31hVz9sTK; Tue, 14 Apr 2020 12:19:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586831449;
 bh=WJLiycbU2fx+ZCVD0et7MCneHzzsvDNA1cg34XPHel4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JrX7f+VXXTw09GYhueZlu0UCOHYFnJ8JbtUDNoJSW81wOdVzjxeiyAT46we3pvO2c
 f3yoJL5bQEsXeh9DsKQjPeROPiue/j7+6Kkrv9z8UCk/2/9QFmMNzKyfiax6qzTLax
 qjUKosDu0ltGz6gCADsREqsoZ5n/eKC99RPHoleA=
Date: Tue, 14 Apr 2020 12:03:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH RESEND v3 0/2] Makefile: libfdt: build only the strict
 necessary
Message-ID: <20200414020303.GC48061@umbus.fritz.box>
References: <20200411093150.4741-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20200411093150.4741-1-cfontana@suse.de>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Alex Bennee <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2020 at 11:31:48AM +0200, Claudio Fontana wrote:
> v2 -> v3:
>=20
> * changed into a 2 patch series; in the second patch we remove the old
>   compatibility gunks that were meant for removal some time after 4.1.
>=20
> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>   existing working trees forward and backward compatible across the chang=
e.
>=20
> v1 -> v2:
>=20
> * fix error generated when running UNCHECKED_GOALS without prior configur=
e,
>   for example during make docker-image-fedora. Without configure, DSOSUF =
is
>   empty, and the module pattern rule in rules.mak that uses this variable
>   can match too much; provide a default in the Makefile to avoid it.
>=20
> * only attempt to build the archive when there is a non-empty list of obj=
ects.
>   This could be done in general for the %.a: pattern in rules.mak, but ma=
ybe
>   there are valid reasons to build an empty .a?
>=20
> * removed some intermediate variables that did not add much value
>   (LIBFDT_srcdir, LIBFDT_archive)
>=20
> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subd=
ir),
> and with docker-image-fedora, docker-test-debug@fedora that failed
> before.

Seems reasonable to me.  It's a bit of a shame that we can't use the
dtc makefiles more simply for this.  But I don't quickly know how to
fix them upstream to allow that.

>=20
> Claudio Fontana (2):
>   Makefile: libfdt: build only the strict necessary
>   Makefile: remove old compatibility gunks
>=20
>  Makefile  | 32 ++++++++++++++++----------------
>  configure |  6 +-----
>  rules.mak |  2 ++
>  3 files changed, 19 insertions(+), 21 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6VGdcACgkQbDjKyiDZ
s5JkdxAAza25ROvzcQbH0k4QiAjYWwLc+JCbdzEzbH8IfQ8R48rQ3lGVmbwKcxUK
ZRbLYD76bByVVMnzVhLC/GpRTW629yy6K/w5nr2INwVjW1v2gJmcfhk8A/TnltGT
F8sHVLWeumBwQEoKy1wLUQmHcCpq/sN8/MyRiqbevYHT8OPjX6gyizIaZzrWGsfm
V+ZDErGtMixY5VeNHy6SknJuhdbaYwGEHeJCrbyihIGtbvp8TaGwWoVNC3FU5Rga
yTnZ5QO4H6thx283jAXzte4eVSQGY30SblZ+UFkWA6/uMvniPQwsgDiU0Q+DDH+m
335xRdCpgLvbRtpduyeqmtqg3NO3HySYIcpR3kWqdQEPFOqitV668i4Vrpi6EcE9
A2swqXghl6uQskSXSj7VBbY1mG5vX2Du7eVcO92G3/Cs5Tu8wbDuPXUL1gkUv7P9
UpI4wMJw1TpO6ZYNnlukUTU+XdFJxF0EeMBe4QwgWGuJJ9YlUWVsyhLPV4dttQVN
ZxFZ9Z72y+fCT57rt8gq9k7/AIrMXv7cXkDCStB0sJySYx8A9qRI7NBTz88alFih
kumOWf3JJHyrgYSKM8qfNWGQDRuNeYgMMu6D3vqQjyKk1v2d0nHA+98pKlE7/Wwi
+resnhfGqpUU7S9g490/tWTKr7J5g2RDk+UYufCONusN0803ZFo=
=yOrh
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

