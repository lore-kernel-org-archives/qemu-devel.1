Received: from eggs.gnu.org ([2001:4830:134:3::10]:57128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVlx1-0002wS-Aw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVlwx-0005fL-8m
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:14:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:36641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVlwx-0005ew-2u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:14:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVlwu-0001OI-Mb
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:14:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 74BD62E8011
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:14:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 21:00:31 -0000
From: Martin van den Nieuwelaar <martin@rawl.co.nz>
Reply-To: Bug 1253777 <1253777@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131121204609.27303.82489.malonedeb@gac.canonical.com>
	<20170123193237.14567.84429.malone@soybean.canonical.com>
Message-Id: <2ed18f1f-6fd3-5e73-8b19-ffa2b48cbcea@rawl.co.nz>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1253777] Re: OpenBSD VM running on OpenBSD
 host has sleep calls taking twice as long as they should
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I hadn't seen comment #5.  Not sure how that affects qemu.  =

Unfortunately I'm not in a position to set up a system any time soon =

with the latest versions of everything to see if the bug is still present.


On 24/01/17 08:32, Thomas Huth wrote:
> What does comment #5 mean? Is this issue now fixed with the latest
> version of QEMU?
>
> ** Changed in: qemu
>         Status: New =3D> Incomplete
>


-- =

R A Ward Ltd. | We take the privacy of our customers seriously.
Christchurch  | All sensitive E-Mail attachments MUST be encrypted.
New Zealand

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1253777

Title:
  OpenBSD VM running on OpenBSD host has sleep calls taking twice as
  long as they should

Status in QEMU:
  Incomplete

Bug description:
  Running a script like

  while [ 1 ]
  do
    date
    sleep 1
  done

  on the VM will result in the (correct) date being displayed, but it is
  displayed only every two (!) seconds.  We have also noticed that if we
  connect to the VM's console using VNC, and move the mouse pointer
  constantly in the VNC window, the script runs normally with updates
  every second!  Note that the script doesn't have to be running on the
  VM's console - it's also possible to (say) ssh to the VM from a
  separate machine and run the script and it will display the '2 second'
  issue, but as soon as you move the mouse pointer constantly in the VNC
  console window the script starts behaving normally with updates every
  second.

  I have only seen this bug when running an OpenBSD VM on an OpenBSD
  host.  Running an OpenBSD VM on a Linux host does not exhibit the
  problem for me.  I also belive (am told) that a Linux VM running on an
  OpenBSD host does not exhibit the problem.

  I have been using the OpenBSD 5.4 64 bit distro which comes with qemu
  1.5.1 in a package, however I tried compiling qemu 1.6.1 and that has
  the same bug.  In fact older OpenBSD distros have the same issue -
  going back to OpenBSD distros from two years ago still have the
  problem.  This is not a 'new' bug recently introduced.

  Initially I wondered if it could be traced to an incorrectly set
  command line option, but I've since gone through many of the options
  in the man page simply trying different values (eg. different CPU
  types ( -cpu) , different emulated PC (-M)) but so far the problem
  remains.

  I'm quite happy to run tests in order to track this bug down better.
  We use qemu running on OpenBSD extensively and find it very useful!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1253777/+subscriptions
