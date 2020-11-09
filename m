Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B34C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1518B2083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1518B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcB3f-00009C-2f
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxZ-0002Ss-BT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:56548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxW-0005QE-Tv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A4F0FAD11;
 Mon,  9 Nov 2020 17:28:01 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 04/10] i386: move hvf accel files into accel/hvf/
Date: Mon,  9 Nov 2020 18:27:49 +0100
Message-Id: <20201109172755.16500-5-cfontana@suse.de>
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
 MAINTAINERS                              | 3 +--
 target/i386/{ => accel}/hvf/README.md    | 0
 target/i386/{ => accel}/hvf/hvf-cpus.c   | 0
 target/i386/{ => accel}/hvf/hvf-cpus.h   | 0
 target/i386/{ => accel}/hvf/hvf-i386.h   | 0
 target/i386/{ => accel}/hvf/hvf.c        | 0
 target/i386/{ => accel}/hvf/meson.build  | 0
 target/i386/{ => accel}/hvf/panic.h      | 0
 target/i386/{ => accel}/hvf/vmcs.h       | 0
 target/i386/{ => accel}/hvf/vmx.h        | 0
 target/i386/{ => accel}/hvf/x86.c        | 0
 target/i386/{ => accel}/hvf/x86.h        | 0
 target/i386/{ => accel}/hvf/x86_cpuid.c  | 0
 target/i386/{ => accel}/hvf/x86_decode.c | 0
 target/i386/{ => accel}/hvf/x86_decode.h | 0
 target/i386/{ => accel}/hvf/x86_descr.c  | 0
 target/i386/{ => accel}/hvf/x86_descr.h  | 0
 target/i386/{ => accel}/hvf/x86_emu.c    | 0
 target/i386/{ => accel}/hvf/x86_emu.h    | 0
 target/i386/{ => accel}/hvf/x86_flags.c  | 0
 target/i386/{ => accel}/hvf/x86_flags.h  | 0
 target/i386/{ => accel}/hvf/x86_mmu.c    | 0
 target/i386/{ => accel}/hvf/x86_mmu.h    | 0
 target/i386/{ => accel}/hvf/x86_task.c   | 0
 target/i386/{ => accel}/hvf/x86_task.h   | 0
 target/i386/{ => accel}/hvf/x86hvf.c     | 0
 target/i386/{ => accel}/hvf/x86hvf.h     | 0
 target/i386/meson.build                  | 2 +-
 28 files changed, 2 insertions(+), 3 deletions(-)
 rename target/i386/{ => accel}/hvf/README.md (100%)
 rename target/i386/{ => accel}/hvf/hvf-cpus.c (100%)
 rename target/i386/{ => accel}/hvf/hvf-cpus.h (100%)
 rename target/i386/{ => accel}/hvf/hvf-i386.h (100%)
 rename target/i386/{ => accel}/hvf/hvf.c (100%)
 rename target/i386/{ => accel}/hvf/meson.build (100%)
 rename target/i386/{ => accel}/hvf/panic.h (100%)
 rename target/i386/{ => accel}/hvf/vmcs.h (100%)
 rename target/i386/{ => accel}/hvf/vmx.h (100%)
 rename target/i386/{ => accel}/hvf/x86.c (100%)
 rename target/i386/{ => accel}/hvf/x86.h (100%)
 rename target/i386/{ => accel}/hvf/x86_cpuid.c (100%)
 rename target/i386/{ => accel}/hvf/x86_decode.c (100%)
 rename target/i386/{ => accel}/hvf/x86_decode.h (100%)
 rename target/i386/{ => accel}/hvf/x86_descr.c (100%)
 rename target/i386/{ => accel}/hvf/x86_descr.h (100%)
 rename target/i386/{ => accel}/hvf/x86_emu.c (100%)
 rename target/i386/{ => accel}/hvf/x86_emu.h (100%)
 rename target/i386/{ => accel}/hvf/x86_flags.c (100%)
 rename target/i386/{ => accel}/hvf/x86_flags.h (100%)
 rename target/i386/{ => accel}/hvf/x86_mmu.c (100%)
 rename target/i386/{ => accel}/hvf/x86_mmu.h (100%)
 rename target/i386/{ => accel}/hvf/x86_task.c (100%)
 rename target/i386/{ => accel}/hvf/x86_task.h (100%)
 rename target/i386/{ => accel}/hvf/x86hvf.c (100%)
 rename target/i386/{ => accel}/hvf/x86hvf.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dabd972c9..dd16c78f97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -439,8 +439,7 @@ M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
-F: accel/stubs/hvf-stub.c
-F: target/i386/hvf/
+F: target/i386/accel/hvf/
 F: include/sysemu/hvf.h
 
 WHPX CPUs
diff --git a/target/i386/hvf/README.md b/target/i386/accel/hvf/README.md
similarity index 100%
rename from target/i386/hvf/README.md
rename to target/i386/accel/hvf/README.md
diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/accel/hvf/hvf-cpus.c
similarity index 100%
rename from target/i386/hvf/hvf-cpus.c
rename to target/i386/accel/hvf/hvf-cpus.c
diff --git a/target/i386/hvf/hvf-cpus.h b/target/i386/accel/hvf/hvf-cpus.h
similarity index 100%
rename from target/i386/hvf/hvf-cpus.h
rename to target/i386/accel/hvf/hvf-cpus.h
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/accel/hvf/hvf-i386.h
similarity index 100%
rename from target/i386/hvf/hvf-i386.h
rename to target/i386/accel/hvf/hvf-i386.h
diff --git a/target/i386/hvf/hvf.c b/target/i386/accel/hvf/hvf.c
similarity index 100%
rename from target/i386/hvf/hvf.c
rename to target/i386/accel/hvf/hvf.c
diff --git a/target/i386/hvf/meson.build b/target/i386/accel/hvf/meson.build
similarity index 100%
rename from target/i386/hvf/meson.build
rename to target/i386/accel/hvf/meson.build
diff --git a/target/i386/hvf/panic.h b/target/i386/accel/hvf/panic.h
similarity index 100%
rename from target/i386/hvf/panic.h
rename to target/i386/accel/hvf/panic.h
diff --git a/target/i386/hvf/vmcs.h b/target/i386/accel/hvf/vmcs.h
similarity index 100%
rename from target/i386/hvf/vmcs.h
rename to target/i386/accel/hvf/vmcs.h
diff --git a/target/i386/hvf/vmx.h b/target/i386/accel/hvf/vmx.h
similarity index 100%
rename from target/i386/hvf/vmx.h
rename to target/i386/accel/hvf/vmx.h
diff --git a/target/i386/hvf/x86.c b/target/i386/accel/hvf/x86.c
similarity index 100%
rename from target/i386/hvf/x86.c
rename to target/i386/accel/hvf/x86.c
diff --git a/target/i386/hvf/x86.h b/target/i386/accel/hvf/x86.h
similarity index 100%
rename from target/i386/hvf/x86.h
rename to target/i386/accel/hvf/x86.h
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/accel/hvf/x86_cpuid.c
similarity index 100%
rename from target/i386/hvf/x86_cpuid.c
rename to target/i386/accel/hvf/x86_cpuid.c
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/accel/hvf/x86_decode.c
similarity index 100%
rename from target/i386/hvf/x86_decode.c
rename to target/i386/accel/hvf/x86_decode.c
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/accel/hvf/x86_decode.h
similarity index 100%
rename from target/i386/hvf/x86_decode.h
rename to target/i386/accel/hvf/x86_decode.h
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/accel/hvf/x86_descr.c
similarity index 100%
rename from target/i386/hvf/x86_descr.c
rename to target/i386/accel/hvf/x86_descr.c
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/accel/hvf/x86_descr.h
similarity index 100%
rename from target/i386/hvf/x86_descr.h
rename to target/i386/accel/hvf/x86_descr.h
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/accel/hvf/x86_emu.c
similarity index 100%
rename from target/i386/hvf/x86_emu.c
rename to target/i386/accel/hvf/x86_emu.c
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/accel/hvf/x86_emu.h
similarity index 100%
rename from target/i386/hvf/x86_emu.h
rename to target/i386/accel/hvf/x86_emu.h
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/accel/hvf/x86_flags.c
similarity index 100%
rename from target/i386/hvf/x86_flags.c
rename to target/i386/accel/hvf/x86_flags.c
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/accel/hvf/x86_flags.h
similarity index 100%
rename from target/i386/hvf/x86_flags.h
rename to target/i386/accel/hvf/x86_flags.h
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/accel/hvf/x86_mmu.c
similarity index 100%
rename from target/i386/hvf/x86_mmu.c
rename to target/i386/accel/hvf/x86_mmu.c
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/accel/hvf/x86_mmu.h
similarity index 100%
rename from target/i386/hvf/x86_mmu.h
rename to target/i386/accel/hvf/x86_mmu.h
diff --git a/target/i386/hvf/x86_task.c b/target/i386/accel/hvf/x86_task.c
similarity index 100%
rename from target/i386/hvf/x86_task.c
rename to target/i386/accel/hvf/x86_task.c
diff --git a/target/i386/hvf/x86_task.h b/target/i386/accel/hvf/x86_task.h
similarity index 100%
rename from target/i386/hvf/x86_task.h
rename to target/i386/accel/hvf/x86_task.h
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/accel/hvf/x86hvf.c
similarity index 100%
rename from target/i386/hvf/x86hvf.c
rename to target/i386/accel/hvf/x86hvf.c
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/accel/hvf/x86hvf.h
similarity index 100%
rename from target/i386/hvf/x86hvf.h
rename to target/i386/accel/hvf/x86hvf.h
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 34ec93dbef..da070e4e54 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -31,7 +31,7 @@ i386_softmmu_ss.add(files(
 subdir('accel/kvm')
 subdir('accel/hax')
 subdir('accel/whpx')
-subdir('hvf')
+subdir('accel/hvf')
 
 target_arch += {'i386': i386_ss}
 target_softmmu_arch += {'i386': i386_softmmu_ss}
-- 
2.26.2


