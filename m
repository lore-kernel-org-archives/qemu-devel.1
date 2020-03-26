Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FAC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA132206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IjG+/9Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA132206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSo4-00077l-To
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1jHSnK-0006Ep-9L
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1jHSnJ-0002fj-1f
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:43:38 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:44959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1jHSnI-0002ee-NW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585230217;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dLmyqyhGeopiywpiXKWNNgDa9zmcQBLA4yhnWSTaxCY=;
 b=IjG+/9PiBMbdrRi2vBFDfMRmswVSXnr2Q+mHglBCM2cHUNiBQvwzZa+T
 yyQxwXT3BFAG18939UEFh06EzAaOP7nEp/3jLnRDed5KE5yVbi6L4mAwv
 vWfpuW0mciK3CFKahpVkSLjGY66NpSGSLkZsiPbjjWYrC0D0IhzogQ1Kb w=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: bRVLWcKMW78I3KXDW5GDWpI+oOgJx89dUf2WEmRQ6KC5+vyCIqbHEzNJpg4LshFRDOnomy8U78
 dD2go9bU5omzasWAD/Bkd2HjMryOGYaBWrHFHRiJRuy5Qd4PvnbnA5evEs8/gA89l4MfiSYMlP
 Ht2olHspNvgu5jRnInGytVemTCKI88eKI6xYdUPsWjhLzCI3/HiziZH+f1GULyaCYNa9rCB0h4
 MIz/nciYmen4itmKcLKejIkrf75wCz2Ih/MQiR06z2dj8BSrNg/6iDOOciTsX95ZCA9OQtOcSb
 qPw=
X-SBRS: 2.7
X-MesageID: 14692363
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,308,1580792400"; d="scan'208";a="14692363"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] qemu-user: fix build with LLVM lld 10
Date: Thu, 26 Mar 2020 14:43:16 +0100
Message-ID: <20200326134316.36059-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.153
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roger Pau Monne <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lld 10.0.0 introduced a new linker option --image-base equivalent to
the GNU -Ttext-segment one, hence use it when available.

This fixes the build of QEMU on systems using lld 10 or greater.

Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
---
 configure | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index da09c35895..92d57d84fa 100755
--- a/configure
+++ b/configure
@@ -6514,27 +6514,31 @@ if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
     cat > $TMPC <<EOF
     int main(void) { return 0; }
 EOF
-    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
+    # Test with image-base first, which appeared in lld 10.0.0
+    textseg_ldflags="-Wl,--image-base=$textseg_addr"
     if ! compile_prog "" "$textseg_ldflags"; then
-      # In case ld does not support -Ttext-segment, edit the default linker
-      # script via sed to set the .text start addr.  This is needed on FreeBSD
-      # at least.
-      if ! $ld --verbose >/dev/null 2>&1; then
-        error_exit \
-            "We need to link the QEMU user mode binaries at a" \
-            "specific text address. Unfortunately your linker" \
-            "doesn't support either the -Ttext-segment option or" \
-            "printing the default linker script with --verbose." \
-            "If you don't want the user mode binaries, pass the" \
-            "--disable-user option to configure."
-      fi
+      textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
+      if ! compile_prog "" "$textseg_ldflags"; then
+        # In case ld does not support -Ttext-segment, edit the default linker
+        # script via sed to set the .text start addr.  This is needed on FreeBSD
+        # at least.
+        if ! $ld --verbose >/dev/null 2>&1; then
+          error_exit \
+              "We need to link the QEMU user mode binaries at a" \
+              "specific text address. Unfortunately your linker" \
+              "doesn't support either the --image-base or -Ttext-segment" \
+              "options or printing the default linker script with" \
+              "--verbose. If you don't want the user mode binaries," \
+              "pass the --disable-user option to configure."
+        fi
 
-      $ld --verbose | sed \
-        -e '1,/==================================================/d' \
-        -e '/==================================================/,$d' \
-        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
-        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
-      textseg_ldflags="-Wl,-T../config-host.ld"
+        $ld --verbose | sed \
+          -e '1,/==================================================/d' \
+          -e '/==================================================/,$d' \
+          -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
+          -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
+        textseg_ldflags="-Wl,-T../config-host.ld"
+      fi
     fi
   fi
 fi
-- 
2.26.0


