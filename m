Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZYqy-0007Ex-7O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZYqt-0002he-BF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:36:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:46104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dZYqt-0002hP-5v
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:36:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dZYqs-0007VV-6r
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:36:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 206A32E80C9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:36:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jul 2017 08:24:59 -0000
From: Thomas Huth <1089005@bugs.launchpad.net>
Reply-To: Bug 1089005 <1089005@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121211164752.19821.67677.malonedeb@wampee.canonical.com>
Message-Id: <150088469973.26937.4212389504632963864.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089005] Re: Qemu does not shutdown with vnc
 enabled on OS X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rida, this bug was about stopping QEMU with CTRL-c, so I guess you tried
to do something else here? What do you mean by "running process"? The
emulated process that is running with QEMU?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1089005

Title:
  Qemu does not shutdown with vnc enabled on OS X

Status in QEMU:
  Expired

Bug description:
  I am running OS X 10.8.2 and Qemu 1.3.50 from your git repository.

  Running

      qemu-system-i386 <image>

  works fine. I can quit the process using ctrl-c.

  When I try to use

       qemu-system-i386 -vnc :<port> <image>

  ctrl-c does nothing and I have to kill the process trough the activity mo=
nitor.
  Furthermore terminating the process from my java program does not work ei=
ther. =

  I have also posted a question on Stackoverflow: http://stackoverflow.com/=
questions/13798367/qemu-does-not-shutdown-with-vnc-enabled-on-os-x

  Thanks
  Leander

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089005/+subscriptions
