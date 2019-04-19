Received: from eggs.gnu.org ([209.51.188.92]:49599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHJ9P-0006gm-BH
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHIuI-00054J-Nj
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:05:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hHIuI-00053v-IQ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:05:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hHIuH-00037G-B5
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 02:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4CB402E80C7
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 02:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2019 01:59:39 -0000
From: Ivan Volosyuk <1825452@bugs.launchpad.net>
Reply-To: Bug 1825452 <1825452@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155563917977.14412.17112414712610030215.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825452] [NEW] Pulse audio backend doesn't work
 in v4.0.0-rc4 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

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
XDG_RUNTIME_DIR is not set for me. There is no /run/user directory exist in=
 my system.

Also:
$ less ~/.pulse/client.conf  =

default-server =3D unix:/home/ivan/.pulse_server

** Affects: qemu
     Importance: Undecided
         Status: New

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
