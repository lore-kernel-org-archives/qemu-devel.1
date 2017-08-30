Received: from eggs.gnu.org ([2001:4830:134:3::10]:57625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iN-000458-IM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iL-0004Ds-DN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dn9iL-0004Cr-6c
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dn9iK-0003XK-8E
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 30CCD2E806F
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Aug 2017 20:16:57 -0000
From: Thomas Huth <984516@bugs.launchpad.net>
Reply-To: Bug 984516 <984516@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120418021847.6939.88224.malonedeb@chaenomeles.canonical.com>
Message-Id: <150412421820.10925.16842197802086525769.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 984516] Re: should use sdl-config for static
 build not pkg-config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/984516

Title:
  should use sdl-config for static build not pkg-config

Status in QEMU:
  Fix Released

Bug description:
  In the configure script when a user wants to compile a static QEMU and
  enable SDL support (i.e. ./configure --static --enable-sdl):

  pkg-config does not have an option "--static-libs". For correct
  results (to find the static archive libSDL.a) you need to use sdl-
  config --static-libs.

  =

  This is how I get it to work for me anyway:

  =

  diff --git a/configure b/configure
  index 2d62d12..3de4c9b 100755
  --- a/configure
  +++ b/configure
  @@ -1548,7 +1548,7 @@ int main( void ) { return SDL_Init (SDL_INIT_VIDEO)=
; }
   EOF
     sdl_cflags=3D`$sdlconfig --cflags 2> /dev/null`
     if test "$static" =3D "yes" ; then
  -    sdl_libs=3D`$sdlconfig --static-libs 2>/dev/null`
  +    sdl_libs=3D`${SDL_CONFIG-${cross_prefix}sdl-config} --static-libs`
     else
       sdl_libs=3D`$sdlconfig --libs 2> /dev/null`
     fi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/984516/+subscriptions
