Received: from eggs.gnu.org ([2001:4830:134:3::10]:34890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbE9-0003th-1x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbE4-000067-Ao
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:03:53 -0500
Date: Wed, 20 Dec 2017 10:03:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100320.GE21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: replace print statement by
 print() function for python3 compatibility
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

On Tue, Dec 19, 2017 at 02:34:19PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/149        | 3 ++-
>  tests/qemu-iotests/165        | 3 ++-
>  tests/qemu-iotests/iotests.py | 5 +++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 223cd68ad5..d3ffa259db 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -20,6 +20,7 @@
>  # Exercise the QEMU 'luks' block driver to validate interoperability
>  # with the Linux dm-crypt + cryptsetup implementation
> =20
> +from __future__ import print_function
>  import subprocess
>  import os
>  import os.path
> @@ -376,7 +377,7 @@ def test_once(config, qemu_img=3DFalse):
>      finally:
>          iotests.log("# Delete image")
>          delete_image(config)
> -        print
> +        print()
> =20
> =20
>  # Obviously we only work with the luks image format
> diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
> index a3932db3de..ab29066076 100755
> --- a/tests/qemu-iotests/165
> +++ b/tests/qemu-iotests/165
> @@ -18,6 +18,7 @@
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
>  #
> =20
> +from __future__ import print_function
>  import os
>  import re
>  import iotests
> @@ -85,7 +86,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
>          log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
>          log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
>          if log:
> -            print log
> +            print(log)
> =20
>          self.vm =3D self.mkVm()
>          self.vm.launch()
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 6f057904a9..85c9d2c211 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -16,6 +16,7 @@
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
>  #
> =20
> +from __future__ import print_function
>  import errno
>  import os
>  import re
> @@ -145,7 +146,7 @@ def filter_qmp_event(event):
>  def log(msg, filters=3D[]):
>      for flt in filters:
>          msg =3D flt(msg)
> -    print msg
> +    print(msg)
> =20
>  class Timeout:
>      def __init__(self, seconds, errmsg =3D "Timeout"):
> @@ -417,7 +418,7 @@ def notrun(reason):
>      seq =3D os.path.basename(sys.argv[0])
> =20
>      open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n'=
)
> -    print '%s not run: %s' % (seq, reason)
> +    print("{} not run: {}".format(seq, reason))

I don't see the benefit in changing '%s' to '{}' and '%s' to '.format'.
The original code is the idiomatic python IME.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
