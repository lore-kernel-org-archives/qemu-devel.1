Received: from eggs.gnu.org ([2001:4830:134:3::10]:35567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GAf-0005CK-SA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GAf-0003e1-5h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:47:49 -0400
Date: Thu, 4 May 2017 13:47:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504124745.GK32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EMQjp+MvU6EBGjHc"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/17] block: access wakeup
 with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--EMQjp+MvU6EBGjHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:46PM +0200, Paolo Bonzini wrote:
> @@ -622,6 +620,8 @@ struct BlockDriverState {
>      unsigned int in_flight;
>      unsigned int serialising_in_flight;
> =20
> +    bool wakeup;

You added a comment that this field is accessed atomically in the other
patches.  Should it be added here too?

--EMQjp+MvU6EBGjHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyLxAAoJEJykq7OBq3PI4TYH/2bMuKJC1hb3qiUkaRobUOdl
VKUX4e3omtU8aKJZMzlbLU6slhSYN6TZ6vXcHw+tUrkOrQTwB6DuFCyu3Eue+6f1
X4NndwfBkmXUr20IZNcKGPjoV8oQfn02AusW/Hr2wfk5A30HmPILak3dTfIQXnro
8wIM7nkBk3s2RxbGc1Ixf/eHl+DHJoyZmIfReq7XiT/WVu8meXMhr/kDq7dX0LO9
e6xB3HA8WyT9Ojz/TL0+hSuNURhEoHiK0LC8TCeJJEaG/ZmUpnHTxU/zm53nu2I/
oLEuzBsvte33IbFeyx0kmqFdid1dm26ibJZZK5nj/D1S5CbnUkIVijMY0C+8oNA=
=G22Z
-----END PGP SIGNATURE-----

--EMQjp+MvU6EBGjHc--
