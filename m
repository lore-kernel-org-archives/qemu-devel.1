Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbGZ-0005zV-9i
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbGS-0002Se-V5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:23 -0500
Date: Wed, 20 Dec 2017 10:05:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220100543.GF21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-5-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: use octal numbers for python3
 compatibility
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

On Tue, Dec 19, 2017 at 02:34:20PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/118 | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index 8a9e838c90..3cf21218f0 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -417,14 +417,14 @@ class TestChangeReadOnly(ChangeBaseClass):
> =20
>      def tearDown(self):
>          self.vm.shutdown()
> -        os.chmod(old_img, 0666)
> -        os.chmod(new_img, 0666)
> +        os.chmod(old_img, 0o666)
> +        os.chmod(new_img, 0o666)
>          os.remove(old_img)
>          os.remove(new_img)
> =20
>      def test_ro_ro_retain(self):
> -        os.chmod(old_img, 0444)
> -        os.chmod(new_img, 0444)
> +        os.chmod(old_img, 0o444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'flo=
ppy')
>          self.vm.launch()
> =20
> @@ -443,7 +443,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', n=
ew_img)
> =20
>      def test_ro_rw_retain(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'flo=
ppy')
>          self.vm.launch()
> =20
> @@ -462,7 +462,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', n=
ew_img)
> =20
>      def test_rw_ro_retain(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk', 'floppy')
>          self.vm.launch()
> =20
> @@ -483,7 +483,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', o=
ld_img)
> =20
>      def test_ro_rw(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'flo=
ppy')
>          self.vm.launch()
> =20
> @@ -503,7 +503,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', n=
ew_img)
> =20
>      def test_rw_ro(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk', 'floppy')
>          self.vm.launch()
> =20
> @@ -542,7 +542,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', n=
ew_img)
> =20
>      def test_make_ro_rw(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk', 'floppy')
>          self.vm.launch()
> =20
> @@ -562,7 +562,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', o=
ld_img)
> =20
>      def test_make_rw_ro_by_retain(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk,read-only=3Don', 'flo=
ppy')
>          self.vm.launch()
> =20
> @@ -581,7 +581,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', n=
ew_img)
> =20
>      def test_make_ro_rw_by_retain(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk', 'floppy')
>          self.vm.launch()
> =20
> @@ -600,7 +600,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', o=
ld_img)
> =20
>      def test_rw_ro_cycle(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=3Ddisk', 'floppy')
>          self.vm.launch()
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
