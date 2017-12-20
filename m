Received: from eggs.gnu.org ([2001:4830:134:3::10]:38015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbGo-0006Bm-KR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbGn-0002tQ-CA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:38 -0500
Date: Wed, 20 Dec 2017 10:06:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100619.GG21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: replace xrange() by range()
 for python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

On Tue, Dec 19, 2017 at 02:34:21PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/044 | 14 +++++++-------
>  tests/qemu-iotests/163 |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
> index 11ea0f4d35..1e96800176 100755
> --- a/tests/qemu-iotests/044
> +++ b/tests/qemu-iotests/044
> @@ -52,23 +52,23 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>              # Write a refcount table
>              fd.seek(off_reftable)
> =20
> -            for i in xrange(0, h.refcount_table_clusters):
> +            for i in range(0, h.refcount_table_clusters):
>                  sector =3D ''.join(struct.pack('>Q',
>                      off_refblock + i * 64 * 512 + j * 512)
> -                    for j in xrange(0, 64))
> +                    for j in range(0, 64))
>                  fd.write(sector)
> =20
>              # Write the refcount blocks
>              assert(fd.tell() =3D=3D off_refblock)
> -            sector =3D ''.join(struct.pack('>H', 1) for j in xrange(0,=
 64 * 256))
> -            for block in xrange(0, h.refcount_table_clusters):
> +            sector =3D ''.join(struct.pack('>H', 1) for j in range(0, =
64 * 256))
> +            for block in range(0, h.refcount_table_clusters):
>                  fd.write(sector)
> =20
>              # Write the L1 table
>              assert(fd.tell() =3D=3D off_l1)
>              assert(off_l2 + 512 * h.l1_size =3D=3D off_data)
>              table =3D ''.join(struct.pack('>Q', (1 << 63) | off_l2 + 5=
12 * j)
> -                for j in xrange(0, h.l1_size))
> +                for j in range(0, h.l1_size))
>              fd.write(table)
> =20
>              # Write the L2 tables
> @@ -79,14 +79,14 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>              off =3D off_data
>              while remaining > 1024 * 512:
>                  pytable =3D list((1 << 63) | off + 512 * j
> -                    for j in xrange(0, 1024))
> +                    for j in range(0, 1024))
>                  table =3D struct.pack('>1024Q', *pytable)
>                  fd.write(table)
>                  remaining =3D remaining - 1024 * 512
>                  off =3D off + 1024 * 512
> =20
>              table =3D ''.join(struct.pack('>Q', (1 << 63) | off + 512 =
* j)
> -                for j in xrange(0, remaining / 512))
> +                for j in range(0, remaining / 512))
>              fd.write(table)
> =20
> =20
> diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
> index 403842354e..fb0d0257ec 100644
> --- a/tests/qemu-iotests/163
> +++ b/tests/qemu-iotests/163
> @@ -41,7 +41,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
>          div_roundup =3D lambda n, d: (n + d - 1) / d
> =20
>          def split_by_n(data, n):
> -            for x in xrange(0, len(data), n):
> +            for x in range(0, len(data), n):
>                  yield struct.unpack('>Q', data[x:x + n])[0] & l1_mask
> =20
>          def check_l1_table(h, l1_data):
> --=20
> 2.15.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
