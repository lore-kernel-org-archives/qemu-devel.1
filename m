Received: from eggs.gnu.org ([2001:4830:134:3::10]:45210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGDC-0000ei-Os
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGD9-0006tM-Km
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:38:58 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGD9-0006ss-BW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:38:55 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4so3297036lfj.3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:38:55 -0700 (PDT)
Date: Mon, 15 May 2017 14:38:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515133851.GI1201@stefanha-x1.localdomain>
References: <20170512143717.30391-1-stefanha@redhat.com>
	<20170512143717.30391-2-stefanha@redhat.com>
	<d876c5bf-6820-33e6-66e3-35ce670b7e7e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <d876c5bf-6820-33e6-66e3-35ce670b7e7e@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 03:19:18PM -0500, Eric Blake wrote:
> On 05/12/2017 09:37 AM, Stefan Hajnoczi wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > The GThread implementation is not functional enough to actually
> > run QEMU reliably. While it was potentially useful for debugging,
> > we have a scripts/qemugdb/coroutine.py to enable tracing of
> > ucontext coroutines in GDB, so that removes the only reason for
> > GThread to exist.
> >=20
>=20
> Quick question (unrelated to the pull request): Can we get a patch to
> scripts/qemugdb/coroutine.py or nearby that mentions the preferred way
> to actually use the script?  I didn't know the script existed before
> seeing this commit message, and was sad to see that it was not
> self-documenting (or else a scripts/qemugdb/README file) on how best to
> utilize the script (is it as simple as running 'gdb --some-arg
> /path/to/coroutine.py'? do you have to install some magic file to tell
> gdb to autoload the file any time you are debugging qemu? something
> else???).
>=20
> Okay, I searched a bit harder, and found that scripts/qemu-gdb.py loads
> these subscripts, if you type 'source scripts/qemu-gdb.py' at the (gdb)
> prompt.  Still, is there a way to automate that so that the scripts are
> loaded every time you fire up gdb, instead of having to remember to do
> it by hand? And if so, can that be documented?

I'll send a patch to add a .gdbinit file.

Stefan

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGa9rAAoJEJykq7OBq3PIPzoIAIvJSPuG2B2xejU65dvRKc6B
ODGUY4eZ4tqEuwCJUbRDY2HeSbd8GilGR5qc+zkv7h/JpnO/p/7lq5mA+VY/5fUt
Dz9Iflyi+IJbaAWVTbnhiKLVgGaJxG25eyiRhLzNY9maxFucs49ZNQLQ4bH9pXmM
atkuyRBsKa5mhp2coHhIwibQuEUDzORIKzHu4FcP9loXiWOp7MzKoIsF7/L+q7ph
xhlYBJzRo05u1m511i0Rrvp7Wm3TsciYbCUpx/Ca0MckUO26RbszGGLE4/poXiFV
a/pbozyhjzAw7QYxtPsji/juRr6DdiSHMvbtQt6mqd21A42wyL7BDkxPBioaS3U=
=722/
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
