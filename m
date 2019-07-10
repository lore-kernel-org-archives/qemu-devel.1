Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E2C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 22:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E7921019
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 22:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ8RsSwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlLVU-0002vh-Rl
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 18:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <carenas@gmail.com>) id 1hlLUz-0002Wb-TG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <carenas@gmail.com>) id 1hlLUy-0007dN-T8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:55:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <carenas@gmail.com>) id 1hlLUy-0007af-Hf
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:55:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id q4so1926269pgj.8
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XsdYnm6RUPndCLZ2LXhRueT5fjAxexwVldjB/35j73Q=;
 b=TJ8RsSwhqBAMDxSJ7gnfgPigs7Nl7bPsJUr0v7PQgg/gHDdZqePO/Df6wk5KctnpsF
 aD+nyngDWk8ZCrQ8EVLMpmMX/+F3j97AkSv0FeDf2ObpF1N+jmk0VRucUVendJ/XgnCO
 mPVXLItwb1zxDT67nu2K857HoCuCfEBMTShMDSzx9iQ4VJIA8C5VOmrwwEFnlQhi3G7b
 GxuvAQq30CikKzvLkoHS9LHtCKcpTILvpbsq4D6kt+pZbt/OYJ2qg8gXSm1L9b+dZS2e
 EMce5GEd6oKArqIDADGioFbverabSrtq2ogg+YQ+VdbRTM4MsTgH9VIO0gFWhLQOpFnU
 +FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XsdYnm6RUPndCLZ2LXhRueT5fjAxexwVldjB/35j73Q=;
 b=Cdhhl6Y2JL+oN4e/tPu7R6M4YfQ3v7u3F6htvFiipJxw/9iqrSYjwhIiOK12oqSLm4
 QEENVr8ELTvSnGg3RyfRGKZkn2ml0Gfi8MvoFJR3HEoRW3rHgm/RPWRh6on3VatUrsqc
 LxAr7TCa6pj2FjmRsVyd3NFRIglOQATgt+5QPyTgV/nIGUrmJOq6WGGoSr69dY0aVA01
 ANEKj3F52p0lG645M45bfyYq7fKCVL7QmfQnXk4LBuiOxmswAkDJMsctGHBc5Wd8U4dT
 IGJgrmJNXyqc4W0bTf23A2IFxhbUwi/18uV59cD/i5/aWsOTr6ss6P8Z5/X5onafIJrp
 OGzA==
X-Gm-Message-State: APjAAAWkmzPWYqTpEMsAOc7bjeGT3yZIBvBQLBysh0xzX13Ae99JtKHe
 7rAcPH03OcvfB8lp4obQhV+lKbtQ
X-Google-Smtp-Source: APXvYqzPvGF8zSWE5scQQVZoeloPlmFHdZzMw5lf2/RrlUUl8Ml4zZZYhr6JrNKYQWjPjMNK3XXayg==
X-Received: by 2002:a17:90a:1b48:: with SMTP id
 q66mr849809pjq.83.1562799338543; 
 Wed, 10 Jul 2019 15:55:38 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
 by smtp.gmail.com with ESMTPSA id l44sm3440263pje.29.2019.07.10.15.55.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 10 Jul 2019 15:55:38 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 15:55:28 -0700
Message-Id: <20190710225528.409-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH] configure: fix sdl detection using sdl2-config
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If SDL2 is requested but pkg-config doesn't have a module for it
configure should fallback to use sdl*-config, but wasn't able to
because and old variable (from SDL) was being used by mistake.

Correct the variable name and complete other related changes so
there are no more references to the old SDL.

Fixes: 0015ca5cbabe ("ui: remove support for SDL1.2 in favour of SDL2")
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 configure | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 4983c8b533..0f88ba98a6 100755
--- a/configure
+++ b/configure
@@ -3016,15 +3016,15 @@ fi
 ##########################################
 # SDL probe
 
-# Look for sdl configuration program (pkg-config or sdl-config).  Try
-# sdl-config even without cross prefix, and favour pkg-config over sdl-config.
+# Look for sdl configuration program (pkg-config or sdl2-config).  Try
+# sdl2-config even without cross prefix, and favour pkg-config over sdl2-config.
 
 sdl_probe ()
 {
   if $pkg_config sdl2 --exists; then
     sdlconfig="$pkg_config sdl2"
     sdlversion=$($sdlconfig --modversion 2>/dev/null)
-  elif has ${sdl_config}; then
+  elif has "$sdl2_config"; then
     sdlconfig="$sdl2_config"
     sdlversion=$($sdlconfig --version)
   else
@@ -3035,7 +3035,7 @@ sdl_probe ()
     # no need to do the rest
     return
   fi
-  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" = sdl-config; then
+  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" = sdl2-config; then
     echo warning: using "\"$sdlconfig\"" to detect cross-compiled sdl >&2
   fi
 
@@ -8019,7 +8019,6 @@ preserve_env PKG_CONFIG
 preserve_env PKG_CONFIG_LIBDIR
 preserve_env PKG_CONFIG_PATH
 preserve_env PYTHON
-preserve_env SDL_CONFIG
 preserve_env SDL2_CONFIG
 preserve_env SMBD
 preserve_env STRIP
-- 
2.22.0


