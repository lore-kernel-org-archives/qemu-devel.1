Received: from eggs.gnu.org ([2001:4830:134:3::10]:59030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9SI-000631-2q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9SG-00039b-LP
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:38 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9SG-00039B-DQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id t74so14293833wme.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:26:36 -0800 (PST)
Date: Mon, 29 Jan 2018 13:26:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129132633.GE20446@stefanha-x1.localdomain>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20180125175949.7780-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] coroutine-lock: convert CoQueue to use
 QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 06:59:47PM +0100, Paolo Bonzini wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use
> a CoMutex and so cannot qemu_co_queue_wait.  Use QemuLockable so
> that the CoQueue can interchangeably use CoMutex or QemuMutex.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/coroutine.h   |  6 +++++-
>  util/qemu-coroutine-lock.c | 12 +++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyEJAAoJEJykq7OBq3PIyZ8IAL6L3xWJxhNLteffh0pvaZBn
KfbFCd9MiwVMiHCF4UCaDYFDBv1KLUjgesbJZ48fA7bqm/uz/gVg2fAdXJPvkBWS
LcfVP35TppMZ6nBQKoYQmObQXjJUSA+eVvyD5FAlloBA1qTVEKNPlX3jU+oiXpY8
z0j1ku6w69yxF5WDeF/y6i8Sm9CELAgJ/AHrbI0lGvENd+LFZIEq3V1utmZPVWXa
i+yw5zimGddVnQF4pARcsL3RW6opTA9wRNa2bUN3gVXxG2a3WTGWJgfXmigeQRDD
hXuC6LMXHtjvCg7ID6t0Z9uaY95CS1TVMGFDKLqsUbuJW0/zNcMPI5LvEopeMfo=
=SHiT
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
