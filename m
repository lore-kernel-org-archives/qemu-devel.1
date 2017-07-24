Received: from eggs.gnu.org ([2001:4830:134:3::10]:45581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZcWB-0005ZJ-M9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZcW6-0002Xa-Oc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:31:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:51856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dZcW6-0002XM-Ih
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:31:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dZcW4-0005sX-Vw
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:31:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4A9432E823B
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:31:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jul 2017 12:20:45 -0000
From: Victor Tapia <victor.tapia@canonical.com>
Reply-To: Bug 1706058 <1706058@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150089884536.6327.14466730634235428413.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1706058] [NEW] Windows VM crashes when restoring
 from file if balloon stats polling is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

[Impact]

=C2=A0* Windows VMs BSOD when restoring from QEMUfile or during live migrat=
ion if the virtio balloon stats polling is enabled.
 * Affected version: 1:2.5+dfsg-5ubuntu10.14 (xenial)

[Test Case]

=C2=A0* Install a Windows VM with virtio balloon drivers
=C2=A0* Start the VM and enable stats polling [1]
=C2=A0* Save the VM to savefile [2]
=C2=A0* Restore the VM [3]
=C2=A0* Enable stats polling [1] and VM will BSOD

QMP examples:
=C2=A0[1] {"execute":"qom-set","arguments":{"path":"//machine/i440fx/pci.0/=
child[7]","property":"guest-stats-polling-interval","value":10}}
=C2=A0[2] {"execute": "migrate", "arguments": {"uri":"exec:gzip -c > /stora=
ge/cases/VM/savefiles/testVM3save.gz"}}
=C2=A0[3] {"execute":"migrate-incoming","arguments":{"uri":"exec:gzip -c -d=
 /storage/cases/VM/savefiles/testVM3save.gz"}}

[Other Info]

=C2=A0* This has been fixed upstream with commit
4a1e48becab81020adfb74b22c76a595f2d02a01

[Regression Potential]

=C2=A0*

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: sts

** Description changed:

  [Impact]
  =

-  * Windows VMs BSOD when restoring from QEMUfile or during live
- migration if the virtio balloon stats polling is enabled.
+ =C2=A0* Windows VMs BSOD when restoring from QEMUfile or during live migr=
ation if the virtio balloon stats polling is enabled.
+  * Affected version: 1:2.5+dfsg-5ubuntu10.14 (xenial)
  =

  [Test Case]
  =

-  * Install a Windows VM with virtio balloon drivers
-  * Start the VM and enable stats polling [1]   =

-  * Save the VM to savefile [2]
-  * Restore the VM [3] =

-  * Enable stats polling [1] and VM will BSOD =

+ =C2=A0* Install a Windows VM with virtio balloon drivers
+ =C2=A0* Start the VM and enable stats polling [1]
+ =C2=A0* Save the VM to savefile [2]
+ =C2=A0* Restore the VM [3]
+ =C2=A0* Enable stats polling [1] and VM will BSOD
  =

  QMP examples:
-  [1] {"execute":"qom-set","arguments":{"path":"//machine/i440fx/pci.0/chi=
ld[7]","property":"guest-stats-polling-interval","value":10}} =

-  [2] {"execute": "migrate", "arguments": {"uri":"exec:gzip -c > /storage/=
cases/VM/savefiles/testVM3save.gz"}}
-  [3] {"execute":"migrate-incoming","arguments":{"uri":"exec:gzip -c -d /s=
torage/cases/VM/savefiles/testVM3save.gz"}}
+ =C2=A0[1] {"execute":"qom-set","arguments":{"path":"//machine/i440fx/pci.=
0/child[7]","property":"guest-stats-polling-interval","value":10}}
+ =C2=A0[2] {"execute": "migrate", "arguments": {"uri":"exec:gzip -c > /sto=
rage/cases/VM/savefiles/testVM3save.gz"}}
+ =C2=A0[3] {"execute":"migrate-incoming","arguments":{"uri":"exec:gzip -c =
-d /storage/cases/VM/savefiles/testVM3save.gz"}}
  =

  [Other Info]
  =

-  * This has been fixed upstream with commit
+ =C2=A0* This has been fixed upstream with commit
  4a1e48becab81020adfb74b22c76a595f2d02a01
  =

  [Regression Potential]
  =

-  *
+ =C2=A0*

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1706058

Title:
  Windows VM crashes when restoring from file if balloon stats polling
  is enabled

Status in QEMU:
  New

Bug description:
  [Impact]

  =C2=A0* Windows VMs BSOD when restoring from QEMUfile or during live migr=
ation if the virtio balloon stats polling is enabled.
   * Affected version: 1:2.5+dfsg-5ubuntu10.14 (xenial)

  [Test Case]

  =C2=A0* Install a Windows VM with virtio balloon drivers
  =C2=A0* Start the VM and enable stats polling [1]
  =C2=A0* Save the VM to savefile [2]
  =C2=A0* Restore the VM [3]
  =C2=A0* Enable stats polling [1] and VM will BSOD

  QMP examples:
  =C2=A0[1] {"execute":"qom-set","arguments":{"path":"//machine/i440fx/pci.=
0/child[7]","property":"guest-stats-polling-interval","value":10}}
  =C2=A0[2] {"execute": "migrate", "arguments": {"uri":"exec:gzip -c > /sto=
rage/cases/VM/savefiles/testVM3save.gz"}}
  =C2=A0[3] {"execute":"migrate-incoming","arguments":{"uri":"exec:gzip -c =
-d /storage/cases/VM/savefiles/testVM3save.gz"}}

  [Other Info]

  =C2=A0* This has been fixed upstream with commit
  4a1e48becab81020adfb74b22c76a595f2d02a01

  [Regression Potential]

  =C2=A0*

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1706058/+subscriptions
