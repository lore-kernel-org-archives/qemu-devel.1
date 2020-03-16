Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9CA206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpcSv0JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9CA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxLV-00080Z-H5
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH1-0002RZ-Ls
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGz-0000KI-L1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxGz-0000HK-Ed
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6e+v+OManYXqofQhTvrc5JkW78lq45Eovz+D7iEwTw=;
 b=IpcSv0JReTuIuakAcADL/UroQBfmiY563rT5EsPQVhNxxf4JxEuALne8627ZHo7anAXh+h
 wnMvcEQvw3hW1g+JnexsltJxlNpXsktHhY8flrnJlKy23dW3AAeqgahi26QPOOlDJ3SVio
 deKWOiEt990ANQjXYANBYKtYZaelZ28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Jmgh-_2sNYiq0Giz2aVmzQ-1; Mon, 16 Mar 2020 17:27:41 -0400
X-MC-Unique: Jmgh-_2sNYiq0Giz2aVmzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3359149C0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:27:39 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEA5519488;
 Mon, 16 Mar 2020 21:27:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/61] misc: Replace zero-length arrays with flexible array
 member (manual)
Date: Mon, 16 Mar 2020 22:26:31 +0100
Message-Id: <1584394048-44994-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Description copied from Linux kernel commit from Gustavo A. R. Silva
(see [3]):

--v-- description start --v--

  The current codebase makes use of the zero-length array language
  extension to the C90 standard, but the preferred mechanism to
  declare variable-length types such as these ones is a flexible
  array member [1], introduced in C99:

  struct foo {
      int stuff;
      struct boo array[];
  };

  By making use of the mechanism above, we will get a compiler
  warning in case the flexible array does not occur last in the
  structure, which will help us prevent some kind of undefined
  behavior bugs from being unadvertenly introduced [2] to the
  Linux codebase from now on.

--^-- description end --^--

Do the similar housekeeping in the QEMU codebase (which uses
C99 since commit 7be41675f7cb).

All these instances of code were found with the help of the
following command (then manual analysis, without modifying
structures only having a single flexible array member, such
QEDTable in block/qed.h):

  git grep -F '[0];'

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D76497732932f
[3] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/co=
mmit/?id=3D17642a2fbd2c1

Inspired-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vmdk.c                      | 2 +-
 docs/interop/vhost-user.rst       | 4 ++--
 hw/char/sclpconsole-lm.c          | 2 +-
 hw/char/sclpconsole.c             | 2 +-
 hw/s390x/virtio-ccw.c             | 2 +-
 include/hw/acpi/acpi-defs.h       | 4 ++--
 include/hw/boards.h               | 2 +-
 include/hw/s390x/event-facility.h | 2 +-
 include/hw/s390x/sclp.h           | 8 ++++----
 target/s390x/ioinst.c             | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d..8466051 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -187,7 +187,7 @@ typedef struct VmdkMetaData {
 typedef struct VmdkGrainMarker {
     uint64_t lba;
     uint32_t size;
-    uint8_t  data[0];
+    uint8_t  data[];
 } QEMU_PACKED VmdkGrainMarker;
=20
 enum {
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 4016523..3b1b660 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -568,7 +568,7 @@ For split virtqueue, queue region can be implemented as=
:
       uint16_t used_idx;
=20
       /* Used to track the state of each descriptor in descriptor table */
-      DescStateSplit desc[0];
+      DescStateSplit desc[];
   } QueueRegionSplit;
=20
 To track inflight I/O, the queue region should be processed as follows:
@@ -690,7 +690,7 @@ For packed virtqueue, queue region can be implemented a=
s:
       uint8_t padding[7];
=20
       /* Used to track the state of each descriptor fetched from descripto=
r ring */
-      DescStatePacked desc[0];
+      DescStatePacked desc[];
   } QueueRegionPacked;
=20
 To track inflight I/O, the queue region should be processed as follows:
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c420dc0..2b5f37b 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -31,7 +31,7 @@
 typedef struct OprtnsCommand {
     EventBufferHeader header;
     MDMSU message_unit;
-    char data[0];
+    char data[];
 } QEMU_PACKED OprtnsCommand;
=20
 /* max size for line-mode data in 4K SCCB page */
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 1fa124d..5c76649 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -25,7 +25,7 @@
=20
 typedef struct ASCIIConsoleData {
     EventBufferHeader ebh;
-    char data[0];
+    char data[];
 } QEMU_PACKED ASCIIConsoleData;
=20
 /* max size for ASCII data in 4K SCCB page */
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 50cf95b..64f928f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -193,7 +193,7 @@ typedef struct VirtioThinintInfo {
 typedef struct VirtioRevInfo {
     uint16_t revision;
     uint16_t length;
-    uint8_t data[0];
+    uint8_t data[];
 } QEMU_PACKED VirtioRevInfo;
=20
 /* Specify where the virtqueues for the subchannel are in guest memory. */
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 19f7ba7..c13327f 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -152,7 +152,7 @@ typedef struct AcpiSerialPortConsoleRedirection
  */
 struct AcpiRsdtDescriptorRev1 {
     ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
-    uint32_t table_offset_entry[0];  /* Array of pointers to other */
+    uint32_t table_offset_entry[];  /* Array of pointers to other */
     /* ACPI tables */
 } QEMU_PACKED;
 typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
@@ -162,7 +162,7 @@ typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescripto=
rRev1;
  */
 struct AcpiXsdtDescriptorRev2 {
     ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
-    uint64_t table_offset_entry[0];  /* Array of pointers to other */
+    uint64_t table_offset_entry[];  /* Array of pointers to other */
     /* ACPI tables */
 } QEMU_PACKED;
 typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9bc42df..c96120d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -71,7 +71,7 @@ typedef struct CPUArchId {
  */
 typedef struct {
     int len;
-    CPUArchId cpus[0];
+    CPUArchId cpus[];
 } CPUArchIdList;
=20
 /**
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-fac=
ility.h
index bdc32a3..700a610 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -122,7 +122,7 @@ typedef struct MDBO {
=20
 typedef struct MDB {
     MdbHeader header;
-    MDBO mdbo[0];
+    MDBO mdbo[];
 } QEMU_PACKED MDB;
=20
 typedef struct SclpMsg {
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index c54413b..cd7b243 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -132,7 +132,7 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
-    struct CPUEntry entries[0];
+    struct CPUEntry entries[];
 } QEMU_PACKED ReadInfo;
=20
 typedef struct ReadCpuInfo {
@@ -142,7 +142,7 @@ typedef struct ReadCpuInfo {
     uint16_t nr_standby;            /* 12-13 */
     uint16_t offset_standby;        /* 14-15 */
     uint8_t reserved0[24-16];       /* 16-23 */
-    struct CPUEntry entries[0];
+    struct CPUEntry entries[];
 } QEMU_PACKED ReadCpuInfo;
=20
 typedef struct ReadStorageElementInfo {
@@ -151,7 +151,7 @@ typedef struct ReadStorageElementInfo {
     uint16_t assigned;
     uint16_t standby;
     uint8_t _reserved0[16 - 14]; /* 14-15 */
-    uint32_t entries[0];
+    uint32_t entries[];
 } QEMU_PACKED ReadStorageElementInfo;
=20
 typedef struct AttachStorageElement {
@@ -159,7 +159,7 @@ typedef struct AttachStorageElement {
     uint8_t _reserved0[10 - 8];  /* 8-9 */
     uint16_t assigned;
     uint8_t _reserved1[16 - 12]; /* 12-15 */
-    uint32_t entries[0];
+    uint32_t entries[];
 } QEMU_PACKED AttachStorageElement;
=20
 typedef struct AssignStorage {
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d..0e840cc 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -347,7 +347,7 @@ typedef struct ChscResp {
     uint16_t len;
     uint16_t code;
     uint32_t param;
-    char data[0];
+    char data[];
 } QEMU_PACKED ChscResp;
=20
 #define CHSC_MIN_RESP_LEN 0x0008
--=20
1.8.3.1



