Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D0C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3032173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqlyUQ1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho60f-0003Sy-Mb
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho60T-0002ya-6b
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho60R-0008Of-S8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:59:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho60R-0008OB-LJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:59:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so25503539wmj.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyoFO1RlKJhdoAKsNHGdbd1/3rVaZK+AHTqU2IwHJqU=;
 b=XqlyUQ1ib5opKjytg8AA5cVa1pCmD4UYNw8UOcfTQuisuAAjGQCOrOyeMtwvOdTSki
 xtD+XW6mdU33sLRVJssk1A/dh0XqL4w975WymYlI8XDVSYK4FDfCeErRGACrbvGiJf8R
 XATn2/YZJ29DckArQaVSpEm9DhfNkfsM9j062VKZAJm5QzjW/8iMzwA7T8imYFB7ELFx
 u7EG9+3MO4MIQLoSbjrgdSxTd/GmZThYE6FDtFYrFH/kaG1V0qR9kZtTN6R0WOp6LgYI
 aCkR+gwbRO4gp4HRyddCKjC2r2iPd8fFo35QVkMM2IkG1iGVEtWHLGxI0WVQq0lgJ5KM
 AIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyoFO1RlKJhdoAKsNHGdbd1/3rVaZK+AHTqU2IwHJqU=;
 b=R4BQOmexjZE/WhgPCWhjZ6pyULG1vSujfWsPXlYGkap3O2tLj0BNpEbuULhwTIJ584
 r0cA48CCQexwGhZ88lr38qt9G73INn6lNIGH7Xi+OKYxSKkkegGtCApjxztLa1QUKo8Q
 QdcXhB1s6MWRA7TcUrurFc0LiwZ5rv/tyujTVWJkAKrLQRY6opi3YEL4rOojE8UalEXl
 fNBG4XOqYCmMcotadii9xHG7EdS2ZU5EZVTffGkL5sO2cU9EV12zh4/NReNOqkdO66Ri
 6DV/4LHjrQk8WCufOnc7wMqr3FtB+Ybimd+JHauShClgV+O9g7INx+SpqomwZV+3LdbF
 lgEw==
X-Gm-Message-State: APjAAAVurxY4Lk0twVeO56dUvGEgKYvdjFiD8YP85lOpGg2f21lC+TSZ
 mVd8A+23ccvdSC2QzvzIUKOU0w==
X-Google-Smtp-Source: APXvYqx/Wtku8ad9iXWdPJ1Luln+/0XKpr0pXSY6Qpt6pyazyOU7kP5fL5qQTMQea/huGBsdF0nbYg==
X-Received: by 2002:a1c:6882:: with SMTP id d124mr41531689wmc.40.1563454770381; 
 Thu, 18 Jul 2019 05:59:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t63sm21622182wmt.6.2019.07.18.05.59.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 05:59:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 13:59:28 +0100
Message-Id: <20190718125928.20147-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH for-4.1] target/arm: Limit ID register
 assertions to TCG
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_cpu_realizefn() we make several assertions about the values of
guest ID registers:
 * if the CPU provides AArch32 v7VE or better it must advertise the
   ARM_DIV feature
 * if the CPU provides AArch32 A-profile v6 or better it must
   advertise the Jazelle feature

These are essentially consistency checks that our ID register
specifications in cpu.c didn't accidentally miss out a feature,
because increasingly the TCG emulation gates features on the values
in ID registers rather than using old-style checks of ARM_FEATURE_FOO
bits.

Unfortunately, these asserts can cause problems if we're running KVM,
because in that case we don't control the values of the ID registers
-- we read them from the host kernel.  In particular, if the host
kernel is older than 4.15 then it doesn't expose the ID registers via
the KVM_GET_ONE_REG ioctl, and we set up dummy values for some
registers and leave the rest at zero.  (See the comment in
target/arm/kvm64.c kvm_arm_get_host_cpu_features().) This set of
dummy values is not sufficient to pass our assertions, and so on
those kernels running an AArch32 guest on AArch64 will assert.

We could provide a more sophisticated set of dummy ID registers in
this case, but that still leaves the possibility of a host CPU which
reports bogus ID register values that would cause us to assert.  It's
more robust to only do these ID register checks if we're using TCG,
as that is the only case where this is truly a QEMU code bug.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1830864
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Laszlo, would you mind testing this on your setup? I don't have
a system with an old enough kernel to trigger the assert. (The
change is pretty much a "has to work" one though :-))

 target/arm/cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1959467fdc8..9eb40ff755f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1369,6 +1369,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * There exist AArch64 cpus without AArch32 support.  When KVM
      * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
      * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
+     * As a general principle, we also do not make ID register
+     * consistency checks anywhere unless using TCG, because only
+     * for TCG would a consistency-check failure be a QEMU bug.
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
@@ -1383,7 +1386,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
+        assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(arm_div, cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -1409,7 +1412,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
         if (!arm_feature(env, ARM_FEATURE_M)) {
-            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
+            assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(jazelle, cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
-- 
2.20.1


