Received: from eggs.gnu.org ([2001:4830:134:3::10]:60453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP456-00023x-Dg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP451-0005z3-Hr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:16:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eP451-0005xn-BW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:15:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eP450-000890-Cm
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:15:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B23F2E80C9
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:15:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2017 10:00:18 -0000
From: ChristianEhrhardt <1484990@bugs.launchpad.net>
Reply-To: Bug 1484990 <1484990@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814145418.19376.19961.malonedeb@wampee.canonical.com>
Message-Id: <151315921877.3246.7911403173870689641.malone@gac.canonical.com>
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

(late) Hi,
You are right Laurent, IMHO they should be added.
Not very critical since as of today there are no conffiles in there yet, bu=
t still right to do so.

Adding an Ubutu task to include the fix and actually also the script to
better support the freeze/thaw operations.

** Also affects: qemu (Ubuntu)
   Importance: Undecided
       Status: New

** Tags added: qemu-18.04

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1484990

Title:
  fsfreeze-hook script should also ignored dpkg generated files

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

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
