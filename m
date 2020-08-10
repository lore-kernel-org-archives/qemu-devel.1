Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E079C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E129D207DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nub5KPLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E129D207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BNV-00062q-3n
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIi-0005VN-87
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIc-0002hX-1D
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=RFLnPqNKmzotlWEsfNCCMdomt8UhXSpqFfmgTAwVeR4=;
 b=Nub5KPLwUsOlc7fHYSOubyJJgPxBfpOYv+oq2diat6EqHz4qQPU9k0DzAX6ZAix8UzJiAw
 6wGkA91YemAOjzJaRiaJFeQEpFj57WTIDecc0bb2sZdrBAIO8n74fREVDW3qw9YPZ3SiV8
 ljPqWN6Vdb9X2ZwPW+iSMICu2Ii7Ips=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-Uf59eXW8M1imd3uc1pUvZQ-1; Mon, 10 Aug 2020 13:09:22 -0400
X-MC-Unique: Uf59eXW8M1imd3uc1pUvZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C84800477
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:22 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 585B45F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 005/147] meson: rename .inc.c files to .inc
Date: Mon, 10 Aug 2020 19:06:43 +0200
Message-Id: <1597079345-42801-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                                         |  4 +--
 Makefile                                           | 36 +++++++++----------
 .../tcg/{atomic_common.inc.c => atomic_common.inc} |  0
 accel/tcg/cputlb.c                                 |  2 +-
 accel/tcg/user-exec.c                              |  2 +-
 contrib/gitdm/filetypes.txt                        |  2 +-
 exec.c                                             |  4 +--
 ...t-specialize.inc.c => softfloat-specialize.inc} |  0
 fpu/softfloat.c                                    |  2 +-
 include/tcg/tcg.h                                  |  2 +-
 memory_ldst.inc.c => memory_ldst.inc               |  0
 scripts/clean-includes                             |  2 +-
 target/arm/Makefile.objs                           | 40 +++++++++++-----------
 .../{translate-neon.inc.c => translate-neon.inc}   |  6 ++--
 target/arm/translate-sve.c                         |  2 +-
 .../arm/{translate-vfp.inc.c => translate-vfp.inc} |  4 +--
 target/arm/translate.c                             | 12 +++----
 target/avr/Makefile.objs                           |  4 +--
 target/avr/disas.c                                 |  2 +-
 target/avr/translate.c                             |  2 +-
 target/cris/translate.c                            |  2 +-
 .../{translate_v10.inc.c => translate_v10.inc}     |  0
 target/hppa/Makefile.objs                          |  4 +--
 target/hppa/translate.c                            |  2 +-
 target/mips/translate.c                            |  2 +-
 .../{translate_init.inc.c => translate_init.inc}   |  0
 target/openrisc/Makefile.objs                      |  6 ++--
 target/openrisc/disas.c                            |  2 +-
 target/openrisc/translate.c                        |  2 +-
 target/ppc/int_helper.c                            |  2 +-
 target/ppc/{mfrom_table.inc.c => mfrom_table.inc}  |  0
 target/ppc/translate.c                             | 22 ++++++------
 .../ppc/translate/{dfp-impl.inc.c => dfp-impl.inc} |  0
 .../ppc/translate/{dfp-ops.inc.c => dfp-ops.inc}   |  0
 .../ppc/translate/{fp-impl.inc.c => fp-impl.inc}   |  0
 target/ppc/translate/{fp-ops.inc.c => fp-ops.inc}  |  0
 .../ppc/translate/{spe-impl.inc.c => spe-impl.inc} |  0
 .../ppc/translate/{spe-ops.inc.c => spe-ops.inc}   |  0
 .../ppc/translate/{vmx-impl.inc.c => vmx-impl.inc} |  0
 .../ppc/translate/{vmx-ops.inc.c => vmx-ops.inc}   |  0
 .../ppc/translate/{vsx-impl.inc.c => vsx-impl.inc} |  0
 .../ppc/translate/{vsx-ops.inc.c => vsx-ops.inc}   |  0
 .../{translate_init.inc.c => translate_init.inc}   |  0
 target/riscv/Makefile.objs                         |  8 ++---
 ...trans_privileged.inc.c => trans_privileged.inc} |  0
 .../insn_trans/{trans_rva.inc.c => trans_rva.inc}  |  0
 .../insn_trans/{trans_rvd.inc.c => trans_rvd.inc}  |  0
 .../insn_trans/{trans_rvf.inc.c => trans_rvf.inc}  |  0
 .../insn_trans/{trans_rvh.inc.c => trans_rvh.inc}  |  0
 .../insn_trans/{trans_rvi.inc.c => trans_rvi.inc}  |  0
 .../insn_trans/{trans_rvm.inc.c => trans_rvm.inc}  |  0
 .../insn_trans/{trans_rvv.inc.c => trans_rvv.inc}  |  0
 target/riscv/translate.c                           | 20 +++++------
 target/rx/Makefile.objs                            |  6 ++--
 target/rx/disas.c                                  |  2 +-
 target/rx/translate.c                              |  2 +-
 target/s390x/translate.c                           |  2 +-
 .../s390x/{translate_vx.inc.c => translate_vx.inc} |  0
 target/xtensa/core-dc232b.c                        |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-dc233c.c                        |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-de212.c                         |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-fsf.c                           |  2 +-
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-sample_controller.c             |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-test_kc705_be.c                 |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/core-test_mmuhifi_c3.c               |  4 +--
 .../{gdb-config.inc.c => gdb-config.inc}           |  0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |  0
 target/xtensa/import_core.sh                       |  8 ++---
 tcg/README                                         |  2 +-
 tcg/aarch64/{tcg-target.inc.c => tcg-target.inc}   |  4 +--
 tcg/arm/{tcg-target.inc.c => tcg-target.inc}       |  4 +--
 tcg/i386/{tcg-target.inc.c => tcg-target.inc}      |  4 +--
 tcg/mips/{tcg-target.inc.c => tcg-target.inc}      |  2 +-
 tcg/ppc/{tcg-target.inc.c => tcg-target.inc}       |  4 +--
 tcg/riscv/{tcg-target.inc.c => tcg-target.inc}     |  4 +--
 tcg/s390/{tcg-target.inc.c => tcg-target.inc}      |  4 +--
 tcg/sparc/{tcg-target.inc.c => tcg-target.inc}     |  2 +-
 tcg/{tcg-ldst.inc.c => tcg-ldst.inc}               |  0
 tcg/{tcg-pool.inc.c => tcg-pool.inc}               |  2 +-
 tcg/tcg.c                                          |  6 ++--
 tcg/tci/README                                     |  4 +--
 tcg/tci/{tcg-target.inc.c => tcg-target.inc}       |  0
 tests/fp/fp-test.c                                 |  2 +-
 tests/fp/{wrap.inc.c => wrap.inc}                  |  0
 ui/input-keymap.c                                  | 34 +++++++++---------
 ui/vnc-enc-zrle.c                                  | 22 ++++++------
 ui/{vnc-enc-zrle.inc.c => vnc-enc-zrle.inc}        |  0
 98 files changed, 173 insertions(+), 173 deletions(-)
 rename accel/tcg/{atomic_common.inc.c => atomic_common.inc} (100%)
 rename fpu/{softfloat-specialize.inc.c => softfloat-specialize.inc} (100%)
 rename memory_ldst.inc.c => memory_ldst.inc (100%)
 rename target/arm/{translate-neon.inc.c => translate-neon.inc} (99%)
 rename target/arm/{translate-vfp.inc.c => translate-vfp.inc} (99%)
 rename target/cris/{translate_v10.inc.c => translate_v10.inc} (100%)
 rename target/mips/{translate_init.inc.c => translate_init.inc} (100%)
 rename target/ppc/{mfrom_table.inc.c => mfrom_table.inc} (100%)
 rename target/ppc/translate/{dfp-impl.inc.c => dfp-impl.inc} (100%)
 rename target/ppc/translate/{dfp-ops.inc.c => dfp-ops.inc} (100%)
 rename target/ppc/translate/{fp-impl.inc.c => fp-impl.inc} (100%)
 rename target/ppc/translate/{fp-ops.inc.c => fp-ops.inc} (100%)
 rename target/ppc/translate/{spe-impl.inc.c => spe-impl.inc} (100%)
 rename target/ppc/translate/{spe-ops.inc.c => spe-ops.inc} (100%)
 rename target/ppc/translate/{vmx-impl.inc.c => vmx-impl.inc} (100%)
 rename target/ppc/translate/{vmx-ops.inc.c => vmx-ops.inc} (100%)
 rename target/ppc/translate/{vsx-impl.inc.c => vsx-impl.inc} (100%)
 rename target/ppc/translate/{vsx-ops.inc.c => vsx-ops.inc} (100%)
 rename target/ppc/{translate_init.inc.c => translate_init.inc} (100%)
 rename target/riscv/insn_trans/{trans_privileged.inc.c => trans_privileged.inc} (100%)
 rename target/riscv/insn_trans/{trans_rva.inc.c => trans_rva.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvd.inc.c => trans_rvd.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvf.inc.c => trans_rvf.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvh.inc.c => trans_rvh.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvi.inc.c => trans_rvi.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvm.inc.c => trans_rvm.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvv.inc.c => trans_rvv.inc} (100%)
 rename target/s390x/{translate_vx.inc.c => translate_vx.inc} (100%)
 rename target/xtensa/core-dc232b/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-dc232b/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-dc233c/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-dc233c/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-de212/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-de212/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-fsf/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-sample_controller/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-sample_controller/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-test_kc705_be/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-test_kc705_be/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-test_mmuhifi_c3/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-test_mmuhifi_c3/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename tcg/aarch64/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/arm/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/i386/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/mips/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/ppc/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/riscv/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/s390/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/sparc/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/{tcg-ldst.inc.c => tcg-ldst.inc} (100%)
 rename tcg/{tcg-pool.inc.c => tcg-pool.inc} (99%)
 rename tcg/tci/{tcg-target.inc.c => tcg-target.inc} (100%)
 rename tests/fp/{wrap.inc.c => wrap.inc} (100%)
 rename ui/{vnc-enc-zrle.inc.c => vnc-enc-zrle.inc} (100%)

diff --git a/.gitignore b/.gitignore
index 656e390..2424131 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,7 +18,7 @@
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
 /ui/shader/texture-blit-flip-vert.h
-/ui/input-keymap-*.c
+/ui/input-keymap-*.inc
 *-timestamp
 /*-softmmu
 /*-darwin-user
@@ -161,4 +161,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
-/target/arm/decode-sve.inc.c
+/target/arm/decode-sve.inc
diff --git a/Makefile b/Makefile
index 00cadeb..f237ff8 100644
--- a/Makefile
+++ b/Makefile
@@ -289,28 +289,28 @@ KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
-		 ui/input-keymap-atset1-to-qcode.c \
-		 ui/input-keymap-linux-to-qcode.c \
-		 ui/input-keymap-qcode-to-atset1.c \
-		 ui/input-keymap-qcode-to-atset2.c \
-		 ui/input-keymap-qcode-to-atset3.c \
-		 ui/input-keymap-qcode-to-linux.c \
-		 ui/input-keymap-qcode-to-qnum.c \
-		 ui/input-keymap-qcode-to-sun.c \
-		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-usb-to-qcode.c \
-		 ui/input-keymap-win32-to-qcode.c \
-		 ui/input-keymap-x11-to-qcode.c \
-		 ui/input-keymap-xorgevdev-to-qcode.c \
-		 ui/input-keymap-xorgkbd-to-qcode.c \
-		 ui/input-keymap-xorgxquartz-to-qcode.c \
-		 ui/input-keymap-xorgxwin-to-qcode.c \
-		 ui/input-keymap-osx-to-qcode.c \
+		 ui/input-keymap-atset1-to-qcode.inc \
+		 ui/input-keymap-linux-to-qcode.inc \
+		 ui/input-keymap-qcode-to-atset1.inc \
+		 ui/input-keymap-qcode-to-atset2.inc \
+		 ui/input-keymap-qcode-to-atset3.inc \
+		 ui/input-keymap-qcode-to-linux.inc \
+		 ui/input-keymap-qcode-to-qnum.inc \
+		 ui/input-keymap-qcode-to-sun.inc \
+		 ui/input-keymap-qnum-to-qcode.inc \
+		 ui/input-keymap-usb-to-qcode.inc \
+		 ui/input-keymap-win32-to-qcode.inc \
+		 ui/input-keymap-x11-to-qcode.inc \
+		 ui/input-keymap-xorgevdev-to-qcode.inc \
+		 ui/input-keymap-xorgkbd-to-qcode.inc \
+		 ui/input-keymap-xorgxquartz-to-qcode.inc \
+		 ui/input-keymap-xorgxwin-to-qcode.inc \
+		 ui/input-keymap-osx-to-qcode.inc \
 		 $(NULL)
 
 generated-files-$(CONFIG_SOFTMMU) += $(KEYCODEMAP_FILES)
 
-ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
+ui/input-keymap-%.inc: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
 	$(call quiet-command,\
 	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
 	    test -e $(KEYCODEMAP_GEN) && \
diff --git a/accel/tcg/atomic_common.inc.c b/accel/tcg/atomic_common.inc
similarity index 100%
rename from accel/tcg/atomic_common.inc.c
rename to accel/tcg/atomic_common.inc
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5349ee6..ca4c982 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2354,7 +2354,7 @@ void cpu_stq_le_data(CPUArchState *env, target_ulong ptr, uint64_t val)
 #define ATOMIC_MMU_CLEANUP
 #define ATOMIC_MMU_IDX   get_mmuidx(oi)
 
-#include "atomic_common.inc.c"
+#include "atomic_common.inc"
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1d34c57..e219ecc 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1189,7 +1189,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
 
-#include "atomic_common.inc.c"
+#include "atomic_common.inc"
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 2d5002f..e8e2628 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -42,7 +42,7 @@ order build,interface,tests,code,documentation,devel-doc,blobs
 # (most common languages first
 #
 filetype code \.c$	# C
-filetype code \.inc.c$	# C
+filetype code \.inc$	# C
 filetype code \.C$	# C++
 filetype code \.cpp$	# C++
 filetype code \.c\+\+$	# C++
diff --git a/exec.c b/exec.c
index 8047bf2..f5915ce 100644
--- a/exec.c
+++ b/exec.c
@@ -3659,7 +3659,7 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
 #define TRANSLATE(...)           address_space_translate(as, __VA_ARGS__)
 #define RCU_READ_LOCK(...)       rcu_read_lock()
 #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
-#include "memory_ldst.inc.c"
+#include "memory_ldst.inc"
 
 int64_t address_space_cache_init(MemoryRegionCache *cache,
                                  AddressSpace *as,
@@ -3795,7 +3795,7 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
 #define RCU_READ_LOCK()          ((void)0)
 #define RCU_READ_UNLOCK()        ((void)0)
-#include "memory_ldst.inc.c"
+#include "memory_ldst.inc"
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc
similarity index 100%
rename from fpu/softfloat-specialize.inc.c
rename to fpu/softfloat-specialize.inc
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 79be4f5..7fb1f3b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -621,7 +621,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 | are propagated from function inputs to output.  These details are target-
 | specific.
 *----------------------------------------------------------------------------*/
-#include "softfloat-specialize.inc.c"
+#include "softfloat-specialize.inc"
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
 static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e63450a..89fa9cf 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -636,7 +636,7 @@ struct TCGContext {
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
 
-    /* These structures are private to tcg-target.inc.c.  */
+    /* These structures are private to tcg-target.inc.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;
 #endif
diff --git a/memory_ldst.inc.c b/memory_ldst.inc
similarity index 100%
rename from memory_ldst.inc.c
rename to memory_ldst.inc
diff --git a/scripts/clean-includes b/scripts/clean-includes
index 795b3be..ff2dbe8 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -113,7 +113,7 @@ EOT
 
 for f in "$@"; do
   case "$f" in
-    *.inc.c)
+    *.inc)
       # These aren't standalone C source files
       echo "SKIPPING $f (not a standalone source file)"
       continue
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index fa39fd7..4a177ad 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -13,66 +13,66 @@ obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
-target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
+target/arm/decode-sve.inc: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-neon-shared.inc.c: $(SRC_PATH)/target/arm/neon-shared.decode $(DECODETREE)
+target/arm/decode-neon-shared.inc: $(SRC_PATH)/target/arm/neon-shared.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_shared -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-neon-dp.inc.c: $(SRC_PATH)/target/arm/neon-dp.decode $(DECODETREE)
+target/arm/decode-neon-dp.inc: $(SRC_PATH)/target/arm/neon-dp.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_dp -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-neon-ls.inc.c: $(SRC_PATH)/target/arm/neon-ls.decode $(DECODETREE)
+target/arm/decode-neon-ls.inc: $(SRC_PATH)/target/arm/neon-ls.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_ls -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-vfp.inc.c: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
+target/arm/decode-vfp.inc: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.decode $(DECODETREE)
+target/arm/decode-vfp-uncond.inc: $(SRC_PATH)/target/arm/vfp-uncond.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
+target/arm/decode-a32.inc: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-a32-uncond.inc.c: $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
+target/arm/decode-a32-uncond.inc: $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
+target/arm/decode-t32.inc: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/decode-t16.inc.c: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
+target/arm/decode-t16.inc: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) -w 16 --static-decode disas_t16 -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
-target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-target/arm/translate.o: target/arm/decode-neon-shared.inc.c
-target/arm/translate.o: target/arm/decode-neon-dp.inc.c
-target/arm/translate.o: target/arm/decode-neon-ls.inc.c
-target/arm/translate.o: target/arm/decode-vfp.inc.c
-target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
-target/arm/translate.o: target/arm/decode-a32.inc.c
-target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
-target/arm/translate.o: target/arm/decode-t32.inc.c
-target/arm/translate.o: target/arm/decode-t16.inc.c
+target/arm/translate-sve.o: target/arm/decode-sve.inc
+target/arm/translate.o: target/arm/decode-neon-shared.inc
+target/arm/translate.o: target/arm/decode-neon-dp.inc
+target/arm/translate.o: target/arm/decode-neon-ls.inc
+target/arm/translate.o: target/arm/decode-vfp.inc
+target/arm/translate.o: target/arm/decode-vfp-uncond.inc
+target/arm/translate.o: target/arm/decode-a32.inc
+target/arm/translate.o: target/arm/decode-a32-uncond.inc
+target/arm/translate.o: target/arm/decode-t32.inc
+target/arm/translate.o: target/arm/decode-t16.inc
 
 obj-y += tlb_helper.o debug_helper.o
 obj-y += translate.o op_helper.o
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc
similarity index 99%
rename from target/arm/translate-neon.inc.c
rename to target/arm/translate-neon.inc
index f6cb921..ac0ddcc 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc
@@ -50,9 +50,9 @@ static inline int rsub_8(DisasContext *s, int x)
 }
 
 /* Include the generated Neon decoder */
-#include "decode-neon-dp.inc.c"
-#include "decode-neon-ls.inc.c"
-#include "decode-neon-shared.inc.c"
+#include "decode-neon-dp.inc"
+#include "decode-neon-ls.inc"
+#include "decode-neon-shared.inc"
 
 /* Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
  * where 0 is the least significant end of the register.
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 88a2fb2..60c0716 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -100,7 +100,7 @@ static inline int msz_dtype(DisasContext *s, int msz)
  * Include the generated decoder.
  */
 
-#include "decode-sve.inc.c"
+#include "decode-sve.inc"
 
 /*
  * Implement all of the translator functions referenced by the decoder.
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc
similarity index 99%
rename from target/arm/translate-vfp.inc.c
rename to target/arm/translate-vfp.inc
index afa8a5f..1f518b4 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc
@@ -27,8 +27,8 @@
  */
 
 /* Include the generated VFP decoder */
-#include "decode-vfp.inc.c"
-#include "decode-vfp-uncond.inc.c"
+#include "decode-vfp.inc"
+#include "decode-vfp-uncond.inc"
 
 /*
  * The imm8 encodes the sign bit, enough bits to represent an exponent in
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c39a929..3128fa6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1176,8 +1176,8 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 #define ARM_CP_RW_BIT   (1 << 20)
 
 /* Include the VFP and Neon decoders */
-#include "translate-vfp.inc.c"
-#include "translate-neon.inc.c"
+#include "translate-vfp.inc"
+#include "translate-neon.inc"
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
 {
@@ -5217,10 +5217,10 @@ static int t16_pop_list(DisasContext *s, int x)
  * Include the generated decoders.
  */
 
-#include "decode-a32.inc.c"
-#include "decode-a32-uncond.inc.c"
-#include "decode-t32.inc.c"
-#include "decode-t16.inc.c"
+#include "decode-a32.inc"
+#include "decode-a32-uncond.inc"
+#include "decode-t32.inc"
+#include "decode-t16.inc"
 
 /* Helpers to swap operands for reverse-subtract.  */
 static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
index 6e35ba2..81d9bcd 100644
--- a/target/avr/Makefile.objs
+++ b/target/avr/Makefile.objs
@@ -21,12 +21,12 @@
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 decode-y = $(SRC_PATH)/target/avr/insn.decode
 
-target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+target/avr/decode_insn.inc: $(decode-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
 	  "GEN", $(TARGET_DIR)$@)
 
-target/avr/translate.o: target/avr/decode_insn.inc.c
+target/avr/translate.o: target/avr/decode_insn.inc
 
 obj-y += translate.o cpu.o helper.o
 obj-y += gdbstub.o
diff --git a/target/avr/disas.c b/target/avr/disas.c
index 8e1bac4..c45ab2c 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -60,7 +60,7 @@ static int append_16(DisasContext *ctx, int x)
 
 /* Include the auto-generated decoder.  */
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
-#include "decode_insn.inc.c"
+#include "decode_insn.inc"
 
 #define output(mnemonic, format, ...) \
     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 648dcd5..8deb126 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -198,7 +198,7 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
 }
 
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
-#include "decode_insn.inc.c"
+#include "decode_insn.inc"
 
 /*
  * Arithmetic Instructions
diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5..a0d4b1c 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3037,7 +3037,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
     return insn_len;
 }
 
-#include "translate_v10.inc.c"
+#include "translate_v10.inc"
 
 /*
  * Delay slots on QEMU/CRIS.
diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc
similarity index 100%
rename from target/cris/translate_v10.inc.c
rename to target/cris/translate_v10.inc
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index 174f50a..40dcb86 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -4,8 +4,8 @@ obj-$(CONFIG_SOFTMMU) += machine.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
-target/hppa/decode.inc.c: $(SRC_PATH)/target/hppa/insns.decode $(DECODETREE)
+target/hppa/decode.inc: $(SRC_PATH)/target/hppa/insns.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
 
-target/hppa/translate.o: target/hppa/decode.inc.c
+target/hppa/translate.o: target/hppa/decode.inc
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4bd22d4..31e2926 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -334,7 +334,7 @@ static int expand_shl11(DisasContext *ctx, int val)
 
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode.inc"
 
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9fad58e..221a42e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31322,7 +31322,7 @@ void mips_tcg_init(void)
 #endif
 }
 
-#include "translate_init.inc.c"
+#include "translate_init.inc"
 
 void cpu_mips_realize_env(CPUMIPSState *env)
 {
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc
similarity index 100%
rename from target/mips/translate_init.inc.c
rename to target/mips/translate_init.inc
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index b5432f4..0f2fcff 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -6,10 +6,10 @@ obj-y += gdbstub.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
-target/openrisc/decode.inc.c: \
+target/openrisc/decode.inc: \
   $(SRC_PATH)/target/openrisc/insns.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
 
-target/openrisc/translate.o: target/openrisc/decode.inc.c
-target/openrisc/disas.o: target/openrisc/decode.inc.c
+target/openrisc/translate.o: target/openrisc/decode.inc
+target/openrisc/disas.o: target/openrisc/decode.inc
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index ce11264..3f75316 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -25,7 +25,7 @@
 typedef disassemble_info DisasContext;
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode.inc"
 
 #define output(mnemonic, format, ...) \
     (info->fprintf_func(info->stream, "%-9s " format, \
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 52323a1..a119be2 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -65,7 +65,7 @@ static inline bool is_user(DisasContext *dc)
 }
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode.inc"
 
 static TCGv cpu_sr;
 static TCGv cpu_regs[32];
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d8bd3c2..eff3c0d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -398,7 +398,7 @@ target_ulong helper_divso(CPUPPCState *env, target_ulong arg1,
 target_ulong helper_602_mfrom(target_ulong arg)
 {
     if (likely(arg < 602)) {
-#include "mfrom_table.inc.c"
+#include "mfrom_table.inc"
         return mfrom_ROM_table[arg];
     } else {
         return 0;
diff --git a/target/ppc/mfrom_table.inc.c b/target/ppc/mfrom_table.inc
similarity index 100%
rename from target/ppc/mfrom_table.inc.c
rename to target/ppc/mfrom_table.inc
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4ce3d66..95d9080 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6900,15 +6900,15 @@ static inline void set_avr64(int regno, TCGv_i64 src, bool high)
     tcg_gen_st_i64(src, cpu_env, avr64_offset(regno, high));
 }
 
-#include "translate/fp-impl.inc.c"
+#include "translate/fp-impl.inc"
 
-#include "translate/vmx-impl.inc.c"
+#include "translate/vmx-impl.inc"
 
-#include "translate/vsx-impl.inc.c"
+#include "translate/vsx-impl.inc"
 
-#include "translate/dfp-impl.inc.c"
+#include "translate/dfp-impl.inc"
 
-#include "translate/spe-impl.inc.c"
+#include "translate/spe-impl.inc"
 
 /* Handles lfdp, lxsd, lxssp */
 static void gen_dform39(DisasContext *ctx)
@@ -7587,19 +7587,19 @@ GEN_HANDLER2_E(treclaim, "treclaim", 0x1F, 0x0E, 0x1D, 0x03E0F800, \
 GEN_HANDLER2_E(trechkpt, "trechkpt", 0x1F, 0x0E, 0x1F, 0x03FFF800, \
                PPC_NONE, PPC2_TM),
 
-#include "translate/fp-ops.inc.c"
+#include "translate/fp-ops.inc"
 
-#include "translate/vmx-ops.inc.c"
+#include "translate/vmx-ops.inc"
 
-#include "translate/vsx-ops.inc.c"
+#include "translate/vsx-ops.inc"
 
-#include "translate/dfp-ops.inc.c"
+#include "translate/dfp-ops.inc"
 
-#include "translate/spe-ops.inc.c"
+#include "translate/spe-ops.inc"
 };
 
 #include "helper_regs.h"
-#include "translate_init.inc.c"
+#include "translate_init.inc"
 
 /*****************************************************************************/
 /* Misc PowerPC helpers */
diff --git a/target/ppc/translate/dfp-impl.inc.c b/target/ppc/translate/dfp-impl.inc
similarity index 100%
rename from target/ppc/translate/dfp-impl.inc.c
rename to target/ppc/translate/dfp-impl.inc
diff --git a/target/ppc/translate/dfp-ops.inc.c b/target/ppc/translate/dfp-ops.inc
similarity index 100%
rename from target/ppc/translate/dfp-ops.inc.c
rename to target/ppc/translate/dfp-ops.inc
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc
similarity index 100%
rename from target/ppc/translate/fp-impl.inc.c
rename to target/ppc/translate/fp-impl.inc
diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc
similarity index 100%
rename from target/ppc/translate/fp-ops.inc.c
rename to target/ppc/translate/fp-ops.inc
diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc
similarity index 100%
rename from target/ppc/translate/spe-impl.inc.c
rename to target/ppc/translate/spe-impl.inc
diff --git a/target/ppc/translate/spe-ops.inc.c b/target/ppc/translate/spe-ops.inc
similarity index 100%
rename from target/ppc/translate/spe-ops.inc.c
rename to target/ppc/translate/spe-ops.inc
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc
similarity index 100%
rename from target/ppc/translate/vmx-impl.inc.c
rename to target/ppc/translate/vmx-impl.inc
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc
similarity index 100%
rename from target/ppc/translate/vmx-ops.inc.c
rename to target/ppc/translate/vmx-ops.inc
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc
similarity index 100%
rename from target/ppc/translate/vsx-impl.inc.c
rename to target/ppc/translate/vsx-impl.inc
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc
similarity index 100%
rename from target/ppc/translate/vsx-ops.inc.c
rename to target/ppc/translate/vsx-ops.inc
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc
similarity index 100%
rename from target/ppc/translate_init.inc.c
rename to target/ppc/translate_init.inc
diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index ff38df6..1a66d8a 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -14,15 +14,15 @@ decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
 decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
 decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
 
-target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
+target/riscv/decode_insn32.inc: $(decode32-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
           $(decode32-y), "GEN", $(TARGET_DIR)$@)
 
-target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
+target/riscv/decode_insn16.inc: $(decode16-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
           --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
 
-target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
-	target/riscv/decode_insn16.inc.c
+target/riscv/translate.o: target/riscv/decode_insn32.inc \
+	target/riscv/decode_insn16.inc
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_privileged.inc.c
rename to target/riscv/insn_trans/trans_privileged.inc
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rva.inc.c
rename to target/riscv/insn_trans/trans_rva.inc
diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvd.inc.c
rename to target/riscv/insn_trans/trans_rvd.inc
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvf.inc.c
rename to target/riscv/insn_trans/trans_rvf.inc
diff --git a/target/riscv/insn_trans/trans_rvh.inc.c b/target/riscv/insn_trans/trans_rvh.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvh.inc.c
rename to target/riscv/insn_trans/trans_rvh.inc
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvi.inc.c
rename to target/riscv/insn_trans/trans_rvi.inc
diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvm.inc.c
rename to target/riscv/insn_trans/trans_rvm.inc
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvv.inc.c
rename to target/riscv/insn_trans/trans_rvv.inc
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9632e79..aa7f56d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -583,7 +583,7 @@ static int ex_rvc_shifti(DisasContext *ctx, int imm)
 }
 
 /* Include the auto-generated decoder for 32 bit insn */
-#include "decode_insn32.inc.c"
+#include "decode_insn32.inc"
 
 static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
                              void (*func)(TCGv, TCGv, target_long))
@@ -718,17 +718,17 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 }
 
 /* Include insn module translation function */
-#include "insn_trans/trans_rvi.inc.c"
-#include "insn_trans/trans_rvm.inc.c"
-#include "insn_trans/trans_rva.inc.c"
-#include "insn_trans/trans_rvf.inc.c"
-#include "insn_trans/trans_rvd.inc.c"
-#include "insn_trans/trans_rvh.inc.c"
-#include "insn_trans/trans_rvv.inc.c"
-#include "insn_trans/trans_privileged.inc.c"
+#include "insn_trans/trans_rvi.inc"
+#include "insn_trans/trans_rvm.inc"
+#include "insn_trans/trans_rva.inc"
+#include "insn_trans/trans_rvf.inc"
+#include "insn_trans/trans_rvd.inc"
+#include "insn_trans/trans_rvh.inc"
+#include "insn_trans/trans_rvv.inc"
+#include "insn_trans/trans_privileged.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
-#include "decode_insn16.inc.c"
+#include "decode_insn16.inc"
 
 static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
index a0018d5..eddc62a 100644
--- a/target/rx/Makefile.objs
+++ b/target/rx/Makefile.objs
@@ -2,10 +2,10 @@ obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
-target/rx/decode.inc.c: \
+target/rx/decode.inc: \
   $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN", $(TARGET_DIR)$@)
 
-target/rx/translate.o: target/rx/decode.inc.c
-target/rx/disas.o: target/rx/decode.inc.c
+target/rx/translate.o: target/rx/decode.inc
+target/rx/disas.o: target/rx/decode.inc
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 6dee7a0..6450892 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -100,7 +100,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 }
 
 /* Include the auto-generated decoder.  */
-#include "decode.inc.c"
+#include "decode.inc"
 
 static void dump_bytes(DisasContext *ctx)
 {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 61e8665..272619c 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -124,7 +124,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 }
 
 /* Include the auto-generated decoder. */
-#include "decode.inc.c"
+#include "decode.inc"
 
 void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4f6f1e3..4c6452f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5120,7 +5120,7 @@ static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
 }
 #endif
 
-#include "translate_vx.inc.c"
+#include "translate_vx.inc"
 
 /* ====================================================================== */
 /* The "Cc OUTput" generators.  Given the generated output (and in some cases
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc
similarity index 100%
rename from target/s390x/translate_vx.inc.c
rename to target/s390x/translate_vx.inc
diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 7851bcb..bc4c866 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -35,13 +35,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_dc232b
-#include "core-dc232b/xtensa-modules.inc.c"
+#include "core-dc232b/xtensa-modules.inc"
 
 static XtensaConfig dc232b __attribute__((unused)) = {
     .name = "dc232b",
     .gdb_regmap = {
         .reg = {
-#include "core-dc232b/gdb-config.inc.c"
+#include "core-dc232b/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-dc232b/gdb-config.inc.c b/target/xtensa/core-dc232b/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-dc232b/gdb-config.inc.c
rename to target/xtensa/core-dc232b/gdb-config.inc
diff --git a/target/xtensa/core-dc232b/xtensa-modules.inc.c b/target/xtensa/core-dc232b/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-dc232b/xtensa-modules.inc.c
rename to target/xtensa/core-dc232b/xtensa-modules.inc
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index f8204f7..8341925 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -34,13 +34,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_dc233c
-#include "core-dc233c/xtensa-modules.inc.c"
+#include "core-dc233c/xtensa-modules.inc"
 
 static XtensaConfig dc233c __attribute__((unused)) = {
     .name = "dc233c",
     .gdb_regmap = {
         .reg = {
-#include "core-dc233c/gdb-config.inc.c"
+#include "core-dc233c/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-dc233c/gdb-config.inc.c b/target/xtensa/core-dc233c/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-dc233c/gdb-config.inc.c
rename to target/xtensa/core-dc233c/gdb-config.inc
diff --git a/target/xtensa/core-dc233c/xtensa-modules.inc.c b/target/xtensa/core-dc233c/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-dc233c/xtensa-modules.inc.c
rename to target/xtensa/core-dc233c/xtensa-modules.inc
diff --git a/target/xtensa/core-de212.c b/target/xtensa/core-de212.c
index a061158..eda095d 100644
--- a/target/xtensa/core-de212.c
+++ b/target/xtensa/core-de212.c
@@ -34,13 +34,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_de212
-#include "core-de212/xtensa-modules.inc.c"
+#include "core-de212/xtensa-modules.inc"
 
 static XtensaConfig de212 __attribute__((unused)) = {
     .name = "de212",
     .gdb_regmap = {
         .reg = {
-#include "core-de212/gdb-config.inc.c"
+#include "core-de212/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-de212/gdb-config.inc.c b/target/xtensa/core-de212/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-de212/gdb-config.inc.c
rename to target/xtensa/core-de212/gdb-config.inc
diff --git a/target/xtensa/core-de212/xtensa-modules.inc.c b/target/xtensa/core-de212/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-de212/xtensa-modules.inc.c
rename to target/xtensa/core-de212/xtensa-modules.inc
diff --git a/target/xtensa/core-fsf.c b/target/xtensa/core-fsf.c
index 1221a29..3398f3b 100644
--- a/target/xtensa/core-fsf.c
+++ b/target/xtensa/core-fsf.c
@@ -34,7 +34,7 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_fsf
-#include "core-fsf/xtensa-modules.inc.c"
+#include "core-fsf/xtensa-modules.inc"
 
 static XtensaConfig fsf __attribute__((unused)) = {
     .name = "fsf",
diff --git a/target/xtensa/core-fsf/xtensa-modules.inc.c b/target/xtensa/core-fsf/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-fsf/xtensa-modules.inc.c
rename to target/xtensa/core-fsf/xtensa-modules.inc
diff --git a/target/xtensa/core-sample_controller.c b/target/xtensa/core-sample_controller.c
index a1d220b..1523ef5 100644
--- a/target/xtensa/core-sample_controller.c
+++ b/target/xtensa/core-sample_controller.c
@@ -34,13 +34,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_sample_controller
-#include "core-sample_controller/xtensa-modules.inc.c"
+#include "core-sample_controller/xtensa-modules.inc"
 
 static XtensaConfig sample_controller __attribute__((unused)) = {
     .name = "sample_controller",
     .gdb_regmap = {
         .reg = {
-#include "core-sample_controller/gdb-config.inc.c"
+#include "core-sample_controller/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-sample_controller/gdb-config.inc.c b/target/xtensa/core-sample_controller/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-sample_controller/gdb-config.inc.c
rename to target/xtensa/core-sample_controller/gdb-config.inc
diff --git a/target/xtensa/core-sample_controller/xtensa-modules.inc.c b/target/xtensa/core-sample_controller/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-sample_controller/xtensa-modules.inc.c
rename to target/xtensa/core-sample_controller/xtensa-modules.inc
diff --git a/target/xtensa/core-test_kc705_be.c b/target/xtensa/core-test_kc705_be.c
index ab73c38..60e9a7d 100644
--- a/target/xtensa/core-test_kc705_be.c
+++ b/target/xtensa/core-test_kc705_be.c
@@ -34,13 +34,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_test_kc705_be
-#include "core-test_kc705_be/xtensa-modules.inc.c"
+#include "core-test_kc705_be/xtensa-modules.inc"
 
 static XtensaConfig test_kc705_be __attribute__((unused)) = {
     .name = "test_kc705_be",
     .gdb_regmap = {
         .reg = {
-#include "core-test_kc705_be/gdb-config.inc.c"
+#include "core-test_kc705_be/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-test_kc705_be/gdb-config.inc.c b/target/xtensa/core-test_kc705_be/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-test_kc705_be/gdb-config.inc.c
rename to target/xtensa/core-test_kc705_be/gdb-config.inc
diff --git a/target/xtensa/core-test_kc705_be/xtensa-modules.inc.c b/target/xtensa/core-test_kc705_be/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-test_kc705_be/xtensa-modules.inc.c
rename to target/xtensa/core-test_kc705_be/xtensa-modules.inc
diff --git a/target/xtensa/core-test_mmuhifi_c3.c b/target/xtensa/core-test_mmuhifi_c3.c
index 089ed7d..0a297f5 100644
--- a/target/xtensa/core-test_mmuhifi_c3.c
+++ b/target/xtensa/core-test_mmuhifi_c3.c
@@ -35,13 +35,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_test_mmuhifi_c3
-#include "core-test_mmuhifi_c3/xtensa-modules.inc.c"
+#include "core-test_mmuhifi_c3/xtensa-modules.inc"
 
 static XtensaConfig test_mmuhifi_c3 __attribute__((unused)) = {
     .name = "test_mmuhifi_c3",
     .gdb_regmap = {
         .reg = {
-#include "core-test_mmuhifi_c3/gdb-config.inc.c"
+#include "core-test_mmuhifi_c3/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c b/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc
similarity index 100%
rename from target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
rename to target/xtensa/core-test_mmuhifi_c3/gdb-config.inc
diff --git a/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c b/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc
similarity index 100%
rename from target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
rename to target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc
diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 8f844cf..a2e422b 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -23,7 +23,7 @@ tar -xf "$OVERLAY" -C "$TARGET" --strip-components=2 \
     xtensa/config/core-isa.h \
     xtensa/config/core-matmap.h
 tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
-    sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.inc.c
+    sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.inc
 #
 # Fix up known issues in the xtensa-modules.c
 #
@@ -35,7 +35,7 @@ tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
         -e '/^#include "ansidecl.h"/d' \
         -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
         -e 's/#include <xtensa-isa.h>/#include "xtensa-isa.h"/' \
-    > "$TARGET"/xtensa-modules.inc.c
+    > "$TARGET"/xtensa-modules.inc
 
 cat <<EOF > "${TARGET}.c"
 #include "qemu/osdep.h"
@@ -49,13 +49,13 @@ cat <<EOF > "${TARGET}.c"
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_$NAME
-#include "core-$NAME/xtensa-modules.inc.c"
+#include "core-$NAME/xtensa-modules.inc"
 
 static XtensaConfig $NAME __attribute__((unused)) = {
     .name = "$NAME",
     .gdb_regmap = {
         .reg = {
-#include "core-$NAME/gdb-config.inc.c"
+#include "core-$NAME/gdb-config.inc"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/tcg/README b/tcg/README
index a64f678..fdf6ee5 100644
--- a/tcg/README
+++ b/tcg/README
@@ -652,7 +652,7 @@ function tcg_gen_xxx(args).
 
 4) Backend
 
-tcg-target.h contains the target specific definitions. tcg-target.inc.c
+tcg-target.h contains the target specific definitions. tcg-target.inc
 contains the target specific code; it is #included by tcg/tcg.c, rather
 than being a standalone C file.
 
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc
similarity index 99%
rename from tcg/aarch64/tcg-target.inc.c
rename to tcg/aarch64/tcg-target.inc
index 760b0e7..000f7e6 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory for details.
  */
 
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 #include "qemu/bitops.h"
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
@@ -1542,7 +1542,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc
similarity index 99%
rename from tcg/arm/tcg-target.inc.c
rename to tcg/arm/tcg-target.inc
index 6aa7757..42c2601 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc
@@ -23,7 +23,7 @@
  */
 
 #include "elf.h"
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 
 int arm_arch = __ARM_ARCH;
 
@@ -1131,7 +1131,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc
similarity index 99%
rename from tcg/i386/tcg-target.inc.c
rename to tcg/i386/tcg-target.inc
index ae02282..c8d5ff7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -1647,7 +1647,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc
similarity index 99%
rename from tcg/mips/tcg-target.inc.c
rename to tcg/mips/tcg-target.inc
index 4d32ebc..5459818 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc
@@ -1107,7 +1107,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 static void * const qemu_ld_helpers[16] = {
     [MO_UB]   = helper_ret_ldub_mmu,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc
similarity index 99%
rename from tcg/ppc/tcg-target.inc.c
rename to tcg/ppc/tcg-target.inc
index c8d1e76..7f13849 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc
@@ -23,7 +23,7 @@
  */
 
 #include "elf.h"
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 
 #if defined _CALL_DARWIN || defined __APPLE__
 #define TCG_TARGET_CALL_DARWIN
@@ -1845,7 +1845,7 @@ static const uint32_t qemu_exts_opc[4] = {
 };
 
 #if defined (CONFIG_SOFTMMU)
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
  *                                 int mmu_idx, uintptr_t ra)
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc
similarity index 99%
rename from tcg/riscv/tcg-target.inc.c
rename to tcg/riscv/tcg-target.inc
index 3c11ab8..d666c79 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc
@@ -27,7 +27,7 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -919,7 +919,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
  */
 
 #if defined(CONFIG_SOFTMMU)
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc
similarity index 99%
rename from tcg/s390/tcg-target.inc.c
rename to tcg/s390/tcg-target.inc
index b07e9ff..c313a08 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc
@@ -29,7 +29,7 @@
 #error "unsupported code generation mode"
 #endif
 
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 #include "elf.h"
 
 /* ??? The translation blocks produced by TCG are generally small enough to
@@ -1536,7 +1536,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg data,
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "../tcg-ldst.inc.c"
+#include "../tcg-ldst.inc"
 
 /* We're expecting to use a 20-bit negative offset on the tlb memory ops.  */
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc
similarity index 99%
rename from tcg/sparc/tcg-target.inc.c
rename to tcg/sparc/tcg-target.inc
index 65fddb3..e6aecd9 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-pool.inc.c"
+#include "../tcg-pool.inc"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
diff --git a/tcg/tcg-ldst.inc.c b/tcg/tcg-ldst.inc
similarity index 100%
rename from tcg/tcg-ldst.inc.c
rename to tcg/tcg-ldst.inc
diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc
similarity index 99%
rename from tcg/tcg-pool.inc.c
rename to tcg/tcg-pool.inc
index 4eaa84b..7390173 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc
@@ -118,7 +118,7 @@ static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
     new_pool_insert(s, n);
 }
 
-/* To be provided by cpu/tcg-target.inc.c.  */
+/* To be provided by cpu/tcg-target.inc.  */
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
 
 static int tcg_out_pool_finalize(TCGContext *s)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1362bc6..5af2ce4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -65,7 +65,7 @@
 #include "exec/log.h"
 #include "sysemu/sysemu.h"
 
-/* Forward declarations for functions declared in tcg-target.inc.c and
+/* Forward declarations for functions declared in tcg-target.inc and
    used here. */
 static void tcg_target_init(TCGContext *s);
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode);
@@ -101,7 +101,7 @@ static void tcg_register_jit_int(void *buf, size_t size,
                                  size_t debug_frame_size)
     __attribute__((unused));
 
-/* Forward declarations for functions declared and used in tcg-target.inc.c. */
+/* Forward declarations for functions declared and used in tcg-target.inc. */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
@@ -341,7 +341,7 @@ static void set_jmp_reset_offset(TCGContext *s, int which)
     assert(s->tb_jmp_reset_offset[which] == off);
 }
 
-#include "tcg-target.inc.c"
+#include "tcg-target.inc"
 
 /* compare a pointer @ptr and a tb_tc @s */
 static int ptr_cmp_tb_tc(const void *ptr, const struct tb_tc *s)
diff --git a/tcg/tci/README b/tcg/tci/README
index 386c3c7..63ce297 100644
--- a/tcg/tci/README
+++ b/tcg/tci/README
@@ -21,7 +21,7 @@ This is what TCI (Tiny Code Interpreter) does.
 2) Implementation
 
 Like each TCG host frontend, TCI implements the code generator in
-tcg-target.inc.c, tcg-target.h. Both files are in directory tcg/tci.
+tcg-target.inc, tcg-target.h. Both files are in directory tcg/tci.
 
 The additional file tcg/tci.c adds the interpreter.
 
@@ -123,7 +123,7 @@ u1 = linux-user-test works
   would also improve speed for hosts which support byte alignment).
 
 * A better disassembler for the pseudo code would be nice (a very primitive
-  disassembler is included in tcg-target.inc.c).
+  disassembler is included in tcg-target.inc).
 
 * It might be useful to have a runtime option which selects the native TCG
   or TCI, so QEMU would have to include two TCGs. Today, selecting TCI
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc
similarity index 100%
rename from tcg/tci/tcg-target.inc.c
rename to tcg/tci/tcg-target.inc
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 43ef962..6fe2402 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -116,7 +116,7 @@ static void usage_complete(int argc, char *argv[])
 }
 
 /* keep wrappers separate but do not bother defining headers for all of them */
-#include "wrap.inc.c"
+#include "wrap.inc"
 
 static void not_implemented(void)
 {
diff --git a/tests/fp/wrap.inc.c b/tests/fp/wrap.inc
similarity index 100%
rename from tests/fp/wrap.inc.c
rename to tests/fp/wrap.inc
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index c430185..cfe2c44 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -4,23 +4,23 @@
 
 #include "standard-headers/linux/input.h"
 
-#include "ui/input-keymap-atset1-to-qcode.c"
-#include "ui/input-keymap-linux-to-qcode.c"
-#include "ui/input-keymap-qcode-to-atset1.c"
-#include "ui/input-keymap-qcode-to-atset2.c"
-#include "ui/input-keymap-qcode-to-atset3.c"
-#include "ui/input-keymap-qcode-to-linux.c"
-#include "ui/input-keymap-qcode-to-qnum.c"
-#include "ui/input-keymap-qcode-to-sun.c"
-#include "ui/input-keymap-qnum-to-qcode.c"
-#include "ui/input-keymap-usb-to-qcode.c"
-#include "ui/input-keymap-win32-to-qcode.c"
-#include "ui/input-keymap-x11-to-qcode.c"
-#include "ui/input-keymap-xorgevdev-to-qcode.c"
-#include "ui/input-keymap-xorgkbd-to-qcode.c"
-#include "ui/input-keymap-xorgxquartz-to-qcode.c"
-#include "ui/input-keymap-xorgxwin-to-qcode.c"
-#include "ui/input-keymap-osx-to-qcode.c"
+#include "ui/input-keymap-atset1-to-qcode.inc"
+#include "ui/input-keymap-linux-to-qcode.inc"
+#include "ui/input-keymap-qcode-to-atset1.inc"
+#include "ui/input-keymap-qcode-to-atset2.inc"
+#include "ui/input-keymap-qcode-to-atset3.inc"
+#include "ui/input-keymap-qcode-to-linux.inc"
+#include "ui/input-keymap-qcode-to-qnum.inc"
+#include "ui/input-keymap-qcode-to-sun.inc"
+#include "ui/input-keymap-qnum-to-qcode.inc"
+#include "ui/input-keymap-usb-to-qcode.inc"
+#include "ui/input-keymap-win32-to-qcode.inc"
+#include "ui/input-keymap-x11-to-qcode.inc"
+#include "ui/input-keymap-xorgevdev-to-qcode.inc"
+#include "ui/input-keymap-xorgkbd-to-qcode.inc"
+#include "ui/input-keymap-xorgxquartz-to-qcode.inc"
+#include "ui/input-keymap-xorgxwin-to-qcode.inc"
+#include "ui/input-keymap-osx-to-qcode.inc"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index b4f71e3..98d5002 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -199,56 +199,56 @@ static void zrle_write_u8(VncState *vs, uint8_t value)
 
 #define ZRLE_BPP 8
 #define ZYWRLE_ENDIAN ENDIAN_NO
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 #undef ZRLE_BPP
 
 #define ZRLE_BPP 15
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZRLE_BPP
 #define ZRLE_BPP 16
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZRLE_BPP
 #define ZRLE_BPP 32
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #define ZRLE_COMPACT_PIXEL 24a
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZRLE_COMPACT_PIXEL
 #define ZRLE_COMPACT_PIXEL 24b
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle.inc.c"
+#include "vnc-enc-zrle.inc"
 #undef ZRLE_COMPACT_PIXEL
 #undef ZRLE_BPP
 
diff --git a/ui/vnc-enc-zrle.inc.c b/ui/vnc-enc-zrle.inc
similarity index 100%
rename from ui/vnc-enc-zrle.inc.c
rename to ui/vnc-enc-zrle.inc
-- 
1.8.3.1



