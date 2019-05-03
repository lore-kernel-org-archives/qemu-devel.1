Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1922075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1922075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWNd-0000jA-4J
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:29:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEv-0000Vc-6E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEt-0002JA-Rr
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEr-0002FS-8H; Fri, 03 May 2019 07:20:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M42b8-1hMWEd42PA-0007cI; Fri, 03 May 2019 13:20:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:50 +0200
Message-Id: <20190503111958.30825-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0z/K3wjAdqIK5oWiNca7+Fj70jexOIzVi0yIWQsEPFFIvbBx7xV
	+TYQ7Uu6yk81BL12vuMS4CmpXoEsU4gK/nSkjjWB9ojbdwg/p+tFJaVWCZ4x2+m/NY8eAVg
	7D9HAVJombX08pAayR+mnMk+8bfxgB/l7O7OhbH9Y1ry2B/11+UV5Ng1gAmpySjNHC8r9VF
	laQS/mFYCMbMassaqLlyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mu24ZYJjzy0=:LoByJxiSy4M1VYp2f9joZk
	eZaOcLxQR+00eVw5TIKKXO3GjEtHnLf0abe+hy7VqvRIvQl1PjhO8EfkILTiFJgtRq4UIGmz1
	1e9M/q1URWkt/muEKEPYPiHaRFqTwiNE9RNADQQq7osjOo2twKEg0FyWeaXZIlSDZYnP7gvSv
	osWJaiuyD6OdtZ4CVqp4Cgq8l7x34/NOVCaj7fA/KZWCdK51Jtcg9mfxPNtkaR8aKXLldCkhS
	MJRvQ/vkpbAQ/h5j2LkHG4j0zrwfPbcYviEC4ekJ9FWxZy+4uoc20/yOr9Q3HSlp3t0SAvDV5
	ySjCIdhDn4x1n8Vw/8+3CYjwkctANnR7O0bMStxDRhYmN+j6Jjey4UNAt/cPABzDffdCgd2ep
	tV+nL6Gxtzc9xjFwAkUdLvoc/shAbseB74RVwB7fnxD8k0bol93ILylfAEw5JFBLkt2+AaaJs
	gEfkHWAA/zo9l7evXjgK363NdkX/K+a9dK9GT1oWdWHljAlxMKHovx0mT4dHLv2A0cT0scTji
	ljiGH2oVPSRlVTjHiM3Qu5XzUwBOZ6LKK1Z0e6T4hqr/J1rkvSBmoTbiLLmEIyTuvBECU5x4B
	5PaNrARFWhcpzXyXCbIkB46LBTnCDd91XRIuEPsxdJWdkeNmyoE+ZUi7HMnR5mQOIEx1IIxXf
	UegS7VIU8w4ogeV4l4v9t1+UQuqqzgQFi9UyC6SuJbvZtOOEUJ+Lge+qqJuC1a4NdkSfsIXxA
	DrqhOh1df7SxOkAr2Dz3C0eQ35pjLpAmszHGuG2CYpdI+wA1L/UI+Wff+GQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Message-ID: <20190503111950.cmg6XDUzQozy1NMfBmJ_hsBuVqP2oITAXWeBrB-O5TQ@z>

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


