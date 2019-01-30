Received: from eggs.gnu.org ([209.51.188.92]:45761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gouCb-0005eV-I0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gouCa-0006Hc-Nz
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:03:09 -0500
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548870690-647481-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fabd78b-68cd-6ac6-0681-d6ad084c7c0b@redhat.com>
Date: Wed, 30 Jan 2019 12:03:03 -0600
MIME-Version: 1.0
In-Reply-To: <1548870690-647481-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vHBT9y3OKcgqgbBbVUegcg4nvYPqATHqi"
Subject: Re: [Qemu-devel] [PATCH v10 1/3] bdrv_query_image_info Error
 parameter added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vHBT9y3OKcgqgbBbVUegcg4nvYPqATHqi
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <2fabd78b-68cd-6ac6-0681-d6ad084c7c0b@redhat.com>
Subject: Re: [PATCH v10 1/3] bdrv_query_image_info Error parameter added
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548870690-647481-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548870690-647481-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 11:51 AM, Andrey Shinkevich wrote:
> Inform a user in case qcow2_get_specific_info fails to obtain
> QCOW2 image specific information. This patch is preliminary to
> the print of bitmap information in the 'qemu-img info' output.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vHBT9y3OKcgqgbBbVUegcg4nvYPqATHqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxR5tcACgkQp6FrSiUn
Q2rvaAgAn6I+L7kq2hbVmJ7NdhbZ1XVtwW+QzjUE93AqEpEC+ypyhkAEKwBSR/zQ
m3FAnHnV8dGbO1UlodUrAeFspQcWK1dtuNZXHPSELKduMF/R01yL3PMUBE2xUDOB
u0pg6jId6GfqGbsJE0fePqnOQ53qFdA1SgINWl7SYhItcfMbHlB5ARIpAsQNcFo0
vSI6Ii2+ib4plw8QXD5gn9JNjZ2NvvvuXFjGMzGAURi8zvbJe+qLPbx6zQWA+iS+
yanNI25HPYtHujAfYtwE5nXE3VWN9ISK47Y0TyA2yCKZNUl8ydIxnZW2kZ+aHVGH
3y1zuKGKJ37wjldxYf9WF4g4vk4NPw==
=+2OG
-----END PGP SIGNATURE-----

--vHBT9y3OKcgqgbBbVUegcg4nvYPqATHqi--
