Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciets-0003Yn-GL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cietn-0004JV-Ik
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:20:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:42695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cietn-0004JA-CM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:20:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cietl-0007UC-KK
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E7FE2E80E1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Feb 2017 10:09:37 -0000
From: Michael Klopf <1668556@bugs.launchpad.net>
Reply-To: Bug 1668556 <1668556@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170228100937.7789.7367.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1668556] [NEW] QEMU Guest Agent service fails to
 start on Windows 10 RS2 preview
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

The "QEMU Guest Agent" service cannot be started on Windows 10 RS2
preview build. After starting the service this error message is
displayed: "Windows could not start QEMU Guest Agent service on Local
Computer. Error 1053: The service did not respond to the start or
control request in a timely fashion."

Output from the Windows System event log:
<?xml version=3D"1.0" encoding=3D"utf-8" standalone=3D"yes"?>
<Events><Event xmlns=3D'http://schemas.microsoft.com/win/2004/08/events/eve=
nt'><System><Provider Name=3D'Service Control Manager' Guid=3D'{555908d1-a6=
d7-4695-8e1e-26931d2012f4}' EventSourceName=3D'Service Control Manager'/><E=
ventID Qualifiers=3D'49152'>7009</EventID><Version>0</Version><Level>2</Lev=
el><Task>0</Task><Opcode>0</Opcode><Keywords>0x8080000000000000</Keywords><=
TimeCreated SystemTime=3D'2017-02-28T09:39:35.713939500Z'/><EventRecordID>1=
406</EventRecordID><Correlation/><Execution ProcessID=3D'568' ThreadID=3D'9=
64'/><Channel>System</Channel><Computer>LT-WIN10-64</Computer><Security/></=
System><EventData><Data Name=3D'param1'>30000</Data><Data Name=3D'param2'>Q=
EMU Guest Agent</Data><Binary>510045004D0055002D00470041000000</Binary></Ev=
entData></Event></Events>

The "QEMU Guest Agent VSS Provider" service is running successfully.

It worked on Windows 10 RS1 (before the upgrade).

QEMU Guest Agent version:
Installed from virtio-win-0.1.126_amd64
which was built from master branch with latest commit (8aaf403) - https://g=
ithub.com/virtio-win/kvm-guest-drivers-windows =


Windows version (upgraded from RS1):
Windows 10 Enterprise Insider Preview
Evaluation copy. Build 15019.rs_prerelease.170121-1513

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: guestagent win10rs2preview

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668556

Title:
  QEMU Guest Agent  service fails to start on Windows 10 RS2 preview

Status in QEMU:
  New

Bug description:
  The "QEMU Guest Agent" service cannot be started on Windows 10 RS2
  preview build. After starting the service this error message is
  displayed: "Windows could not start QEMU Guest Agent service on Local
  Computer. Error 1053: The service did not respond to the start or
  control request in a timely fashion."

  Output from the Windows System event log:
  <?xml version=3D"1.0" encoding=3D"utf-8" standalone=3D"yes"?>
  <Events><Event xmlns=3D'http://schemas.microsoft.com/win/2004/08/events/e=
vent'><System><Provider Name=3D'Service Control Manager' Guid=3D'{555908d1-=
a6d7-4695-8e1e-26931d2012f4}' EventSourceName=3D'Service Control Manager'/>=
<EventID Qualifiers=3D'49152'>7009</EventID><Version>0</Version><Level>2</L=
evel><Task>0</Task><Opcode>0</Opcode><Keywords>0x8080000000000000</Keywords=
><TimeCreated SystemTime=3D'2017-02-28T09:39:35.713939500Z'/><EventRecordID=
>1406</EventRecordID><Correlation/><Execution ProcessID=3D'568' ThreadID=3D=
'964'/><Channel>System</Channel><Computer>LT-WIN10-64</Computer><Security/>=
</System><EventData><Data Name=3D'param1'>30000</Data><Data Name=3D'param2'=
>QEMU Guest Agent</Data><Binary>510045004D0055002D00470041000000</Binary></=
EventData></Event></Events>

  The "QEMU Guest Agent VSS Provider" service is running successfully.

  It worked on Windows 10 RS1 (before the upgrade).

  QEMU Guest Agent version:
  Installed from virtio-win-0.1.126_amd64
  which was built from master branch with latest commit (8aaf403) - https:/=
/github.com/virtio-win/kvm-guest-drivers-windows =


  Windows version (upgraded from RS1):
  Windows 10 Enterprise Insider Preview
  Evaluation copy. Build 15019.rs_prerelease.170121-1513

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668556/+subscriptions
