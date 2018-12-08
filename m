Received: from eggs.gnu.org ([2001:4830:134:3::10]:48727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gVhkt-0006k8-Bk
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 13:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gVhkl-0001Be-D1
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 13:55:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:39708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gVhkj-00019M-Be
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 13:55:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gVhke-0007Pn-Jm
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 18:54:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B2B62E8084
	for <qemu-devel@nongnu.org>; Sat,  8 Dec 2018 18:54:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Dec 2018 18:43:32 -0000
From: "Mark A. Hershberger" <mah@everybody.org>
Reply-To: Bug 1174654 <1174654@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130430080722.32341.54160.malonedeb@gac.canonical.com>
Message-Id: <154429461298.889.622814861831968708.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1174654] Re: qemu-system-x86_64 takes 100% CPU
 after host machine resumed from suspend to ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was seeing this problem when my Debian laptop suspended.  The CentOS
guest would begin consuming a lot of cpu and only a hard-reset would fix
it.

Changing the rtc line to

      <timer name=3D'rtc' track=3D'guest'/>

seems to have fixed it, though I haven't done extensive testing yet.

Thanks!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1174654

Title:
  qemu-system-x86_64 takes 100% CPU after host machine resumed from
  suspend to ram

Status in QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  I have Windows XP SP3  inside qemu VM. All works fine in 12.10. But
  after upgraiding to 13.04 i have to restart the VM each time i
  resuming my host machine, because qemu process starts to take CPU
  cycles and OS inside VM is very slow and sluggish. However it's still
  controllable and could be shutdown by itself.

  According to the taskmgr any active process takes 99% CPU. It's not
  stuck on some single process.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1174654/+subscriptions
