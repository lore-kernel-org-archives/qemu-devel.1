Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbId-000834-UG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbIc-0004HF-Pl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:08:31 -0500
Date: Wed, 20 Dec 2017 10:08:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100805.GI21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-8-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: replace lambda function by
 lambda expression for python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

On Tue, Dec 19, 2017 at 02:34:23PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/065 | 4 ++--
>  tests/qemu-iotests/139 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
> index 72aa9707c7..e95f7f817b 100755
> --- a/tests/qemu-iotests/065
> +++ b/tests/qemu-iotests/065
> @@ -59,7 +59,7 @@ class TestQemuImgInfo(TestImageInfoSpecific):
>                      :data.index('')]
>          for field in data:
>              self.assertTrue(re.match('^ {4}[^ ]', field) is not None)
> -        data =3D map(lambda line: line.strip(), data)
> +        data =3D [line.strip() for line in data]
>          self.assertEqual(data, self.human_compare)
> =20
>  class TestQMP(TestImageInfoSpecific):
> @@ -80,7 +80,7 @@ class TestQMP(TestImageInfoSpecific):
> =20
>      def test_qmp(self):
>          result =3D self.vm.qmp('query-block')['return']
> -        drive =3D filter(lambda drive: drive['device'] =3D=3D 'drive0'=
, result)[0]
> +        drive =3D [drive for drive in result if drive['device'] =3D=3D=
 'drive0'][0]
>          data =3D drive['inserted']['image']['format-specific']
>          self.assertEqual(data['type'], iotests.imgfmt)
>          self.assertEqual(data['data'], self.compare)
> diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
> index f8f02808a9..b54c816c16 100644
> --- a/tests/qemu-iotests/139
> +++ b/tests/qemu-iotests/139
> @@ -51,7 +51,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
>      # Check whether a BlockDriverState exists
>      def checkBlockDriverState(self, node, must_exist =3D True):
>          result =3D self.vm.qmp('query-named-block-nodes')
> -        nodes =3D filter(lambda x: x['node-name'] =3D=3D node, result[=
'return'])
> +        nodes =3D [x for x in result['return'] if x['node-name'] =3D=3D=
 node]
>          self.assertLessEqual(len(nodes), 1)
>          self.assertEqual(must_exist, len(nodes) =3D=3D 1)
> =20
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
