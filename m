Received: from eggs.gnu.org ([209.51.188.92]:56412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXf3-0007qo-Fg
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXf2-0005Rx-85
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwXf2-0005Aj-1Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:36:04 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 20:35:41 +0100
Message-Id: <20190220193541.24419-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] travis: Bump Xcode 10 image to 10.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>

Travis enforce the use of the git protocol v2 on their images,
but the 'xcode10' image doesn't handle this correctly, resulting
in the brew packages installation failing:

  $ git config protocol.version
  2
  $ rvm $brew_ruby do brew bundle --verbose --global
  /usr/local/bin/brew tap homebrew/bundle
  =3D=3D> Tapping homebrew/bundle
  Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-bundle=
'...
  fatal: unknown value for config 'protocol.version': 2
  Error: Failure while executing; `git clone https://github.com/Homebrew/=
homebrew-bundle /usr/local/Homebrew/Library/Taps/homebrew/homebrew-bundle=
 --depth=3D1` exited with 128.
  Error: Failure while executing; `/usr/local/bin/brew tap homebrew/bundl=
e` exited with 1.

The newer 'xcode10.2' beta [*] image doesn't have this limitation.

This image comes with the following brew packages pre-installed,
which extend the current code coverage:
 - libffi
 - libpng
 - libtasn1
 - gnutls
 - jpeg
 - nettle

[*] https://blog.travis-ci.com/2019-02-12-xcode-10-2-beta-2-is-now-availa=
ble

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
"RFC" because this image is 'beta'.

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index baa06b976a..5de765bb20 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -177,7 +177,7 @@ matrix:
     - env:
         - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
       os: osx
-      osx_image: xcode10
+      osx_image: xcode10.2
       compiler: clang
=20
=20
--=20
2.20.1
