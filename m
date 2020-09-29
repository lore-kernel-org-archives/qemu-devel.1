Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 01:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C957F2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eq34jlJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C957F2083B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN4l1-0008VG-QS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 21:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VJJyXwMKCkUzj3nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--scw.bounces.google.com>)
 id 1kN4kT-00084u-0U
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:48:09 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:36014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VJJyXwMKCkUzj3nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--scw.bounces.google.com>)
 id 1kN4kR-0000wH-3g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:48:08 -0400
Received: by mail-yb1-xb49.google.com with SMTP id z40so3136552ybi.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 18:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=p6iy/h0tkjRCW6HiNRSv1A8FGLIvu9v9SXgGqb3DxyU=;
 b=eq34jlJgFUMnmc5GiEDG6lkDiXBBsmQnuAhzQG1Bykwy0J6tjLAOpEaPYL25kHE+2D
 kfyoM5vRTNHL6RL2y69pvIFkVgaedbfoRudeJLg1jpkYpu7Ojmg4oq+EJshV/jlXwAP+
 hVTrCjqUMKWXNIn+VjJCd+Px4bjooVLIFH2rJm0plo4CI4SrdMjgTR5yeXz03a4GPnEc
 7mDwArjpnVPDMQLQB25r2XuRg/119gdcOvwR71VND746K6QXeL/IaHNsoim0AvSo95S/
 og2ddNYkW8ACwGhs2lST++xGYXhydF7eRrPYreQMJatSP+HQa9Zsj1O08f9u4yUremWX
 u6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=p6iy/h0tkjRCW6HiNRSv1A8FGLIvu9v9SXgGqb3DxyU=;
 b=LPh/XrU+9hrxCke++rIhhO+RpyfrPmg4/luVTRv2AKB+YDMZEgRXAtD7MfIO4YfmbL
 dsQDKe8SzpebuVn8u+diynu+nEtrLzauzgIzd67IEvY49TYjXNBUzNgg0iqPTNBnhm6P
 WcLOHldf2F5mDWdpY1pn/x7AixesFQ+Gaki4m4J5B4aq89iM9ptKSDkbpVm41F0uNayL
 GMPY1sL1HzK/pI/Xa2Q/aSyLOkNyI7Z5z6aGzkIkLFEUCdD1njbMfJ4gCp+LxjGf/giv
 I1qBBVr4egPnJ6VKAVdXh+1VEHgbberb/JuppNazXl4QnOVMUSYKopjNw0OVGW4pSrMJ
 TelQ==
X-Gm-Message-State: AOAM530ysRwXv63IULQ7om1ICw+nwcNFQl2ZtYfsBrKRUK/ymn0poyQL
 aUe/OMucKvVkXNRteRL2gvzYNI3bvQ+vjuhQ6LyZeGepBlycmj2ZUT/9FMfrjHNkD3Fg8/2JIVh
 kjHGWmSi7RdB0rovfmazIjKo3S60HMPaLigsVzZfyccRxYu0ayNZf
X-Google-Smtp-Source: ABdhPJz2gKuNvDPa8M/OyvQKDlNyWwK8/9RZnW2o5aOeg2ZblXRI+9eA9vNDJ/gjJi8BVQNzfJWHBQw=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2ce:200:f693:9fff:fef4:29b5])
 (user=scw job=sendgmr) by 2002:a25:4688:: with SMTP id
 t130mr3021631yba.345.1601344084241; 
 Mon, 28 Sep 2020 18:48:04 -0700 (PDT)
Date: Mon, 28 Sep 2020 18:48:01 -0700
Message-Id: <20200929014801.655524-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4] linux-user: Add most IFTUN ioctls
To: qemu-devel@nongnu.org, laurent@vivier.eu
Cc: Shu-Chun Weng <scw@google.com>, riku.voipio@iki.fi,
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3VJJyXwMKCkUzj3nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Shu-Chun Weng <scw@google.com>
From: Shu-Chun Weng via <qemu-devel@nongnu.org>

The three options handling `struct sock_fprog` (TUNATTACHFILTER,
TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel
keeps a user space pointer in them which we cannot correctly handle.

Signed-off-by: Josh Kunz <jkz@google.com>
Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v2->v3:
  IOCTL_SPECIAL(TUNSETTXFILTER) type changed to MK_PTR(TYPE_PTRVOID) for strace
  to display the raw pointer.

  Updated do_ioctl_TUNSETTXFILTER for correct usages of unlock_user() and
  offsetof().

v3->v4:
  IOCTL_SPECIAL(TUNSETTXFILTER) corrected to TYPE_PTRVOID.

 linux-user/ioctls.h       | 46 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      | 38 ++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 32 +++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..c6e5926eb4 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -593,3 +593,49 @@
   IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
   IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
 #endif
+
+  IOCTL(TUNSETDEBUG,     IOC_W, TYPE_INT)
+  IOCTL(TUNSETIFF,       IOC_RW, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNSETPERSIST,   IOC_W, TYPE_INT)
+  IOCTL(TUNSETOWNER,     IOC_W, TYPE_INT)
+  IOCTL(TUNSETLINK,      IOC_W, TYPE_INT)
+  IOCTL(TUNSETGROUP,     IOC_W, TYPE_INT)
+  IOCTL(TUNGETFEATURES,  IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETOFFLOAD,   IOC_W, TYPE_LONG)
+  IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,
+                /*
+                 * We can't represent `struct tun_filter` in thunk so leaving
+                 * it uninterpreted. do_ioctl_TUNSETTXFILTER will do the
+                 * conversion.
+                 */
+                TYPE_PTRVOID)
+  IOCTL(TUNGETIFF,       IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNGETSNDBUF,    IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETSNDBUF,    IOC_W, MK_PTR(TYPE_INT))
+  /*
+   * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
+   * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
+   */
+  IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNSETQUEUE,     IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(TUNSETIFINDEX ,  IOC_W, MK_PTR(TYPE_INT))
+  /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
+  IOCTL(TUNSETVNETLE,    IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNGETVNETLE,    IOC_R, MK_PTR(TYPE_INT))
+#ifdef TUNSETVNETBE
+  IOCTL(TUNSETVNETBE,    IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(TUNGETVNETBE,    IOC_R, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETSTEERINGEBPF
+  IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETFILTEREBPF
+  IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNSETCARRIER
+  IOCTL(TUNSETCARRIER,   IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef TUNGETDEVNETNS
+  IOCTL(TUNGETDEVNETNS,  IOC_R, TYPE_NULL)
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..1c955bc675 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -56,6 +56,7 @@
 #include <linux/wireless.h>
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
+#include <linux/if_tun.h>
 #include <linux/errqueue.h>
 #include <linux/random.h>
 #ifdef CONFIG_TIMERFD
@@ -5415,6 +5416,43 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
 
 #endif
 
+static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                        int fd, int cmd, abi_long arg)
+{
+    struct tun_filter *filter = (struct tun_filter *)buf_temp;
+    struct tun_filter *target_filter;
+    char *target_addr;
+
+    assert(ie->access == IOC_W);
+
+    target_filter = lock_user(VERIFY_READ, arg, sizeof(*target_filter), 1);
+    if (!target_filter) {
+        return -TARGET_EFAULT;
+    }
+    filter->flags = tswap16(target_filter->flags);
+    filter->count = tswap16(target_filter->count);
+    unlock_user(target_filter, arg, 0);
+
+    if (filter->count) {
+        if (offsetof(struct tun_filter, addr) + filter->count * ETH_ALEN >
+            MAX_STRUCT_SIZE) {
+            return -TARGET_EFAULT;
+        }
+
+        target_addr = lock_user(VERIFY_READ,
+                                arg + offsetof(struct tun_filter, addr),
+                                filter->count * ETH_ALEN, 1);
+        if (!target_addr) {
+            return -TARGET_EFAULT;
+        }
+        memcpy(filter->addr, target_addr, filter->count * ETH_ALEN);
+        unlock_user(target_addr, arg + offsetof(struct tun_filter, addr),
+                    filter->count * ETH_ALEN);
+    }
+
+    return get_errno(safe_ioctl(fd, ie->host_cmd, filter));
+}
+
 IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..7ef0ff0328 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -891,6 +891,38 @@ struct target_rtc_pll_info {
 
 #define TARGET_SIOCGIWNAME     0x8B01          /* get name == wireless protocol */
 
+/* From <linux/if_tun.h> */
+
+#define TARGET_TUNSETDEBUG        TARGET_IOW('T', 201, int)
+#define TARGET_TUNSETIFF          TARGET_IOW('T', 202, int)
+#define TARGET_TUNSETPERSIST      TARGET_IOW('T', 203, int)
+#define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, int)
+#define TARGET_TUNSETLINK         TARGET_IOW('T', 205, int)
+#define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, int)
+#define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, unsigned int)
+#define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, unsigned int)
+#define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, unsigned int)
+#define TARGET_TUNGETIFF          TARGET_IOR('T', 210, unsigned int)
+#define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, int)
+#define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, int)
+/*
+ * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel keeps a
+ * user pointer in TUNATTACHFILTER, which we are not able to correctly handle.
+ */
+#define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, int)
+#define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, int)
+#define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, int)
+#define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, unsigned int)
+/* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
+#define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, int)
+#define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, int)
+#define TARGET_TUNSETVNETBE       TARGET_IOW('T', 222, int)
+#define TARGET_TUNGETVNETBE       TARGET_IOR('T', 223, int)
+#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR('T', 224, int)
+#define TARGET_TUNSETFILTEREBPF   TARGET_IOR('T', 225, int)
+#define TARGET_TUNSETCARRIER      TARGET_IOW('T', 226, int)
+#define TARGET_TUNGETDEVNETNS     TARGET_IO('T', 227)
+
 /* From <linux/random.h> */
 
 #define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, int)
-- 
2.28.0.709.gb0816b6eb0-goog


