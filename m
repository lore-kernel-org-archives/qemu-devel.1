Received: from eggs.gnu.org ([209.51.188.92]:38346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gn5ZT-0002Q6-NP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gn5ZS-0006ja-KO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:47:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 Jan 2019 18:46:50 +0100
Message-Id: <20190125174653.4604-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] scsi-disk: Device Identification fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

The vendor specific designator in the Device Identification VPD page has
two problems:

1. It defaults to the BlockBackend name (-drive id=3D...), which everyone
   expected to be a host detail that the guest never sees

2. With -blockdev based setups it defaults to an empty string; if this
   default is used with more than one disk, the guest OS will interpret
   this as a single multipath disk.

We can address problem 2 immediately, and start running the deprecation
clock for problem 1.

Related bug reports:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1669446
https://bugzilla.redhat.com/show_bug.cgi?id=3D1668248

Kevin Wolf (3):
  scsi-disk: Don't use empty string as device id
  scsi-disk: Add device_id property
  scsi-disk: Deprecate device_id fallback to BlockBackend name

 hw/scsi/scsi-disk.c  | 41 ++++++++++++++++++++++++++++-------------
 qemu-deprecated.texi | 22 +++++++++++++++++++++-
 2 files changed, 49 insertions(+), 14 deletions(-)

--=20
2.20.1
