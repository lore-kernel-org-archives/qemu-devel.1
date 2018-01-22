Received: from eggs.gnu.org ([2001:4830:134:3::10]:37846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edWZ7-00009D-Pq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edWZ3-0007q9-Ua
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:44954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1edWZ3-0007pg-P0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1edWZ2-0007Vz-M4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A3D502E854B
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2018 07:19:05 -0000
From: Changpeng Liu <1744654@bugs.launchpad.net>
Reply-To: Bug 1744654 <1744654@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151660554545.11051.313938910819247555.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1744654] [NEW] commit: 4fe6d78 "virtio: postpone
 the execution of event_notifier_cleanup function" will cause vhost-user
 device crash
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

The new commit: 4fe6d78 break the existing vhost-user devices, such as
vhost-user-scsi/blk and vhost-vsocks when exit the host driver,
kvm_io_ioeventfd_del will hit the abort().

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: vhost-user virtio

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1744654

Title:
  commit: 4fe6d78 "virtio: postpone the execution of
  event_notifier_cleanup function" will cause vhost-user device crash

Status in QEMU:
  New

Bug description:
  The new commit: 4fe6d78 break the existing vhost-user devices, such as
  vhost-user-scsi/blk and vhost-vsocks when exit the host driver,
  kvm_io_ioeventfd_del will hit the abort().

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1744654/+subscriptions
