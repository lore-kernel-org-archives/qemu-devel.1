Received: from eggs.gnu.org ([2001:4830:134:3::10]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee0FN-0008EZ-79
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee0FJ-0007Ul-Vj
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:12:25 -0500
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
	<20180119135719.24745-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1c36fb0-a90f-daf8-e785-f815b510ba46@redhat.com>
Date: Tue, 23 Jan 2018 09:12:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180119135719.24745-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PqtO2fIfX0raHipgrbRaP2bnvp6izGiX5"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PqtO2fIfX0raHipgrbRaP2bnvp6izGiX5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <a1c36fb0-a90f-daf8-e785-f815b510ba46@redhat.com>
Subject: Re: [PATCH v3 5/5] iotest 201: new test for qmp nbd-server-remove
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
 <20180119135719.24745-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180119135719.24745-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 07:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/201     | 156 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/201.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 162 insertions(+)
>  create mode 100644 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out

Test 201 (and 204) is in Kevin's pull request, I'm renaming this to 205
as part of preparing my NBD queue.
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05626.html


> +++ b/tests/qemu-iotests/group
> @@ -197,5 +197,6 @@
>  197 rw auto quick
>  198 rw auto
>  200 rw auto
> +201 rw auto quick
>  202 rw auto quick
>  203 rw auto
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PqtO2fIfX0raHipgrbRaP2bnvp6izGiX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpnUMYACgkQp6FrSiUn
Q2of9Af/bHptrWCPsze9NPg0BfCMkIFlMcum1CxhG+aJX8DTCK5SDyVW2hmKo2tu
coHoVouc7H+aHqu+DTe+4F4CmOXhO7FM0Tl3xdF5czJ92v1RfZW3RKp1WWTs9LIK
meL9s+IEvkFAJSdtE3M8kzkTD8pwQKiIVELn2YHcYDVUJ2p2gTwctjB9tkwNtf9N
IFcKf2ZvHpxWBad+DsyHDVayB1RJjMFvXcmtcdtXVFGTYe3mvVnM+Wgw1hXnhcOO
zEjtSyc2uGCT8vwvwKFbPwUDQZ/7b02OOUrcqeI4a1kHlyDe9Ar3TCiPV+xtvIJV
J5GltEz0xoKaqW5KibVY3zYWfLBGMw==
=Er0q
-----END PGP SIGNATURE-----

--PqtO2fIfX0raHipgrbRaP2bnvp6izGiX5--
