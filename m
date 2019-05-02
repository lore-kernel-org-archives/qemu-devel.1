Received: from eggs.gnu.org ([209.51.188.92]:34630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hM6L3-0006X7-9H
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hM6L1-0004Ee-Hb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:41:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:57444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hM6L1-0004DN-7h
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:41:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hM6Kz-0007aR-9X
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:41:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 470DF2E80C9
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 07:41:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2019 07:30:22 -0000
From: Gerd Hoffmann <1825452@bugs.launchpad.net>
Reply-To: Bug 1825452 <1825452@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155563917977.14412.17112414712610030215.malonedeb@gac.canonical.com>
Message-Id: <155678222246.13615.4633674796133228393.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825452] Re: Pulse audio backend doesn't work in
 v4.0.0-rc4 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You can use -audiodev
pa,id=3Dwhatever,server=3Dunix:/home/ivan/.pulse_server to get things going
with your configuration.

Oh, and this has nothing to do with systemd:

kraxel@gentoo ~ $ set | grep ^XDG
XDG_CONFIG_DIRS=3D/etc/xdg
XDG_DATA_DIRS=3D/usr/local/share:/usr/share
XDG_RUNTIME_DIR=3D/var/run/user/1000
XDG_SESSION_COOKIE=3Dgentoo-1556780854.41316-799155214

(gentoo with openrc + xfce, serial console login, x11 login has a few
more of these set).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825452

Title:
  Pulse audio backend doesn't work in  v4.0.0-rc4 release

Status in QEMU:
  New

Bug description:
  Using Gentoo linux, build from source: qemu v4.0.0-rc4 release
  (eeba63fc7fface36f438bcbc0d3b02e7dcb59983)

  Pulse audio backend doesn't initialize because of the:
  audio/paaudio.c:
  -    if (!popts->has_server) {
  -        char pidfile[64];
  -        char *runtime;
  -        struct stat st;
  -
  -        runtime =3D getenv("XDG_RUNTIME_DIR");
  -        if (!runtime) {
  -            return NULL;
  -        }
  -        snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
  -        if (stat(pidfile, &st) !=3D 0) {
  -            return NULL;
  -        }
  -    }
  XDG_RUNTIME_DIR is not set for me. There is no /run/user directory exist =
in my system.

  Also:
  $ less ~/.pulse/client.conf  =

  default-server =3D unix:/home/ivan/.pulse_server

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825452/+subscriptions
