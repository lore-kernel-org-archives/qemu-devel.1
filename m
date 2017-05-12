Received: from eggs.gnu.org ([2001:4830:134:3::10]:57956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9H26-000817-7F
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9H23-00041Y-2k
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9H22-00041F-Px
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:19:23 -0400
References: <20170512143717.30391-1-stefanha@redhat.com>
	<20170512143717.30391-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d876c5bf-6820-33e6-66e3-35ce670b7e7e@redhat.com>
Date: Fri, 12 May 2017 15:19:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170512143717.30391-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oJdsVb6plIEqOhBFfUro1eV9JQwd81ARo"
Subject: Re: [Qemu-devel] [PULL for-2.9 1/3] coroutine: remove GThread
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oJdsVb6plIEqOhBFfUro1eV9JQwd81ARo
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <d876c5bf-6820-33e6-66e3-35ce670b7e7e@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 1/3] coroutine: remove GThread
 implementation
References: <20170512143717.30391-1-stefanha@redhat.com>
 <20170512143717.30391-2-stefanha@redhat.com>
In-Reply-To: <20170512143717.30391-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 09:37 AM, Stefan Hajnoczi wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The GThread implementation is not functional enough to actually
> run QEMU reliably. While it was potentially useful for debugging,
> we have a scripts/qemugdb/coroutine.py to enable tracing of
> ucontext coroutines in GDB, so that removes the only reason for
> GThread to exist.
>=20

Quick question (unrelated to the pull request): Can we get a patch to
scripts/qemugdb/coroutine.py or nearby that mentions the preferred way
to actually use the script?  I didn't know the script existed before
seeing this commit message, and was sad to see that it was not
self-documenting (or else a scripts/qemugdb/README file) on how best to
utilize the script (is it as simple as running 'gdb --some-arg
/path/to/coroutine.py'? do you have to install some magic file to tell
gdb to autoload the file any time you are debugging qemu? something
else???).

Okay, I searched a bit harder, and found that scripts/qemu-gdb.py loads
these subscripts, if you type 'source scripts/qemu-gdb.py' at the (gdb)
prompt.  Still, is there a way to automate that so that the scripts are
loaded every time you fire up gdb, instead of having to remember to do
it by hand? And if so, can that be documented?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oJdsVb6plIEqOhBFfUro1eV9JQwd81ARo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhjGAAoJEKeha0olJ0Nq9msH/0ae+oPbiF/6P+l8oRobiQh4
7Y7d1MWw2Rfbv4EfpfRI3OAMDGmlORkZvHWiWVHx7eOkPvqCVCUwd6sbrVA1PDZt
+mHqmCfVOsBPlE190N3yDp1Qr5kE9SbpAkM71Q+Tb8lcqJX2sLIo0reZI/UFvPE1
/pIB8SfkI+XeIpOIVMn/JcEEEzxbxggJfTXInEsiehzF0AqDUvFLioF2FYboV1S8
yDo0O12MYggGD3w7OYfUG/djSphkoHF/Gu8UoCtwNzkLBpzq4mPXTeSwEd6JjOJ6
ZoVkvjfzFN/h+HlczXDrvnCT1yASPEIKcB0HyZRqtXoVzd0UkVQp3Qw1WSRxVyo=
=Rimy
-----END PGP SIGNATURE-----

--oJdsVb6plIEqOhBFfUro1eV9JQwd81ARo--
