Received: from eggs.gnu.org ([2001:4830:134:3::10]:36380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd36-0002DF-Bk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd33-0000RD-9Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:48 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYd33-0000Oz-2A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:45 -0400
Received: by mail-wm0-x242.google.com with SMTP id b188-v6so4880117wme.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:57:44 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	d102-v6sm12516646wma.10.2018.06.28.12.57.42
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 12:57:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 21:57:32 +0200
Message-Id: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] pr-manager/qemu-pr-helper patches for
 QEMU 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first three patches are more or less trivial bugfixes.  The
last three allow libvirt to know the status of the qemu-pr-helper
process that is attached to a running QEMU instance.

Thanks,

Paolo

v1->v2: new patch for non-Linux portability
	issue event as soon as the socket is disconnected
	do not include full object path in event
	renamed "is_connected" field to "connected"

Paolo Bonzini (6):
  pr-helper: fix --socket-path default in help
  pr-helper: fix assertion failure on failed multipath PERSISTENT
    RESERVE IN
  pr-manager-helper: avoid SIGSEGV when writing to the socket fail
  pr-manager: put stubs in .c file
  pr-manager: add query-pr-managers QMP command
  pr-manager-helper: report event on connection/disconnection

 include/scsi/pr-manager.h | 11 ++--------
 qapi/block.json           | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 scsi/Makefile.objs        |  1 +
 scsi/pr-manager-helper.c  | 28 +++++++++++++++++++++++++
 scsi/pr-manager-stub.c    | 30 +++++++++++++++++++++++++++
 scsi/pr-manager.c         | 45 ++++++++++++++++++++++++++++++++++++++++
 scsi/qemu-pr-helper.c     | 21 +++++++++++--------
 7 files changed, 171 insertions(+), 17 deletions(-)
 create mode 100644 scsi/pr-manager-stub.c

-- 
1.8.3.1
