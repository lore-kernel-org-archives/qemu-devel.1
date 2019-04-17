Received: from eggs.gnu.org ([209.51.188.92]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGoci-0005KY-2S
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGocf-0006H7-KK
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGoce-0006FZ-Ap
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGocc-0004mt-0p
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 17:45:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F008A2E80C8
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 17:45:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2019 17:35:12 -0000
From: Thomas Huth <1484990@bugs.launchpad.net>
Reply-To: Bug 1484990 <1484990@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814145418.19376.19961.malonedeb@wampee.canonical.com>
Message-Id: <155552251289.13347.7563768602427723832.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1484990] Re: fsfreeze-hook script should also
 ignored dpkg generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix had been included here (in QEMU v3.1 already):
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7294e600eb814fd2

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1484990

Title:
  fsfreeze-hook script should also ignored dpkg generated files

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  Hello,

  In the fsfreeze-hook script, the following code check if some of the
  files should be ignored:

  =

  # Check whether file $1 is a backup or rpm-generated file and should be i=
gnored
  is_ignored_file() {
      case "$1" in
          *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave | *.sample)
              return 0 ;;
      esac
      return 1
  }

  The functions should probably also skip dpkg generated files.

  I've found a list of the different extensions in the systemd source
  tree:
  https://github.com/systemd/systemd/blob/master/src/basic/util.c#L1871

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1484990/+subscriptions
