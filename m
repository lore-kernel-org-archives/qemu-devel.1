Received: from eggs.gnu.org ([2001:4830:134:3::10]:51639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUV5n-0003EU-DH
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUV5k-0008Kc-6w
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:11:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gUV5j-0008Jr-WB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:11:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gUV5i-00082r-FW
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:11:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 734112E80CC
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 11:11:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Dec 2018 10:58:07 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1801933 <1801933@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154151022459.20108.13605520748922076387.malonedeb@gac.canonical.com>
Message-Id: <154400748752.501.13092288076709627697.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1801933] Re: default memory parameter too small
 on x86_64 today
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: defaults

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1801933

Title:
  default memory parameter too small on x86_64 today

Status in QEMU:
  New

Bug description:
  Launching a centos74 iso VM today does not work anymore on x86_64
  without increasing the size of the memory parameter. For example with
  this command :

  $ /opt/qemu-3.0.0/bin/qemu-system-x86_64 --curses   -enable-kvm -drive
  file=3Dfile.dd,index=3D0,media=3Ddisk -drive file=3Dcentos-
  x86_64.iso,index=3D1,media=3Dcdrom

  [    3.047614] Failed to execute /init
  [    3.048315] Kernel panic - not syncing: No init found.  Try passing in=
it=3D option to kernel. See Linux Documentation/init.txt for guidance.
  [    3.049258] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-693.21.1.=
el7.x86

  Increasing the size from the default 128MiB to 512MiB let the VM works wi=
thout problem.
  So, ok, it's not a qemu problem, it's more a "User problem" and interface=
 problem for me.
  But it push me in the end to launch VirtualBox instead of qemu, because t=
he default parameter does not work anymore... And I had no time to investig=
ate why it does not work because the message is not visible.
  Debian iso with the same command line for example show a message to tell =
me that there is not enough memory, so it help me to track the real issue b=
ehind.

  But... In the end, I think today, the default memory parameter on x86_64 =
is too small and it can lead some people like me to switch to VirtualBox.
  VirtualBox, in the wizard is set by default to 4MiB Ram size, which tell =
you... Ok I need to put more. And, you know that 4MiB is not enough in the =
end.

  Regards,

  Johann

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1801933/+subscriptions
