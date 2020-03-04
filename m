Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2CCC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8865215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YG5bqNk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8865215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W9w-0005Ey-Sb
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W6c-0000qd-9t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W6a-0001SF-6k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W6a-0001RT-3O
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQOQfx06A1ie2SNHaflDW36So/UjUtM++P+T+HY6xSo=;
 b=YG5bqNk3HbQ/l6b7y7zLoC34+ht4ABHoOCuEuPb9tnN3NCSl09lg7TXQhomeAX/sRRsdbD
 gCgtkrHo67p3S6nr34gKS1umIgUvxXsUFJEibsy9zDU6eNZlfGmMmDp4R1AJnH1sBc/sRI
 m/QThEJDjIvUpcW2jZvkFY4+N40AzLQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-eWxUTKHuPEyIDc3ntpp9uw-1; Wed, 04 Mar 2020 10:38:36 -0500
X-MC-Unique: eWxUTKHuPEyIDc3ntpp9uw-1
Received: by mail-wr1-f72.google.com with SMTP id z16so997573wrm.15
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vKf7x2e5mJnoKBehNULn5Enxe4/hEchqUW/qpjE2MWA=;
 b=ajhIEvQrk6R/8Ekoe5+Htzcca86PHyTpn+eLxngMlX2LdZkED8tspWl1dip+BWZ0mF
 cYVLSWE18YDmVvAhvRQ25wqAfUefcVq0tlk7VvAhYOw38+42aVGhc0GAfeFciuAJ2SzH
 JqcswLp6RGdW/7NrX+JfCtLM0gi8H9jqR2ZhQ2I8af9y9YGfsFxggQXflEX+Skg0wrue
 v62sn0U7M3oEIB71IimP5H6pzSktLUclNOQNNiUWxcdZA+zRGaGQ0bHIU0GBs7J+3QAT
 tpCQ2A/zBTIjwFGL+QJe33iWPWW2XVfHJsJNNInEa/A8oKQbBwmJagSKdr2QJPk/HUuv
 XveQ==
X-Gm-Message-State: ANhLgQ0cet/FGQLfacToyNGkp9TO8CTk1j8rw3NSqJX/hX3+Dj5lNwgD
 sSH+AEe9QeuyrZCX+8GX8yjNvaHogqAvP8Pya+2sOoUIoO33mB2ytPA2z/yShLDZn3bOHolpq3c
 5WqrxeiZDC7jurzE=
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr4399086wmk.83.1583336314983; 
 Wed, 04 Mar 2020 07:38:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsDOjmgcEVIZato5ZjdUrjxEY6XPbkE1/nQkF0KQXneBlngEd6/I93J523c3XqRNIFQT8xbGA==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr4399051wmk.83.1583336314606; 
 Wed, 04 Mar 2020 07:38:34 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id e11sm38377995wrm.80.2020.03.04.07.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:38:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] misc: Replace zero-length arrays with flexible array
 member (manual)
Date: Wed,  4 Mar 2020 16:38:16 +0100
Message-Id: <20200304153816.23636-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304153816.23636-1-philmd@redhat.com>
References: <20200304153816.23636-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v2: Do not modify block/qed.h:

  block/qed.h:106:14: error: flexible array member 'offsets' not allowed in=
 otherwise empty struct
      uint64_t offsets[];             /* in bytes */
               ^
---
 docs/interop/vhost-user.rst       | 4 ++--
 include/hw/acpi/acpi-defs.h       | 4 ++--
 include/hw/boards.h               | 2 +-
 include/hw/s390x/event-facility.h | 2 +-
 include/hw/s390x/sclp.h           | 8 ++++----
 block/vmdk.c                      | 2 +-
 hw/char/sclpconsole-lm.c          | 2 +-
 hw/char/sclpconsole.c             | 2 +-
 hw/s390x/virtio-ccw.c             | 2 +-
 target/s390x/ioinst.c             | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 401652397c..3b1b6602c7 100644
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
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 19f7ba7b70..c13327fa78 100644
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
index 9bc42dfb22..c96120d15f 100644
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
index bdc32a3c09..700a610f33 100644
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
index c54413b78c..cd7b24359f 100644
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
diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d997..8466051bc9 100644
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
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c420dc066e..2b5f37b6a2 100644
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
index 1fa124dab9..5c7664905e 100644
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
index 50cf95b781..64f928fc7d 100644
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
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6..0e840cc579 100644
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
2.21.1


