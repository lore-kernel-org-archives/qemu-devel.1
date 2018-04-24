Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6EA-0008GX-1j
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6E9-0007I9-0z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:15:58 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2290ac9c-5fd0-976d-7dbd-c220bb119034@redhat.com>
Date: Tue, 24 Apr 2018 17:15:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xgWqg7tWNlWpPOoCFbn4uFhB2ypZrVbhs"
Subject: Re: [Qemu-devel] [RFC PATCH 10/33] job: Add job_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xgWqg7tWNlWpPOoCFbn4uFhB2ypZrVbhs
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <2290ac9c-5fd0-976d-7dbd-c220bb119034@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/33] job: Add job_delete()
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-11-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> This moves freeing the Job object and its fields from block_job_unref()=

> to job_delete().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/job.c
> @@ -56,3 +56,9 @@ void *job_create(const char *job_id, const JobDriver =
*driver, Error **errp)
> =20
>      return job;
>  }
> +
> +void job_delete(Job *job)
> +{
> +    g_free(job->id);
> +    g_free(job);

Should this be free()-like, by being a no-op when NULL is passed in, on
the grounds that it might simplify some partial-construction error paths?=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xgWqg7tWNlWpPOoCFbn4uFhB2ypZrVbhs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfrJQACgkQp6FrSiUn
Q2pS0Af/XHB6PW0nPLG2w41UYBSkvPWm2EA7mNrbdjwsJmHWaD6SD2A79fCoFuMg
sIi5BIyVrDklLIvbXSy0Zl1vud8zZkDY+MEbBq77j4ENI7FcRQ50QA5UzH/l095A
XroiJWYXfSmZB2D5HN0uGvYO+H5Ibhhk6xgJFy1CagZ0P7jf9YxWCABFwzei/jnt
wtl8ys+oWd9v2nxqA+Kv2eiu2pza5H31T42NvGB4vgXiutqdeTDnupVOXVJJsX6W
bV1/1wmqBjkW2B8ZOqj4LT7KmvTgsVExMzDy16s+kws3zkts1td6KCDYVFKj1Ube
xTZlRq+COo9zaT4tjyTADtvFebiWWw==
=OBq4
-----END PGP SIGNATURE-----

--xgWqg7tWNlWpPOoCFbn4uFhB2ypZrVbhs--
