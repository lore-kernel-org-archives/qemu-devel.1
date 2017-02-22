Received: from eggs.gnu.org ([2001:4830:134:3::10]:38485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thagrasshoppa@gmail.com>) id 1cge7a-0002wz-4J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thagrasshoppa@gmail.com>) id 1cge7Y-0004IM-MH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:06:46 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:38015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thagrasshoppa@gmail.com>)
	id 1cge7Y-0004Hh-GG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:06:44 -0500
Received: by mail-it0-x22e.google.com with SMTP id y135so13982132itc.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:06:42 -0800 (PST)
MIME-Version: 1.0
From: Tim Cusack <thagrasshoppa@gmail.com>
Date: Wed, 22 Feb 2017 15:06:41 -0600
Message-ID: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Question regarding Snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have a scenario that perhaps not many have attempted, but I still hope
that it is possible.

Scenario:

I would like to have a Base Windows 7 VM in KVM/QEMU.

I would follow the following process (confirmed it works)

1. Shutdown running domain
- virsh shutdown <Domain>
2. Remove existing disk from Domain XML:
- virt-xml BASE --remove-device --disk target=hda
3. Add Correct Disk image for Snapshot to Domain XML:
- virt-xml BASE --add-device --disk
/var/lib/libvirt/images/BASE.qcow2,format=qcow2,target=hda,bus=ide
4. Create the snapshot with description
- virsh snapshot-create-as BASE <Model>.qcow2 "OEM, Model" --disk-only
--atomic
5. Start Snapshot
- virsh start FA2BASE

All that works, but my question and issue is this:

Can you make a snapshot, then go back to the base and ignore that snapshot
like a closed branch, make another snapshot, and then go back and forth
from each to each?

My reasons for needing this are that I have tools and software that doesnt
play nice together, and would like to keep them separated on different
snapshots, but never really need to have more than one up at a time.

This would allow me to have only 1 windows license per computer, and the
ability to just change from tool to tool with simple front end to virsh to
remove the disk from the .xml and add the other one.

So like this:
Tool A is on snapshot A
Tool B is on snapshot B
go through steps 1-5 above to go back and forth.

I know that I can not merge things back into the base, but I really don't
need to do that, in fact, I can throw away the tool snapshots when new
tools come out, by making new snapshots from the base when new tools come
out.

We have done this already, but we had an issue where the ability to write
to the snapshots seemed to stop.

Reason unknown, everything worked one day and next could not write to any
snapshot, but could still load the base and work on it fine.

This might be the wrong mailing list to post to, if so, could anyone point
out a more appropriate one?

Tim
