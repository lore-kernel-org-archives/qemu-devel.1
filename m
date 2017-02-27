Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLrR-0000uW-0t
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLrN-00072K-4j
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:01:09 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLrM-00072D-R1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:01:05 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so13568982wmu.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:01:04 -0800 (PST)
Date: Mon, 27 Feb 2017 14:01:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227140101.GU28403@stefanha-x1.localdomain>
References: <20170227111726.9237-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aQ0PHH3iiKbaMI5N"
Content-Disposition: inline
In-Reply-To: <20170227111726.9237-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests-aio-multithread: use atomic_read
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com


--aQ0PHH3iiKbaMI5N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 12:17:26PM +0100, Paolo Bonzini wrote:
> nodes[id].next is written by other threads.  If atomic_read is not used
> (matching atomic_set in mcs_mutex_lock!) the compiler can optimize the
> whole "if" away!
>=20
> Reported-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-aio-multithread.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--aQ0PHH3iiKbaMI5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtDEdAAoJEJykq7OBq3PIyIkH/RrLkcZNMXuUqndTf1XeMZBR
RR8JWlCs2rbb/LZO7qaPKZlE7wYCKD6HXEx7XvbyuJ5FU23LQzpAzQ9nH4XdNnsS
DGfLsusLXu6gLbpOpbkNaMBIop2aCy1iQTUr3KeOssFLjd+J3Cl20KgRvNS51uT5
xczQZpDLaiTg9K/0rC8jHjbJFWFBFUmM9C24yRu7CTivXEzk4G0N19QYaf4VOVPp
GrMldAStGgE01qCbsdM3xmUB60Auu/sTs01vLNFvFSG6CQPxasTDCFlBxK2bjGSG
M9wa3WJNcwFr+amAXaP6kQOAO0/fzofo7V4F45GcpWDNTQePropALMjeOVTlNJI=
=tX6i
-----END PGP SIGNATURE-----

--aQ0PHH3iiKbaMI5N--
