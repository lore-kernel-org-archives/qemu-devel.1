Received: from eggs.gnu.org ([209.51.188.92]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gulCN-0001d4-DE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 16:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gulCL-0005H2-G9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 16:39:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:59810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gulCL-0005GJ-9D
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 16:39:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gukpe-0003eY-0W
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 21:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 018BA2E8031
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 21:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Feb 2019 21:03:54 -0000
From: Larry Dewey <larry.j.dewey@gmail.com>
Reply-To: Bug 1816189 <1816189@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155026463486.6528.17912471655076346086.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1816189] [NEW] Unable to create or revert
 snapshots
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

With an update to Qemu (3.1.x) I am unable to revert snapshots using
virt-manager or virsh. Virtual Machines existing before the update seem
to function properly. It is only after creating a new machine that
snapshots are misbehaving. I tested spinning up vms of tumbleweed,
leap15, and ubuntu 18.04. Each of them had the following issues:

- With the machine running, live reversions act like they apply, but no cha=
nges are actually made.
- With the machine paused, reversion also does not apply.
- With the machine turned off, reversion is not possible. Virsh is unable t=
o find the snapshot, and virt-manager errors out with:

Error running snapshot 'FreshInstall': internal error: qemu unexpectedly
closed the monitor: 2019-01-15T19:19:46.020247Z qemu-system-x86_64:
Device 'drive-virtio-disk0' does not have the requested snapshot
'FreshInstall'

Traceback (most recent call last):
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_wr=
apper
    callback(asyncjob, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tmpcb
    callback(*args, **kwargs)
  File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 66, in =
newfn
    ret =3D fn(self, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/domain.py", line 1105, in rever=
t_to_snapshot
    self._backend.revertToSnapshot(snap.get_backend())
  File "/usr/lib64/python3.6/site-packages/libvirt.py", line 2024, in rever=
tToSnapshot
    if ret =3D=3D -1: raise libvirtError ('virDomainRevertToSnapshot() fail=
ed', dom=3Dself)

libvirt.libvirtError: internal error: qemu unexpectedly closed the
monitor: 2019-01-15T19:19:46.020247Z qemu-system-x86_64: Device 'drive-
virtio-disk0' does not have the requested snapshot 'FreshInstall'

After doing some digging, the error occurs because of the following commit:
d98f26073bebddcd3da0ba1b86c3a34e840c0fb8

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: nest nested nested-virt nesting qemu snap snapshots virtulazation

** Attachment added: "qemu-debug-logs"
   https://bugs.launchpad.net/bugs/1816189/+attachment/5238920/+files/snaps=
hot-specific-debug-output.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816189

Title:
  Unable to create or revert snapshots

Status in QEMU:
  New

Bug description:
  With an update to Qemu (3.1.x) I am unable to revert snapshots using
  virt-manager or virsh. Virtual Machines existing before the update
  seem to function properly. It is only after creating a new machine
  that snapshots are misbehaving. I tested spinning up vms of
  tumbleweed, leap15, and ubuntu 18.04. Each of them had the following
  issues:

  - With the machine running, live reversions act like they apply, but no c=
hanges are actually made.
  - With the machine paused, reversion also does not apply.
  - With the machine turned off, reversion is not possible. Virsh is unable=
 to find the snapshot, and virt-manager errors out with:

  Error running snapshot 'FreshInstall': internal error: qemu
  unexpectedly closed the monitor: 2019-01-15T19:19:46.020247Z qemu-
  system-x86_64: Device 'drive-virtio-disk0' does not have the requested
  snapshot 'FreshInstall'

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 66, i=
n newfn
      ret =3D fn(self, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/domain.py", line 1105, in rev=
ert_to_snapshot
      self._backend.revertToSnapshot(snap.get_backend())
    File "/usr/lib64/python3.6/site-packages/libvirt.py", line 2024, in rev=
ertToSnapshot
      if ret =3D=3D -1: raise libvirtError ('virDomainRevertToSnapshot() fa=
iled', dom=3Dself)

  libvirt.libvirtError: internal error: qemu unexpectedly closed the
  monitor: 2019-01-15T19:19:46.020247Z qemu-system-x86_64: Device
  'drive-virtio-disk0' does not have the requested snapshot
  'FreshInstall'

  After doing some digging, the error occurs because of the following commi=
t:
  d98f26073bebddcd3da0ba1b86c3a34e840c0fb8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816189/+subscriptions
