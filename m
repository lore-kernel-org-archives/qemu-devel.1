Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSId-0001du-5W
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSIc-0004B4-8R
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:59:23 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-5-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8598d51f-04fd-be25-533f-17c5362187ff@redhat.com>
Date: Mon, 5 Nov 2018 00:59:02 +0100
MIME-Version: 1.0
In-Reply-To: <1539981546-10596-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3dzdAmEUtEvxr4ENWEq1Mi33HNeW8wGnc"
Subject: Re: [Qemu-devel] [PATCH v4 4/8] qemu-img: assert block_job_get()
 does not return NULL in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3dzdAmEUtEvxr4ENWEq1Mi33HNeW8wGnc
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <8598d51f-04fd-be25-533f-17c5362187ff@redhat.com>
Subject: Re: [PATCH v4 4/8] qemu-img: assert block_job_get() does not return
 NULL in img_commit()
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
 <1539981546-10596-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.18 22:39, Liam Merwick wrote:
> Although the function block_job_get() can return NULL, it would be a
> serious bug if it did so (because the job yields before executing anyth=
ing
> (if it started successfully); but otherwise, commit_active_start() woul=
d
> have returned an error).  However, as a precaution, before dereferencin=
g
> the 'job' pointer in img_commit() assert it is not NULL.

(In the meantime, Markus has argued to me in some other case that
asserting that something isn't NULL is just as good as just
dereferencing it.  Oh well, I still don't mind either way.)

> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  qemu-img.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--3dzdAmEUtEvxr4ENWEq1Mi33HNeW8wGnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvfh8cACgkQ9AfbAGHV
z0D81ggAkNDkbu3fUrEJmpGRJwcQYPcLUv8BoektPSlDRnM+zmobdAi9XeFY6NYq
P1sJiPtGHrVZn9TmbkUiR0bZg/5Wh8IyciGymwZYEfdaBgYJUgkPff/Fd4xcPow1
5mF3k2ncuWOa8zpjYXrDhhjOSw9lpqxEHqnWhQi12aIbFz37SuA8SCzRv9ER2VQc
y6+ipgj/wUBfqrE+21ErYr5GJPZYjI3J+QjJqaB68r89Y3eXgXbyEuMnFwQIXQsV
LLazR+uEMc0lDZSXKucrDRRGqmR/zg9+4zqc9Omo5uaEod4P1C2WbN6y3HvkcSyp
ddAG3uVTZKHk90irMnn2Jw7M2q76DA==
=1qZU
-----END PGP SIGNATURE-----

--3dzdAmEUtEvxr4ENWEq1Mi33HNeW8wGnc--
