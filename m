Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70001C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379BA20789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb8+JRaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379BA20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gQB-00042U-Fl
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGg-0003WH-Cz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGe-00063J-RN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p20so15282098wrf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v1AguchhlgmoLPXUlF2TKI6VdFVr+arnC+mhG7/d0Ac=;
 b=Jb8+JRaGdLvthom2BJLr2o2bNmokGtmKSPmLPW9xiVq6uh6X25gDccPpYleJrDxyyj
 UEZna2ynDW5WhwmTcHs0jUE1fdt5Nj07NyIHolAIIC8R/dPa53bFrU0aosx4QkfzjpyG
 +ai+DxOGX9yelvpy9WHvsT1WuGWg5z3TSV4Xd9afgfdOwIVvTvtdlveZW97uKzwkyzTq
 X995OSx0Qu2hC13gmekRAyr2Zr84rH7m1EydbTwnFXFauLM4f2Pqll1e9npZD/XUSig4
 nnWmIAyRWHbGlVUGL7jKesYspeL/lL8wGV+BAobNOPg4J6ninyKrzw+iAt1Cu1JD3gop
 4y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v1AguchhlgmoLPXUlF2TKI6VdFVr+arnC+mhG7/d0Ac=;
 b=mr3wOreMkwygdNGTnVe56Z0xL4xivh2hH+qopqLntZ9zQD68Hn6peO6bEDjS044Q9h
 3nmGhiXTEjClXi22ZSM9NnX0wzMYWsvDAvHoq1kaL6E9qIXL4EezkKj0wWjEDkdgsklE
 CDGp7xd02uBqmLvLGoDCaSWzdE+qjZBiyRefUiRPUe2uP7UopUD73DctyHLKMCqeJG4B
 W5xYWyoWkHTtGUOkAh2VLInCqUXjnn89SCAJiOJ23Z2XLI6C28M7er5ZDM6feV7Cwxr1
 sdRGTUYPPmwpJ9I6ugwAuXiHsQtQW+JQ/ZXsgh3K4BcuSvbxRZKo08L4FH48MB4fcvTz
 wChA==
X-Gm-Message-State: AOAM532KxS26krQ2a1GAKKnpWVj9Ke9k4/3hkdKz3l4dvVo3Qh/J2FFz
 iUWl58LtaZxh6du7NhPhHvxUuGNYFC0=
X-Google-Smtp-Source: ABdhPJwrFUh5hV+S/fiKU4I+CKicW3beEM8xbtuNaxv7uhXMHDyydxSuqoP7x9KkpOyl4jJhm1XtNg==
X-Received: by 2002:adf:b353:: with SMTP id k19mr15503324wrd.159.1597675063261; 
 Mon, 17 Aug 2020 07:37:43 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 016/150] configure: generate Meson cross file
Date: Mon, 17 Aug 2020 16:35:09 +0200
Message-Id: <20200817143723.343284-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 68 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index f99baba99e..994e9844aa 100755
--- a/configure
+++ b/configure
@@ -8580,21 +8580,71 @@ echo "# Automatically generated by configure - do not modify" > "$iotests_common
 echo >> "$iotests_common_env"
 echo "export PYTHON='$python'" >> "$iotests_common_env"
 
+cross="config-meson.cross"
+cross_arg=
+
+if test -n "$cross_prefix"; then
+    echo "# Automatically generated by configure - do not modify" > $cross
+    echo "[binaries]" >> $cross
+    echo "c = '$cc'" >> $cross
+    echo "cpp = '$cxx'" >> $cross
+    echo "ar = '$ar'" >> $cross
+    echo "nm = '$nm'" >> $cross
+    echo "pkgconfig = '$pkg_config_exe'" >> $cross
+    echo "ranlib = '$ranlib'" >> $cross
+    echo "strip = '$strip'" >> $cross
+    echo "windres = '$windres'" >> $cross
+
+    echo "[host_machine]" >> $cross
+
+    # Hack: Meson expects an absolute path for the *build* machine
+    # for the prefix, so add a slash in front of a Windows path that
+    # includes a drive letter.
+    #
+    # See https://github.com/mesonbuild/meson/issues/7577.
+    if test "$mingw32" = "yes" ; then
+        echo "system = 'windows'" >> $cross
+        case $prefix in
+            ?:*) pre_prefix=/ ;;
+        esac
+    fi
+    case "$ARCH" in
+        i386|x86_64)
+            echo "cpu_family = 'x86'" >> $cross
+            ;;
+        ppc64le)
+            echo "cpu_family = 'ppc64'" >> $cross
+            ;;
+        *)
+            echo "cpu_family = '$ARCH'" >> $cross
+            ;;
+    esac
+    echo "cpu = '$cpu'" >> $cross
+    if test "$bigendian" = "yes" ; then
+        echo "endian = 'big'" >> $cross
+    else
+        echo "endian = 'little'" >> $cross
+    fi
+
+    cross_arg="--cross-file=$cross"
+fi
+
 rm -rf meson-private/ meson-logs/ meson-info/
 NINJA=$PWD/ninjatool $meson setup \
-        --prefix "$prefix" \
-        --libdir "$libdir" \
-        --libexecdir "$libexecdir" \
-        --bindir "$bindir" \
-        --includedir "$includedir" \
-        --datadir "$datadir" \
-        --mandir "$mandir" \
-        --sysconfdir "$sysconfdir" \
-        --localstatedir "$local_statedir" \
+        --prefix "${pre_prefix}$prefix" \
+        --libdir "${pre_prefix}$libdir" \
+        --libexecdir "${pre_prefix}$libexecdir" \
+        --bindir "${pre_prefix}$bindir" \
+        --includedir "${pre_prefix}$includedir" \
+        --datadir "${pre_prefix}$datadir" \
+        --mandir "${pre_prefix}$mandir" \
+        --sysconfdir "${pre_prefix}$sysconfdir" \
+        --localstatedir "${pre_prefix}$local_statedir" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
+        $cross_arg \
         "$PWD" "$source_path"
 
 if test "$?" -ne 0 ; then
-- 
2.26.2



