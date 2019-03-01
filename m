Received: from eggs.gnu.org ([209.51.188.92]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznPE-00073v-JX
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznPA-0005Vm-ET
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:01:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gznP8-0005Pl-6m
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:01:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21J0rhq018285
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:01:03 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qy8grdhdk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:00:58 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 1 Mar 2019 18:59:42 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri,  1 Mar 2019 13:59:26 -0500
In-Reply-To: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 06/16] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Add proper typedefs to all structs and modify all bit fields to use consistent
formatting.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.h      | 152 ++++++++++++++++++++++----------------------
 pc-bios/s390-ccw/s390-ccw.h |   8 ---
 2 files changed, 76 insertions(+), 84 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 1a0795f..2f58256 100644
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
@@ -162,27 +162,27 @@ struct ccw1 {
 /*
  * Command-mode operation request block
  */
-struct cmd_orb {
-    __u32 intparm;    /* interruption parameter */
-    __u32 key:4;      /* flags, like key, suspend control, etc. */
-    __u32 spnd:1;     /* suspend control */
-    __u32 res1:1;     /* reserved */
-    __u32 mod:1;      /* modification control */
-    __u32 sync:1;     /* synchronize control */
-    __u32 fmt:1;      /* format control */
-    __u32 pfch:1;     /* prefetch control */
-    __u32 isic:1;     /* initial-status-interruption control */
-    __u32 alcc:1;     /* address-limit-checking control */
-    __u32 ssic:1;     /* suppress-suspended-interr. control */
-    __u32 res2:1;     /* reserved */
-    __u32 c64:1;      /* IDAW/QDIO 64 bit control  */
-    __u32 i2k:1;      /* IDAW 2/4kB block size control */
-    __u32 lpm:8;      /* logical path mask */
-    __u32 ils:1;      /* incorrect length */
-    __u32 zero:6;     /* reserved zeros */
-    __u32 orbx:1;     /* ORB extension control */
-    __u32 cpa;    /* channel program address */
-}  __attribute__ ((packed, aligned(4)));
+typedef struct cmd_orb {
+    __u32 intparm;  /* interruption parameter */
+    __u32 key:4;    /* flags, like key, suspend control, etc. */
+    __u32 spnd:1;   /* suspend control */
+    __u32 res1:1;   /* reserved */
+    __u32 mod:1;    /* modification control */
+    __u32 sync:1;   /* synchronize control */
+    __u32 fmt:1;    /* format control */
+    __u32 pfch:1;   /* prefetch control */
+    __u32 isic:1;   /* initial-status-interruption control */
+    __u32 alcc:1;   /* address-limit-checking control */
+    __u32 ssic:1;   /* suppress-suspended-interr. control */
+    __u32 res2:1;   /* reserved */
+    __u32 c64:1;    /* IDAW/QDIO 64 bit control  */
+    __u32 i2k:1;    /* IDAW 2/4kB block size control */
+    __u32 lpm:8;    /* logical path mask */
+    __u32 ils:1;    /* incorrect length */
+    __u32 zero:6;   /* reserved zeros */
+    __u32 orbx:1;   /* ORB extension control */
+    __u32 cpa;      /* channel program address */
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
index 9828aa2..241c6d0 100644
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
2.7.4
