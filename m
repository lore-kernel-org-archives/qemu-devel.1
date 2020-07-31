Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D691C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0205A21744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="sLwp23nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1aO4-00085F-Md
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aMy-0006WN-Ay
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:04 -0400
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132]:59583 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aMu-0002Mw-UJ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQF06dGXuwBWfCIfJu31+wjoJZisan6i+AhUTcMmA1JxucEiwFmCvkQFSlM2QPNNizduZSyLIM96Jm/G1yhEYzyqZU3Nt5ZKUngRScrnkKJoH7Lq1BsTbMLCSe4S/Bs95SIBzAhf0YL4QkO11HdDwq4z4o/Uk37ByVitWiVh4xH4P9+Q3ydvHKYr7II1BBwd4Y4PDETJG8JchE9Ed3hASD4KDLDZhqWxf/82cOa1qyJe2MMaRJ1pD/cMNKkth2R67KUhKt6vv/aBSOhkqWXW+F8tA1W8zlGd+v/5D69/LaMoIzGjgw1DFf8PoHY2gSlz/tTUNImnx94CyPOBUtewqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns52SGx06j5UyEtQx51dsg4ZQZ94lRnc89aUFbqthqI=;
 b=mIhrd1MsJgUZo3HrbA46iWZUfvMPwWVuw/HxnbKHbiV0BUWJoGosBpQep3V+MFuQz58v3/jOVb9SjU3dEc2gsE+2ADTaStBrmQx+5regW1WHEUTnFhKvXx15RXakhJ6/qCpSjxnjG1zo8JZEGw4DNg3XqORAqGz1FtwHQiS+LxLzrgPRh4mggGBz2kTpcLo9k7TbsRWG0HCGWetO5ARAGtMoMliDdyRF5Skz++tcnmP6vKwk1moGMtYEIsoyBfTafpmk9QmNrsU3WXZmRogzFtsJ1jXr0fuDQqjVPpMjiZI5dYbzHXTmIUo9GzxwwPccDnQPHXjx1b55X+P+uVOWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns52SGx06j5UyEtQx51dsg4ZQZ94lRnc89aUFbqthqI=;
 b=sLwp23nbGKS1Hl5z7IevFv575AG1PQFsAce4HuZ7odPaIbKZpLNeo84WafL0c0l3V43RbKu0/50547JEbGIAIF1jLZ552insb7L6sisjaWy01itrlSX+PF4Wi5Pd83YoeoqQXPE6qaY+dPiwnlTlZxOZAfBkx3XaLMipFiTqGgI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM5PR03MB2884.eurprd03.prod.outlook.com (2603:10a6:206:1a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 31 Jul
 2020 19:06:52 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:06:52 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] linux-user: Modify 'sendmmsg()' and 'recvmmsg()'
 implementation
Date: Fri, 31 Jul 2020 21:06:35 +0200
Message-Id: <20200731190637.66698-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
References: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 19:06:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb00de4-d512-400d-ba19-08d83584e26d
X-MS-TrafficTypeDiagnostic: AM5PR03MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR03MB28846B00D413E990EEB058D5EB4E0@AM5PR03MB2884.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRvJmvQyE/YlXE19FG4EYiTkSX/zx6D5qPdpYpHQWWlNoIEQ5kvKuBBP8u4CoJF8JGx7hVrtqVtohvEtonVdNgwERVnNTRcJQgqyotLpV3pmy0hpkxn7HmNuGeW7Gm3tWTb0KYKyRHJJGEDyY968N+SDGPLSKJVM/z/MbaAek1WozSylaiCh74p4kdhaJk5FLNk49TFQgKk1dK1l2uNYBQz1Aq3fUYCTkw39wUYP+IBqwWgXv3hSXPungjgefxPWtLPWLME6CkoZhSylpIe0yTTgLmKycKwPXnx/xe1IhCRLJ04jcEPGJzYEph3z70ACG9HdcKf2tQ1bVBzvSwmkLyyYCceOTjRnOzx7LRoIcS3dqPMx28r/opF9PY8wZ4my
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39830400003)(376002)(346002)(366004)(136003)(6506007)(26005)(66556008)(186003)(6486002)(107886003)(66946007)(69590400007)(2616005)(66476007)(54906003)(6512007)(8676002)(2906002)(36756003)(4326008)(16526019)(5660300002)(52116002)(316002)(6666004)(83380400001)(86362001)(508600001)(956004)(6916009)(8936002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: twUN+WVmIX7I1mhHj8/itRMIut60ZmXrZoJitgfP84KT2nsmv7A/Ce8iJOglX9qNPzWWnPV7dTDzLJgDE/4fPqu2qzf3XXo7yAtnDnYBMsR+ghsygoAalQ5FopXJHTSeC56Aelajw8+yEMJgSDlzhi19hZEoFcNxle2FO4EnD2Y9rpVrb1RvAgQ3enNDn3VcTfQX5yK9b3irJP3TaIs3oHqED387GpD5rTqfnVp8NBrpNH7Qc0utvpI21s8UDCpInWJHtYF13iFVYmOHXnDAMs/5ineElVJUxfjwRCr+cQCR/cqgbLu+bBE8hv1GiYybCQntKwlQpeUigKrTkwrMTFN7sRNU1Xjjjlf4jz+pTzOzFcLImEtZLFVES3hN79+hukIUCIzlh3nZ9XXGHJjRo248KJVLlXuk9zRqYWj7KHdF6wLgm4gdlMSHSGRjOX6pnMdTu5r6VKC8bolbSq1jSX5IIp0r7tW2iPpTAIQ0g7Q=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb00de4-d512-400d-ba19-08d83584e26d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:06:52.6221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43H3yDZdqhKfBLT2VXESX720ysaJtdSrVdRp6S+BMZzrUkJ/LvkarA/EGoHepROE0NkGg/Hr3fhWo5t27F/0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR03MB2884
Received-SPF: pass client-ip=40.107.22.132;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 15:06:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementations of 'sendmmsg()' and 'recvmmsg()' in 'syscall.c' use
a loop over a host command of 'sendmsg()' and 'recvmsg()' respectively
to send/receive individual messages from a socket. This patch changes
these implementations to use the host commands 'sendmmsg()' and 'recvmmsg()'
to send all messages without looping over 'sendmsg()' and 'recvmsg()'.

Implementation notes:

    Parts of code from 'do_sendrecvmsg_locked()', that are used to transfer
    values of 'struct msghdr' between host and target, were moved to separate
    functions 'target_to_host_msghdr()' and 'host_to_target_msghdr()'. These
    functions are used in 'do_sendrecvmmsg()' to transfer the data of each
    individual 'struct msghdr' from the 'msgvec' argument. Memory allocation
    for the 'iovec' field is done outside of these functions as to ensure that
    the memory is freed after the syscall execution.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 243 ++++++++++++++++++++++++++++---------------
 1 file changed, 159 insertions(+), 84 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..8cbefdb561 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -798,6 +798,10 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len,
               int, flags, struct sockaddr *, addr, socklen_t *, addrlen)
 safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, int, flags)
 safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, flags)
+safe_syscall4(int, sendmmsg, int, fd, struct mmsghdr *, msgvec,
+              unsigned int, vlen, int, flags)
+safe_syscall5(int, recvmmsg, int, fd, struct mmsghdr *, msgvec,
+              unsigned int, vlen, int, flags, struct timespec *, timeout)
 safe_syscall2(int, flock, int, fd, int, operation)
 #ifdef TARGET_NR_rt_sigtimedwait
 safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
@@ -3064,41 +3068,94 @@ static abi_long do_connect(int sockfd, abi_ulong target_addr,
     return get_errno(safe_connect(sockfd, addr, addrlen));
 }
 
-/* do_sendrecvmsg_locked() Must return target values and target errnos. */
-static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
-                                      int flags, int send)
+static abi_long target_to_host_msghdr(int fd, struct msghdr *host_msg,
+                                      struct target_msghdr *target_msg,
+                                      int send)
 {
-    abi_long ret, len;
-    struct msghdr msg;
-    abi_ulong count;
-    struct iovec *vec;
-    abi_ulong target_vec;
-
-    if (msgp->msg_name) {
-        msg.msg_namelen = tswap32(msgp->msg_namelen);
-        msg.msg_name = alloca(msg.msg_namelen+1);
-        ret = target_to_host_sockaddr(fd, msg.msg_name,
-                                      tswapal(msgp->msg_name),
-                                      msg.msg_namelen);
+    abi_long ret = 0;
+    if (target_msg->msg_name) {
+        host_msg->msg_namelen = tswap32(target_msg->msg_namelen);
+        host_msg->msg_name = alloca(host_msg->msg_namelen + 1);
+        ret = target_to_host_sockaddr(fd, host_msg->msg_name,
+                                      tswapal(target_msg->msg_name),
+                                      host_msg->msg_namelen);
         if (ret == -TARGET_EFAULT) {
-            /* For connected sockets msg_name and msg_namelen must
+            /*
+             * For connected sockets msg_name and msg_namelen must
              * be ignored, so returning EFAULT immediately is wrong.
              * Instead, pass a bad msg_name to the host kernel, and
              * let it decide whether to return EFAULT or not.
              */
-            msg.msg_name = (void *)-1;
+            host_msg->msg_name = (void *)-1;
+            ret = 0;
         } else if (ret) {
-            goto out2;
+            return ret;
         }
     } else {
-        msg.msg_name = NULL;
-        msg.msg_namelen = 0;
+        host_msg->msg_name = NULL;
+        host_msg->msg_namelen = 0;
+    }
+    host_msg->msg_controllen = 2 * tswapal(target_msg->msg_controllen);
+    host_msg->msg_control = alloca(host_msg->msg_controllen);
+    memset(host_msg->msg_control, 0, host_msg->msg_controllen);
+    host_msg->msg_flags = tswap32(target_msg->msg_flags);
+    if (send) {
+        if (fd_trans_target_to_host_data(fd)) {
+            void *host_iov_base;
+
+            host_iov_base = g_malloc(host_msg->msg_iov->iov_len);
+            memcpy(host_iov_base, host_msg->msg_iov->iov_base,
+                   host_msg->msg_iov->iov_len);
+            ret = fd_trans_target_to_host_data(fd)(host_iov_base,
+                                                   host_msg->msg_iov->iov_len);
+            if (ret >= 0) {
+                host_msg->msg_iov->iov_base = host_iov_base;
+                ret = 0;
+            }
+            g_free(host_iov_base);
+        } else {
+            ret = target_to_host_cmsg(host_msg, target_msg);
+        }
+    }
+    return ret;
+}
+
+static abi_long host_to_target_msghdr(int fd, struct target_msghdr *target_msg,
+                                      struct msghdr *host_msg, int len)
+{
+    abi_long ret;
+
+    if (fd_trans_host_to_target_data(fd)) {
+        ret = fd_trans_host_to_target_data(fd)(host_msg->msg_iov->iov_base,
+                                      MIN(host_msg->msg_iov->iov_len, len));
+    } else {
+        ret = host_to_target_cmsg(target_msg, host_msg);
+    }
+    if (!is_error(ret)) {
+        target_msg->msg_namelen = tswap32(host_msg->msg_namelen);
+        target_msg->msg_flags = tswap32(host_msg->msg_flags);
+        if (host_msg->msg_name != NULL && host_msg->msg_name != (void *)-1) {
+            ret = host_to_target_sockaddr(tswapal(target_msg->msg_name),
+                              host_msg->msg_name, host_msg->msg_namelen);
+            if (ret) {
+                return ret;
+            }
+        }
+        ret = len;
     }
-    msg.msg_controllen = 2 * tswapal(msgp->msg_controllen);
-    msg.msg_control = alloca(msg.msg_controllen);
-    memset(msg.msg_control, 0, msg.msg_controllen);
 
-    msg.msg_flags = tswap32(msgp->msg_flags);
+    return ret;
+}
+
+/* do_sendrecvmsg_locked() Must return target values and target errnos. */
+static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
+                                      int flags, int send)
+{
+    abi_long ret;
+    struct msghdr msg;
+    abi_ulong count;
+    struct iovec *vec;
+    abi_ulong target_vec;
 
     count = tswapal(msgp->msg_iovlen);
     target_vec = tswapal(msgp->msg_iov);
@@ -3120,48 +3177,18 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
     msg.msg_iovlen = count;
     msg.msg_iov = vec;
 
-    if (send) {
-        if (fd_trans_target_to_host_data(fd)) {
-            void *host_msg;
+    ret = target_to_host_msghdr(fd, &msg, msgp, send);
 
-            host_msg = g_malloc(msg.msg_iov->iov_len);
-            memcpy(host_msg, msg.msg_iov->iov_base, msg.msg_iov->iov_len);
-            ret = fd_trans_target_to_host_data(fd)(host_msg,
-                                                   msg.msg_iov->iov_len);
-            if (ret >= 0) {
-                msg.msg_iov->iov_base = host_msg;
-                ret = get_errno(safe_sendmsg(fd, &msg, flags));
-            }
-            g_free(host_msg);
-        } else {
-            ret = target_to_host_cmsg(&msg, msgp);
-            if (ret == 0) {
-                ret = get_errno(safe_sendmsg(fd, &msg, flags));
-            }
-        }
+    if (ret) {
+        goto out;
+    }
+
+    if (send) {
+        ret = get_errno(safe_sendmsg(fd, &msg, flags));
     } else {
         ret = get_errno(safe_recvmsg(fd, &msg, flags));
         if (!is_error(ret)) {
-            len = ret;
-            if (fd_trans_host_to_target_data(fd)) {
-                ret = fd_trans_host_to_target_data(fd)(msg.msg_iov->iov_base,
-                                               MIN(msg.msg_iov->iov_len, len));
-            } else {
-                ret = host_to_target_cmsg(msgp, &msg);
-            }
-            if (!is_error(ret)) {
-                msgp->msg_namelen = tswap32(msg.msg_namelen);
-                msgp->msg_flags = tswap32(msg.msg_flags);
-                if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
-                    ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
-                                    msg.msg_name, msg.msg_namelen);
-                    if (ret) {
-                        goto out;
-                    }
-                }
-
-                ret = len;
-            }
+            ret = host_to_target_msghdr(fd, msgp, &msg, ret);
         }
     }
 
@@ -3188,50 +3215,98 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
     return ret;
 }
 
-/* We don't rely on the C library to have sendmmsg/recvmmsg support,
- * so it might not have this *mmsg-specific flag either.
- */
-#ifndef MSG_WAITFORONE
-#define MSG_WAITFORONE 0x10000
-#endif
-
-static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec,
+static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec_addr,
                                 unsigned int vlen, unsigned int flags,
                                 int send)
 {
-    struct target_mmsghdr *mmsgp;
+    struct mmsghdr *host_msgvec;
+    struct target_mmsghdr *target_msgvec;
     abi_long ret = 0;
+    int num_sentrecv = 0;
+    int num_iovec = 0;
+    abi_ulong iovlen = 0;
+    struct iovec *host_iovec;
+    abi_ulong target_iovec;
     int i;
 
     if (vlen > UIO_MAXIOV) {
         vlen = UIO_MAXIOV;
     }
 
-    mmsgp = lock_user(VERIFY_WRITE, target_msgvec, sizeof(*mmsgp) * vlen, 1);
-    if (!mmsgp) {
+    target_msgvec = lock_user(VERIFY_WRITE, target_msgvec_addr,
+                              sizeof(target_msgvec) * vlen, 1);
+    if (!target_msgvec) {
         return -TARGET_EFAULT;
     }
 
+    host_msgvec = alloca(sizeof(*host_msgvec) * vlen);
+
     for (i = 0; i < vlen; i++) {
-        ret = do_sendrecvmsg_locked(fd, &mmsgp[i].msg_hdr, flags, send);
+
+        iovlen = tswapal(target_msgvec[i].msg_hdr.msg_iovlen);
+        target_iovec = tswapal(target_msgvec[i].msg_hdr.msg_iov);
+
+        if (iovlen > IOV_MAX) {
+            ret = -TARGET_EMSGSIZE;
+            break;
+         }
+         host_iovec = lock_iovec(send ? VERIFY_READ : VERIFY_WRITE,
+                                 target_iovec, iovlen, send);
+
+        if (host_iovec == NULL) {
+            ret = -host_to_target_errno(errno);
+            break;
+        }
+
+        num_iovec++;
+
+        host_msgvec[i].msg_hdr.msg_iovlen = iovlen;
+        host_msgvec[i].msg_hdr.msg_iov = host_iovec;
+
+        ret = target_to_host_msghdr(fd, &host_msgvec[i].msg_hdr,
+                                    &target_msgvec[i].msg_hdr, send);
+
         if (is_error(ret)) {
             break;
         }
-        mmsgp[i].msg_len = tswap32(ret);
-        /* MSG_WAITFORONE turns on MSG_DONTWAIT after one packet */
-        if (flags & MSG_WAITFORONE) {
-            flags |= MSG_DONTWAIT;
+    }
+
+    if (i > 0) {
+        if (send) {
+            ret = get_errno(safe_sendmmsg(fd, host_msgvec, i, flags));
+        } else {
+            ret = get_errno(safe_recvmmsg(fd, host_msgvec, i, flags, NULL));
+        }
+    }
+
+    if (!is_error(ret)) {
+        num_sentrecv = ret;
+        for (i = 0; i < num_sentrecv; i++) {
+            if (!send) {
+                ret = host_to_target_msghdr(fd, &target_msgvec[i].msg_hdr,
+                                            &host_msgvec[i].msg_hdr,
+                                            host_msgvec[i].msg_len);
+                if (is_error(ret)) {
+                    num_sentrecv = i;
+                    break;
+                }
+            }
+            target_msgvec[i].msg_len = tswap32(host_msgvec[i].msg_len);
         }
     }
 
-    unlock_user(mmsgp, target_msgvec, sizeof(*mmsgp) * i);
+    for (i = 0; i < num_iovec; i++) {
+        target_iovec = tswapal(target_msgvec[i].msg_hdr.msg_iov);
+        unlock_iovec(host_msgvec[i].msg_hdr.msg_iov,
+                     target_iovec, iovlen, !send);
+    }
+
+    unlock_user(target_msgvec, target_msgvec_addr, sizeof(*target_msgvec) * i);
 
-    /* Return number of datagrams sent if we sent any at all;
-     * otherwise return the error.
-     */
-    if (i) {
-        return i;
+    if (num_sentrecv) {
+        return num_sentrecv;
     }
+
     return ret;
 }
 
-- 
2.25.1


