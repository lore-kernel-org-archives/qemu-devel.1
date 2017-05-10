Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8UYj-0005DW-Rb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8UYj-0000Wr-4D
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:33:53 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-3-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <36ef862f-2b07-6f28-3a22-02373fb503fc@redhat.com>
Date: Wed, 10 May 2017 18:33:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ljOH8CaN8LL99rbJjeufv861UtRv5xPE9"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] curl: never invoke
 callbacks with s->mutex held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ljOH8CaN8LL99rbJjeufv861UtRv5xPE9
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <36ef862f-2b07-6f28-3a22-02373fb503fc@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/7] curl: never invoke callbacks with
 s->mutex held
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-3-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:32, Paolo Bonzini wrote:
> All curl callbacks go through curl_multi_do, and hence are called with
> s->mutex held.  Note that with comments, and make curl_read_cb drop the=

> lock before invoking the callback.
>=20
> Likewise for curl_find_buf, where the callback can be invoked by the
> caller.
>=20
> Cc: qemu-stable@nongnu.org
> Cc: jcody@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ljOH8CaN8LL99rbJjeufv861UtRv5xPE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTQOYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4TQIAJ/hwwWhrU1VOraIdJaZcL4EhsjlTjzd
+f8TzWD0YinpIeCIRlSJFKVqzK3sc5J6pkstB3dN03XQZhIRTRVB+1R89mv/57gD
iGkrL3g3d/0wRRRcHgSQAzps+ak2onYXklHtSpU8tHuND9si43ky0Mu9iugZjzSJ
M7iigQEybDGTijY/zPmYAWCtvyonWGaJabhzEsKfTqAC5QEEIFrPRS6Us81aOAdR
SiyNwa9nfqdYmFFTmbeXFgmd57jaxnedQihVONYa8ryOyzCKmhvr56CQjNg3XtJX
WtpKswgwLN6Y6YwRhZSMraIpM23/hsT9tIHcqxIkLr/D9Wj5SLc9Mq4=
=rRC9
-----END PGP SIGNATURE-----

--ljOH8CaN8LL99rbJjeufv861UtRv5xPE9--
