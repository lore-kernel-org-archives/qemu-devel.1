Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSiux-0001Fu-0m
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSiut-0005Fd-Qo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:00:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSiut-0005Dt-I2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSius-0003U4-AK
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4A3052E80CC
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Jun 2018 12:48:21 -0000
From: guysoft <guysoft@gmail.com>
Reply-To: Bug 1776478 <1776478@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152880770129.26761.1762643804065210181.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776478] [NEW] Getting qemu: uncaught target
 signal 6 when running lv2 plugin cross-compilation
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

Hey,
I am part of the Zynthian team and we use qemu-arm-static to cross compile =
lv2 audio plugins.

When running a compilation of DISTRHO-Ports we get:

lv2_ttl_generator: pthread_mutex_lock.c:81: __pthread_mutex_lock: Assertion=
 `mutex->__data.__owner =3D=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
./scripts/generate-ttl.sh: line 27: 16524 Aborted                 $GEN ./$F=
ILE
Makefile:62: recipe for target 'gen_lv2' failed
make[1]: *** [gen_lv2] Error 134
make[1]: Leaving directory '/home/pi/zynthian-sw/plugins/DISTRHO-Ports'
Makefile:104: recipe for target 'lv2' failed
make: *** [lv2] Error 2


lv2_ttl_generator source is here:
https://github.com/DISTRHO/DISTRHO-Ports/tree/master/libs/lv2-ttl-generator

The command that is ruining is
lv2_ttl_generator ./TAL-Filter-2.so =


And ./TAL-Filter-2.so source is here:
https://github.com/DISTRHO/DISTRHO-Ports/tree/master/ports/tal-filter-2/sou=
rce


Is there a way to debug what is going on?
This runs fine on a Raspberrypi which is armv7

A workaround would also help.


Bug in Zynthian:
https://github.com/zynthian/zynthian-sys/issues/59
Bug in DISTRHO-Ports:
https://github.com/DISTRHO/DISTRHO-Ports/issues/29

Using qemu-arm-static version from master from two days ago:
qemu-arm version 2.12.50 (v2.12.0-1182-ga7a7309ca5-dirty), commit: a7a7309c=
a52c327c6603d60db90ae4feeae719f7

Also saw this in qemu-arm version 2.12.0 (Debian 1:2.12+dfsg-3)

Thanks,
Guy

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- Getting qemu: uncaught target signal 6 when running     Work in Progress =
in Malpelo No milestone Notifications  You=E2=80=99re receiving notificatio=
ns because you commented. 2 participants @jofemodo @guysoft Lock conversati=
on @jofemodo Member jofemodo commented 5 days ago  It fails in the automate=
d building process but it works perfectly when executed from command line i=
n a RBPi with the latest ZynthianOS image. You can see the error in the Jen=
kins parsed console output. It remains the last 2 warnings in the list ;-) =
 lv2_ttl_generator: pthread_mutex_lock.c:81: __pthread_mutex_lock: Assertio=
n `mutex->__data.__owner =3D=3D 0' failed
+ Getting qemu: uncaught target signal 6 when running  lv2 plugin cross-com=
pilation

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776478

Title:
  Getting qemu: uncaught target signal 6 when running  lv2 plugin cross-
  compilation

Status in QEMU:
  New

Bug description:
  Hey,
  I am part of the Zynthian team and we use qemu-arm-static to cross compil=
e lv2 audio plugins.

  When running a compilation of DISTRHO-Ports we get:

  lv2_ttl_generator: pthread_mutex_lock.c:81: __pthread_mutex_lock: Asserti=
on `mutex->__data.__owner =3D=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  ./scripts/generate-ttl.sh: line 27: 16524 Aborted                 $GEN ./=
$FILE
  Makefile:62: recipe for target 'gen_lv2' failed
  make[1]: *** [gen_lv2] Error 134
  make[1]: Leaving directory '/home/pi/zynthian-sw/plugins/DISTRHO-Ports'
  Makefile:104: recipe for target 'lv2' failed
  make: *** [lv2] Error 2

  =

  lv2_ttl_generator source is here:
  https://github.com/DISTRHO/DISTRHO-Ports/tree/master/libs/lv2-ttl-generat=
or

  The command that is ruining is
  lv2_ttl_generator ./TAL-Filter-2.so =


  And ./TAL-Filter-2.so source is here:
  https://github.com/DISTRHO/DISTRHO-Ports/tree/master/ports/tal-filter-2/s=
ource


  Is there a way to debug what is going on?
  This runs fine on a Raspberrypi which is armv7

  A workaround would also help.

  =

  Bug in Zynthian:
  https://github.com/zynthian/zynthian-sys/issues/59
  Bug in DISTRHO-Ports:
  https://github.com/DISTRHO/DISTRHO-Ports/issues/29

  Using qemu-arm-static version from master from two days ago:
  qemu-arm version 2.12.50 (v2.12.0-1182-ga7a7309ca5-dirty), commit: a7a730=
9ca52c327c6603d60db90ae4feeae719f7

  Also saw this in qemu-arm version 2.12.0 (Debian 1:2.12+dfsg-3)

  Thanks,
  Guy

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776478/+subscriptions
