Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF84C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A9C217D7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g+dqRVsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A9C217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3rxA-0007nI-Jo
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 21:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3rub-0007Fk-Vw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3ruZ-0001DA-7k
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:10:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37623 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i3ruX-0000uX-Ki
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:10:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46KyvS0j2mz9sNF; Sat, 31 Aug 2019 11:10:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567213828;
 bh=/LkwraZoyoxEDjQDnLqkwVkdMZmjGBYnCRqWr3VGeE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g+dqRVsZVfst3JsCftbfFq9LZNmdV/5DudvP8r8ht0Ex1ti3VAapxIExPV7abUEnq
 nkncZXrXw2YzKmJV0RyD0f3h14lPQmTlEt4sZlopGv90teOjK/0NZcexrcuXB1jTqZ
 P4bCUKO11McM7/rTitc5ttmkrfUG4SRylX2h3GMU=
Date: Sat, 31 Aug 2019 11:05:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190831010544.GA12065@umbus.fritz.box>
References: <20190830184033.7630-1-philmd@redhat.com>
 <20190830185139.GG3694@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20190830185139.GG3694@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] tests/acceptance: Do not install paramiko
 module by default
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 03:51:39PM -0300, Eduardo Habkost wrote:
> On Fri, Aug 30, 2019 at 08:40:33PM +0200, Philippe Mathieu-Daud=E9 wrote:
> > The paramiko Python module has many dependencies. Some of them
> > are not pure Python, such cryptography module which requires to
> > be built and linked with OpenSSL.
> >=20
> > When native libraries and header are missing on the host, the
> > error reported is not very helpful:
> >=20
> >   $ make check-venv
> >   VENV    tests/venv
> >   PIP     tests/requirements.txt
> >   Command "tests/venv/bin/python -u -c "import setuptools, tokenize;__f=
ile__=3D'/tmp/pip-build-la4el5r5/cryptography/setup.py';f=3Dgetattr(tokeniz=
e, 'open', open)(__file__);code=3Df.read().replace('\r\n', '\n');f.close();=
exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-1efs22iz-r=
ecord/install-record.txt --single-version-externally-managed --compile --in=
stall-headers tests/venv/include/site/python3.6/cryptography" failed with e=
rror code 1 in /tmp/pip-build-la4el5r5/cryptography/
> >=20
> > Since currently the tests depending on paramiko are targetting
> > very specific uses, we can avoid the strong dependency on the
> > paramiko module, to let systems where it does not build properly
> > work the rest of the tests.
> > If paramiko is manually installed, the tests using it will be
> > automatically run.
> >=20
> > Fixes: c47c336e870
> > Reported-by: David Gibson <david@gibson.dropbear.id.au>
> > Suggested-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Thanks!  Queued on python-next.

Yay!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1px+UACgkQbDjKyiDZ
s5IcvxAAwi6CdihPpzvf1tuJBXZQ8/0ztJeJqLmjR8tOyessEw8+U8LhvVEp+W27
xklzu9BslVEr+O2SsYid4afEzbr753CjvSfKzi2DDtY8Aquh6piwEu91xGo92MzJ
fZbOSB5DpmkNZvxH1OADg5XeydBxRT6JampXQR2XjGNo/qmc+6H+AobfOW22W2KH
5CduXaguvnm8SBsPyukgBHOc93nk7s3TTHCplSszo38gJ2WuM9j02HbNhdQZk6yq
04nMr/RXIBVEBGha2I5ip9dQuFsfohtB6hjT2TwCX0N+iGHDoR8mP0P+v6djZqjq
xmwIMeHgV9WHq5NqEPBlIcmVz820HcUb+03capD3oiuUhLEPEIFjxvIEMjL7c327
RIZpcloxKHMolmw1bQ0EUvCVWTh41OrmDp6BYMNeQqi8mpHIcXVEPJwxVVJ28Mzj
fgjD6Ej2+p1b8XnTANRSgNwwoMkyPzeToO6vrQfv7qUgKxZ4bhCuDRZn4OlO6vZF
DP/ZBt++AXnqehb7gjWBEsW8SCiSClRYxEMNu4TAG/1xI+oeLF/yhIOdClZ8y9Kw
MnFnZoMBLNCPG0O7p3J2YCsGN/rXDx514r0ZEaAt+Pc8cD9FHezrFEjgNdFcosUu
js07g/If81dLhd+1YAFbIQ/aMdhLIC0zuFYblYylBQ4wU3/rEXM=
=XZZu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

