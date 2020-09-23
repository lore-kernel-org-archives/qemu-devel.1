Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0341206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2lTo6IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0341206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL11V-0000x8-Kp
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oa-0001F1-FA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-0002NU-IZ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94X5PSzSwL05xf1B2MpSeV/8KqUGx6cAUA43T+vor3E=;
 b=G2lTo6IZSyFUyqsMCHbr17EKkh80RZU2lu6JWjcArherKk4KDzTBnqEZH53ApvMte04S+F
 y5NK8jmQgQAPiFi27mTDbmk0KDyX1xqknYjM9x0Jes8pe/hCEqaOvoPSx7J6O7VIXvRUWP
 ezGscLVtl8bp4oetE8NnD7M0uLbO77o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-M00J1RNxPg21HdatwveCxQ-1; Wed, 23 Sep 2020 05:11:40 -0400
X-MC-Unique: M00J1RNxPg21HdatwveCxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA5E1005E77;
 Wed, 23 Sep 2020 09:11:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC5BF19C4F;
 Wed, 23 Sep 2020 09:11:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] default-configs: remove redundant keys
Date: Wed, 23 Sep 2020 05:11:31 -0400
Message-Id: <20200923091131.1591563-13-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TARGET_BASE_ARCH and TARGET_ABI_DIR are 99% of the time the same
as TARGET_ARCH, remove them if so.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/targets/aarch64-linux-user.mak      | 1 -
 default-configs/targets/aarch64_be-linux-user.mak   | 1 -
 default-configs/targets/alpha-linux-user.mak        | 2 --
 default-configs/targets/alpha-softmmu.mak           | 1 -
 default-configs/targets/arm-linux-user.mak          | 2 --
 default-configs/targets/arm-softmmu.mak             | 1 -
 default-configs/targets/armeb-linux-user.mak        | 2 --
 default-configs/targets/avr-softmmu.mak             | 1 -
 default-configs/targets/cris-linux-user.mak         | 2 --
 default-configs/targets/cris-softmmu.mak            | 1 -
 default-configs/targets/hppa-linux-user.mak         | 2 --
 default-configs/targets/hppa-softmmu.mak            | 1 -
 default-configs/targets/i386-bsd-user.mak           | 2 --
 default-configs/targets/i386-linux-user.mak         | 2 --
 default-configs/targets/i386-softmmu.mak            | 1 -
 default-configs/targets/lm32-softmmu.mak            | 1 -
 default-configs/targets/m68k-linux-user.mak         | 2 --
 default-configs/targets/m68k-softmmu.mak            | 1 -
 default-configs/targets/microblaze-linux-user.mak   | 2 --
 default-configs/targets/microblaze-softmmu.mak      | 1 -
 default-configs/targets/microblazeel-linux-user.mak | 2 --
 default-configs/targets/microblazeel-softmmu.mak    | 1 -
 default-configs/targets/mips-linux-user.mak         | 2 --
 default-configs/targets/mips-softmmu.mak            | 1 -
 default-configs/targets/mips64-linux-user.mak       | 1 -
 default-configs/targets/mips64el-linux-user.mak     | 1 -
 default-configs/targets/mipsel-linux-user.mak       | 2 --
 default-configs/targets/mipsel-softmmu.mak          | 1 -
 default-configs/targets/mipsn32-linux-user.mak      | 1 -
 default-configs/targets/mipsn32el-linux-user.mak    | 1 -
 default-configs/targets/moxie-softmmu.mak           | 1 -
 default-configs/targets/nios2-linux-user.mak        | 2 --
 default-configs/targets/nios2-softmmu.mak           | 1 -
 default-configs/targets/or1k-linux-user.mak         | 2 --
 default-configs/targets/or1k-softmmu.mak            | 1 -
 default-configs/targets/ppc-linux-user.mak          | 2 --
 default-configs/targets/ppc-softmmu.mak             | 1 -
 default-configs/targets/rx-softmmu.mak              | 1 -
 default-configs/targets/s390x-linux-user.mak        | 2 --
 default-configs/targets/s390x-softmmu.mak           | 1 -
 default-configs/targets/sh4-linux-user.mak          | 2 --
 default-configs/targets/sh4-softmmu.mak             | 1 -
 default-configs/targets/sh4eb-linux-user.mak        | 2 --
 default-configs/targets/sh4eb-softmmu.mak           | 1 -
 default-configs/targets/sparc-bsd-user.mak          | 2 --
 default-configs/targets/sparc-linux-user.mak        | 2 --
 default-configs/targets/sparc-softmmu.mak           | 1 -
 default-configs/targets/sparc64-bsd-user.mak        | 1 -
 default-configs/targets/sparc64-linux-user.mak      | 1 -
 default-configs/targets/tilegx-linux-user.mak       | 2 --
 default-configs/targets/tricore-softmmu.mak         | 1 -
 default-configs/targets/unicore32-softmmu.mak       | 1 -
 default-configs/targets/x86_64-bsd-user.mak         | 1 -
 default-configs/targets/x86_64-linux-user.mak       | 1 -
 default-configs/targets/xtensa-linux-user.mak       | 2 --
 default-configs/targets/xtensa-softmmu.mak          | 1 -
 default-configs/targets/xtensaeb-linux-user.mak     | 2 --
 default-configs/targets/xtensaeb-softmmu.mak        | 1 -
 meson.build                                         | 8 ++++++++
 59 files changed, 8 insertions(+), 81 deletions(-)

diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
index d6c4a35c39..163c9209f4 100644
--- a/default-configs/targets/aarch64-linux-user.mak
+++ b/default-configs/targets/aarch64-linux-user.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=aarch64
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/aarch64_be-linux-user.mak b/default-configs/targets/aarch64_be-linux-user.mak
index 5e2d615c11..4c953cf8c5 100644
--- a/default-configs/targets/aarch64_be-linux-user.mak
+++ b/default-configs/targets/aarch64_be-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=aarch64
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/alpha-linux-user.mak b/default-configs/targets/alpha-linux-user.mak
index e21f7cdefd..7e62fd796a 100644
--- a/default-configs/targets/alpha-linux-user.mak
+++ b/default-configs/targets/alpha-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=alpha
-TARGET_BASE_ARCH=alpha
-TARGET_ABI_DIR=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/alpha-softmmu.mak b/default-configs/targets/alpha-softmmu.mak
index 8ba1b4e403..e4b874a19e 100644
--- a/default-configs/targets/alpha-softmmu.mak
+++ b/default-configs/targets/alpha-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=alpha
-TARGET_BASE_ARCH=alpha
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
index 1b9bac9d3a..c7cd872e86 100644
--- a/default-configs/targets/arm-linux-user.mak
+++ b/default-configs/targets/arm-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
index 8af1d3ee1d..9b1a7f37c6 100644
--- a/default-configs/targets/arm-softmmu.mak
+++ b/default-configs/targets/arm-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/armeb-linux-user.mak b/default-configs/targets/armeb-linux-user.mak
index d2b0d9e26e..79bf10e99b 100644
--- a/default-configs/targets/armeb-linux-user.mak
+++ b/default-configs/targets/armeb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/avr-softmmu.mak
index 547c2986b6..e3f921c019 100644
--- a/default-configs/targets/avr-softmmu.mak
+++ b/default-configs/targets/avr-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=avr
-TARGET_BASE_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
diff --git a/default-configs/targets/cris-linux-user.mak b/default-configs/targets/cris-linux-user.mak
index 7d3f6eb36d..e483c42066 100644
--- a/default-configs/targets/cris-linux-user.mak
+++ b/default-configs/targets/cris-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=cris
-TARGET_BASE_ARCH=cris
-TARGET_ABI_DIR=cris
diff --git a/default-configs/targets/cris-softmmu.mak b/default-configs/targets/cris-softmmu.mak
index a132cec8d9..e483c42066 100644
--- a/default-configs/targets/cris-softmmu.mak
+++ b/default-configs/targets/cris-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=cris
-TARGET_BASE_ARCH=cris
diff --git a/default-configs/targets/hppa-linux-user.mak b/default-configs/targets/hppa-linux-user.mak
index 05ef4568ad..f01e0a7b9e 100644
--- a/default-configs/targets/hppa-linux-user.mak
+++ b/default-configs/targets/hppa-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=hppa
-TARGET_BASE_ARCH=hppa
-TARGET_ABI_DIR=hppa
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/targets/hppa-softmmu.mak
index bd7eaaf9a5..e3e71eb21b 100644
--- a/default-configs/targets/hppa-softmmu.mak
+++ b/default-configs/targets/hppa-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=hppa
-TARGET_BASE_ARCH=hppa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/i386-bsd-user.mak b/default-configs/targets/i386-bsd-user.mak
index aa4d8c55e1..0283bb62a0 100644
--- a/default-configs/targets/i386-bsd-user.mak
+++ b/default-configs/targets/i386-bsd-user.mak
@@ -1,4 +1,2 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=i386
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-linux-user.mak b/default-configs/targets/i386-linux-user.mak
index 5117f59222..5b2546a430 100644
--- a/default-configs/targets/i386-linux-user.mak
+++ b/default-configs/targets/i386-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-softmmu.mak b/default-configs/targets/i386-softmmu.mak
index 7371e87982..5babf71895 100644
--- a/default-configs/targets/i386-softmmu.mak
+++ b/default-configs/targets/i386-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/lm32-softmmu.mak b/default-configs/targets/lm32-softmmu.mak
index 6e55873788..55e7184a3d 100644
--- a/default-configs/targets/lm32-softmmu.mak
+++ b/default-configs/targets/lm32-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=lm32
-TARGET_BASE_ARCH=lm32
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-linux-user.mak b/default-configs/targets/m68k-linux-user.mak
index 186d1117cf..805d16c6ab 100644
--- a/default-configs/targets/m68k-linux-user.mak
+++ b/default-configs/targets/m68k-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=m68k
-TARGET_BASE_ARCH=m68k
-TARGET_ABI_DIR=m68k
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softmmu.mak
index fd8975978c..5df1a2b7d7 100644
--- a/default-configs/targets/m68k-softmmu.mak
+++ b/default-configs/targets/m68k-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=m68k
-TARGET_BASE_ARCH=m68k
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
diff --git a/default-configs/targets/microblaze-linux-user.mak b/default-configs/targets/microblaze-linux-user.mak
index 249a22295a..2a25bf2fa3 100644
--- a/default-configs/targets/microblaze-linux-user.mak
+++ b/default-configs/targets/microblaze-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
index 8e5126f0f1..0b5c78ef00 100644
--- a/default-configs/targets/microblaze-softmmu.mak
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/microblazeel-linux-user.mak b/default-configs/targets/microblazeel-linux-user.mak
index f59156c63b..d0e775d840 100644
--- a/default-configs/targets/microblazeel-linux-user.mak
+++ b/default-configs/targets/microblazeel-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
index 2d465cf6b4..dc822219d8 100644
--- a/default-configs/targets/microblazeel-softmmu.mak
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips-linux-user.mak b/default-configs/targets/mips-linux-user.mak
index 5b8000dfb0..19f5779831 100644
--- a/default-configs/targets/mips-linux-user.mak
+++ b/default-configs/targets/mips-linux-user.mak
@@ -1,7 +1,5 @@
 TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/mips-softmmu.mak
index e391801a0e..8a49999a47 100644
--- a/default-configs/targets/mips-softmmu.mak
+++ b/default-configs/targets/mips-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=mips
-TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips64-linux-user.mak b/default-configs/targets/mips64-linux-user.mak
index 811df35427..32fd1acdf2 100644
--- a/default-configs/targets/mips64-linux-user.mak
+++ b/default-configs/targets/mips64-linux-user.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mips64el-linux-user.mak b/default-configs/targets/mips64el-linux-user.mak
index f9de5d7857..f348f35997 100644
--- a/default-configs/targets/mips64el-linux-user.mak
+++ b/default-configs/targets/mips64el-linux-user.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-linux-user.mak b/default-configs/targets/mipsel-linux-user.mak
index 11c3556665..e23793070c 100644
--- a/default-configs/targets/mipsel-linux-user.mak
+++ b/default-configs/targets/mipsel-linux-user.mak
@@ -1,7 +1,5 @@
 TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/targets/mipsel-softmmu.mak
index a9fc3b2647..c7c41f4fb7 100644
--- a/default-configs/targets/mipsel-softmmu.mak
+++ b/default-configs/targets/mipsel-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=mips
-TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mipsn32-linux-user.mak b/default-configs/targets/mipsn32-linux-user.mak
index 040022ce87..b8c2441ad0 100644
--- a/default-configs/targets/mipsn32-linux-user.mak
+++ b/default-configs/targets/mipsn32-linux-user.mak
@@ -2,7 +2,6 @@ TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsn32el-linux-user.mak b/default-configs/targets/mipsn32el-linux-user.mak
index faeca7752e..f31a9c394b 100644
--- a/default-configs/targets/mipsn32el-linux-user.mak
+++ b/default-configs/targets/mipsn32el-linux-user.mak
@@ -2,7 +2,6 @@ TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/moxie-softmmu.mak b/default-configs/targets/moxie-softmmu.mak
index b9d8d97031..183e6b0ebd 100644
--- a/default-configs/targets/moxie-softmmu.mak
+++ b/default-configs/targets/moxie-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=moxie
-TARGET_BASE_ARCH=moxie
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/nios2-linux-user.mak b/default-configs/targets/nios2-linux-user.mak
index 57ddc32838..9a372f0717 100644
--- a/default-configs/targets/nios2-linux-user.mak
+++ b/default-configs/targets/nios2-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=nios2
-TARGET_BASE_ARCH=nios2
-TARGET_ABI_DIR=nios2
diff --git a/default-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmmu.mak
index 787d1d1be1..9a372f0717 100644
--- a/default-configs/targets/nios2-softmmu.mak
+++ b/default-configs/targets/nios2-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=nios2
-TARGET_BASE_ARCH=nios2
diff --git a/default-configs/targets/or1k-linux-user.mak b/default-configs/targets/or1k-linux-user.mak
index 88175f039b..1dfb93e46d 100644
--- a/default-configs/targets/or1k-linux-user.mak
+++ b/default-configs/targets/or1k-linux-user.mak
@@ -1,4 +1,2 @@
 TARGET_ARCH=openrisc
-TARGET_BASE_ARCH=openrisc
-TARGET_ABI_DIR=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/or1k-softmmu.mak b/default-configs/targets/or1k-softmmu.mak
index 4c0c4165aa..1dfb93e46d 100644
--- a/default-configs/targets/or1k-softmmu.mak
+++ b/default-configs/targets/or1k-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=openrisc
-TARGET_BASE_ARCH=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-linux-user.mak b/default-configs/targets/ppc-linux-user.mak
index dda377508b..ca4187e4aa 100644
--- a/default-configs/targets/ppc-linux-user.mak
+++ b/default-configs/targets/ppc-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=ppc
-TARGET_BASE_ARCH=ppc
-TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
index b02f1fe51a..ef69037a2c 100644
--- a/default-configs/targets/ppc-softmmu.mak
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=ppc
-TARGET_BASE_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
index 07abc5cd55..2d410e0b0c 100644
--- a/default-configs/targets/rx-softmmu.mak
+++ b/default-configs/targets/rx-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=rx
-TARGET_BASE_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
diff --git a/default-configs/targets/s390x-linux-user.mak b/default-configs/targets/s390x-linux-user.mak
index f7e4244f43..9e31ce6457 100644
--- a/default-configs/targets/s390x-linux-user.mak
+++ b/default-configs/targets/s390x-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=s390x
-TARGET_BASE_ARCH=s390x
-TARGET_ABI_DIR=s390x
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.mak
index 080682f07b..fd9fbd870d 100644
--- a/default-configs/targets/s390x-softmmu.mak
+++ b/default-configs/targets/s390x-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=s390x
-TARGET_BASE_ARCH=s390x
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
diff --git a/default-configs/targets/sh4-linux-user.mak b/default-configs/targets/sh4-linux-user.mak
index db395a4886..0152d6621e 100644
--- a/default-configs/targets/sh4-linux-user.mak
+++ b/default-configs/targets/sh4-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak
index 037cdac1d2..95896376c4 100644
--- a/default-configs/targets/sh4-softmmu.mak
+++ b/default-configs/targets/sh4-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-linux-user.mak b/default-configs/targets/sh4eb-linux-user.mak
index b498e99ac2..9b6fb4c1bb 100644
--- a/default-configs/targets/sh4eb-linux-user.mak
+++ b/default-configs/targets/sh4eb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targets/sh4eb-softmmu.mak
index e0fc9715e0..382e9a80f8 100644
--- a/default-configs/targets/sh4eb-softmmu.mak
+++ b/default-configs/targets/sh4eb-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak
index bb83a268b6..9ba3d7b07f 100644
--- a/default-configs/targets/sparc-bsd-user.mak
+++ b/default-configs/targets/sparc-bsd-user.mak
@@ -1,5 +1,3 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-linux-user.mak b/default-configs/targets/sparc-linux-user.mak
index 72a4a90219..53dc7aaed5 100644
--- a/default-configs/targets/sparc-linux-user.mak
+++ b/default-configs/targets/sparc-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sparc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak
index dab69263bb..9ba3d7b07f 100644
--- a/default-configs/targets/sparc-softmmu.mak
+++ b/default-configs/targets/sparc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/sparc64-bsd-user.mak
index 3202825dc3..8dd3217800 100644
--- a/default-configs/targets/sparc64-bsd-user.mak
+++ b/default-configs/targets/sparc64-bsd-user.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc64
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-linux-user.mak b/default-configs/targets/sparc64-linux-user.mak
index 87d880032e..846924201a 100644
--- a/default-configs/targets/sparc64-linux-user.mak
+++ b/default-configs/targets/sparc64-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc64
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/tilegx-linux-user.mak b/default-configs/targets/tilegx-linux-user.mak
index dfa00f4327..10480e74c9 100644
--- a/default-configs/targets/tilegx-linux-user.mak
+++ b/default-configs/targets/tilegx-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=tilegx
-TARGET_BASE_ARCH=tilegx
-TARGET_ABI_DIR=tilegx
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/targets/tricore-softmmu.mak
index 6f4193717f..96b10af853 100644
--- a/default-configs/targets/tricore-softmmu.mak
+++ b/default-configs/targets/tricore-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=tricore
-TARGET_BASE_ARCH=tricore
diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-configs/targets/unicore32-softmmu.mak
index 23d02da953..57331e94fe 100644
--- a/default-configs/targets/unicore32-softmmu.mak
+++ b/default-configs/targets/unicore32-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=unicore32
-TARGET_BASE_ARCH=unicore32
diff --git a/default-configs/targets/x86_64-bsd-user.mak b/default-configs/targets/x86_64-bsd-user.mak
index 83ac877606..799cd4acd4 100644
--- a/default-configs/targets/x86_64-bsd-user.mak
+++ b/default-configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=x86_64
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-linux-user.mak b/default-configs/targets/x86_64-linux-user.mak
index 6ccc10597b..9ceefbb615 100644
--- a/default-configs/targets/x86_64-linux-user.mak
+++ b/default-configs/targets/x86_64-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=x86_64
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/xtensa-linux-user.mak b/default-configs/targets/xtensa-linux-user.mak
index 83ac59dbc9..fc95cc60f5 100644
--- a/default-configs/targets/xtensa-linux-user.mak
+++ b/default-configs/targets/xtensa-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/xtensa-softmmu.mak
index 7ea404f8be..26c0285655 100644
--- a/default-configs/targets/xtensa-softmmu.mak
+++ b/default-configs/targets/xtensa-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/xtensaeb-linux-user.mak b/default-configs/targets/xtensaeb-linux-user.mak
index 954e798fbe..cfc3518118 100644
--- a/default-configs/targets/xtensaeb-linux-user.mak
+++ b/default-configs/targets/xtensaeb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/xtensaeb-softmmu.mak b/default-configs/targets/xtensaeb-softmmu.mak
index c22832d236..14cb9289a6 100644
--- a/default-configs/targets/xtensaeb-softmmu.mak
+++ b/default-configs/targets/xtensaeb-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/meson.build b/meson.build
index 444610a258..b90fd23f27 100644
--- a/meson.build
+++ b/meson.build
@@ -780,6 +780,14 @@ foreach target : target_dirs
   config_target += keyval.load('default-configs/targets' / target + '.mak')
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
+  # Add default keys
+  if 'TARGET_BASE_ARCH' not in config_target
+    config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
+  endif
+  if 'TARGET_ABI_DIR' not in config_target
+    config_target += {'TARGET_ABI_DIR': config_target['TARGET_ARCH']}
+  endif
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
-- 
2.26.2


