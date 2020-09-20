Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7207C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108B420EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAMxwWO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108B420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzAn-0004iJ-0R
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3q-0006A4-T9
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-000184-GQ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhMctbgkeMPZhDoiOUuIIz9jqksde6/IoFkbGNb4ZGs=;
 b=AAMxwWO4/ksBHYtl8Lvoeg+4szonaYgHvYJzBFPf/oAxeq6/pleZe5zod5EX1lOaGz8UJA
 V+aM5rAZ6j1Tw3HbtsjK3pmpI4IfMLbA0Q5rX6zyKyqYMn5r6PgEq/9ncVGjWC2tYiv+hG
 hkLUOhn0ONR1Ib62V9KWBfE5XglcNyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-AZoclnhMNyWZjziQALU8VA-1; Sun, 20 Sep 2020 09:07:10 -0400
X-MC-Unique: AZoclnhMNyWZjziQALU8VA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A59271074644
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73FA560C47
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] default-configs: move files to default-configs/devices/
Date: Sun, 20 Sep 2020 09:07:00 -0400
Message-Id: <20200920130708.1156310-2-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:07:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make room for target files in default-configs/targets/

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                                 | 6 +++---
 default-configs/{ => devices}/aarch64-linux-user.mak      | 0
 default-configs/{ => devices}/aarch64-softmmu.mak         | 0
 default-configs/{ => devices}/aarch64_be-linux-user.mak   | 0
 default-configs/{ => devices}/alpha-linux-user.mak        | 0
 default-configs/{ => devices}/alpha-softmmu.mak           | 0
 default-configs/{ => devices}/arm-linux-user.mak          | 0
 default-configs/{ => devices}/arm-softmmu.mak             | 0
 default-configs/{ => devices}/armeb-linux-user.mak        | 0
 default-configs/{ => devices}/avr-softmmu.mak             | 0
 default-configs/{ => devices}/cris-linux-user.mak         | 0
 default-configs/{ => devices}/cris-softmmu.mak            | 0
 default-configs/{ => devices}/hppa-linux-user.mak         | 0
 default-configs/{ => devices}/hppa-softmmu.mak            | 0
 default-configs/{ => devices}/i386-bsd-user.mak           | 0
 default-configs/{ => devices}/i386-linux-user.mak         | 0
 default-configs/{ => devices}/i386-softmmu.mak            | 0
 default-configs/{ => devices}/lm32-softmmu.mak            | 0
 default-configs/{ => devices}/m68k-linux-user.mak         | 0
 default-configs/{ => devices}/m68k-softmmu.mak            | 0
 default-configs/{ => devices}/microblaze-linux-user.mak   | 0
 default-configs/{ => devices}/microblaze-softmmu.mak      | 0
 default-configs/{ => devices}/microblazeel-linux-user.mak | 0
 default-configs/{ => devices}/microblazeel-softmmu.mak    | 0
 default-configs/{ => devices}/mips-linux-user.mak         | 0
 default-configs/{ => devices}/mips-softmmu-common.mak     | 0
 default-configs/{ => devices}/mips-softmmu.mak            | 0
 default-configs/{ => devices}/mips64-linux-user.mak       | 0
 default-configs/{ => devices}/mips64-softmmu.mak          | 0
 default-configs/{ => devices}/mips64el-linux-user.mak     | 0
 default-configs/{ => devices}/mips64el-softmmu.mak        | 0
 default-configs/{ => devices}/mipsel-linux-user.mak       | 0
 default-configs/{ => devices}/mipsel-softmmu.mak          | 0
 default-configs/{ => devices}/mipsn32-linux-user.mak      | 0
 default-configs/{ => devices}/mipsn32el-linux-user.mak    | 0
 default-configs/{ => devices}/moxie-softmmu.mak           | 0
 default-configs/{ => devices}/nios2-linux-user.mak        | 0
 default-configs/{ => devices}/nios2-softmmu.mak           | 0
 default-configs/{ => devices}/or1k-linux-user.mak         | 0
 default-configs/{ => devices}/or1k-softmmu.mak            | 0
 default-configs/{ => devices}/ppc-linux-user.mak          | 0
 default-configs/{ => devices}/ppc-softmmu.mak             | 0
 default-configs/{ => devices}/ppc64-linux-user.mak        | 0
 default-configs/{ => devices}/ppc64-softmmu.mak           | 0
 default-configs/{ => devices}/ppc64abi32-linux-user.mak   | 0
 default-configs/{ => devices}/ppc64le-linux-user.mak      | 0
 default-configs/{ => devices}/riscv32-linux-user.mak      | 0
 default-configs/{ => devices}/riscv32-softmmu.mak         | 0
 default-configs/{ => devices}/riscv64-linux-user.mak      | 0
 default-configs/{ => devices}/riscv64-softmmu.mak         | 0
 default-configs/{ => devices}/rx-softmmu.mak              | 0
 default-configs/{ => devices}/s390x-linux-user.mak        | 0
 default-configs/{ => devices}/s390x-softmmu.mak           | 0
 default-configs/{ => devices}/sh4-linux-user.mak          | 0
 default-configs/{ => devices}/sh4-softmmu.mak             | 0
 default-configs/{ => devices}/sh4eb-linux-user.mak        | 0
 default-configs/{ => devices}/sh4eb-softmmu.mak           | 0
 default-configs/{ => devices}/sparc-bsd-user.mak          | 0
 default-configs/{ => devices}/sparc-linux-user.mak        | 0
 default-configs/{ => devices}/sparc-softmmu.mak           | 0
 default-configs/{ => devices}/sparc32plus-linux-user.mak  | 0
 default-configs/{ => devices}/sparc64-bsd-user.mak        | 0
 default-configs/{ => devices}/sparc64-linux-user.mak      | 0
 default-configs/{ => devices}/sparc64-softmmu.mak         | 0
 default-configs/{ => devices}/tilegx-linux-user.mak       | 0
 default-configs/{ => devices}/tricore-softmmu.mak         | 0
 default-configs/{ => devices}/unicore32-softmmu.mak       | 0
 default-configs/{ => devices}/x86_64-bsd-user.mak         | 0
 default-configs/{ => devices}/x86_64-linux-user.mak       | 0
 default-configs/{ => devices}/x86_64-softmmu.mak          | 0
 default-configs/{ => devices}/xtensa-linux-user.mak       | 0
 default-configs/{ => devices}/xtensa-softmmu.mak          | 0
 default-configs/{ => devices}/xtensaeb-linux-user.mak     | 0
 default-configs/{ => devices}/xtensaeb-softmmu.mak        | 0
 meson.build                                               | 2 +-
 75 files changed, 4 insertions(+), 4 deletions(-)
 rename default-configs/{ => devices}/aarch64-linux-user.mak (100%)
 rename default-configs/{ => devices}/aarch64-softmmu.mak (100%)
 rename default-configs/{ => devices}/aarch64_be-linux-user.mak (100%)
 rename default-configs/{ => devices}/alpha-linux-user.mak (100%)
 rename default-configs/{ => devices}/alpha-softmmu.mak (100%)
 rename default-configs/{ => devices}/arm-linux-user.mak (100%)
 rename default-configs/{ => devices}/arm-softmmu.mak (100%)
 rename default-configs/{ => devices}/armeb-linux-user.mak (100%)
 rename default-configs/{ => devices}/avr-softmmu.mak (100%)
 rename default-configs/{ => devices}/cris-linux-user.mak (100%)
 rename default-configs/{ => devices}/cris-softmmu.mak (100%)
 rename default-configs/{ => devices}/hppa-linux-user.mak (100%)
 rename default-configs/{ => devices}/hppa-softmmu.mak (100%)
 rename default-configs/{ => devices}/i386-bsd-user.mak (100%)
 rename default-configs/{ => devices}/i386-linux-user.mak (100%)
 rename default-configs/{ => devices}/i386-softmmu.mak (100%)
 rename default-configs/{ => devices}/lm32-softmmu.mak (100%)
 rename default-configs/{ => devices}/m68k-linux-user.mak (100%)
 rename default-configs/{ => devices}/m68k-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblaze-linux-user.mak (100%)
 rename default-configs/{ => devices}/microblaze-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblazeel-linux-user.mak (100%)
 rename default-configs/{ => devices}/microblazeel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu-common.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips64-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64el-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips64el-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsel-linux-user.mak (100%)
 rename default-configs/{ => devices}/mipsel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsn32-linux-user.mak (100%)
 rename default-configs/{ => devices}/mipsn32el-linux-user.mak (100%)
 rename default-configs/{ => devices}/moxie-softmmu.mak (100%)
 rename default-configs/{ => devices}/nios2-linux-user.mak (100%)
 rename default-configs/{ => devices}/nios2-softmmu.mak (100%)
 rename default-configs/{ => devices}/or1k-linux-user.mak (100%)
 rename default-configs/{ => devices}/or1k-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64abi32-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc64le-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv32-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv32-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv64-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv64-softmmu.mak (100%)
 rename default-configs/{ => devices}/rx-softmmu.mak (100%)
 rename default-configs/{ => devices}/s390x-linux-user.mak (100%)
 rename default-configs/{ => devices}/s390x-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4-linux-user.mak (100%)
 rename default-configs/{ => devices}/sh4-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4eb-linux-user.mak (100%)
 rename default-configs/{ => devices}/sh4eb-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc-bsd-user.mak (100%)
 rename default-configs/{ => devices}/sparc-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc32plus-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-bsd-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/tilegx-linux-user.mak (100%)
 rename default-configs/{ => devices}/tricore-softmmu.mak (100%)
 rename default-configs/{ => devices}/unicore32-softmmu.mak (100%)
 rename default-configs/{ => devices}/x86_64-bsd-user.mak (100%)
 rename default-configs/{ => devices}/x86_64-linux-user.mak (100%)
 rename default-configs/{ => devices}/x86_64-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensa-linux-user.mak (100%)
 rename default-configs/{ => devices}/xtensa-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-linux-user.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-softmmu.mak (100%)

diff --git a/configure b/configure
index c65d3e06bb..bf55c24557 100755
--- a/configure
+++ b/configure
@@ -1716,13 +1716,13 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$softmmu" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-softmmu.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-softmmu.mak"
 fi
 if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-linux-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-linux-user.mak"
 fi
 if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-bsd-user.mak"
 fi
 
 if test -z "$target_list_exclude" -a -z "$target_list"; then
diff --git a/default-configs/aarch64-linux-user.mak b/default-configs/devices/aarch64-linux-user.mak
similarity index 100%
rename from default-configs/aarch64-linux-user.mak
rename to default-configs/devices/aarch64-linux-user.mak
diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/devices/aarch64-softmmu.mak
similarity index 100%
rename from default-configs/aarch64-softmmu.mak
rename to default-configs/devices/aarch64-softmmu.mak
diff --git a/default-configs/aarch64_be-linux-user.mak b/default-configs/devices/aarch64_be-linux-user.mak
similarity index 100%
rename from default-configs/aarch64_be-linux-user.mak
rename to default-configs/devices/aarch64_be-linux-user.mak
diff --git a/default-configs/alpha-linux-user.mak b/default-configs/devices/alpha-linux-user.mak
similarity index 100%
rename from default-configs/alpha-linux-user.mak
rename to default-configs/devices/alpha-linux-user.mak
diff --git a/default-configs/alpha-softmmu.mak b/default-configs/devices/alpha-softmmu.mak
similarity index 100%
rename from default-configs/alpha-softmmu.mak
rename to default-configs/devices/alpha-softmmu.mak
diff --git a/default-configs/arm-linux-user.mak b/default-configs/devices/arm-linux-user.mak
similarity index 100%
rename from default-configs/arm-linux-user.mak
rename to default-configs/devices/arm-linux-user.mak
diff --git a/default-configs/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
similarity index 100%
rename from default-configs/arm-softmmu.mak
rename to default-configs/devices/arm-softmmu.mak
diff --git a/default-configs/armeb-linux-user.mak b/default-configs/devices/armeb-linux-user.mak
similarity index 100%
rename from default-configs/armeb-linux-user.mak
rename to default-configs/devices/armeb-linux-user.mak
diff --git a/default-configs/avr-softmmu.mak b/default-configs/devices/avr-softmmu.mak
similarity index 100%
rename from default-configs/avr-softmmu.mak
rename to default-configs/devices/avr-softmmu.mak
diff --git a/default-configs/cris-linux-user.mak b/default-configs/devices/cris-linux-user.mak
similarity index 100%
rename from default-configs/cris-linux-user.mak
rename to default-configs/devices/cris-linux-user.mak
diff --git a/default-configs/cris-softmmu.mak b/default-configs/devices/cris-softmmu.mak
similarity index 100%
rename from default-configs/cris-softmmu.mak
rename to default-configs/devices/cris-softmmu.mak
diff --git a/default-configs/hppa-linux-user.mak b/default-configs/devices/hppa-linux-user.mak
similarity index 100%
rename from default-configs/hppa-linux-user.mak
rename to default-configs/devices/hppa-linux-user.mak
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/devices/hppa-softmmu.mak
similarity index 100%
rename from default-configs/hppa-softmmu.mak
rename to default-configs/devices/hppa-softmmu.mak
diff --git a/default-configs/i386-bsd-user.mak b/default-configs/devices/i386-bsd-user.mak
similarity index 100%
rename from default-configs/i386-bsd-user.mak
rename to default-configs/devices/i386-bsd-user.mak
diff --git a/default-configs/i386-linux-user.mak b/default-configs/devices/i386-linux-user.mak
similarity index 100%
rename from default-configs/i386-linux-user.mak
rename to default-configs/devices/i386-linux-user.mak
diff --git a/default-configs/i386-softmmu.mak b/default-configs/devices/i386-softmmu.mak
similarity index 100%
rename from default-configs/i386-softmmu.mak
rename to default-configs/devices/i386-softmmu.mak
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/devices/lm32-softmmu.mak
similarity index 100%
rename from default-configs/lm32-softmmu.mak
rename to default-configs/devices/lm32-softmmu.mak
diff --git a/default-configs/m68k-linux-user.mak b/default-configs/devices/m68k-linux-user.mak
similarity index 100%
rename from default-configs/m68k-linux-user.mak
rename to default-configs/devices/m68k-linux-user.mak
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/devices/m68k-softmmu.mak
similarity index 100%
rename from default-configs/m68k-softmmu.mak
rename to default-configs/devices/m68k-softmmu.mak
diff --git a/default-configs/microblaze-linux-user.mak b/default-configs/devices/microblaze-linux-user.mak
similarity index 100%
rename from default-configs/microblaze-linux-user.mak
rename to default-configs/devices/microblaze-linux-user.mak
diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/devices/microblaze-softmmu.mak
similarity index 100%
rename from default-configs/microblaze-softmmu.mak
rename to default-configs/devices/microblaze-softmmu.mak
diff --git a/default-configs/microblazeel-linux-user.mak b/default-configs/devices/microblazeel-linux-user.mak
similarity index 100%
rename from default-configs/microblazeel-linux-user.mak
rename to default-configs/devices/microblazeel-linux-user.mak
diff --git a/default-configs/microblazeel-softmmu.mak b/default-configs/devices/microblazeel-softmmu.mak
similarity index 100%
rename from default-configs/microblazeel-softmmu.mak
rename to default-configs/devices/microblazeel-softmmu.mak
diff --git a/default-configs/mips-linux-user.mak b/default-configs/devices/mips-linux-user.mak
similarity index 100%
rename from default-configs/mips-linux-user.mak
rename to default-configs/devices/mips-linux-user.mak
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/devices/mips-softmmu-common.mak
similarity index 100%
rename from default-configs/mips-softmmu-common.mak
rename to default-configs/devices/mips-softmmu-common.mak
diff --git a/default-configs/mips-softmmu.mak b/default-configs/devices/mips-softmmu.mak
similarity index 100%
rename from default-configs/mips-softmmu.mak
rename to default-configs/devices/mips-softmmu.mak
diff --git a/default-configs/mips64-linux-user.mak b/default-configs/devices/mips64-linux-user.mak
similarity index 100%
rename from default-configs/mips64-linux-user.mak
rename to default-configs/devices/mips64-linux-user.mak
diff --git a/default-configs/mips64-softmmu.mak b/default-configs/devices/mips64-softmmu.mak
similarity index 100%
rename from default-configs/mips64-softmmu.mak
rename to default-configs/devices/mips64-softmmu.mak
diff --git a/default-configs/mips64el-linux-user.mak b/default-configs/devices/mips64el-linux-user.mak
similarity index 100%
rename from default-configs/mips64el-linux-user.mak
rename to default-configs/devices/mips64el-linux-user.mak
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/devices/mips64el-softmmu.mak
similarity index 100%
rename from default-configs/mips64el-softmmu.mak
rename to default-configs/devices/mips64el-softmmu.mak
diff --git a/default-configs/mipsel-linux-user.mak b/default-configs/devices/mipsel-linux-user.mak
similarity index 100%
rename from default-configs/mipsel-linux-user.mak
rename to default-configs/devices/mipsel-linux-user.mak
diff --git a/default-configs/mipsel-softmmu.mak b/default-configs/devices/mipsel-softmmu.mak
similarity index 100%
rename from default-configs/mipsel-softmmu.mak
rename to default-configs/devices/mipsel-softmmu.mak
diff --git a/default-configs/mipsn32-linux-user.mak b/default-configs/devices/mipsn32-linux-user.mak
similarity index 100%
rename from default-configs/mipsn32-linux-user.mak
rename to default-configs/devices/mipsn32-linux-user.mak
diff --git a/default-configs/mipsn32el-linux-user.mak b/default-configs/devices/mipsn32el-linux-user.mak
similarity index 100%
rename from default-configs/mipsn32el-linux-user.mak
rename to default-configs/devices/mipsn32el-linux-user.mak
diff --git a/default-configs/moxie-softmmu.mak b/default-configs/devices/moxie-softmmu.mak
similarity index 100%
rename from default-configs/moxie-softmmu.mak
rename to default-configs/devices/moxie-softmmu.mak
diff --git a/default-configs/nios2-linux-user.mak b/default-configs/devices/nios2-linux-user.mak
similarity index 100%
rename from default-configs/nios2-linux-user.mak
rename to default-configs/devices/nios2-linux-user.mak
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/devices/nios2-softmmu.mak
similarity index 100%
rename from default-configs/nios2-softmmu.mak
rename to default-configs/devices/nios2-softmmu.mak
diff --git a/default-configs/or1k-linux-user.mak b/default-configs/devices/or1k-linux-user.mak
similarity index 100%
rename from default-configs/or1k-linux-user.mak
rename to default-configs/devices/or1k-linux-user.mak
diff --git a/default-configs/or1k-softmmu.mak b/default-configs/devices/or1k-softmmu.mak
similarity index 100%
rename from default-configs/or1k-softmmu.mak
rename to default-configs/devices/or1k-softmmu.mak
diff --git a/default-configs/ppc-linux-user.mak b/default-configs/devices/ppc-linux-user.mak
similarity index 100%
rename from default-configs/ppc-linux-user.mak
rename to default-configs/devices/ppc-linux-user.mak
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/devices/ppc-softmmu.mak
similarity index 100%
rename from default-configs/ppc-softmmu.mak
rename to default-configs/devices/ppc-softmmu.mak
diff --git a/default-configs/ppc64-linux-user.mak b/default-configs/devices/ppc64-linux-user.mak
similarity index 100%
rename from default-configs/ppc64-linux-user.mak
rename to default-configs/devices/ppc64-linux-user.mak
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/devices/ppc64-softmmu.mak
similarity index 100%
rename from default-configs/ppc64-softmmu.mak
rename to default-configs/devices/ppc64-softmmu.mak
diff --git a/default-configs/ppc64abi32-linux-user.mak b/default-configs/devices/ppc64abi32-linux-user.mak
similarity index 100%
rename from default-configs/ppc64abi32-linux-user.mak
rename to default-configs/devices/ppc64abi32-linux-user.mak
diff --git a/default-configs/ppc64le-linux-user.mak b/default-configs/devices/ppc64le-linux-user.mak
similarity index 100%
rename from default-configs/ppc64le-linux-user.mak
rename to default-configs/devices/ppc64le-linux-user.mak
diff --git a/default-configs/riscv32-linux-user.mak b/default-configs/devices/riscv32-linux-user.mak
similarity index 100%
rename from default-configs/riscv32-linux-user.mak
rename to default-configs/devices/riscv32-linux-user.mak
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/devices/riscv32-softmmu.mak
similarity index 100%
rename from default-configs/riscv32-softmmu.mak
rename to default-configs/devices/riscv32-softmmu.mak
diff --git a/default-configs/riscv64-linux-user.mak b/default-configs/devices/riscv64-linux-user.mak
similarity index 100%
rename from default-configs/riscv64-linux-user.mak
rename to default-configs/devices/riscv64-linux-user.mak
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/devices/riscv64-softmmu.mak
similarity index 100%
rename from default-configs/riscv64-softmmu.mak
rename to default-configs/devices/riscv64-softmmu.mak
diff --git a/default-configs/rx-softmmu.mak b/default-configs/devices/rx-softmmu.mak
similarity index 100%
rename from default-configs/rx-softmmu.mak
rename to default-configs/devices/rx-softmmu.mak
diff --git a/default-configs/s390x-linux-user.mak b/default-configs/devices/s390x-linux-user.mak
similarity index 100%
rename from default-configs/s390x-linux-user.mak
rename to default-configs/devices/s390x-linux-user.mak
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/devices/s390x-softmmu.mak
similarity index 100%
rename from default-configs/s390x-softmmu.mak
rename to default-configs/devices/s390x-softmmu.mak
diff --git a/default-configs/sh4-linux-user.mak b/default-configs/devices/sh4-linux-user.mak
similarity index 100%
rename from default-configs/sh4-linux-user.mak
rename to default-configs/devices/sh4-linux-user.mak
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/devices/sh4-softmmu.mak
similarity index 100%
rename from default-configs/sh4-softmmu.mak
rename to default-configs/devices/sh4-softmmu.mak
diff --git a/default-configs/sh4eb-linux-user.mak b/default-configs/devices/sh4eb-linux-user.mak
similarity index 100%
rename from default-configs/sh4eb-linux-user.mak
rename to default-configs/devices/sh4eb-linux-user.mak
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/devices/sh4eb-softmmu.mak
similarity index 100%
rename from default-configs/sh4eb-softmmu.mak
rename to default-configs/devices/sh4eb-softmmu.mak
diff --git a/default-configs/sparc-bsd-user.mak b/default-configs/devices/sparc-bsd-user.mak
similarity index 100%
rename from default-configs/sparc-bsd-user.mak
rename to default-configs/devices/sparc-bsd-user.mak
diff --git a/default-configs/sparc-linux-user.mak b/default-configs/devices/sparc-linux-user.mak
similarity index 100%
rename from default-configs/sparc-linux-user.mak
rename to default-configs/devices/sparc-linux-user.mak
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/devices/sparc-softmmu.mak
similarity index 100%
rename from default-configs/sparc-softmmu.mak
rename to default-configs/devices/sparc-softmmu.mak
diff --git a/default-configs/sparc32plus-linux-user.mak b/default-configs/devices/sparc32plus-linux-user.mak
similarity index 100%
rename from default-configs/sparc32plus-linux-user.mak
rename to default-configs/devices/sparc32plus-linux-user.mak
diff --git a/default-configs/sparc64-bsd-user.mak b/default-configs/devices/sparc64-bsd-user.mak
similarity index 100%
rename from default-configs/sparc64-bsd-user.mak
rename to default-configs/devices/sparc64-bsd-user.mak
diff --git a/default-configs/sparc64-linux-user.mak b/default-configs/devices/sparc64-linux-user.mak
similarity index 100%
rename from default-configs/sparc64-linux-user.mak
rename to default-configs/devices/sparc64-linux-user.mak
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/devices/sparc64-softmmu.mak
similarity index 100%
rename from default-configs/sparc64-softmmu.mak
rename to default-configs/devices/sparc64-softmmu.mak
diff --git a/default-configs/tilegx-linux-user.mak b/default-configs/devices/tilegx-linux-user.mak
similarity index 100%
rename from default-configs/tilegx-linux-user.mak
rename to default-configs/devices/tilegx-linux-user.mak
diff --git a/default-configs/tricore-softmmu.mak b/default-configs/devices/tricore-softmmu.mak
similarity index 100%
rename from default-configs/tricore-softmmu.mak
rename to default-configs/devices/tricore-softmmu.mak
diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/devices/unicore32-softmmu.mak
similarity index 100%
rename from default-configs/unicore32-softmmu.mak
rename to default-configs/devices/unicore32-softmmu.mak
diff --git a/default-configs/x86_64-bsd-user.mak b/default-configs/devices/x86_64-bsd-user.mak
similarity index 100%
rename from default-configs/x86_64-bsd-user.mak
rename to default-configs/devices/x86_64-bsd-user.mak
diff --git a/default-configs/x86_64-linux-user.mak b/default-configs/devices/x86_64-linux-user.mak
similarity index 100%
rename from default-configs/x86_64-linux-user.mak
rename to default-configs/devices/x86_64-linux-user.mak
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/devices/x86_64-softmmu.mak
similarity index 100%
rename from default-configs/x86_64-softmmu.mak
rename to default-configs/devices/x86_64-softmmu.mak
diff --git a/default-configs/xtensa-linux-user.mak b/default-configs/devices/xtensa-linux-user.mak
similarity index 100%
rename from default-configs/xtensa-linux-user.mak
rename to default-configs/devices/xtensa-linux-user.mak
diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/devices/xtensa-softmmu.mak
similarity index 100%
rename from default-configs/xtensa-softmmu.mak
rename to default-configs/devices/xtensa-softmmu.mak
diff --git a/default-configs/xtensaeb-linux-user.mak b/default-configs/devices/xtensaeb-linux-user.mak
similarity index 100%
rename from default-configs/xtensaeb-linux-user.mak
rename to default-configs/devices/xtensaeb-linux-user.mak
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/devices/xtensaeb-softmmu.mak
similarity index 100%
rename from default-configs/xtensaeb-softmmu.mak
rename to default-configs/devices/xtensaeb-softmmu.mak
diff --git a/meson.build b/meson.build
index 4d6ef64adf..a12ad1fbff 100644
--- a/meson.build
+++ b/meson.build
@@ -699,7 +699,7 @@ foreach target : target_dirs
 
     config_devices_mak = target + '-config-devices.mak'
     config_devices_mak = configure_file(
-      input: ['default-configs' / target + '.mak', 'Kconfig'],
+      input: ['default-configs/devices' / target + '.mak', 'Kconfig'],
       output: config_devices_mak,
       depfile: config_devices_mak + '.d',
       capture: true,
-- 
2.26.2



