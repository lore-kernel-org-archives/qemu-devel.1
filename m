Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E04EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC30206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC30206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifX5q-0001lt-TJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifX4O-0000Ry-8Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifX4M-0008Pj-OK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifX4M-0008Nv-Fs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCMWQ0U130886
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsd29xv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:25 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 12 Dec 2019 22:36:23 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 22:36:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBCMaKcc47251930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 22:36:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F9E5AE05F;
 Thu, 12 Dec 2019 22:36:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B636AE05D;
 Thu, 12 Dec 2019 22:36:20 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 22:36:20 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-185-241.de.ibm.com [9.145.185.241])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id C1043220110;
 Thu, 12 Dec 2019 23:36:19 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/5] virtfs-proxy-helper: switch from libcap to libcap-ng
Date: Thu, 12 Dec 2019 23:35:56 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212223601.309245-1-groug@kaod.org>
References: <20191212223601.309245-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19121222-0028-0000-0000-000003C7FBB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121222-0029-0000-0000-0000248B3727
Message-Id: <20191212223601.309245-2-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1034 phishscore=0 mlxlogscore=999
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120172
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBCMWQ0U130886
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

virtfs-proxy-helper is the only user of libcap; everyone else is using
the simpler libcap-ng API.  Switch and remove the configure code to
detect libcap.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[groug: - drop remaining -lcap from Makefile
        - fix error message in configure]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 Makefile                    |   1 -
 configure                   |  20 +-------
 fsdev/virtfs-proxy-helper.c | 100 ++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/Makefile b/Makefile
index b437a346d71a..1361def1441c 100644
--- a/Makefile
+++ b/Makefile
@@ -575,7 +575,6 @@ qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o=
 $(COMMON_LDADDS)
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDAD=
DS)
=20
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p=
-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
-fsdev/virtfs-proxy-helper$(EXESUF): LIBS +=3D -lcap
=20
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
diff --git a/configure b/configure
index 6099be1d848c..2c72e04d23f3 100755
--- a/configure
+++ b/configure
@@ -3863,22 +3863,6 @@ else
   mpathpersist=3Dno
 fi
=20
-##########################################
-# libcap probe
-
-if test "$cap" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <stdio.h>
-#include <sys/capability.h>
-int main(void) { cap_t caps; caps =3D cap_init(); return caps !=3D NULL;=
 }
-EOF
-  if compile_prog "" "-lcap" ; then
-    cap=3Dyes
-  else
-    cap=3Dno
-  fi
-fi
-
 ##########################################
 # pthread probe
 PTHREADLIBS_LIST=3D"-pthread -lpthread -lpthreadGC2"
@@ -6204,12 +6188,12 @@ if test "$want_tools" =3D "yes" ; then
 fi
 if test "$softmmu" =3D yes ; then
   if test "$linux" =3D yes; then
-    if test "$virtfs" !=3D no && test "$cap" =3D yes && test "$attr" =3D=
 yes ; then
+    if test "$virtfs" !=3D no && test "$cap_ng" =3D yes && test "$attr" =
=3D yes ; then
       virtfs=3Dyes
       tools=3D"$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" =3D yes; then
-        error_exit "VirtFS requires libcap devel and libattr devel"
+        error_exit "VirtFS requires libcap-ng devel and libattr devel"
       fi
       virtfs=3Dno
     fi
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 6f132c5ff15a..0d4de49dcf75 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -13,7 +13,6 @@
 #include <sys/resource.h>
 #include <getopt.h>
 #include <syslog.h>
-#include <sys/capability.h>
 #include <sys/fsuid.h>
 #include <sys/vfs.h>
 #include <sys/ioctl.h>
@@ -21,6 +20,7 @@
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
 #endif
+#include <cap-ng.h>
 #include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/xattr.h"
@@ -79,49 +79,10 @@ static void do_perror(const char *string)
     }
 }
=20
-static int do_cap_set(cap_value_t *cap_value, int size, int reset)
-{
-    cap_t caps;
-    if (reset) {
-        /*
-         * Start with an empty set and set permitted and effective
-         */
-        caps =3D cap_init();
-        if (caps =3D=3D NULL) {
-            do_perror("cap_init");
-            return -1;
-        }
-        if (cap_set_flag(caps, CAP_PERMITTED, size, cap_value, CAP_SET) =
< 0) {
-            do_perror("cap_set_flag");
-            goto error;
-        }
-    } else {
-        caps =3D cap_get_proc();
-        if (!caps) {
-            do_perror("cap_get_proc");
-            return -1;
-        }
-    }
-    if (cap_set_flag(caps, CAP_EFFECTIVE, size, cap_value, CAP_SET) < 0)=
 {
-        do_perror("cap_set_flag");
-        goto error;
-    }
-    if (cap_set_proc(caps) < 0) {
-        do_perror("cap_set_proc");
-        goto error;
-    }
-    cap_free(caps);
-    return 0;
-
-error:
-    cap_free(caps);
-    return -1;
-}
-
 static int init_capabilities(void)
 {
     /* helper needs following capabilities only */
-    cap_value_t cap_list[] =3D {
+    int cap_list[] =3D {
         CAP_CHOWN,
         CAP_DAC_OVERRIDE,
         CAP_FOWNER,
@@ -130,7 +91,34 @@ static int init_capabilities(void)
         CAP_MKNOD,
         CAP_SETUID,
     };
-    return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 1);
+    int i;
+
+    capng_clear(CAPNG_SELECT_BOTH);
+    for (i =3D 0; i < ARRAY_SIZE(cap_list); i++) {
+        if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                         cap_list[i]) < 0) {
+            do_perror("capng_update");
+            return -1;
+        }
+    }
+    if (capng_apply(CAPNG_SELECT_BOTH) < 0) {
+        do_perror("capng_apply");
+        return -1;
+    }
+
+    /* Prepare effective set for setugid.  */
+    for (i =3D 0; i < ARRAY_SIZE(cap_list); i++) {
+        if (cap_list[i] =3D=3D CAP_DAC_OVERRIDE) {
+            continue;
+        }
+
+        if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE,
+                         cap_list[i]) < 0) {
+            do_perror("capng_update");
+            return -1;
+        }
+    }
+    return 0;
 }
=20
 static int socket_read(int sockfd, void *buff, ssize_t size)
@@ -295,14 +283,6 @@ static int setugid(int uid, int gid, int *suid, int =
*sgid)
 {
     int retval;
=20
-    /*
-     * We still need DAC_OVERRIDE because we don't change
-     * supplementary group ids, and hence may be subjected DAC rules
-     */
-    cap_value_t cap_list[] =3D {
-        CAP_DAC_OVERRIDE,
-    };
-
     *suid =3D geteuid();
     *sgid =3D getegid();
=20
@@ -316,11 +296,21 @@ static int setugid(int uid, int gid, int *suid, int=
 *sgid)
         goto err_sgid;
     }
=20
-    if (uid !=3D 0 || gid !=3D 0) {
-        if (do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0) < 0) {
-            retval =3D -errno;
-            goto err_suid;
-        }
+    if (uid =3D=3D 0 && gid =3D=3D 0) {
+        /* Linux has already copied the permitted set to the effective s=
et.  */
+        return 0;
+    }
+
+    /*
+     * All capabilities have been cleared from the effective set.  Howev=
er
+     * we still need DAC_OVERRIDE because we don't change supplementary
+     * group ids, and hence may be subject to DAC rules.  init_capabilit=
ies
+     * left the set of capabilities that we want in libcap-ng's state.
+     */
+    if (capng_apply(CAPNG_SELECT_CAPS) < 0) {
+        retval =3D -errno;
+        do_perror("capng_apply");
+        goto err_suid;
     }
     return 0;
=20
--=20
2.21.0


