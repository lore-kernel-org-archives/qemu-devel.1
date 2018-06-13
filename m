Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fT8pu-0000ks-Vh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fT8pt-0001gl-VW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:41:31 -0400
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
	<20180613154711.12977-3-dplotnikov@virtuozzo.com>
	<ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b78d2918-9ba8-5f4d-0953-bf2420aabae0@redhat.com>
Date: Wed, 13 Jun 2018 18:41:14 +0200
MIME-Version: 1.0
In-Reply-To: <ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BWjScocJUrinYWwnUaanFiVJyo2Oe3UTF"
Subject: Re: [Qemu-devel] [PATCH v0 2/2] qmp: add block-set-copy-on-read
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BWjScocJUrinYWwnUaanFiVJyo2Oe3UTF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, famz@redhat.com,
 stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 den@virtuozzo.com, rkagan@virtuozzo.com
Message-ID: <b78d2918-9ba8-5f4d-0953-bf2420aabae0@redhat.com>
Subject: Re: [PATCH v0 2/2] qmp: add block-set-copy-on-read command
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
 <20180613154711.12977-3-dplotnikov@virtuozzo.com>
 <ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
In-Reply-To: <ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-13 18:02, Eric Blake wrote:
> On 06/13/2018 10:47 AM, Denis Plotnikov wrote:
>> The command enables/disables copy-on-read mode for VM's disk while
>> VM is running.
>>
>> This is needed when using external disk readers to shape access patter=
n
>> to the disk backend.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>=20
> Deferring thoughts on the actual design for later;

But why? ;-)

This patch would definitely be superseded by a block reconfiguration
command (i.e. presumably one that makes reopen accessible over QMP).
With such a command, you could insert or remove a copy-on-read filter
node at any point in time.

Since we definitely want block graph configuration, I don't think we
want to add special commands now.

Max


--BWjScocJUrinYWwnUaanFiVJyo2Oe3UTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlshSSoACgkQ9AfbAGHV
z0CdGQgAlBWT/FqR7Vn3VUb9zJ75MP/KX2+lL5pYDnrJSX+JJcDa4+0vl4/Gcs7Y
X5Jk6iWG9MeoMhP8ZUbpBCKjlJEuJGcL+KoXZWzEUeIskGXHvSWtYu4ghTa3iKqq
lTGqQuPAwrNM38Cv10UNal6Ym6edOwOllPwvm3Rg+YsZH+BoMUNJuGc6QoBMc1GM
PaVcl3Or2HV/+q0ALEDT25iCtw0sX7854Xuu1ZDM75MxjC+91LUdUeIkXtnzsjzk
4cY+arLJDFikuXAL1hPQfNMmx+BFrfXLVXZ/OopBvqVw/CvPMNvEanrch31vSQjI
lF8pDIBgVehwO6L7tNE/c8XkpCzJjg==
=OyPU
-----END PGP SIGNATURE-----

--BWjScocJUrinYWwnUaanFiVJyo2Oe3UTF--
