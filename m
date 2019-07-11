Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBCC74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EC020872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EC020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcgO-0004UN-0O
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hlcg8-00042z-2H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hlcg6-0007Mh-QO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:16:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hlcg6-0007Ki-CN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:16:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MowbA-1iH4kW2uGE-00qVio; Thu, 11 Jul 2019 19:16:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 19:15:56 +0200
Message-Id: <20190711171556.3377-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gxN+auINtwkY9Odo+26LA71NipLlubgRsXMQquGGTXPgf+6Vg8+
 Bd07rPZrVzQZvMmDONKJTLGm/MXdJrGG+QXuWMCRj+eG+jd0mfeRQK1XMDZHx80yJEZ+xKO
 3FzZOxADKWA5iqTMpqXJSwVfzZVXtNa5Izf/BD1I2go+x3FhicU2mb291mIcfd6vCS1iKe2
 4R/0mMvJVPqIZUrSIOIlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ane88wFzbgU=:xpE5oPzezSbrTKsCBu/ABr
 YekmlnHnA3esQcPRDKJSh0DQGEzbn3XVso4N3MZDbcUvB03ThugMgwBwcJOiRmL8VdorpgdMm
 2OFOzQs5ND59KXC9B7x38sOY5HH7ffMMmfTW6nf6HBHezCDJtOSUWMWC/PAeHDJ3tFMUfwEkq
 y5IfaKcuEe8WCdhOC9jbOua2l9U8VXaDKY+cBX4wyrTzfviF4JXshjCrwnPpsSVWQ2l6MmL+D
 v5voZxxlKBOTd5TtlzarIMn5HlZmVcRrgnpGNz/1l0KqwDQ+/Ex+MUpprq574pmRHopMJCq7x
 lc1VhqTCW16c55ORTBk48iq7qM1CIxzNIsTqX67NHNWEMOlK+GtaDgJOVRVec3sDfLnL6/o+c
 BPX1e+txeRYDAMCyMnKKRewWlEP2OsgBsxeBTjZa4Dg9buMSe7p14xIuXov+zm885JvJoGIfT
 LOubPaBl7UEmnjEN/ioNzFCHwM2QqkqwXR+3ywO96opuisfAq/iXwoLbn8g2mw9pdikMNce9C
 zHeWmREBry6+wAkK90FOwYZq6B54Zg9FPi0Osy+D0M/c9S1nVVdMA0EOUnQv9dqwvp/4qNKpO
 gcx0pSK+65id5Grnmn0bqEwSNhD3qjHu7aT9jIDkaotVp9DJW87Cu++l1zM4CXe8dRzB77UW1
 THTSWcNRXLOSPhpV1/2kdOHGqrVWDY8VPnBgsWWC5Kvde6pfV29cII6qK57L8QryNXBpuXWAt
 koNRVMvjarsC0JfLIuvXoaoO8Phb58PHV2aj+NsWutKQDPMq5Y5S+l1U2XU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PATCH v3] linux-user: fix to handle variably sized
 SIOCGSTAMP with new kernels
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The SIOCGSTAMP symbol was previously defined in the
asm-generic/sockios.h header file. QEMU sees that header
indirectly via sys/socket.h

In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
Instead it provides only SIOCGSTAMP_OLD, which only uses a
32-bit time_t on 32-bit architectures.

The linux/sockios.h header then defines SIOCGSTAMP using
either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
on 32-bit architectures

To cope with this we must now define two separate syscalls,
with corresponding old and new sizes, as well as including
the new linux/sockios.h header.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v3: [lv] redefine TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMPNS_NEW,
        timeval64 and timespec64 to use 0x89 type and abi_llong[2]
    
    v2: [dpb] implement _NEW and _OLD variants

 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  1 +
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/syscall_types.h |  6 ++++++
 4 files changed, 26 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 5e84dc7c3a77..5a6d6def7e3f 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -222,8 +222,23 @@
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
   IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
+
+#ifdef SIOCGSTAMP_OLD
+  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
+#else
   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
+#endif
+#ifdef SIOCGSTAMPNS_OLD
+  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
+#else
   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
+#endif
+#ifdef SIOCGSTAMP_NEW
+  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
+#endif
+#ifdef SIOCGSTAMPNS_NEW
+  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64)))
+#endif
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39a37496fed5..aa18ac4b2389 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -37,6 +37,7 @@
 #include <sched.h>
 #include <sys/timex.h>
 #include <sys/socket.h>
+#include <linux/sockios.h>
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <poll.h>
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fffa89f2564b..e0326923a018 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -751,6 +751,10 @@ struct target_pollfd {
 
 #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
 #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
+#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timeval) */
+#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (timespec) */
+#define TARGET_SIOCGSTAMP_NEW   TARGET_IOR(0x89, 0x06, abi_llong[2]) /* Get stamp (timeval64) */
+#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOR(0x89, 0x07, abi_llong[2]) /* Get stamp (timespec64) */
 
 /* Networking ioctls */
 #define TARGET_SIOCADDRT       0x890B          /* add routing table entry */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b98a23b0f1b0..584087301edc 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -20,6 +20,12 @@ STRUCT(timeval,
 STRUCT(timespec,
        MK_ARRAY(TYPE_LONG, 2))
 
+STRUCT(timeval64,
+       MK_ARRAY(TYPE_LONGLONG, 2))
+
+STRUCT(timespec64,
+       MK_ARRAY(TYPE_LONGLONG, 2))
+
 STRUCT(rtentry,
        TYPE_ULONG, MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr),
        TYPE_SHORT, TYPE_SHORT, TYPE_ULONG, TYPE_PTRVOID, TYPE_SHORT, TYPE_PTRVOID,
-- 
2.21.0


