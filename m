Received: from eggs.gnu.org ([2001:4830:134:3::10]:36682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxuw-0000L0-6O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxuq-0005lL-La
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:04:14 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpxuq-0005kQ-G1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:04:08 -0400
Received: by mail-wm0-x229.google.com with SMTP id u132so64412207wmg.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:04:08 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:04:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320140405.GW17887@stefanha-x1.localdomain>
References: <20170315160255.23768.27906.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFjAQ8ujNJnIGHaX"
Content-Disposition: inline
In-Reply-To: <20170315160255.23768.27906.malonedeb@gac.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1673130] [NEW] qemu 2.7.0 receives SIGABRT in
 qemu_coroutine_enter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1673130 <1673130@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--AFjAQ8ujNJnIGHaX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2017 at 04:02:55PM -0000, Mohammed Gamal wrote:
> I've been experiencing frequent SIGABRTs (in addition to segfaults in
> #1671876) lately with qemu 2.7.0 running Ubuntu 16.04 guests. The crash
> usually happens in qemu_coroutine_enter(). I haven't seen this so far
> with any other guests or distros.

Please report this against the Ubuntu package, not the upstream QEMU
project.

If the abort reproduces with qemu.git/master or QEMU 2.9-rc0 then it
would be appropriate for the upstream QEMU bug tracker.

Thanks,
Stefan

--AFjAQ8ujNJnIGHaX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+FVAAoJEJykq7OBq3PIvI8IAIUuN3UHV6RrcA591mrVZ/fY
L1ySCzMof3QSBivffot0jlHAot8jo+JN9NsGvH8W7L/cC88K6w0dckD/1vXpfW/G
jMRdIdlgK9t03W8cahbJ53btBGeXZXjG2DhUZgqlHUAYXozFKZQTwza/vSTpA9vb
p9Jt9F1UG0uUDrG//HulphwgKrpPK1hznUk0d3p9rOFOS+EDnLEtu/Rwh4ltzWps
AlDFm5qLMyOV17AxGGarAT7eur0VDe9Z3aAHE4cCSMhR8+AdX4dgH3jf6HcsY1m8
iMu0eWMLXa4GcxvqoqDC4B3pzGoCHpq3LbTJWTjMdkYLDHfEHRmLSzu5h8EDPTM=
=y2eS
-----END PGP SIGNATURE-----

--AFjAQ8ujNJnIGHaX--
