Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87452177B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4SWT7SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87452177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUv2K-0000V0-HQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUv0b-0007oz-7S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:01:13 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUv0Z-0004rt-IG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:01:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ds1so1197876pjb.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9vfxdnRCLsliVllqt/rhZ7KYxjMhIVE68F6rGYVRGI8=;
 b=c4SWT7SE6bL+6PNYDzpJ6TlgbtT73FuFzyvk9J1igWT3KUmasgTurJVm/AIkw3em+h
 MIwe8tfpZu/kigbbr3k5Vct5Pkl65y+DGZZLCmueW5xKQMFgiojz2BupFYiqNGXkl3eB
 bra6py56A4YVL8MTB8KkXcwYVVyRF5CV+nYPbg9D/1ium83fI7UrGIlQ6ZrPfUNxrvYX
 xWSCsaetiSB05dKeeNJoLcZnfxzy1fmVnqG31tqd/0XphHsrGDYeACt0PbJ9V6pkJ3Yc
 TwXKBmaqKi1pkKaoF/NAWDlXsu19WM1H6BooydwZ4tSA2HSpfY2cWZsk+jpsEz/8HlWD
 NUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9vfxdnRCLsliVllqt/rhZ7KYxjMhIVE68F6rGYVRGI8=;
 b=iwsqq8XnZdQq/5paDVq4SSsZ71Q3Aq8DiYiZ4fF4D8+gm6dYhxQmXByVdz4dANyjup
 l2B6AR6YLhNTo4eKbtdcjl86LefUm6A9erKc4VB0B4+T3Uy/EjqAO0YeGt4xGwrQUghV
 YSwTYYSru8FfXMY/WKCXJal4Rcy1wXZektjmTQ7HP78ivEzyT/iJv/GBB/BhKGsvxBs9
 3Z69zjfoQ7Yo6jMvXCIgyqb6hRK+va9AxteeqVBOfLe8/W+HOptVYQi/K0LxCc5PpQHK
 oEsYBjjtSh3mZa5nQIb125loTl1KiQlVYVZxWqEnuaBnwvmpb0osDSQAiAeOxgX5WYXD
 x/Ww==
X-Gm-Message-State: AOAM533bCVqaAL3QVzPiFjt4oBWgmrXHECfC/iNKpXkjVkjKOkRsYcdz
 /TbcskQzdM8hPmNX+76OlctmWusU6og=
X-Google-Smtp-Source: ABdhPJwiTW478eHb035jsmIY5P9juzumk5Lm7S0w1b/UrmSeJgsmdmd/ZaKLAyxhaadizHpiCeJt9g==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id
 u14mr3608130pjr.112.1603213269952; 
 Tue, 20 Oct 2020 10:01:09 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.132])
 by smtp.googlemail.com with ESMTPSA id x29sm2766161pfp.152.2020.10.20.10.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:01:09 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: qemu-devel@nongnu.org,
	ameynarkhede03@gmail.com
Subject: [PATCH 2/2] kvm: Add ioeventfd read test code
Date: Tue, 20 Oct 2020 22:30:56 +0530
Message-Id: <20201020170056.433528-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020170056.433528-1-ameynarkhede03@gmail.com>
References: <20201020170056.433528-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds kvm_set_ioeventfd_read and
dummy_notifier_read functons to test ioeventfd
read support. When the guess writes to address
provided in kvm_set_ioeventfd_read function,
dummy_notifier_read prints to stdio.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 accel/kvm/kvm-all.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9ef5daf4c5..357e74d84c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1006,6 +1006,43 @@ static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
     return val;
 }
 
+static void dummy_notifier_read(EventNotifier *n)
+{
+    printf("Received ioeventfd read event\n");
+    event_notifier_test_and_clear(n);
+}
+
+static int kvm_set_ioeventfd_read(int fd, hwaddr addr, uint64_t val,
+				  uint64_t size, bool datamatch)
+{
+	int ret;
+	struct kvm_ioeventfd ioevent = {
+        	.datamatch = datamatch ? adjust_ioeventfd_endianness(val, size) : 0,
+		.dataread = val,
+		.addr = addr,
+		.len = size,
+		.flags = KVM_IOEVENTFD_FLAG_DATAREAD,
+		.fd = fd,
+	};
+
+	if (!kvm_enabled()) {
+		return -ENOSYS;
+	}
+
+	if (datamatch) {
+            ioevent.flags |= KVM_IOEVENTFD_FLAG_DATAMATCH;
+	}
+
+	ret = kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &ioevent);
+
+	if (ret < 0) {
+		return -errno;
+	}
+
+	return 0;
+}
+
+
 static int kvm_set_ioeventfd_mmio(int fd, hwaddr addr, uint32_t val,
                                   bool assign, uint32_t size, bool datamatch)
 {
@@ -2012,6 +2049,7 @@ static int kvm_init(MachineState *ms)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
+    int efd = -1;
     int type = 0;
     const char *kvm_type;
     uint64_t dirty_log_manual_caps;
@@ -2253,6 +2291,22 @@ static int kvm_init(MachineState *ms)
     }
 
     cpus_register_accel(&kvm_cpus);
+
+    EventNotifier *e = g_malloc0(sizeof(EventNotifier));
+    ret = event_notifier_init(e, false);
+    if (ret < 0) {
+	printf("Failed to initialize EventNotifier\n");
+    }
+    else {
+        AioContext *ctx = qemu_get_aio_context();
+        efd = event_notifier_get_fd(e);
+        aio_set_event_notifier(ctx, e, false, dummy_notifier_read, NULL);
+        ret = kvm_set_ioeventfd_read(efd, 0xff01003f, 123, 8, false);
+        if (ret < 0)
+            printf("ioeventfd read failed\n");
+    }
+
+
     return 0;
 
 err:
@@ -2268,6 +2322,7 @@ err:
     return ret;
 }
 
+
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len)
 {
     s->sigmask_len = sigmask_len;
-- 
2.28.0


