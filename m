Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51170C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71592078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmWAH8aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71592078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjAm-0007lt-LI
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPj88-0005aV-JF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPj85-0007aH-4z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601975967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRBkJ5PYq3eSKF/e3ogfuBzCz5aI+nbfhvCuifeFG5A=;
 b=XmWAH8aC/nz3xssKQsqbi91JO+6p7fH9ED5mglOxISq4BhjvUmOmXubUXbPMz6Z1ID07p2
 KSyMwCL7/4CsI/It5OWKcaeR894rNAgkU5qK4K5c7rX/yNzcqc3MaIufQD4mWb6ARFBV7l
 mwTlCx1b2P60oPlrpi26DnGnNLliRLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-WhDayyMLPWWQ6GGQpLos7w-1; Tue, 06 Oct 2020 05:19:24 -0400
X-MC-Unique: WhDayyMLPWWQ6GGQpLos7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F065510BBEC0
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 09:19:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B544D10013DB
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 09:19:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] softmmu: move more files to softmmu/
Date: Tue,  6 Oct 2020 05:19:21 -0400
Message-Id: <20201006091922.331832-2-pbonzini@redhat.com>
In-Reply-To: <20201006091922.331832-1-pbonzini@redhat.com>
References: <20201006091922.331832-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Keep most softmmu_ss files into the system-emulation-specific
directory.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                              | 10 ----------
 bootdevice.c => softmmu/bootdevice.c     |  0
 device_tree.c => softmmu/device_tree.c   |  0
 dma-helpers.c => softmmu/dma-helpers.c   |  0
 softmmu/meson.build                      | 10 ++++++++++
 qdev-monitor.c => softmmu/qdev-monitor.c |  0
 qemu-seccomp.c => softmmu/qemu-seccomp.c |  0
 tpm.c => softmmu/tpm.c                   |  0
 8 files changed, 10 insertions(+), 10 deletions(-)
 rename bootdevice.c => softmmu/bootdevice.c (100%)
 rename device_tree.c => softmmu/device_tree.c (100%)
 rename dma-helpers.c => softmmu/dma-helpers.c (100%)
 rename qdev-monitor.c => softmmu/qdev-monitor.c (100%)
 rename qemu-seccomp.c => softmmu/qemu-seccomp.c (100%)
 rename tpm.c => softmmu/tpm.c (100%)

diff --git a/meson.build b/meson.build
index 17c89c87c6..0e0577e81e 100644
--- a/meson.build
+++ b/meson.build
@@ -1360,17 +1360,7 @@ blockdev_ss.add(files(
 # os-win32.c does not
 blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
 softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
-
 softmmu_ss.add_all(blockdev_ss)
-softmmu_ss.add(files(
-  'bootdevice.c',
-  'dma-helpers.c',
-  'qdev-monitor.c',
-), sdl)
-
-softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
-softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
-softmmu_ss.add(when: fdt, if_true: files('device_tree.c'))
 
 common_ss.add(files('cpus-common.c'))
 
diff --git a/bootdevice.c b/softmmu/bootdevice.c
similarity index 100%
rename from bootdevice.c
rename to softmmu/bootdevice.c
diff --git a/device_tree.c b/softmmu/device_tree.c
similarity index 100%
rename from device_tree.c
rename to softmmu/device_tree.c
diff --git a/dma-helpers.c b/softmmu/dma-helpers.c
similarity index 100%
rename from dma-helpers.c
rename to softmmu/dma-helpers.c
diff --git a/softmmu/meson.build b/softmmu/meson.build
index 36c96e7b15..862ab24878 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -14,3 +14,13 @@ specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files(
 specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: [files(
   'icount.c'
 )])
+
+softmmu_ss.add(files(
+  'bootdevice.c',
+  'dma-helpers.c',
+  'qdev-monitor.c',
+), sdl)
+
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
+softmmu_ss.add(when: fdt, if_true: files('device_tree.c'))
diff --git a/qdev-monitor.c b/softmmu/qdev-monitor.c
similarity index 100%
rename from qdev-monitor.c
rename to softmmu/qdev-monitor.c
diff --git a/qemu-seccomp.c b/softmmu/qemu-seccomp.c
similarity index 100%
rename from qemu-seccomp.c
rename to softmmu/qemu-seccomp.c
diff --git a/tpm.c b/softmmu/tpm.c
similarity index 100%
rename from tpm.c
rename to softmmu/tpm.c
-- 
2.26.2



