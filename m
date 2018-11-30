Received: from eggs.gnu.org ([2001:4830:134:3::10]:59222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSiHs-0003kF-VM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSiHs-000471-4y
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:52:52 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<d8fdd816-90a1-29d7-cdab-0efe3e9abeda@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ef7a489-a944-fb18-3032-228a51ec7ee2@redhat.com>
Date: Fri, 30 Nov 2018 13:52:39 +0100
MIME-Version: 1.0
In-Reply-To: <d8fdd816-90a1-29d7-cdab-0efe3e9abeda@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pETgukdsNhBK0sNS3XuAm5p19Qq5lM5p7"
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH v2 0/2] mirror
 dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-stable@nongnu.org, dplotnikov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pETgukdsNhBK0sNS3XuAm5p19Qq5lM5p7
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-stable@nongnu.org,
 dplotnikov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1ef7a489-a944-fb18-3032-228a51ec7ee2@redhat.com>
Subject: Re: [Qemu-devel for-3.1?] [PATCH v2 0/2] mirror dead-lock
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <d8fdd816-90a1-29d7-cdab-0efe3e9abeda@redhat.com>
In-Reply-To: <d8fdd816-90a1-29d7-cdab-0efe3e9abeda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.11.18 15:14, Eric Blake wrote:
> On 11/29/18 4:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> v2: add fix:)
>>
>> We've faced the following mirror bug:
>>
>> Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.=

>=20
> How long has the bug been present?=C2=A0 Based on patch 1 mentioning co=
mmit
> 2e1990b26e5 (in 3.0), I'm guessing that this bug is not a regression
> specific to 3.1?=C2=A0 If so, then maybe we're better off deferring thi=
s to
> 4.0 just relying on qemu-stable (already cc'd); on the other hand, if i=
t
> is an easy-to-trigger deadlock on something the user is likely to do,
> can we justify it being severe enough to warrant -rc4?

The test does indeed break on 3.0.0 (and passes on 2.12.0).  But mirror
just not working from non-trivial qcow2 images?  To me, that is a reason
to delay the release, even though it is not a regression.

Max


--pETgukdsNhBK0sNS3XuAm5p19Qq5lM5p7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBMpcACgkQ9AfbAGHV
z0CijwgAodUrJryYB3c+GyJB8elfaZF6QnkwhYEBT9P4Zv0zSU5fv59rtruJsiyV
w3exK1/9tSHUru6/jOI9MC1yQj49Fp9ApfFf4C043Sbz5zv+0jYM/t8hvbWnAq3g
j/XkVAGdokZG49lHhJVWW18eUmFFCgT30fDEB/wK0bJM77oeqV+InFOX2EGEyYWc
Qv9dOsNPNySauI3RIC0SFjLxXCCEhVBzjBesaLsOWPpGjEBNBOyOaqfdF2ivDy3X
xRHBWlDcz/dPg/Kw3cPycoLZBFf4z8Y5kHI5/TkEkWNcYo5hlIv2/YJBHux7Hk8N
iHZTk39wLWBykxQC4d/8NpsOKFYymA==
=tQGg
-----END PGP SIGNATURE-----

--pETgukdsNhBK0sNS3XuAm5p19Qq5lM5p7--
