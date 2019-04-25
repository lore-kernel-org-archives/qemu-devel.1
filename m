Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD6C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E76212F5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E76212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeR8-0000ke-PO
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:29:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJu-0003Aa-TN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJt-0003co-IE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeJt-0003cR-9x; Thu, 25 Apr 2019 09:21:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8672830832C2;
	Thu, 25 Apr 2019 13:21:44 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B0E65D719;
	Thu, 25 Apr 2019 13:21:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:19 +0200
Message-Id: <20190425132134.2839-5-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 25 Apr 2019 13:21:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/19] s390-bios: Clean up cio.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132119.tcDGtd1riQ9NrNkRvlDtXqK0ApyjqHOIBf5tXdr0CYk@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Add proper typedefs to all structs and modify all bit fields to use consistent
formatting.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-5-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h      | 114 ++++++++++++++++++------------------
 pc-bios/s390-ccw/s390-ccw.h |   8 ---
 2 files changed, 57 insertions(+), 65 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 1a0795f6455f..ed5b2cbf72db 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -17,35 +17,35 @@
  * path management control word
  */
 struct pmcw {
-    __u32 intparm;        /* interruption parameter */
-    __u32 qf      : 1;    /* qdio facility */
-    __u32 w       : 1;
-    __u32 isc     : 3;    /* interruption sublass */
-    __u32 res5    : 3;    /* reserved zeros */
-    __u32 ena     : 1;    /* enabled */
-    __u32 lm      : 2;    /* limit mode */
-    __u32 mme     : 2;    /* measurement-mode enable */
-    __u32 mp      : 1;    /* multipath mode */
-    __u32 tf      : 1;    /* timing facility */
-    __u32 dnv     : 1;    /* device number valid */
-    __u32 dev     : 16;   /* device number */
-    __u8  lpm;            /* logical path mask */
-    __u8  pnom;           /* path not operational mask */
-    __u8  lpum;           /* last path used mask */
-    __u8  pim;            /* path installed mask */
-    __u16 mbi;            /* measurement-block index */
-    __u8  pom;            /* path operational mask */
-    __u8  pam;            /* path available mask */
-    __u8  chpid[8];       /* CHPID 0-7 (if available) */
-    __u32 unused1 : 8;    /* reserved zeros */
-    __u32 st      : 3;    /* subchannel type */
-    __u32 unused2 : 18;   /* reserved zeros */
-    __u32 mbfc    : 1;    /* measurement block format control */
-    __u32 xmwme   : 1;    /* extended measurement word mode enable */
-    __u32 csense  : 1;    /* concurrent sense; can be enabled ...*/
-                /*  ... per MSCH, however, if facility */
-                /*  ... is not installed, this results */
-                /*  ... in an operand exception.       */
+    __u32 intparm;      /* interruption parameter */
+    __u32 qf:1;         /* qdio facility */
+    __u32 w:1;
+    __u32 isc:3;        /* interruption sublass */
+    __u32 res5:3;       /* reserved zeros */
+    __u32 ena:1;        /* enabled */
+    __u32 lm:2;         /* limit mode */
+    __u32 mme:2;        /* measurement-mode enable */
+    __u32 mp:1;         /* multipath mode */
+    __u32 tf:1;         /* timing facility */
+    __u32 dnv:1;        /* device number valid */
+    __u32 dev:16;       /* device number */
+    __u8  lpm;          /* logical path mask */
+    __u8  pnom;         /* path not operational mask */
+    __u8  lpum;         /* last path used mask */
+    __u8  pim;          /* path installed mask */
+    __u16 mbi;          /* measurement-block index */
+    __u8  pom;          /* path operational mask */
+    __u8  pam;          /* path available mask */
+    __u8  chpid[8];     /* CHPID 0-7 (if available) */
+    __u32 unused1:8;    /* reserved zeros */
+    __u32 st:3;         /* subchannel type */
+    __u32 unused2:18;   /* reserved zeros */
+    __u32 mbfc:1;       /* measurement block format control */
+    __u32 xmwme:1;      /* extended measurement word mode enable */
+    __u32 csense:1;     /* concurrent sense; can be enabled ...*/
+                        /*  ... per MSCH, however, if facility */
+                        /*  ... is not installed, this results */
+                        /*  ... in an operand exception.       */
 } __attribute__ ((packed));
 
 /* Target SCHIB configuration. */
@@ -77,28 +77,28 @@ struct scsw {
 /*
  * subchannel information block
  */
-struct schib {
+typedef struct schib {
     struct pmcw pmcw;     /* path management control word */
     struct scsw scsw;     /* subchannel status word */
     __u64 mba;            /* measurement block address */
     __u8 mda[4];          /* model dependent area */
-} __attribute__ ((packed,aligned(4)));
-
-struct subchannel_id {
-        __u32 cssid  : 8;
-        __u32        : 4;
-        __u32 m      : 1;
-        __u32 ssid   : 2;
-        __u32 one    : 1;
-        __u32 sch_no : 16;
-} __attribute__ ((packed, aligned(4)));
+} __attribute__ ((packed, aligned(4))) Schib;
+
+typedef struct subchannel_id {
+        __u32 cssid:8;
+        __u32:4;
+        __u32 m:1;
+        __u32 ssid:2;
+        __u32 one:1;
+        __u32 sch_no:16;
+} __attribute__ ((packed, aligned(4))) SubChannelId;
 
 struct chsc_header {
     __u16 length;
     __u16 code;
 } __attribute__((packed));
 
-struct chsc_area_sda {
+typedef struct chsc_area_sda {
     struct chsc_header request;
     __u8 reserved1:4;
     __u8 format:4;
@@ -111,29 +111,29 @@ struct chsc_area_sda {
     __u32 reserved5:4;
     __u32 format2:4;
     __u32 reserved6:24;
-} __attribute__((packed));
+} __attribute__((packed)) ChscAreaSda;
 
 /*
  * TPI info structure
  */
 struct tpi_info {
     struct subchannel_id schid;
-    __u32 intparm;         /* interruption parameter */
-    __u32 adapter_IO : 1;
-    __u32 reserved2  : 1;
-    __u32 isc        : 3;
-    __u32 reserved3  : 12;
-    __u32 int_type   : 3;
-    __u32 reserved4  : 12;
+    __u32 intparm;      /* interruption parameter */
+    __u32 adapter_IO:1;
+    __u32 reserved2:1;
+    __u32 isc:3;
+    __u32 reserved3:12;
+    __u32 int_type:3;
+    __u32 reserved4:12;
 } __attribute__ ((packed, aligned(4)));
 
 /* channel command word (type 1) */
-struct ccw1 {
+typedef struct ccw1 {
     __u8 cmd_code;
     __u8 flags;
     __u16 count;
     __u32 cda;
-} __attribute__ ((packed, aligned(8)));
+} __attribute__ ((packed, aligned(8))) Ccw1;
 
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
@@ -162,7 +162,7 @@ struct ccw1 {
 /*
  * Command-mode operation request block
  */
-struct cmd_orb {
+typedef struct cmd_orb {
     __u32 intparm;    /* interruption parameter */
     __u32 key:4;      /* flags, like key, suspend control, etc. */
     __u32 spnd:1;     /* suspend control */
@@ -182,7 +182,7 @@ struct cmd_orb {
     __u32 zero:6;     /* reserved zeros */
     __u32 orbx:1;     /* ORB extension control */
     __u32 cpa;    /* channel program address */
-}  __attribute__ ((packed, aligned(4)));
+}  __attribute__ ((packed, aligned(4))) CmdOrb;
 
 struct ciw {
     __u8 type;
@@ -193,7 +193,7 @@ struct ciw {
 /*
  * sense-id response buffer layout
  */
-struct senseid {
+typedef struct senseid {
     /* common part */
     __u8  reserved;   /* always 0x'FF' */
     __u16 cu_type;    /* control unit type */
@@ -203,15 +203,15 @@ struct senseid {
     __u8  unused;     /* padding byte */
     /* extended part */
     struct ciw ciw[62];
-}  __attribute__ ((packed, aligned(4)));
+}  __attribute__ ((packed, aligned(4))) SenseId;
 
 /* interruption response block */
-struct irb {
+typedef struct irb {
     struct scsw scsw;
     __u32 esw[5];
     __u32 ecw[8];
     __u32 emw[8];
-}  __attribute__ ((packed, aligned(4)));
+}  __attribute__ ((packed, aligned(4))) Irb;
 
 /*
  * Some S390 specific IO instructions as inline
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 9828aa233d2e..241c6d0b69be 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -49,14 +49,6 @@ typedef unsigned long long __u64;
 #include "cio.h"
 #include "iplb.h"
 
-typedef struct irb Irb;
-typedef struct ccw1 Ccw1;
-typedef struct cmd_orb CmdOrb;
-typedef struct schib Schib;
-typedef struct chsc_area_sda ChscAreaSda;
-typedef struct senseid SenseId;
-typedef struct subchannel_id SubChannelId;
-
 /* start.s */
 void disabled_wait(void);
 void consume_sclp_int(void);
-- 
2.17.2


