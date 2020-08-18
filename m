Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E35C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207FA206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMN8hIUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207FA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84kw-00017z-9o
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jo-0007mK-NA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jm-0007GS-Rl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuA3dSLI/gGfSrEgYmyI+qJh4j0OmglQV0RfJbX8r0k=;
 b=EMN8hIUGfH3E2B7RxSLP7CVFiaDgHAXNTHooSlLtQexl0HXu5UwEOEnZAiYxDdxi+vfwfc
 60HeOBQPU/c9dHjhVO4nuneLXc94hBbwyI+c68a8OYak4WwaXEXbYXhEh7mTc3E+cpxovJ
 ngo4j+UjiiZRT+tyPAvqIoHkDHshZSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-mz5BBBhpPamWC0zKR6U4lQ-1; Tue, 18 Aug 2020 12:45:24 -0400
X-MC-Unique: mz5BBBhpPamWC0zKR6U4lQ-1
Received: by mail-wm1-f71.google.com with SMTP id z10so7608611wmi.8
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TuA3dSLI/gGfSrEgYmyI+qJh4j0OmglQV0RfJbX8r0k=;
 b=UnS2M6XQCxHF9moslmMPzTDt8f0oNTu0O69K/NCzUKTkkvIPV/okNlNk6dzSwKMrQh
 /CSoXuUtxoCc0iQx6rZS25NKfQgJ4BzehOvY/97k/eum86f/69K117NztD5dP7QydLYt
 r8J30sbP4pCDoc+Wx0Csjx0g9XwtdAxyJzRs7kndZF1WrbV6T0JHanuGhPwI4Fslqmkx
 qn7cBp7xCD2iNQWeQyH17J8+GOjfWw0+uCly7/NoMhzHryUC3iwnUhrlpGpBUlbVlWN1
 tKa/IPgLCfNyzzuT/cDdB8eYCtG0SOn0LALOakU0lJOek3h+UgE15mw1TU2MmtWv5Lu5
 c+GA==
X-Gm-Message-State: AOAM533HNj28WITtWeR2YTvmWW4BDgP3d4Gw62ZjFGrw14vr39Kx3P/D
 3a5exxU0XNjknDkipqNsaZGV2KrXIi10G0hQkgBK/bvQUlCpoGlXnek5EDFHwAp+2pp0V9Irj+M
 HVcjslsdQUES3Z44=
X-Received: by 2002:adf:a4d7:: with SMTP id h23mr140511wrb.276.1597769121970; 
 Tue, 18 Aug 2020 09:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUsn0wsNfdu2PLp3XvmehHVv0VO67fiSj3ttqMjB3NgtTJU/SuKb3AXwe7ebO5TM2LBVi8pg==
X-Received: by 2002:adf:a4d7:: with SMTP id h23mr140482wrb.276.1597769121695; 
 Tue, 18 Aug 2020 09:45:21 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm649939wmf.47.2020.08.18.09.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 2/5] util/vfio-helpers: Report error on unsupported
 host architectures
Date: Tue, 18 Aug 2020 18:45:06 +0200
Message-Id: <20200818164509.736367-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818164509.736367-1-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Drew Jones <drjones@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vfio-helpers implementation expects a TYPEv1 IOMMU, see
qemu_vfio_init_pci:

  263     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
  264         error_setg_errno(errp, errno, "VFIO IOMMU check failed");

Thus POWER SPAPR IOMMU is obviously not supported.

The implementation only cares about host page size alignment
(usually 4KB on X86), not the IOMMU one, which is be problematic
on Aarch64, when 64MB page size is used. So Aarch64 is not
supported neither.

Report an error when the host architecture is different than X86:

 $ qemu-system-aarch64 \
    -drive file=nvme://0001:01:00.0/1,if=none,id=drive0 \
    -device virtio-blk-pci,drive=drive0
  qemu-system-aarch64: -drive file=nvme://0001:01:00.0/1,if=none,id=drive0: QEMU VFIO utility is not supported on this architecture

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Drew Jones <drjones@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
---
 util/vfio-helpers.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index e399e330e26..60017936e3e 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -420,14 +420,38 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
     qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
 }
 
+/**
+ * Return if the host architecture is supported.
+ *
+ * aarch64: IOMMU page alignment not respected
+ * ppc64:   SPAPR IOMMU window not configured
+ * x86-64:  Only architecture validated
+ * other:   Untested
+ */
+static bool qemu_vfio_arch_supported(void)
+{
+    bool supported = false;
+
+#if defined(HOST_X86_64)
+    supported = true;
+#endif
+
+    return supported;
+}
 /**
  * Open a PCI device, e.g. "0000:00:01.0".
  */
 QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
 {
     int r;
-    QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
+    QEMUVFIOState *s;
 
+    if (!qemu_vfio_arch_supported()) {
+        error_setg(errp,
+                   "QEMU VFIO utility is not supported on this architecture");
+        return NULL;
+    }
+    s = g_new0(QEMUVFIOState, 1);
     r = qemu_vfio_init_pci(s, device, errp);
     if (r) {
         g_free(s);
-- 
2.26.2


