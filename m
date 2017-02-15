Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce0e1-0006CH-Sy
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce0dx-00054r-5u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:21 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ce0dw-00054V-W7
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:33:17 -0500
Received: by mail-wr0-x242.google.com with SMTP id q39so793503wrb.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:33:16 -0800 (PST)
Date: Wed, 15 Feb 2017 14:33:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170215143311.GB16064@stefanha-x1.localdomain>
References: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
	<20170208221050.GP2955@var.home>
	<20170212073019.GA25566@cs.unibo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20170212073019.GA25566@cs.unibo.it>
Subject: Re: [Qemu-devel] libslirp and QEMU slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, virtualsquare@cs.unibo.it, thuth@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@web.de>, peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2017 at 08:30:19AM +0100, Renzo Davoli wrote:
> It would be a nice project to create a common codebase for libslirp.
> The project sould be interesting for other VM projects (virtualbox-OSE?) =
and
> maybe many others. We could collect several ants...
>=20
> Libslirp/QEMU integration is not so difficult.
> As a first step:
> * Qemu could add the UNIX socket redirect feature, or at least a unixtcp_=
fconnect dummy function
> returning -1 (#ifndef LIBSLIRP)
> * #include <qemu2libslirp.h>
> could be added in slirp.h (inside an #ifdef LIBSLIRP).
> In this way we could share exactly the same codebase.
>=20
> One further step:
> * discuss how to reduce/eliminate qemu-specific dependence
> * create an API for save/restore

Eliminating QEMU dependencies is feasible, I think.  libslirp could have
no "qemu" strings in the code :).  Applications like QEMU need to query
libslirp for timers and fds so they can be integrated into event loops
(select(2)).

Once there is a working libslirp that arbitrary programs can link
against it can be packaged (rpm, deb, etc) and announced.  That might
attract new contributors.

Stefan

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpGanAAoJEJykq7OBq3PICswIALWCIbicJEfZXpMw1VtwRZor
eOR5SKlcOjyXzm5pwDfhhiCvfWN1YFGYA/Er7oqKQrAAzfueJtrDOMlbj1aIdHsy
K/iVLVxAdqa88gLLMozlj1FlqExk+GP91HYKA94yIt+HpnjLqObRz7gFjVt0lwEh
r9pKLty1lOY+PQ+iVUys739KH63Gt1YTxixmXq/o6V5qokI7EGcG2PkNfaX6S81r
fv4fCCbxUnzhZBepDrv6TtokacqrRmwEJsC3G7kgIrCHRwwnhvUjO4ZMMCxLrxKC
TAHH+GhKEHbzndBxU6OJxI2Q9WWg/yC/1AuCnQ5kAZ0Y3yRiKpWlK2d9ESyVytc=
=xAWn
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
