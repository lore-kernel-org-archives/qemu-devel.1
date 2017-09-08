Received: from eggs.gnu.org ([2001:4830:134:3::10]:57025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqNan-0004Mq-7M
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqNai-0000qZ-Ni
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dqNai-0000ps-Ev
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:01:20 -0400
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170724181544.20292-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-1-brandon.carpenter@cypherpath.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4d0a4bb-79d4-3a59-ba50-46ba696249cf@redhat.com>
Date: Fri, 8 Sep 2017 13:01:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k369ocbiKRFh1loKjOgiQNNdsnNANO2ev"
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k369ocbiKRFh1loKjOgiQNNdsnNANO2ev
From: Eric Blake <eblake@redhat.com>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>,
 qemu-devel@nongnu.org
Message-ID: <c4d0a4bb-79d4-3a59-ba50-46ba696249cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Update websocket code to more fully
 support the RFC
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
 <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
 <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 12:37 PM, Brandon Carpenter wrote:
> We've been experiencing issues where the qemu websocket server closes
> connections from noVNC clients for no apparent reason. Debugging shows
> that certain web browsers are injecting ping and pong frames when the
> connection becomes idle. Some browsers send those frames without a
> payload, which also is causing closure. This patch series addresses
> these issues by making the websocket server more conformant to RFC
> 6455 - The WebSocket Protocol.

meta-comment: sending v2 in-reply-to v1 makes it harder for automated
tooling to recognize that you are sending new patches.  We prefer that
v2 be a top-level thread.  More patch submission hints at:
https://wiki.qemu.org/index.php/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k369ocbiKRFh1loKjOgiQNNdsnNANO2ev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmy2ukACgkQp6FrSiUn
Q2ov+gf/Qv85jhrj1GZ1f0or5xHaxAxKC5nHSh/wa0fKgYHnFES+5ZeG2YehaEuc
qj1GLw8lTdCzF2EjnKZoNDNS4ZeVRXNbFOY/49DlHEbccm622+N1aGtGcBra7pXp
00FGztIripJdlgs+FAEYts2ZxsoiqjxsarrEVkQgNQL9nLcQ1oICeIBeVYCK4/Pv
iE5M/7RY/08YzY7k9pKulhLMYAQipSt02qRcXr1I/V0OK172hMXK95iGAQyz3IXz
4DTRjxRfAd+fNxjjACLHtnbDzOUzIOUNtBUn1eicx9uahu5OrIVsKfrm1HkwAxah
bNv9oWdLzZjWUn8cybpvzCpHtsNPdQ==
=J/8g
-----END PGP SIGNATURE-----

--k369ocbiKRFh1loKjOgiQNNdsnNANO2ev--
