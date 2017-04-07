Received: from eggs.gnu.org ([2001:4830:134:3::10]:37004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwSAO-0007Oz-L4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwSAN-00039W-SW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:35:00 -0400
Date: Fri, 7 Apr 2017 12:34:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407113450.GO13602@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
In-Reply-To: <CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
> >
> > A proper solution is to refactor the synchronous code to make it
> > asynchronous.  This might require invoking the system call from a
> > thread pool worker.
> >
>=20
> yes, i agree with you, but this is a big change.
> I will try to find how to optimize this code, maybe need a long time.
>=20
> this patch is not a perfect solution, but can alleviate the problem.

Let's try to understand the problem fully first.

Stefan

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY53laAAoJEJykq7OBq3PI6uEIAMhM6LiRwmY+kfRmZ/jWQdSU
ARTHnOalaI0TGFSUochJwVQQOW6lzaXNuKSIFNH1KtXffEA941L5nlhXX1OSHA2/
qj3ZDDvyMul9Zf+oGhr3KY3NZdLbR4I1ENRBNH5B1UNhEFR0BSDY7+2Ljw0Ukxrf
LLLceHksAa2Qms6IsXQyU7VQi7nmpKhQaVXKSCRV0TYYOw70WvxbGGhcyU3nNSrz
3fdewGAHN4uTAfvvauS7Ryg9jUzwjIx+WwWvDhL85gUfYQNFZxcugx/gHeK8YZw4
4mGJPvLXX/LnecHY5ZAN/TBb0HSej3JPSxpZMjf/0Ocjofz0qemInu4JEZSGduw=
=oviq
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--
