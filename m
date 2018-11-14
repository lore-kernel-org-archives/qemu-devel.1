Received: from eggs.gnu.org ([2001:4830:134:3::10]:36986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMrR8-0003u0-7u
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMrR5-0000BR-45
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:26:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:51850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gMrR4-0000Ap-US
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:26:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gMrR3-0003Xa-En
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 09:26:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6D6572E80C8
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 09:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Nov 2018 09:19:08 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1802150 <1802150@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154161401577.19796.10798182190360171804.malonedeb@gac.canonical.com>
Message-Id: <154218714896.2711.1450615526322833749.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802150] Re: Guest undefined when destroyed on
 host after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dan:
  Rereading your description I think this might be worth discussing on the =
libvirt mailing list/bug trackers instead.
  I *think* what you're saying is the migration works fine, the only proble=
m is that after you shutdown the VM it disappears.
  My understanding (although I'm more qemu than libvirt) is that you need t=
o pass --persistent to the virsh migrate   command to get it to stick on th=
e destination.  However, I'd expected that without --persistent it would ha=
ve still existed on the source after shutdown.

  Given that big long VM name, is it being managed by some higher level
thing rather than directly?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1802150

Title:
  Guest undefined when destroyed on host after migration

Status in QEMU:
  Incomplete

Bug description:
  After a live migration, guest VMs are being undefined from the host
  they were migrated to after shutdown. I have experienced this at two
  (2) separate locations on more than one hardware configuration.  This
  happens when utilizing virt-manager to view current allocations on
  hosts, and virsh on the CLI to migrate guests.  When the guest is
  migrated from one host to another, no errors are thrown, and only lose
  1 packet from infinite ping. Shutting guest down *from* the guest OS
  results in the Guest VM being undefined on the residing host, and XML
  config lost.  If needed, I can provide a recorded session of this
  happening.

  Thanks,
    Dan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802150/+subscriptions
