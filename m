Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB37207FA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB37207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL1j-0005Fp-WC
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzr-0003P4-By
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzq-0002u1-2c
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzp-0002sz-P6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:14 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N95mR-1hpPN60MND-0167ti; Wed, 06 Nov 2019 14:05:07 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/13] linux-user: Support for NETLINK socket options
Date: Wed,  6 Nov 2019 14:04:44 +0100
Message-Id: <20191106130456.6176-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:51GPOKoHdGDAfJRNkhsy5hwU7LDAAJEiZenK2teK9K2fBwmSp8t
 JdgtMsR1PCMFA0P78nn6Dxu8YicazD7AHXeW7PQvLMfjdoTL5mrP4O3umvF1FKk5gfncgpy
 Vh9VEaJlipaxSJu6MOXotRauBHjqW2otcB3Trr/lTNIoRd4v6F80X9Trmt9eJrmMUEP76zk
 Iv+XNuXIY8EHmuPdb7G6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHzZl8154RE=:y0Kbyy6LPrjbmpfwSrBAZg
 XyiPEBG7Q4p1lHiF7YMbf0mH8pIa8YloIGCv/ai6ldKZr6z8TebyEkofJt9YX2j59SyqDCdPF
 OIOJNY9/jQrigRi1mhG+X+dpV9Sk5XBmJCazxnGwZfGJ070oVPFnxO+S9PzkHCgEKimhopbNr
 ViJljsNqePNYAgi8fcmXEiHfMx7zoL0fwHDAFDnSjXD1mL2wtsaE2F/vrw2S+4bq1mBzm722W
 Nq4pwe45uWJSsz/MJkaTuis1G9K6citjMPdeGYoCy0ax0G0slgWbX3YdpVqq+n5ueeDRCUlSL
 KN6FXNhZeqT+N96gnUpTFGTkmvkU+vGXFS60YPlDSPicQ1Og3xAYFoTMbuqey6SZp58K9oIm+
 kze7fb6alMY+wWhjCJZDLc+ibGsntSFAOr4xtBPIfcKYTdD4OtT4QaqzjVKhOBq5LlhNtj6hJ
 Vy3/5uTSzfEjMNxF7z2KMCrv9B7d+eDvVgVQokIblyhXhqS9ozrcwbIX7fhvThTKlSpc23gxC
 umHJVDwagQLL71FijtkFGNiUaUeTOkI0Il9ka9T0rU7hDFGy/m4CLh0K+K6HtofUVbShpvM1+
 8cr+m7RkzLTOAubFcu98RGJgi1mwEuYR28j7HYouH9R+ZY8tyXv3ctUSrC9P4OF5Rn9suXZsR
 srcLeIi1mV96QN5/aF7CyF5/OAtBCataVlNI66tUwScXyvitj8h+RoVa1TN9FKDyGBmeRoVGF
 xXCT7byWUjXuqp0kX1NZD77v2WeLngXVOWvv1+en+lpERB3l+kMpJCmLT6wBm5fRXp7TqML94
 exwQa0bYdTT0aBU1Wkyy51Jy5pCTmnydz+hh4dhhWF53HWVNKK4T87nuTirkcG67vJsB+lFe5
 71JJ6EenB2Spjyu4lp9w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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


