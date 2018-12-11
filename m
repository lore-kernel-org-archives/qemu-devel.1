Received: from eggs.gnu.org ([2001:4830:134:3::10]:37629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gWkwF-0008RT-I9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gWkwB-0004qV-Cj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gWkwB-0004p4-6B
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:11 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 11 Dec 2018 17:31:03 +0100
Message-Id: <20181211163105.31834-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] scsi: Convert from DPRINTF() macro to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Convert the last two files in hw/scsi.

v2: call directly trace_scsi_disk_new_request(), don't pass
    it in the argument

Laurent Vivier (2):
  scsi-disk: Convert from DPRINTF() macro to trace events
  scsi-generic: Convert from DPRINTF() macro to trace events

 hw/scsi/scsi-disk.c    | 103 ++++++++++++++++++++---------------------
 hw/scsi/scsi-generic.c |  56 +++++++++++-----------
 hw/scsi/trace-events   |  40 ++++++++++++++++
 3 files changed, 116 insertions(+), 83 deletions(-)

--=20
2.19.2
