Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEC3C-0006I0-O8
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEC39-0006ir-JS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:28:38 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEC39-0006ht-Ab
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:28:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so20295977wme.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:28:35 -0800 (PST)
Date: Tue, 6 Dec 2016 09:27:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206092732.GB12630@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161205102549.GA23432@lemon>
	<20161205145626.GF30434@stefanha-x1.localdomain>
	<8a60274e-2bb8-fd1a-282d-f1b5e106d684@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <8a60274e-2bb8-fd1a-282d-f1b5e106d684@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/13] aio: experimental virtio-blk
 polling mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Karl Rister <krister@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, borntraeger@de.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:40:49AM -0600, Karl Rister wrote:
> On 12/05/2016 08:56 AM, Stefan Hajnoczi wrote:
> <snip>
>=20
> > Karl: do you have time to run a bigger suite of benchmarks to identify a
> > reasonable default poll-max-ns value?  Both aio=3Dnative and aio=3Dthre=
ads
> > are important.
> >=20
> > If there is a sweet spot that improves performance without pathological
> > cases then we could even enable polling by default in QEMU.
> >=20
> > Otherwise we'd just document the recommended best polling duration as a
> > starting point for users.
> >=20
>=20
> I have collected a baseline on the latest patches and am currently
> collecting poll-max-ns=3D16384.  I can certainly throw in a few more
> scenarios.  Do we want to stick with powers of 2 or some other strategy?

Excellent, thanks!  The algorithm self-tunes by doubling poll time so
there's not much advantage to looking at non pow-2 values.

Thanks,
Stefan

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRoSEAAoJEJykq7OBq3PITEIH/itzxxcIGxJtb9DREeDhG+/j
fSYX2WMgWvxDRjE/WP6MtVceDO4oGYalv5fH+xrADXdOopBRtPVYhlv5LOpl5Z9Q
ZdZDoraI8xU9SqAPkBstkDomI8CcwHzJzhLLrMAURuY1KWO743bUtnrS4OUjwnEX
mf2g4TD8FXJ47kzJwYCP0sBQwpyhAYwIqYTReNbjg6LAgaeJ3086wC7HghoEF1Kb
wa7D+PQObQK4HwBXeL6od0SEpoOhxIj/bhnCyLTi0KvAoNV021y0T/cjZCYGnAnL
Tm/7mod10AKt/C2el9okciTN1CznISCLfZiilG30dr8en2rqj394zq1wYFs8QUU=
=ZMim
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
