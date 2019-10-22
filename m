Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB30CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629912184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629912184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpJw-0006mP-Pg
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGG-0002hh-QR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGF-00054T-Ho
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGF-00053g-7z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MF45G-1iGAM33J8K-00FRiM; Tue, 22 Oct 2019 10:11:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] linux-user/strace: Dump AF_NETLINK sockaddr content
Date: Tue, 22 Oct 2019 10:11:00 +0200
Message-Id: <20191022081104.11814-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DESsI0QzkWz1nsQbcal9gf9LarrsZojwOWRoWfhXnSB6PiAk9J0
 HmHMa349MQ/A2yJ7oxS8THE4ccjvm/5HADO1EEQSX5EOxuQ4wX4BQlQ2ZEC7zITDySJqcKF
 O14pXkgyYAhLbIq6q528N9IrmbPfsF2iVNtJFn1D2GoSAmICcv+ZYKOHpGe/AuAGWKX0aOt
 WGsMKH9s+6MUMQl9yymsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s4Tb9goKibs=:O+4G6uWWuVfeER3YZyJbzq
 F9aW3+zrOnrxMdHdPuBJzcgLvItCNS190WrzXDwzUBgUjCFhYSwm0JhZyT2zyXg6XUeLjOCql
 4t/e7SehfklTMw0LIWhQlwyWLPy5dEDEYj7NsT2p8HNQfl4hBIjEnQUac+UfdQIaC1TxvoXS7
 oHzkiwdh5vq9KRnkJsuykzNgR06Xm0YXNJvad4FtBeO/DZ4sWxZNLJUIvPhqtbujvMD8gfR+8
 qJ8BT8+7CoAZweyj2cBAqkVUa+9B8oyo1Iquh2wHEw4vvmQlz+Ng4Zd/oSx9XmbRpNgXRutJD
 XvEhgzwsJAe09nU2v75OoPyHj4dYHPIxsnsSnNga1DYdz14WsUEeagD9VFZAZvE3Af5/5QM8C
 zpa+UmYg4OEJ2yR0zoxLS1P/Mq8Uew02nSRvVBM/a/JSs/IKInWALhnZ6H7BOXbkfsati83Mh
 9Swg0wUSsDeadgpm9rJQcLzu39jgUn7FmHLYv2yzCQI9OcnwTDFfFSWbgEs4AnWZAB8HUnBjf
 D6xSeV2HPyPeqDjnPXOxWaoSagQjf1uzc0z2nP3zUusQl+rFHAac/K1rSdd+/8XMa//0thytU
 jDhShrjEfwtVI5A3YSxC0M8gWopprZXOSBZmSGokbCsl+w+438JxeD1el93O8EP3D1Hj9ep2Y
 M++35S1knKga4Fgi3stRJ9tczkcQvHxvyEw6CCCkF8/F4uXsQ3KTTyVR4zWlQZUcnNgOl3t6K
 dy39WbG5Z8SvodnGEirOA4kKX4l/28FOR08ZXgtm7+RT219VDO+453OHDrpS+jxu9JyrLFlKg
 WhkSZ47bHqFK3O600URAIf7W/QsiG7eHunUodxseuYsDD7qD7aD6NfEUkGIZRy5N1uLkiTXXX
 BCSo0OjDWoIfIMaMird21gCanoKdx0zHl1GnI7Baw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191021114857.20538-6-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index fd5596a64074..5fa7748427f0 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -8,6 +8,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/netlink.h>
 #include <sched.h>
 #include "qemu.h"
 
@@ -398,6 +399,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
             gemu_log("}");
             break;
         }
+        case AF_NETLINK: {
+            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
+            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+                     tswap32(nl->nl_pid), tswap32(nl->nl_groups));
+            break;
+        }
         default:
             gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
             for (i = 0; i < 13; i++) {
@@ -424,6 +431,9 @@ print_socket_domain(int domain)
     case PF_INET:
         gemu_log("PF_INET");
         break;
+    case PF_NETLINK:
+        gemu_log("PF_NETLINK");
+        break;
     case PF_PACKET:
         gemu_log("PF_PACKET");
         break;
@@ -473,6 +483,33 @@ print_socket_protocol(int domain, int type, int protocol)
         return;
     }
 
+    if (domain == PF_NETLINK) {
+        switch (protocol) {
+        case NETLINK_ROUTE:
+            gemu_log("NETLINK_ROUTE");
+            break;
+        case NETLINK_AUDIT:
+            gemu_log("NETLINK_AUDIT");
+            break;
+        case NETLINK_NETFILTER:
+            gemu_log("NETLINK_NETFILTER");
+            break;
+        case NETLINK_KOBJECT_UEVENT:
+            gemu_log("NETLINK_KOBJECT_UEVENT");
+            break;
+        case NETLINK_RDMA:
+            gemu_log("NETLINK_RDMA");
+            break;
+        case NETLINK_CRYPTO:
+            gemu_log("NETLINK_CRYPTO");
+            break;
+        default:
+            gemu_log("%d", protocol);
+            break;
+        }
+        return;
+    }
+
     switch (protocol) {
     case IPPROTO_IP:
         gemu_log("IPPROTO_IP");
-- 
2.21.0


