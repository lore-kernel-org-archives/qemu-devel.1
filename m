Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E92AC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F32208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhStefGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F32208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERdW-0008GC-Qp
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcB-0006Su-OJ; Sat, 05 Sep 2020 02:23:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:40784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcA-0003UZ-6F; Sat, 05 Sep 2020 02:23:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id gf14so3998485pjb.5;
 Fri, 04 Sep 2020 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bM8au98PWoeNJSV4TV/fhw7ws62pAWVvuMLjtZdOgq4=;
 b=WhStefGg3ym29O/azclYOzuYCMZ0N6D6h1xo9lyj/yjz9m2PS5/J/N63htH61/2lLe
 7Q5pQFQfZEEQxw/V36MPQHr3Q4eFbuiXjNXvAVr4LifZ82Dns8IogVtYySpQgrQnjq9a
 rdbJa37LLCQkMNX2+2C5s2dDMTKYJo2TZI9HYXGLKp9k1jhfJDSqac40mDEZWltwpq3d
 iCDgyiUKS9F0pQHYGuAUHSGBgmUT+LfcVHplosK9+jV8KZAfXWSExs66PhDhRHC/kCEd
 dpZWzZuBsffOtqzJlPC1qFBYDU3ecBCQJjopRAUmA5rWiUTArIMToaa7LHHf6B+gTTXb
 RduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bM8au98PWoeNJSV4TV/fhw7ws62pAWVvuMLjtZdOgq4=;
 b=Ph+sB5a4jLcnRNzxpjwFbKFGea0oU8QgGcVwgdqQp7gEnpgp76KMP+/Ib3OmT/4CsI
 Rlr3D+Ohg6o9veqzRFoW3MadkpYzJfwEBc7/8dWOZqkBvKju1ZTXEqMWdzD23CbHubmC
 NKX1IIN+4QYOmNx0aVbNV0O8W85wAKmoTtWg/tpTC2lU4rg6P3mc3S+X3EGG8SjqVLWB
 zhZYrLAuagzRpIkzvpaNn6WMn9iN7sU/xIYnn0Vv4+J6yExCPF4/CeriLDaGxbCZI2Xf
 hQG6HBb/LV5igkH8GxaK/i2HyGp1DTRV1FE+uYQEbh5I3lc+1O4WFj+PKWsXySHf93E7
 nsTA==
X-Gm-Message-State: AOAM531myjB38Kr9sYxjypnIAxe5IH103GTqsl9sk4xjyv8BcYTZPavE
 we/0f6sIBpTtEvd8Odr4axdiLVPb8xWvtg==
X-Google-Smtp-Source: ABdhPJwcAwwpvAE7Bhdq/x4vcM2OU4LCzkgaePdpLrtb54QjYzxKj3l7RsGsdyw8jrPhUoy7d/oI3g==
X-Received: by 2002:a17:90a:7f8a:: with SMTP id
 m10mr11739392pjl.47.1599287031969; 
 Fri, 04 Sep 2020 23:23:51 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:23:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/11] Revert "configure: add --ninja option"
Date: Sat,  5 Sep 2020 14:23:23 +0800
Message-Id: <20200905062333.1087-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/configure b/configure
index d3495e107f..5d8bf4d8bb 100755
--- a/configure
+++ b/configure
@@ -517,7 +517,6 @@ rng_none="no"
 secret_keyring=""
 libdaxctl=""
 meson=""
-ninja=""
 skip_meson=no
 gettext=""
 
@@ -984,8 +983,6 @@ for opt do
   ;;
   --meson=*) meson="$optarg"
   ;;
-  --ninja=*) ninja="$optarg"
-  ;;
   --smbd=*) smbd="$optarg"
   ;;
   --extra-cflags=*)
@@ -1758,7 +1755,6 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
   --meson=MESON            use specified meson [$meson]
-  --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
@@ -1995,16 +1991,6 @@ case "$meson" in
     *) meson=$(command -v meson) ;;
 esac
 
-# Probe for ninja (used for compdb)
-
-if test -z "$ninja"; then
-    for c in ninja ninja-build samu; do
-        if has $c; then
-            ninja=$(command -v "$c")
-            break
-        fi
-    done
-fi
 
 # Check that the C compiler works. Doing this here before testing
 # the host CPU ensures that we had a valid CC to autodetect the
@@ -7917,7 +7903,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA=${ninja:-$PWD/ninjatool} $meson setup \
+NINJA=$PWD/ninjatool $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
-- 
2.28.0.windows.1


