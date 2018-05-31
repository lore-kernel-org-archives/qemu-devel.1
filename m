Received: from eggs.gnu.org ([2001:4830:134:3::10]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOLMa-0001sw-Eu
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOLMW-0000sc-Dd
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:03:24 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:39071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOLMW-0000rM-5c
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:03:20 -0400
Received: by mail-wm0-x234.google.com with SMTP id f8-v6so53343952wmc.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 04:03:20 -0700 (PDT)
Date: Thu, 31 May 2018 12:03:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531110317.GG27838@stefanha-x1.localdomain>
References: <20180515091356.24106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <20180515091356.24106-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 05:13:56PM +0800, Peter Xu wrote:
> I stole the printk_once() macro.
>=20
> I always wanted to be able to print some error directly if there is a
> buffer to dump, however we can't use error_report() really quite often
> when there can be any DDOS attack.  To avoid that, we can introduce a
> print-once function for it.

I like the idea.  It solves the problem of guest-triggerable error
messages that we should know about for troubleshooting but can't due to
DoS.

Stefan

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD9Z1AAoJEJykq7OBq3PIdswIAKARIctPLsphyrSXRSAzSC+V
uFN2KOmoM2+aQra0jGZKyQi1im5APcY1XiEKwoSRzxYzOVeH3a1/VN3Dy54/89tZ
uF2oxkPVc6PuT1fOIRjHFH9LyGQ77lO7/5pZD0n5srl11wAuwSaql0RHChZlWwR6
0skfyBIRDa/n0dEmNl3jZKIIzttGi4mT6BzCGIj8KfwDmw8zwwKuZpTNIpbaoqHq
1uG32LKfmvetht6Xb9XOQ6M1KUoqYV1zbgBocf4YquQQhb7VR46pH35wPAL1cdma
kvNxeiVf2XggbSUNL0SAYCdLtRhNy6ax5Mc0Pdeq6reO38M31chuonhu2wIrIow=
=Ccr0
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
