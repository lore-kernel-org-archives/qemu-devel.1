Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dVuzE-0001u2-FT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dVuzB-0001HL-4n
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:26:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:38759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dVuzA-0001Gw-Un
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:26:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dVuz9-0004r3-KT
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:25:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B8522E8190
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:25:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jul 2017 07:06:43 -0000
From: Thomas Huth <984516@bugs.launchpad.net>
Reply-To: Bug 984516 <984516@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120418021847.6939.88224.malonedeb@chaenomeles.canonical.com>
Message-Id: <150001600313.15922.1813039944484652674.malone@wampee.canonical.com>
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

Finally fixed here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5f37e6d4a7b22ccf1bb8fa4

** Changed in: qemu
       Status: New =3D> Fix Committed

** Changed in: qemu
     Assignee: (unassigned) =3D> Thomas Huth (th-huth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/984516

Title:
  should use sdl-config for static build not pkg-config

Status in QEMU:
  Fix Committed

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
