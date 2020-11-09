Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA959C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606B92083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606B92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAzj-0004DS-AG
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxa-0002Uw-8D
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxX-0005QU-Ti
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7F71AAD12;
 Mon,  9 Nov 2020 17:28:02 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 05/10] i386: move TCG accel files into accel/tcg/
Date: Mon,  9 Nov 2020 18:27:50 +0100
Message-Id: <20201109172755.16500-6-cfontana@suse.de>
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
 target/i386/{ => accel/tcg}/bpt_helper.c  |  0
 target/i386/{ => accel/tcg}/cc_helper.c   |  0
 target/i386/{ => accel/tcg}/excp_helper.c |  0
 target/i386/{ => accel/tcg}/fpu_helper.c  |  0
 target/i386/{ => accel/tcg}/int_helper.c  |  0
 target/i386/{ => accel/tcg}/mem_helper.c  |  0
 target/i386/accel/tcg/meson.build         | 13 +++++++++++++
 target/i386/{ => accel/tcg}/misc_helper.c |  0
 target/i386/{ => accel/tcg}/mpx_helper.c  |  0
 target/i386/{ => accel/tcg}/seg_helper.c  |  0
 target/i386/{ => accel/tcg}/smm_helper.c  |  0
 target/i386/{ => accel/tcg}/svm_helper.c  |  0
 target/i386/{ => accel/tcg}/tcg-stub.c    |  0
 target/i386/{ => accel/tcg}/translate.c   |  0
 target/i386/meson.build                   | 14 +-------------
 15 files changed, 14 insertions(+), 13 deletions(-)
 rename target/i386/{ => accel/tcg}/bpt_helper.c (100%)
 rename target/i386/{ => accel/tcg}/cc_helper.c (100%)
 rename target/i386/{ => accel/tcg}/excp_helper.c (100%)
 rename target/i386/{ => accel/tcg}/fpu_helper.c (100%)
 rename target/i386/{ => accel/tcg}/int_helper.c (100%)
 rename target/i386/{ => accel/tcg}/mem_helper.c (100%)
 create mode 100644 target/i386/accel/tcg/meson.build
 rename target/i386/{ => accel/tcg}/misc_helper.c (100%)
 rename target/i386/{ => accel/tcg}/mpx_helper.c (100%)
 rename target/i386/{ => accel/tcg}/seg_helper.c (100%)
 rename target/i386/{ => accel/tcg}/smm_helper.c (100%)
 rename target/i386/{ => accel/tcg}/svm_helper.c (100%)
 rename target/i386/{ => accel/tcg}/tcg-stub.c (100%)
 rename target/i386/{ => accel/tcg}/translate.c (100%)

diff --git a/target/i386/bpt_helper.c b/target/i386/accel/tcg/bpt_helper.c
similarity index 100%
rename from target/i386/bpt_helper.c
rename to target/i386/accel/tcg/bpt_helper.c
diff --git a/target/i386/cc_helper.c b/target/i386/accel/tcg/cc_helper.c
similarity index 100%
rename from target/i386/cc_helper.c
rename to target/i386/accel/tcg/cc_helper.c
diff --git a/target/i386/excp_helper.c b/target/i386/accel/tcg/excp_helper.c
similarity index 100%
rename from target/i386/excp_helper.c
rename to target/i386/accel/tcg/excp_helper.c
diff --git a/target/i386/fpu_helper.c b/target/i386/accel/tcg/fpu_helper.c
similarity index 100%
rename from target/i386/fpu_helper.c
rename to target/i386/accel/tcg/fpu_helper.c
diff --git a/target/i386/int_helper.c b/target/i386/accel/tcg/int_helper.c
similarity index 100%
rename from target/i386/int_helper.c
rename to target/i386/accel/tcg/int_helper.c
diff --git a/target/i386/mem_helper.c b/target/i386/accel/tcg/mem_helper.c
similarity index 100%
rename from target/i386/mem_helper.c
rename to target/i386/accel/tcg/mem_helper.c
diff --git a/target/i386/accel/tcg/meson.build b/target/i386/accel/tcg/meson.build
new file mode 100644
index 0000000000..02794226c2
--- /dev/null
+++ b/target/i386/accel/tcg/meson.build
@@ -0,0 +1,13 @@
+i386_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'bpt_helper.c',
+  'cc_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'int_helper.c',
+  'mem_helper.c',
+  'misc_helper.c',
+  'mpx_helper.c',
+  'seg_helper.c',
+  'smm_helper.c',
+  'svm_helper.c',
+  'translate.c'), if_false: files('tcg-stub.c'))
diff --git a/target/i386/misc_helper.c b/target/i386/accel/tcg/misc_helper.c
similarity index 100%
rename from target/i386/misc_helper.c
rename to target/i386/accel/tcg/misc_helper.c
diff --git a/target/i386/mpx_helper.c b/target/i386/accel/tcg/mpx_helper.c
similarity index 100%
rename from target/i386/mpx_helper.c
rename to target/i386/accel/tcg/mpx_helper.c
diff --git a/target/i386/seg_helper.c b/target/i386/accel/tcg/seg_helper.c
similarity index 100%
rename from target/i386/seg_helper.c
rename to target/i386/accel/tcg/seg_helper.c
diff --git a/target/i386/smm_helper.c b/target/i386/accel/tcg/smm_helper.c
similarity index 100%
rename from target/i386/smm_helper.c
rename to target/i386/accel/tcg/smm_helper.c
diff --git a/target/i386/svm_helper.c b/target/i386/accel/tcg/svm_helper.c
similarity index 100%
rename from target/i386/svm_helper.c
rename to target/i386/accel/tcg/svm_helper.c
diff --git a/target/i386/tcg-stub.c b/target/i386/accel/tcg/tcg-stub.c
similarity index 100%
rename from target/i386/tcg-stub.c
rename to target/i386/accel/tcg/tcg-stub.c
diff --git a/target/i386/translate.c b/target/i386/accel/tcg/translate.c
similarity index 100%
rename from target/i386/translate.c
rename to target/i386/accel/tcg/translate.c
diff --git a/target/i386/meson.build b/target/i386/meson.build
index da070e4e54..55a5b27f1d 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -5,19 +5,6 @@ i386_ss.add(files(
   'helper.c',
   'xsave_helper.c',
 ))
-i386_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'bpt_helper.c',
-  'cc_helper.c',
-  'excp_helper.c',
-  'fpu_helper.c',
-  'int_helper.c',
-  'mem_helper.c',
-  'misc_helper.c',
-  'mpx_helper.c',
-  'seg_helper.c',
-  'smm_helper.c',
-  'svm_helper.c',
-  'translate.c'), if_false: files('tcg-stub.c'))
 i386_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-stub.c'))
 
 i386_softmmu_ss = ss.source_set()
@@ -32,6 +19,7 @@ subdir('accel/kvm')
 subdir('accel/hax')
 subdir('accel/whpx')
 subdir('accel/hvf')
+subdir('accel/tcg')
 
 target_arch += {'i386': i386_ss}
 target_softmmu_arch += {'i386': i386_softmmu_ss}
-- 
2.26.2


