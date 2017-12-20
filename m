Received: from eggs.gnu.org ([2001:4830:134:3::10]:38894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbHr-0007Ir-AH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbHq-0003jX-2Y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:07:43 -0500
Date: Wed, 20 Dec 2017 10:07:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100724.GH21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests: replace dict.has_key() by
 'in' operator for python3 compatibility
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

On Tue, Dec 19, 2017 at 02:34:22PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/093 | 2 +-
>  tests/qemu-iotests/096 | 4 ++--
>  tests/qemu-iotests/136 | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index 5c36a5fb4d..28b1d021ca 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -237,7 +237,7 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
>                  if name:
>                      self.assertEqual(info["group"], name)
>                  else:
> -                    self.assertFalse(info.has_key('group'))
> +                    self.assertFalse('group' in info)
>                  return
> =20
>          raise Exception("No group information found for '%s'" % device=
)
> diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
> index aeeb3753cf..a69439602d 100644
> --- a/tests/qemu-iotests/096
> +++ b/tests/qemu-iotests/096
> @@ -53,9 +53,9 @@ class TestLiveSnapshot(iotests.QMPTestCase):
>                  self.assertEqual(r['iops'], self.iops)
>                  self.assertEqual(r['iops_size'], self.iops_size)
>              else:
> -                self.assertFalse(r.has_key('group'))
> +                self.assertFalse('group' in r)
>                  self.assertEqual(r['iops'], 0)
> -                self.assertFalse(r.has_key('iops_size'))
> +                self.assertFalse('iops_size' in r)
> =20
>      def testSnapshot(self):
>          self.checkConfig('base')
> diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
> index 88b97ea7c6..a154d8ef9d 100644
> --- a/tests/qemu-iotests/136
> +++ b/tests/qemu-iotests/136
> @@ -203,7 +203,7 @@ sector =3D "%d"
>          if (self.accounted_ops(read =3D True, write =3D True, flush =3D=
 True) !=3D 0):
>              self.assertLess(0, stats['idle_time_ns'])
>          else:
> -            self.assertFalse(stats.has_key('idle_time_ns'))
> +            self.assertFalse('idle_time_ns' in stats)
> =20
>          # This test does not alter these, so they must be all 0
>          self.assertEqual(0, stats['rd_merged'])
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
