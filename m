Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D901C31E53
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CE420673
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CE420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcAvC-0006R2-6x
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqh-0003fB-BO
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqf-00089v-CC
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqZ-0007jK-HS; Sat, 15 Jun 2019 11:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C532307D913;
 Sat, 15 Jun 2019 15:44:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BEE91001B05;
 Sat, 15 Jun 2019 15:43:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:31 +0200
Message-Id: <20190615154352.26824-3-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sat, 15 Jun 2019 15:44:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/23] target/arm: Makefile cleanup (ARM)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Group ARM objects together, TCG related ones at the bottom.
This will help when restricting TCG-only objects.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 7c31fa01c1..3269dda613 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -4,11 +4,9 @@ obj-$(CONFIG_KVM) +=3D kvm.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
-obj-y +=3D translate.o op_helper.o helper.o cpu.o
-obj-y +=3D neon_helper.o iwmmxt_helper.o vec_helper.o vfp_helper.o
+obj-y +=3D helper.o cpu.o
 obj-y +=3D gdbstub.o
 obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
-obj-y +=3D crypto_helper.o
 obj-$(CONFIG_SOFTMMU) +=3D arm-powerctl.o
=20
 DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
@@ -32,6 +30,11 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.=
c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
=20
+obj-y +=3D translate.o op_helper.o
+obj-y +=3D crypto_helper.o
+obj-y +=3D iwmmxt_helper.o vec_helper.o
+obj-y +=3D neon_helper.o vfp_helper.o
+
 obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) +=3D pauth_helper.o
--=20
2.20.1


