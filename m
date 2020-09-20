Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5445AC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881AC20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcygLCPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881AC20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzDx-0006oG-Ms
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz42-0006Hl-8A
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017q-Kf
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJzAwuafExGGEwX4LpN2r2QxcU8ZKrn0cGn4Bsj3ynA=;
 b=OcygLCPRevbeu0+V+l2O5h8zjHIDy6+hQFHIYP8WN3YMcvdmqczFZ/7xIUiXI0jtubKHwN
 Weut3Dwg0y6yW0if/a6g1vLfqw5D/RMN4KKYr0xejFousY0d1qisXXApfjCeHISQ0ODjc1
 ay87wwlXiae94NqC5v+rZZA11VYFb/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-r-IQZEpCOZ6NLX5I4PWxfw-1; Sun, 20 Sep 2020 09:07:13 -0400
X-MC-Unique: r-IQZEpCOZ6NLX5I4PWxfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BA11074647
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21C5560C47
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] default-configs: remove default-configs/devices for
 user-mode targets
Date: Sun, 20 Sep 2020 09:07:08 -0400
Message-Id: <20200920130708.1156310-10-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-1-pbonzini@redhat.com>
References: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer need dummy files to detect targets, since
default-configs/targets/ exists.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                           | 6 +++---
 default-configs/devices/aarch64-linux-user.mak      | 1 -
 default-configs/devices/aarch64_be-linux-user.mak   | 1 -
 default-configs/devices/alpha-linux-user.mak        | 1 -
 default-configs/devices/arm-linux-user.mak          | 1 -
 default-configs/devices/armeb-linux-user.mak        | 1 -
 default-configs/devices/cris-linux-user.mak         | 1 -
 default-configs/devices/hppa-linux-user.mak         | 1 -
 default-configs/devices/i386-bsd-user.mak           | 1 -
 default-configs/devices/i386-linux-user.mak         | 1 -
 default-configs/devices/m68k-linux-user.mak         | 1 -
 default-configs/devices/microblaze-linux-user.mak   | 1 -
 default-configs/devices/microblazeel-linux-user.mak | 1 -
 default-configs/devices/mips-linux-user.mak         | 1 -
 default-configs/devices/mips64-linux-user.mak       | 1 -
 default-configs/devices/mips64el-linux-user.mak     | 1 -
 default-configs/devices/mipsel-linux-user.mak       | 1 -
 default-configs/devices/mipsn32-linux-user.mak      | 1 -
 default-configs/devices/mipsn32el-linux-user.mak    | 1 -
 default-configs/devices/nios2-linux-user.mak        | 1 -
 default-configs/devices/or1k-linux-user.mak         | 1 -
 default-configs/devices/ppc-linux-user.mak          | 1 -
 default-configs/devices/ppc64-linux-user.mak        | 1 -
 default-configs/devices/ppc64abi32-linux-user.mak   | 1 -
 default-configs/devices/ppc64le-linux-user.mak      | 1 -
 default-configs/devices/riscv32-linux-user.mak      | 1 -
 default-configs/devices/riscv64-linux-user.mak      | 1 -
 default-configs/devices/s390x-linux-user.mak        | 1 -
 default-configs/devices/sh4-linux-user.mak          | 1 -
 default-configs/devices/sh4eb-linux-user.mak        | 1 -
 default-configs/devices/sparc-bsd-user.mak          | 1 -
 default-configs/devices/sparc-linux-user.mak        | 1 -
 default-configs/devices/sparc32plus-linux-user.mak  | 1 -
 default-configs/devices/sparc64-bsd-user.mak        | 1 -
 default-configs/devices/sparc64-linux-user.mak      | 1 -
 default-configs/devices/tilegx-linux-user.mak       | 1 -
 default-configs/devices/x86_64-bsd-user.mak         | 1 -
 default-configs/devices/x86_64-linux-user.mak       | 1 -
 default-configs/devices/xtensa-linux-user.mak       | 1 -
 default-configs/devices/xtensaeb-linux-user.mak     | 1 -
 40 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 default-configs/devices/aarch64-linux-user.mak
 delete mode 100644 default-configs/devices/aarch64_be-linux-user.mak
 delete mode 100644 default-configs/devices/alpha-linux-user.mak
 delete mode 100644 default-configs/devices/arm-linux-user.mak
 delete mode 100644 default-configs/devices/armeb-linux-user.mak
 delete mode 100644 default-configs/devices/cris-linux-user.mak
 delete mode 100644 default-configs/devices/hppa-linux-user.mak
 delete mode 100644 default-configs/devices/i386-bsd-user.mak
 delete mode 100644 default-configs/devices/i386-linux-user.mak
 delete mode 100644 default-configs/devices/m68k-linux-user.mak
 delete mode 100644 default-configs/devices/microblaze-linux-user.mak
 delete mode 100644 default-configs/devices/microblazeel-linux-user.mak
 delete mode 100644 default-configs/devices/mips-linux-user.mak
 delete mode 100644 default-configs/devices/mips64-linux-user.mak
 delete mode 100644 default-configs/devices/mips64el-linux-user.mak
 delete mode 100644 default-configs/devices/mipsel-linux-user.mak
 delete mode 100644 default-configs/devices/mipsn32-linux-user.mak
 delete mode 100644 default-configs/devices/mipsn32el-linux-user.mak
 delete mode 100644 default-configs/devices/nios2-linux-user.mak
 delete mode 100644 default-configs/devices/or1k-linux-user.mak
 delete mode 100644 default-configs/devices/ppc-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64abi32-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64le-linux-user.mak
 delete mode 100644 default-configs/devices/riscv32-linux-user.mak
 delete mode 100644 default-configs/devices/riscv64-linux-user.mak
 delete mode 100644 default-configs/devices/s390x-linux-user.mak
 delete mode 100644 default-configs/devices/sh4-linux-user.mak
 delete mode 100644 default-configs/devices/sh4eb-linux-user.mak
 delete mode 100644 default-configs/devices/sparc-bsd-user.mak
 delete mode 100644 default-configs/devices/sparc-linux-user.mak
 delete mode 100644 default-configs/devices/sparc32plus-linux-user.mak
 delete mode 100644 default-configs/devices/sparc64-bsd-user.mak
 delete mode 100644 default-configs/devices/sparc64-linux-user.mak
 delete mode 100644 default-configs/devices/tilegx-linux-user.mak
 delete mode 100644 default-configs/devices/x86_64-bsd-user.mak
 delete mode 100644 default-configs/devices/x86_64-linux-user.mak
 delete mode 100644 default-configs/devices/xtensa-linux-user.mak
 delete mode 100644 default-configs/devices/xtensaeb-linux-user.mak

diff --git a/configure b/configure
index f6275d95fc..d672006df2 100755
--- a/configure
+++ b/configure
@@ -1611,13 +1611,13 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$softmmu" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-softmmu.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-softmmu.mak"
 fi
 if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-linux-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-linux-user.mak"
 fi
 if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-bsd-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-bsd-user.mak"
 fi
 
 if test -z "$target_list_exclude" -a -z "$target_list"; then
diff --git a/default-configs/devices/aarch64-linux-user.mak b/default-configs/devices/aarch64-linux-user.mak
deleted file mode 100644
index 0a5b08a007..0000000000
--- a/default-configs/devices/aarch64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for aarch64-linux-user
diff --git a/default-configs/devices/aarch64_be-linux-user.mak b/default-configs/devices/aarch64_be-linux-user.mak
deleted file mode 100644
index a69d9d2e41..0000000000
--- a/default-configs/devices/aarch64_be-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for aarch64_be-linux-user
diff --git a/default-configs/devices/alpha-linux-user.mak b/default-configs/devices/alpha-linux-user.mak
deleted file mode 100644
index 7956e29898..0000000000
--- a/default-configs/devices/alpha-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for alpha-linux-user
diff --git a/default-configs/devices/arm-linux-user.mak b/default-configs/devices/arm-linux-user.mak
deleted file mode 100644
index 413361a022..0000000000
--- a/default-configs/devices/arm-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for arm-linux-user
diff --git a/default-configs/devices/armeb-linux-user.mak b/default-configs/devices/armeb-linux-user.mak
deleted file mode 100644
index bf2ffe7038..0000000000
--- a/default-configs/devices/armeb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for armeb-linux-user
diff --git a/default-configs/devices/cris-linux-user.mak b/default-configs/devices/cris-linux-user.mak
deleted file mode 100644
index e3aec7b864..0000000000
--- a/default-configs/devices/cris-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for cris-linux-user
diff --git a/default-configs/devices/hppa-linux-user.mak b/default-configs/devices/hppa-linux-user.mak
deleted file mode 100644
index 796393940b..0000000000
--- a/default-configs/devices/hppa-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for hppa-linux-user
diff --git a/default-configs/devices/i386-bsd-user.mak b/default-configs/devices/i386-bsd-user.mak
deleted file mode 100644
index af1b31a59a..0000000000
--- a/default-configs/devices/i386-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for i386-bsd-user
diff --git a/default-configs/devices/i386-linux-user.mak b/default-configs/devices/i386-linux-user.mak
deleted file mode 100644
index 8657e68627..0000000000
--- a/default-configs/devices/i386-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for i386-linux-user
diff --git a/default-configs/devices/m68k-linux-user.mak b/default-configs/devices/m68k-linux-user.mak
deleted file mode 100644
index 06cd5ed7ed..0000000000
--- a/default-configs/devices/m68k-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for m68k-linux-user
diff --git a/default-configs/devices/microblaze-linux-user.mak b/default-configs/devices/microblaze-linux-user.mak
deleted file mode 100644
index 566fdc01c4..0000000000
--- a/default-configs/devices/microblaze-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for microblaze-linux-user
diff --git a/default-configs/devices/microblazeel-linux-user.mak b/default-configs/devices/microblazeel-linux-user.mak
deleted file mode 100644
index 378c6ddcb0..0000000000
--- a/default-configs/devices/microblazeel-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for microblazeel-linux-user
diff --git a/default-configs/devices/mips-linux-user.mak b/default-configs/devices/mips-linux-user.mak
deleted file mode 100644
index 31df57021e..0000000000
--- a/default-configs/devices/mips-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips-linux-user
diff --git a/default-configs/devices/mips64-linux-user.mak b/default-configs/devices/mips64-linux-user.mak
deleted file mode 100644
index 1598bfcf7d..0000000000
--- a/default-configs/devices/mips64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips64-linux-user
diff --git a/default-configs/devices/mips64el-linux-user.mak b/default-configs/devices/mips64el-linux-user.mak
deleted file mode 100644
index 629f084086..0000000000
--- a/default-configs/devices/mips64el-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips64el-linux-user
diff --git a/default-configs/devices/mipsel-linux-user.mak b/default-configs/devices/mipsel-linux-user.mak
deleted file mode 100644
index 4d0e4afb69..0000000000
--- a/default-configs/devices/mipsel-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsel-linux-user
diff --git a/default-configs/devices/mipsn32-linux-user.mak b/default-configs/devices/mipsn32-linux-user.mak
deleted file mode 100644
index 5b97919794..0000000000
--- a/default-configs/devices/mipsn32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsn32-linux-user
diff --git a/default-configs/devices/mipsn32el-linux-user.mak b/default-configs/devices/mipsn32el-linux-user.mak
deleted file mode 100644
index d6367ff987..0000000000
--- a/default-configs/devices/mipsn32el-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsn32el-linux-user
diff --git a/default-configs/devices/nios2-linux-user.mak b/default-configs/devices/nios2-linux-user.mak
deleted file mode 100644
index 5be3eb795d..0000000000
--- a/default-configs/devices/nios2-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for nios2-linux-user
diff --git a/default-configs/devices/or1k-linux-user.mak b/default-configs/devices/or1k-linux-user.mak
deleted file mode 100644
index 20e03c1317..0000000000
--- a/default-configs/devices/or1k-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for or1k-linux-user
diff --git a/default-configs/devices/ppc-linux-user.mak b/default-configs/devices/ppc-linux-user.mak
deleted file mode 100644
index 6273df2930..0000000000
--- a/default-configs/devices/ppc-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc-linux-user
diff --git a/default-configs/devices/ppc64-linux-user.mak b/default-configs/devices/ppc64-linux-user.mak
deleted file mode 100644
index 422d3fbaeb..0000000000
--- a/default-configs/devices/ppc64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64-linux-user
diff --git a/default-configs/devices/ppc64abi32-linux-user.mak b/default-configs/devices/ppc64abi32-linux-user.mak
deleted file mode 100644
index 1c657ec9bb..0000000000
--- a/default-configs/devices/ppc64abi32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64abi32-linux-user
diff --git a/default-configs/devices/ppc64le-linux-user.mak b/default-configs/devices/ppc64le-linux-user.mak
deleted file mode 100644
index 63f4269023..0000000000
--- a/default-configs/devices/ppc64le-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64le-linux-user
diff --git a/default-configs/devices/riscv32-linux-user.mak b/default-configs/devices/riscv32-linux-user.mak
deleted file mode 100644
index 865b362f5a..0000000000
--- a/default-configs/devices/riscv32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for riscv-linux-user
diff --git a/default-configs/devices/riscv64-linux-user.mak b/default-configs/devices/riscv64-linux-user.mak
deleted file mode 100644
index 865b362f5a..0000000000
--- a/default-configs/devices/riscv64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for riscv-linux-user
diff --git a/default-configs/devices/s390x-linux-user.mak b/default-configs/devices/s390x-linux-user.mak
deleted file mode 100644
index a243c99874..0000000000
--- a/default-configs/devices/s390x-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for s390x-linux-user
diff --git a/default-configs/devices/sh4-linux-user.mak b/default-configs/devices/sh4-linux-user.mak
deleted file mode 100644
index a469e19ac6..0000000000
--- a/default-configs/devices/sh4-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sh4-linux-user
diff --git a/default-configs/devices/sh4eb-linux-user.mak b/default-configs/devices/sh4eb-linux-user.mak
deleted file mode 100644
index be08ca1002..0000000000
--- a/default-configs/devices/sh4eb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sh4eb-linux-user
diff --git a/default-configs/devices/sparc-bsd-user.mak b/default-configs/devices/sparc-bsd-user.mak
deleted file mode 100644
index 21e09508d8..0000000000
--- a/default-configs/devices/sparc-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc-bsd-user
diff --git a/default-configs/devices/sparc-linux-user.mak b/default-configs/devices/sparc-linux-user.mak
deleted file mode 100644
index 9c716d1f92..0000000000
--- a/default-configs/devices/sparc-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc-linux-user
diff --git a/default-configs/devices/sparc32plus-linux-user.mak b/default-configs/devices/sparc32plus-linux-user.mak
deleted file mode 100644
index 432e88011e..0000000000
--- a/default-configs/devices/sparc32plus-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc32plus-linux-user
diff --git a/default-configs/devices/sparc64-bsd-user.mak b/default-configs/devices/sparc64-bsd-user.mak
deleted file mode 100644
index b8b9eea7f6..0000000000
--- a/default-configs/devices/sparc64-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc64-bsd-user
diff --git a/default-configs/devices/sparc64-linux-user.mak b/default-configs/devices/sparc64-linux-user.mak
deleted file mode 100644
index bf1bdd6aa4..0000000000
--- a/default-configs/devices/sparc64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc64-linux-user
diff --git a/default-configs/devices/tilegx-linux-user.mak b/default-configs/devices/tilegx-linux-user.mak
deleted file mode 100644
index 3e47493af0..0000000000
--- a/default-configs/devices/tilegx-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for tilegx-linux-user
diff --git a/default-configs/devices/x86_64-bsd-user.mak b/default-configs/devices/x86_64-bsd-user.mak
deleted file mode 100644
index 73e5d34ec5..0000000000
--- a/default-configs/devices/x86_64-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for x86_64-bsd-user
diff --git a/default-configs/devices/x86_64-linux-user.mak b/default-configs/devices/x86_64-linux-user.mak
deleted file mode 100644
index bec1d9e7c6..0000000000
--- a/default-configs/devices/x86_64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for x86_64-linux-user
diff --git a/default-configs/devices/xtensa-linux-user.mak b/default-configs/devices/xtensa-linux-user.mak
deleted file mode 100644
index fd1d350ee9..0000000000
--- a/default-configs/devices/xtensa-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for xtensa-linux-user
diff --git a/default-configs/devices/xtensaeb-linux-user.mak b/default-configs/devices/xtensaeb-linux-user.mak
deleted file mode 100644
index fd1d350ee9..0000000000
--- a/default-configs/devices/xtensaeb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for xtensa-linux-user
-- 
2.26.2


