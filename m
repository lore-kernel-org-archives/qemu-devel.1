Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1312067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1312067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2oi-0006GG-QF
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn2oP-0005Al-ID
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn2oO-0001Jy-CT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn2oL-0001IM-UL; Mon, 15 Jul 2019 11:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C242308FED5;
 Mon, 15 Jul 2019 15:22:41 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68C086085B;
 Mon, 15 Jul 2019 15:22:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 17:22:21 +0200
Message-Id: <20190715152225.26135-2-philmd@redhat.com>
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
References: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 15:22:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1? v2 1/5] target/arm: Always enable
 CONFIG_SEMIHOSTING
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, James Hogan <james.hogan@mips.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The semihosting feature is always required on user-space, and
is also used by system emulation.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/aarch64-linux-user-common.mak | 4 ++++
 default-configs/aarch64-linux-user.mak        | 2 ++
 default-configs/aarch64_be-linux-user.mak     | 2 ++
 default-configs/arm-linux-user-common.mak     | 4 ++++
 default-configs/arm-linux-user.mak            | 2 ++
 default-configs/arm-softmmu.mak               | 4 +++-
 default-configs/armeb-linux-user.mak          | 2 ++
 7 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/aarch64-linux-user-common.mak
 create mode 100644 default-configs/arm-linux-user-common.mak

diff --git a/default-configs/aarch64-linux-user-common.mak b/default-conf=
igs/aarch64-linux-user-common.mak
new file mode 100644
index 0000000000..94c0cdf826
--- /dev/null
+++ b/default-configs/aarch64-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common aarch64*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/aarch64-linux-user.mak b/default-configs/aar=
ch64-linux-user.mak
index 0a5b08a007..d27232cbc6 100644
--- a/default-configs/aarch64-linux-user.mak
+++ b/default-configs/aarch64-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for aarch64-linux-user
+
+include aarch64-linux-user-common.mak
diff --git a/default-configs/aarch64_be-linux-user.mak b/default-configs/=
aarch64_be-linux-user.mak
index a69d9d2e41..7dee7ba4cb 100644
--- a/default-configs/aarch64_be-linux-user.mak
+++ b/default-configs/aarch64_be-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for aarch64_be-linux-user
+
+include aarch64-linux-user-common.mak
diff --git a/default-configs/arm-linux-user-common.mak b/default-configs/=
arm-linux-user-common.mak
new file mode 100644
index 0000000000..67acd961f3
--- /dev/null
+++ b/default-configs/arm-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common arm*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/arm-linux-user.mak b/default-configs/arm-lin=
ux-user.mak
index 413361a022..7d45e4d20a 100644
--- a/default-configs/arm-linux-user.mak
+++ b/default-configs/arm-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for arm-linux-user
+
+include arm-linux-user-common.mak
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 1f2e0e7fde..ad2debf543 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,5 +1,8 @@
 # Default configuration for arm-softmmu
=20
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
+
 # TODO: ARM_V7M is currently always required - make this more flexible!
 CONFIG_ARM_V7M=3Dy
=20
@@ -39,4 +42,3 @@ CONFIG_MICROBIT=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
-CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/armeb-linux-user.mak b/default-configs/armeb=
-linux-user.mak
index bf2ffe7038..485132f606 100644
--- a/default-configs/armeb-linux-user.mak
+++ b/default-configs/armeb-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for armeb-linux-user
+
+include arm-linux-user-common.mak
--=20
2.20.1


