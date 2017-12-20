Received: from eggs.gnu.org ([2001:4830:134:3::10]:40459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbJL-0000DD-Eu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbJK-0004mn-BG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:09:15 -0500
Date: Wed, 20 Dec 2017 10:08:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100835.GJ21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-9-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-9-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: replace assertEquals() by
 assertEqual() for python3 compatibility
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

On Tue, Dec 19, 2017 at 02:34:24PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/041        | 6 +++---
>  tests/qemu-iotests/118        | 4 ++--
>  tests/qemu-iotests/iotests.py | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index a860a31e9a..fa0f20af0e 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -457,7 +457,7 @@ new_state =3D "1"
>          self.assert_qmp(result, 'return', {})
> =20
>          event =3D self.vm.get_qmp_event(wait=3DTrue)
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>          self.assert_qmp(event, 'data/device', 'drive0')
>          self.assert_qmp(event, 'data/operation', 'read')
>          result =3D self.vm.qmp('query-block-jobs')
> @@ -478,7 +478,7 @@ new_state =3D "1"
>          self.assert_qmp(result, 'return', {})
> =20
>          event =3D self.vm.get_qmp_event(wait=3DTrue)
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>          self.assert_qmp(event, 'data/device', 'drive0')
>          self.assert_qmp(event, 'data/operation', 'read')
>          result =3D self.vm.qmp('query-block-jobs')
> @@ -609,7 +609,7 @@ new_state =3D "1"
>          self.assert_qmp(result, 'return', {})
> =20
>          event =3D self.vm.get_qmp_event(wait=3DTrue)
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>          self.assert_qmp(event, 'data/device', 'drive0')
>          self.assert_qmp(event, 'data/operation', 'write')
>          result =3D self.vm.qmp('query-block-jobs')
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index 3cf21218f0..8158b4bd25 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -295,7 +295,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
>          result =3D self.vm.qmp('blockdev-close-tray', device=3D'drive0=
')
>          # Should be a no-op
>          self.assert_qmp(result, 'return', {})
> -        self.assertEquals(self.vm.get_qmp_events(wait=3DFalse), [])
> +        self.assertEqual(self.vm.get_qmp_events(wait=3DFalse), [])
> =20
>      def test_remove_on_closed(self):
>          if not self.has_real_tray:
> @@ -476,7 +476,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>                                                         read_only_mode=3D=
'retain')
>          self.assert_qmp(result, 'error/class', 'GenericError')
> =20
> -        self.assertEquals(self.vm.get_qmp_events(wait=3DFalse), [])
> +        self.assertEqual(self.vm.get_qmp_events(wait=3DFalse), [])
> =20
>          result =3D self.vm.qmp('query-block')
>          self.assert_qmp(result, 'return[0]/inserted/ro', False)
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 85c9d2c211..4c515d2e6c 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -385,7 +385,7 @@ class QMPTestCase(unittest.TestCase):
>      def wait_ready_and_cancel(self, drive=3D'drive0'):
>          self.wait_ready(drive=3Ddrive)
>          event =3D self.cancel_and_wait(drive=3Ddrive)
> -        self.assertEquals(event['event'], 'BLOCK_JOB_COMPLETED')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_COMPLETED')
>          self.assert_qmp(event, 'data/type', 'mirror')
>          self.assert_qmp(event, 'data/offset', event['data']['len'])
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
