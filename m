Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4950DC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280DA2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280DA2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3KV-0007pW-Sg
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Ir-0005wc-Iy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iq-0004gv-3A
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:41 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Ip-0004fk-Pu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MK3iK-1iEMhF11Q6-00LUJj; Tue, 05 Nov 2019 19:11:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] linux-user: Support for NETLINK socket options
Date: Tue,  5 Nov 2019 19:11:07 +0100
Message-Id: <20191105181119.26779-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4+7uD1XNKyCPZXTebgGuW6OFwtVt3y1MSzqcsSn3RkX6tUN4jcg
 3LSd/RXtU5Ksmrw6/hRzK5wzjBAVNQiGz5q7l6/eyMbmWCsEa5sI/hyzbgYJXl/F/8ix1tA
 9ojm8cfdl9RCNGWkGIKDYRyE4iK0dxoe8DMKeSNfcfDEQ+RNAu+teRjEECagOo+SWzSRI4I
 ALjbf/mUdF0BaIFtCyQkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1MOBssoNAc=:g+3d/6hhcrM6yHFvdBqZ+q
 DNsxP+yHPNVLeG+D8/wWe0Hn34x0Dbu0h76ld736WKT7XU4gUDJtm/5HpdCKdeQuxqwmw4XfP
 k0jF+W+w5h98vquM4NxGQ94jPZuBJZHfOXLl5SMMxybrwV1zUQgOpnbFPLxNgYLkjKQ8jr6+P
 bY5fSgVtSEoA/mJUK6eIQnPFQfcT4qEZYwc2DM32SGEhG9VTjFhKPav4IQYAte+r5htI6tTEt
 JsP/QQf3Mg3qWYOkYF/sRBs2MS8KYuAQh4P3bnc7F2ovEDs6OTxH8gKb+BIgH+SwyRAf7PIMJ
 FEykTJV7lx76+CmuoLxpkN0Vw79l1SNwVZ4RCECDHV6tgzYMzw2V2N+Y+lpW+VWjHJ5CTuvqq
 StHkdjXFZiX/UKf3QO5sNqScwaBKkWHZdsMEoxdendzb0elhXK1Z+WXDlxXiJbiCVx73PIvZi
 p+eR3k9og9YMWzfsUMPU4eU/lvm6vkl11pwtfrk/X5bCuu7Zv5L4wX249C10eqHeVsmiBo9Le
 OR/ne1aBy+3pYVCmCwuXYMGRymfbSt+lLM0vh0cCvBr1e504yuGXsdL016y+XTmCN1Dihpzre
 q+Qctv1jNYgF4Q8U2H8Et2WbcUdX6/xwXuXnQHNws5H2fmur+p2yC3EG68+pilv35GPyRUkY1
 9mWYY2d6RszxLkWjuKUPyallMYbJBi/FHhX4bSJK6bptyXpEI7NLUifdZ7kDlVgbH3FZEI8Px
 VVp1jbVDA9f/4E+wycEFyLAWB2w7ajgPr69f20bTGTGf9qOXQM3kYUJxfrOX6Si9leXk6ef34
 yfLIZ399J2q/qiieKlulcFeqotZGN3BfKBNz9hM08lVJpnBjLKkzIj6cJRcVBP1GmPBWK+jUc
 ZXu6Kfl0FnyB+T1G87zQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Josh Kunz <jkz@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh Kunz <jkz@google.com>

This change includes support for all AF_NETLINK socket options up to about
kernel version 5.4 (5.4 is not formally released at the time of writing).
Socket options that were introduced in kernel versions before the oldest
currently stable kernel version are guarded by kernel version macros.

This change has been built under gcc 8.3, and clang 9.0, and it passes
`make check`. The netlink options have been tested by emulating some
non-trival software that uses NETLINK socket options, but they have
not been exaustively verified.

Signed-off-by: Josh Kunz <jkz@google.com>
Message-Id: <20191029224310.164025-1-jkz@google.com>
[lv: updated patch according to CODING_STYLE]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f6751eecb78c..247883292ce5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2248,6 +2248,39 @@ set_timeout:
             return -TARGET_EFAULT;
 	ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
         break;
+#ifdef SOL_NETLINK
+    case SOL_NETLINK:
+        switch (optname) {
+        case NETLINK_PKTINFO:
+        case NETLINK_ADD_MEMBERSHIP:
+        case NETLINK_DROP_MEMBERSHIP:
+        case NETLINK_BROADCAST_ERROR:
+        case NETLINK_NO_ENOBUFS:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LISTEN_ALL_NSID:
+        case NETLINK_CAP_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
+        case NETLINK_EXT_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
+        case NETLINK_GET_STRICT_CHK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+            break;
+        default:
+            goto unimplemented;
+        }
+        val = 0;
+        if (optlen < sizeof(uint32_t)) {
+            return -TARGET_EINVAL;
+        }
+        if (get_user_u32(val, optval_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(setsockopt(sockfd, SOL_NETLINK, optname, &val,
+                                   sizeof(val)));
+        break;
+#endif /* SOL_NETLINK */
     default:
     unimplemented:
         gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
@@ -2532,6 +2565,74 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             break;
         }
         break;
+#ifdef SOL_NETLINK
+    case SOL_NETLINK:
+        switch (optname) {
+        case NETLINK_PKTINFO:
+        case NETLINK_BROADCAST_ERROR:
+        case NETLINK_NO_ENOBUFS:
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LISTEN_ALL_NSID:
+        case NETLINK_CAP_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
+        case NETLINK_EXT_ACK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
+        case NETLINK_GET_STRICT_CHK:
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len != sizeof(val)) {
+                return -TARGET_EINVAL;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (put_user_u32(lv, optlen)
+                || put_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
+        case NETLINK_LIST_MEMBERSHIPS:
+        {
+            uint32_t *results;
+            int i;
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            results = lock_user(VERIFY_WRITE, optval_addr, len, 1);
+            if (!results) {
+                return -TARGET_EFAULT;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, optname, results, &lv));
+            if (ret < 0) {
+                unlock_user(results, optval_addr, 0);
+                return ret;
+            }
+            /* swap host endianess to target endianess. */
+            for (i = 0; i < (len / sizeof(uint32_t)); i++) {
+                results[i] = tswap32(results[i]);
+            }
+            if (put_user_u32(lv, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            unlock_user(results, optval_addr, 0);
+            break;
+        }
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
+        default:
+            goto unimplemented;
+        }
+#endif /* SOL_NETLINK */
     default:
     unimplemented:
         gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-- 
2.21.0


