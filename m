Received: from eggs.gnu.org ([2001:4830:134:3::10]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Zmd-0000jq-Ex
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZmJ-0004zS-Ky
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:08:09 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-17-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bc244334-b24e-3867-e219-d230f947a9c5@redhat.com>
Date: Fri, 14 Sep 2018 00:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-17-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j8hqrvZGB5ivOsCdpluLxKOoM2KSLBfeB"
Subject: Re: [Qemu-devel] [PATCH v2 16/17] job: Avoid deadlocks in
 job_completed_txn_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j8hqrvZGB5ivOsCdpluLxKOoM2KSLBfeB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <bc244334-b24e-3867-e219-d230f947a9c5@redhat.com>
Subject: Re: [PATCH v2 16/17] job: Avoid deadlocks in
 job_completed_txn_abort()
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-17-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> Amongst others, job_finalize_single() calls the .prepare/.commit/.abort=

> callbacks of the individual job driver. Recently, their use was adapted=

> for all block jobs so that they involve code calling AIO_WAIT_WHILE()
> now. Such code must be called under the AioContext lock for the
> respective job, but without holding any other AioContext lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  job.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--j8hqrvZGB5ivOsCdpluLxKOoM2KSLBfeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlua3kcACgkQ9AfbAGHV
z0Bu9Qf8DaG2TUOIFjzOoG3bckAgWZLTXFYexs+MUqFk2xAqNNP8lyEpDj+3+Y4Y
d9FOlfH7z8EiwMF2fr6BHcTk2BJuHi/fMECFPUvKOuG+xH0Ed77FWZMhcfpLSBiy
1XbvwqmwRX7YVFzdZm2JdvbDXnxLHcPYlomPsBUpVPmMxydRVfh6QdMRxnqhgbLx
Mbdf+rftiWxLXUJBuoECEPZaNEuxcVcqLtiK5R1N9fZ94An/etGJcWDYfxdnNu9a
0jvWMg2UdE/8WMLgvH/nXR719Kd3e5nbsVldvG5la+kCzHBIb1vYxVZWpm3tjq2V
TON/es5US5wJK0mY/wWY2oUzZzqp5w==
=hDHE
-----END PGP SIGNATURE-----

--j8hqrvZGB5ivOsCdpluLxKOoM2KSLBfeB--
