Received: from eggs.gnu.org ([2001:4830:134:3::10]:40914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frhh2-0000PE-M3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frhgz-0004rw-Co
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:45:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:55984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1frhgz-0004r7-1C
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:45:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1frhgx-0000pP-JD
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:45:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 908802E851B
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:45:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Aug 2018 10:25:52 -0000
From: Thomas Huth <1484990@bugs.launchpad.net>
Reply-To: Bug 1484990 <1484990@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814145418.19376.19961.malonedeb@wampee.canonical.com>
Message-Id: <153476075227.5281.6810513404125401525.malone@chaenomeles.canonical.com>
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

Christian, what happened to the upstream patch? Looks like it never got
included? Could you please poke the maintainer, so we could finally
close this bug for upstream, too?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1484990

Title:
  fsfreeze-hook script should also ignored dpkg generated files

Status in QEMU:
  New
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
