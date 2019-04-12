Received: from eggs.gnu.org ([209.51.188.92]:38782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFX-0001wS-SY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFW-0002NM-6K
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:43 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:10 +0200
Message-Id: <20190412122523.24111-5-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 04/17] s390-bios: Clean
 up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Add proper typedefs to all structs and modify all bit fields to use consi=
stent
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
index 1a0795f645..ed5b2cbf72 100644
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
=20
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
=20
 struct chsc_header {
     __u16 length;
     __u16 code;
 } __attribute__((packed));
=20
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
=20
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
=20
 /* channel command word (type 1) */
-struct ccw1 {
+typedef struct ccw1 {
     __u8 cmd_code;
     __u8 flags;
     __u16 count;
     __u32 cda;
-} __attribute__ ((packed, aligned(8)));
+} __attribute__ ((packed, aligned(8))) Ccw1;
=20
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
=20
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
=20
 /* interruption response block */
-struct irb {
+typedef struct irb {
     struct scsw scsw;
     __u32 esw[5];
     __u32 ecw[8];
     __u32 emw[8];
-}  __attribute__ ((packed, aligned(4)));
+}  __attribute__ ((packed, aligned(4))) Irb;
=20
 /*
  * Some S390 specific IO instructions as inline
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 9828aa233d..241c6d0b69 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -49,14 +49,6 @@ typedef unsigned long long __u64;
 #include "cio.h"
 #include "iplb.h"
=20
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
--=20
2.21.0
