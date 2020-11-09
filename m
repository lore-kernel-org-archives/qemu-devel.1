Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B3C55ABD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8382083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8382083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAzl-0004K9-OA
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxX-0002PK-QD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxV-0005PD-70
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E5692AD07;
 Mon,  9 Nov 2020 17:27:59 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 02/10] i386: move whpx accel files to accel/whpx/
Date: Mon,  9 Nov 2020 18:27:47 +0100
Message-Id: <20201109172755.16500-3-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109172755.16500-1-cfontana@suse.de>
References: <20201109172755.16500-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:17:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Claudio Fontana <cfontana@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 Bruce Rogers <brogers@suse.com>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 MAINTAINERS                                 | 5 +----
 target/i386/accel/whpx/meson.build          | 4 ++++
 target/i386/{ => accel/whpx}/whp-dispatch.h | 0
 target/i386/{ => accel/whpx}/whpx-all.c     | 0
 target/i386/{ => accel/whpx}/whpx-cpus.c    | 0
 target/i386/{ => accel/whpx}/whpx-cpus.h    | 0
 target/i386/meson.build                     | 5 +----
 7 files changed, 6 insertions(+), 8 deletions(-)
 create mode 100644 target/i386/accel/whpx/meson.build
 rename target/i386/{ => accel/whpx}/whp-dispatch.h (100%)
 rename target/i386/{ => accel/whpx}/whpx-all.c (100%)
 rename target/i386/{ => accel/whpx}/whpx-cpus.c (100%)
 rename target/i386/{ => accel/whpx}/whpx-cpus.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ce9b36c02..41b613b6a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -446,10 +446,7 @@ F: include/sysemu/hvf.h
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
-F: target/i386/whpx-all.c
-F: target/i386/whpx-cpus.c
-F: target/i386/whp-dispatch.h
-F: accel/stubs/whpx-stub.c
+F: target/i386/accel/whpx/
 F: include/sysemu/whpx.h
 
 Guest CPU Cores (Xen)
diff --git a/target/i386/accel/whpx/meson.build b/target/i386/accel/whpx/meson.build
new file mode 100644
index 0000000000..94a72c8efc
--- /dev/null
+++ b/target/i386/accel/whpx/meson.build
@@ -0,0 +1,4 @@
+i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'whpx-all.c',
+  'whpx-cpus.c',
+))
diff --git a/target/i386/whp-dispatch.h b/target/i386/accel/whpx/whp-dispatch.h
similarity index 100%
rename from target/i386/whp-dispatch.h
rename to target/i386/accel/whpx/whp-dispatch.h
diff --git a/target/i386/whpx-all.c b/target/i386/accel/whpx/whpx-all.c
similarity index 100%
rename from target/i386/whpx-all.c
rename to target/i386/accel/whpx/whpx-all.c
diff --git a/target/i386/whpx-cpus.c b/target/i386/accel/whpx/whpx-cpus.c
similarity index 100%
rename from target/i386/whpx-cpus.c
rename to target/i386/accel/whpx/whpx-cpus.c
diff --git a/target/i386/whpx-cpus.h b/target/i386/accel/whpx/whpx-cpus.h
similarity index 100%
rename from target/i386/whpx-cpus.h
rename to target/i386/accel/whpx/whpx-cpus.h
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 629939b195..6c43b7bfb0 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -27,10 +27,6 @@ i386_softmmu_ss.add(files(
   'machine.c',
   'monitor.c',
 ))
-i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files(
-  'whpx-all.c',
-  'whpx-cpus.c',
-))
 i386_softmmu_ss.add(when: 'CONFIG_HAX', if_true: files(
   'hax-all.c',
   'hax-mem.c',
@@ -40,6 +36,7 @@ i386_softmmu_ss.add(when: ['CONFIG_HAX', 'CONFIG_POSIX'], if_true: files('hax-po
 i386_softmmu_ss.add(when: ['CONFIG_HAX', 'CONFIG_WIN32'], if_true: files('hax-windows.c'))
 
 subdir('accel/kvm')
+subdir('accel/whpx')
 subdir('hvf')
 
 target_arch += {'i386': i386_ss}
-- 
2.26.2


