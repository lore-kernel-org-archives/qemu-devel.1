Received: from eggs.gnu.org ([2001:4830:134:3::10]:54482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1friVq-0003q2-1N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1friTM-0006bA-Gh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:35:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:52744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1friTM-0006Zp-9m
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:35:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1friTI-0002zV-EL
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:35:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF1222E8535
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Aug 2018 11:16:41 -0000
From: =?utf-8?b?7oO/IENocmlzdGlhbiBFaHJoYXJkdCDug78=?=
	<1484990@bugs.launchpad.net>
Reply-To: Bug 1484990 <1484990@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814145418.19376.19961.malonedeb@wampee.canonical.com>
Message-Id: <153476380171.5127.4466633333821670043.malone@chaenomeles.canonical.com>
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

Yeah I even got help back then to make sure CCs are better but nothing happ=
ened.
Old thread: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg0214=
2.html

I re-pinged on the old thread to be reconsidered.
New Ping: http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg03892.=
html

Thanks Thomas for making me aware this was still lingering unresolved.

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
