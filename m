Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emGvB-0002T1-9B
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emGvA-0001Lf-EV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:37:45 -0500
Date: Thu, 15 Feb 2018 10:37:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180215103721.GG23321@stefanha-x1.localdomain>
References: <20180203061621.7033-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <20180203061621.7033-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2018 at 07:16:18AM +0100, Stefan Hajnoczi wrote:
> v2:
>  * It was unnecessary to avoid duplicate iscsi_schedule_bh() calls since =
this
>    function already protects against duplicate calls internally [Stefan]
>=20
> Patches 1 & 2 are cleanups.
>=20
> Patch 3 fixes cancellation of ioctls.  Felipe showed me a trace where an =
acb is
> cancelled and then completes twice.  The second time around crashes QEMU.
>=20
> Compile-tested only.
>=20
> Felipe: Please let us know if this fixes the issue you are seeing.  Thank=
s!
>=20
> Stefan Hajnoczi (3):
>   block/iscsi: drop unused IscsiAIOCB->buf field
>   block/iscsi: take iscsilun->mutex in iscsi_timed_check_events()
>   block/iscsi: fix ioctl cancel use-after-free
>=20
>  block/iscsi.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Thanks for the reviews, Paolo and Felipe.

Paolo: Please merge this, I'll send an additional patch that works
around libiscsi's missing cancellation callback.

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahWLhAAoJEJykq7OBq3PIrMYH/2muQ7ylIK54hZ93lv8V0fJJ
9ShFauAjoxma9ah+ESI6ZmtXX8lwo/EtIS0nSER3HZlJP3e1Iizr7hisKPzcQwcl
fFrSlfX0K6J3Q0mp3M6fnBuQy5nksjf+EzH5mxAidwU7Fk/slAnZZyMZ0qJIuuYn
EuEeMzcZRO4KzRb1TT98W+hgRqBVIEtJiwlrP17G94X7FDod4WqTIFnNtBa6b+n+
bMn/sfPuoJnn+UvtnHEjpsrQO+Bo6YOS+os+5VdGwhffrFbvS8RuZY0EwjP5edul
xt7pUsFIk0s/Q64/dMWyub/hZJLUHP9GhEfA+mxy4nVIo74dXGk+iwghe4w+0hY=
=qNBy
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
