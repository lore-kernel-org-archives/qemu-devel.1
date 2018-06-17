Received: from eggs.gnu.org ([2001:4830:134:3::10]:52826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fULPz-0000D2-Ia
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fULPw-0001yB-Be
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:19:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:43828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fULPw-0001xn-4k
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:19:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fULPv-0006mZ-2L
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 00:19:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0AE492E802E
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 00:19:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Jun 2018 00:06:36 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
	<ciro.santilli@gmail.com>
Reply-To: Bug 614958 <614958@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100808101945.28279.87619.malonedeb@potassium.ubuntu.com>
Message-Id: <152919399670.6742.7633438482379141163.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 614958] Re: copy-paste between client and host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Having to launch a separate `remote-viewer` command to view the desktop
is not very satisfactory for me, as you then have to think about two
processes instead of one.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/614958

Title:
  copy-paste between client and host

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I propose that copy/paste between VMs be implemented somehow directly in =
QEMU.
  This has been discussed repeatedly elsewhere; various solutions are propo=
sed.  See below.

  As it is, each user has to do their own research and testing if they
  are to find a solution.   This makes the product frustratingly
  unattractive for many.

  Most solutions involve either running vnc and using a vnc client that
  supports copy/paste (this can be tricky to find itself), or running
  some other tcp-based copy-paste application.

  For many users, the networking in a client VM is unimportant--they
  just want to run some application there, and setting up netoworking in
  a VM itself can be an issue.  Most of these solutions rely on un-
  maintained software, and some require that other software be installed
  to make them work (Basic interpreter, Java, etc).  Any of these
  solutions take some work to set up.

  I can tell you, the absence of a copy/paste mechanism makes the
  project an immediate no-go for many users.  I work with a guy who
  spent a lot of time trying, gave up, and switched to VirtualBox for
  this exact reason.

  It would be much better if copy/paste worked out of the box.  Ideally,
  it should work independently of networking.

  Cheers!

  Some discussions and proposed solutions:
  -----------------------------------------------------
  http://qemu-forum.ipi.fi/viewtopic.php?f=3D4&t=3D161
      Somebody suggests VNC into the virtual host, and use vncviewer
      Somebody else suggests TCP/IP Clipboard (text editor with tcp/ip)

  http://qemu-forum.ipi.fi/viewtopic.php?f=3D4&t=3D2626
      primitive app for sharing text across machines (in Basic)
      http://homepage.mac.com/bnej/shareclip/

  http://borderworlds.dk/blog/20070217-00.html
      Says doesn't know a good solution but points to unmaintained package
      Qemu Guest Tools
      http://wolfpackally.wo.funpic.de/qemu/qgt/

  http://bonzoli.com/docs/How_to_setup_Qemu_on_Fedora_8.html
      proposes Java remoteclip running on client and server
      http://www.cs.cmu.edu/afs/cs/user/rcm/WWW/RemoteClip/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/614958/+subscriptions
