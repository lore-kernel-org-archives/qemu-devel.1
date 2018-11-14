Received: from eggs.gnu.org ([2001:4830:134:3::10]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMjj1-0004MC-Sc
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMjYq-00071N-Bm
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:01:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:41434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gMjYm-0006yr-9B
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:01:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gMjYh-0000RL-By
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 01:01:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0CCA62E807D
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 01:01:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Nov 2018 00:45:33 -0000
From: Dan Midthun <dan.midthun@gmail.com>
Reply-To: Bug 1802150 <1802150@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154161401577.19796.10798182190360171804.malonedeb@gac.canonical.com>
	<154204719764.2327.17412754718199087172.malone@soybean.canonical.com>
Message-Id: <2c18403c-40c0-d0d6-3881-d73b08c4dc62@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1802150] Re: Guest undefined when destroyed
 on host after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The logs for the VM that gets undefined are no longer available.


Thanks,
 =C2=A0 Dan


On 11/12/2018 01:26 PM, Dr. David Alan Gilbert wrote:
> Also, can you please include the libvirt logs for the VM, they're
> typically in /var/log/libvirt/VMNAME.log
>

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
