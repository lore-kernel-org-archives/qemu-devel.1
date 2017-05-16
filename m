Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdoa-0000AS-PB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdoa-00053C-2A
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:51:08 -0400
Date: Tue, 16 May 2017 15:50:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516145041.GK8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-14-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/18] block: protect tracked_requests and
 flush_queue with reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:03PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: correct and simplify flush queue handling [Fam, me]
>=20
>  block.c                   |  1 +
>  block/io.c                | 16 ++++++++++++++--
>  include/block/block_int.h | 14 +++++++++-----
>  3 files changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxHBAAoJEJykq7OBq3PIpL4H/3ve9YKzBsW/esJmg4xCMUG7
qvV8gPLnc0XNEAqh3uVG8j5/v6KuW8ZYmVpn+Gl8N1nLhFsKOxtD2N4Ma2NKPGh6
vEFhOTnLykY1yEqw+Unmkl43q843yh+AKw9V6dhW5eHSROsndNWFuXmsNnw2BaMC
2w0fV3XvhBd4nBxNlae5/YP7nF1WTbGSbW7eyb6ESndmpjSg2IzT43G8urH8JdmG
/BE23Hy5yS+wpCnUX/1yPWzazzAvfhTrfzKP7ktok9hVex6k47W0yTg0n7sgaQlc
Ud9K2oIwkbo/IPeATZzS7Ru0IvVqfgV+Fup12AJmKBIn9M9bQiXhfFmQNBGZvRc=
=zpAg
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
