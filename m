Received: from eggs.gnu.org ([2001:4830:134:3::10]:37553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMjPN-0008MB-IX
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gMjPK-0001OQ-A0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:51:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gMjPI-0001LS-3v
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:51:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gMjP4-0007aL-B8
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 00:51:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D53D32E8085
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 00:51:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Nov 2018 00:35:53 -0000
From: Dan Midthun <dan.midthun@gmail.com>
Reply-To: Bug 1802150 <1802150@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154161401577.19796.10798182190360171804.malonedeb@gac.canonical.com>
	<154161923212.28791.14123028841206239491.malone@soybean.canonical.com>
Message-Id: <64bf9a53-fd1d-6bff-080f-433290a7d096@gmail.com>
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

This was done with virsh on the cli - not through virt-manager. Virt =

manager was only used to see the visual residence of the vm. The exact =

command is below:


virsh migrate 79fdd9dd-068b-41cc-b97b-d0f9d8e9df84 --desturi =

qemu+ssh://kvmadmin@192.168.0.84/system

after migrating, shutting down the guest vm results in destruction of vm =

(undefined)


Thanks,
 =C2=A0 Dan


On 11/07/2018 02:33 PM, Thomas Huth wrote:
> This is the QEMU bug tracker here ... Can you also reproduce such an
> issue with plain QEMU? If not, could you please report this to the virt-
> manager project first? See https://virt-manager.org/bugs/#report for
> details.
>
> ** Changed in: qemu
>         Status: New =3D> Incomplete
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
