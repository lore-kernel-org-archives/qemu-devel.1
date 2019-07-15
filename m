Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBCC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6612067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6612067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2ow-0007Go-Dw
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn2oY-0005p9-FO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn2oX-0001OA-7o
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn2oU-0001Mo-PP; Mon, 15 Jul 2019 11:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE909811A9;
 Mon, 15 Jul 2019 15:22:49 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA52C6085B;
 Mon, 15 Jul 2019 15:22:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 17:22:22 +0200
Message-Id: <20190715152225.26135-3-philmd@redhat.com>
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
References: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 15 Jul 2019 15:22:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1? v2 2/5] target/mips: Always enable
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

The semihosting feature is always required on user-space.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-linux-user-common.mak | 4 ++++
 default-configs/mips-linux-user.mak        | 2 ++
 default-configs/mips64-linux-user.mak      | 2 ++
 default-configs/mips64el-linux-user.mak    | 2 ++
 default-configs/mipsel-linux-user.mak      | 2 ++
 default-configs/mipsn32-linux-user.mak     | 2 ++
 default-configs/mipsn32el-linux-user.mak   | 2 ++
 7 files changed, 16 insertions(+)
 create mode 100644 default-configs/mips-linux-user-common.mak

diff --git a/default-configs/mips-linux-user-common.mak b/default-configs=
/mips-linux-user-common.mak
new file mode 100644
index 0000000000..04947706e8
--- /dev/null
+++ b/default-configs/mips-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common mips*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/mips-linux-user.mak b/default-configs/mips-l=
inux-user.mak
index 31df57021e..c606e12444 100644
--- a/default-configs/mips-linux-user.mak
+++ b/default-configs/mips-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mips64-linux-user.mak b/default-configs/mips=
64-linux-user.mak
index 1598bfcf7d..81e16ac2eb 100644
--- a/default-configs/mips64-linux-user.mak
+++ b/default-configs/mips64-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips64-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mips64el-linux-user.mak b/default-configs/mi=
ps64el-linux-user.mak
index 629f084086..6399af3fd5 100644
--- a/default-configs/mips64el-linux-user.mak
+++ b/default-configs/mips64el-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips64el-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsel-linux-user.mak b/default-configs/mips=
el-linux-user.mak
index 4d0e4afb69..4a27d30b45 100644
--- a/default-configs/mipsel-linux-user.mak
+++ b/default-configs/mipsel-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsel-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsn32-linux-user.mak b/default-configs/mip=
sn32-linux-user.mak
index 5b97919794..f3ac967463 100644
--- a/default-configs/mipsn32-linux-user.mak
+++ b/default-configs/mipsn32-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsn32-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsn32el-linux-user.mak b/default-configs/m=
ipsn32el-linux-user.mak
index d6367ff987..63fe4de4fd 100644
--- a/default-configs/mipsn32el-linux-user.mak
+++ b/default-configs/mipsn32el-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsn32el-linux-user
+
+include mips-linux-user-common.mak
--=20
2.20.1


