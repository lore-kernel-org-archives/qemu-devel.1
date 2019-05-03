Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7609C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4682081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4682081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWLB-00070U-T7
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:26:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE7-0008Ew-1W
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE5-0001Mi-Qq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWE5-0001LU-I0; Fri, 03 May 2019 07:19:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MpTpc-1gxLwI16Zo-00pvpR; Fri, 03 May 2019 13:19:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:18:24 +0200
Message-Id: <20190503111832.30316-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
References: <20190503111832.30316-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kQidRAwX+nEUtN5LjRA4H/Hdt+9usEawtxJdIRgViv3F0CKj1JB
	vinfpS7A4P8c5DOIBbh+rV8G2cTP4J74P20+DzcLmOB09QcB39PBFKzO4vtTkuGGiEEznVD
	kgwVQnJwZfy1/U8W7xam9XP/RvRyE6zUYql1VkT9wcxG9F5GsTd3iELYSCkx++Dcddq37uD
	gdDfGFOw64p6he8fssirg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X9nH/tQuPGs=:C1LL8LnFT8MkNILgqiwUXN
	W7DNYRebgYdCDJtGQS11r5vOSdk3sukkOiuDcKuCBV213lZPuqWUDxP5n0oGO849Zq5QwlbD5
	rtxUzxCznqARyLegKq3TBP6s1CZm3kMGNCJhpJr9hGh2rpsMUgWAjoq2LcHUCLckqTY1XvhEN
	I9TDg7L7XiWAVWuIl5SxLSn2k2DNIUWyZL/tHgBsP3rDPeWpTVm6XMiycgSFvoo11bhlwsDi3
	9/tiCYtWD/yHAxPOMxzKfE6ngOz0sJaSffd2UWw2i/jTu4i+A7d2HvTKdd1f95nA0gPGE2JWl
	mgTNk0HR49U/PSQHVqnq2JYhdrMSwkPz8oxAj46qeyZJwHy5P7E6sfOZF64670L5UPRA23Bs9
	jdjsy5QpI3fffl7DifYYr+AhyCwBpSVqwVr/Ev2rZIWhlDTDiuEhH7f6b98FspJP2JFPT0Pn/
	8AOcBSaoN9IBRbv4bu+fIA/ZWr350VUOf3ZoHiERadZ0CnRpR6rTCFJ18N+DLpFKFM69v5tDd
	2U0ADVjXNXvCakCS6hXrgp1/SNcINwyC/d3jMt46l8LaXeLELsRy9EDXnuyQ/itcf3x2rdQir
	cqUgcnE+LPZFodISnNpGlbx554adys6RUUTIak96vR+NMmtVfjXwp0SqeomIVCH7cVyig57xn
	ZjArBDwEfQM7NWRwFByIjvmugW+AMyoP4FhA+LAYVR9ZCyntxSwHqa7kC2w8LeDqbMXa5IZ1Z
	Gp8Ni2XjGbscEBW72U5r3o+77CxVkMkMam5q9HTbnWzILsCpVx+kw2jiask=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 04/12] doc: fix the configuration path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111824.eyoR_wAIf1oSih_LD9RBkOhXHqwzWaZZLMzwRlZ8meI@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use a CONFDIR variable to show the configured sysconf path in the
generated documentations (html, man pages etc).

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=1644985

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181126105125.30973-1-marcandre.lureau@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-ga.texi | 4 ++--
 Makefile     | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/qemu-ga.texi b/qemu-ga.texi
index 4c7a8fd16329..f00ad830f283 100644
--- a/qemu-ga.texi
+++ b/qemu-ga.texi
@@ -30,7 +30,7 @@ set user's password
 @end itemize
 
 qemu-ga will read a system configuration file on startup (located at
-@file{/etc/qemu/qemu-ga.conf} by default), then parse remaining
+@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
 configuration options on the command line. For the same key, the last
 option wins, but the lists accumulate (see below for configuration
 file format).
@@ -58,7 +58,7 @@ file format).
   Enable fsfreeze hook. Accepts an optional argument that specifies
   script to run on freeze/thaw. Script will be called with
   'freeze'/'thaw' arguments accordingly (default is
-  @samp{/etc/qemu/fsfreeze-hook}). If using -F with an argument, do
+  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
   not follow -F with a space (for example:
   @samp{-F/var/run/fsfreezehook.sh}).
 
diff --git a/Makefile b/Makefile
index 1211e78c91ed..43a7a047b452 100644
--- a/Makefile
+++ b/Makefile
@@ -899,11 +899,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
 MAKEINFO=makeinfo
 MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
 MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) "-DVERSION=$(VERSION)"
+TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
 TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
 
-docs/version.texi: $(SRC_PATH)/VERSION
-	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
+docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
+	$(call quiet-command,(\
+		echo "@set VERSION $(VERSION)" && \
+		echo "@set CONFDIR $(qemu_confdir)" \
+	)> $@,"GEN","$@")
 
 %.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-- 
2.20.1


