Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B56C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36502083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAfAAvm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36502083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtgM-0002Cy-Vc
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAte1-0007Pt-RA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:09 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAte0-0006WD-5k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:09 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh1so752098plb.12
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=tAfAAvm0wVW7CykvB8v0hP4yi0R80DQ+UCS13eQcqG9xJkNJtG8FgqxGT9P/d3rymr
 oh2Lh89IEvsN1u3lRiO8ldLqshxQzg6anZbhfzIH3eKX1VjUFbXaVbyBx5ie3ReaomCp
 KM9sz3A3ilpSCSO8psMFsHUMUhlNu/eknYsuGHTinj64NYjYHgotEZyjx7PhW0w4Oe0X
 ADyGXwc8X4G1dl0zr8pLsaZpqoPgcH/fGz1w1JbxD/1hcHI9miP4+96qY/yuKjvU42fc
 uEsEoAQbrveCauu3OAGHqmIr/SW7bmgqo3M1ccnjhBFp4XYlcGlIWpNt5e5TMqUJkPg9
 0h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=jrgZoTuwOFRgZ3DDU6TtvaFkj3zirm5WNJPoP8tkehV/7m99m5SUWiIsTF6lc3+GaQ
 BvEpkck/fnjZfmULYuj1SPwVmzkjTm6nGs4xjb1lT1jwuQ2tZF77vb7lwn/VwNsseZM2
 rtEu9TVoM9u5UhkMFUYZhYm/Sq27JNgsUd+c/W2uH5jfon9QvLLnpiYhiZmHrfdkADgi
 SbpVodG81EsbUh7CA4Bayeafu7PVVTkiHJR9QIuBQjnlJvw6EwDThrqNxRlUUnhjSfwH
 O1iDsg/x4CK3c0TO3WuJeHHiJX2TUkkLnWC8zs7xrGpD3YG7Z1w64m/qrwhHZPyhAUx5
 xZww==
X-Gm-Message-State: AOAM532vBoNaHhG57rBg4aNTCdyViBfMyQOLvwSbZyGMURm1xToU54qc
 emrT0kT+5o45Hym965RACN0O+3jlRxwdIRv1
X-Google-Smtp-Source: ABdhPJyMCXfCsz/WogBSkvfrLz2lyaZkiRvwBpDaO/B/cLLVVJEsaIsU/2TnRuH4rFDAnfCwHkc2Eg==
X-Received: by 2002:a17:90a:a081:: with SMTP id
 r1mr5616216pjp.115.1598441466114; 
 Wed, 26 Aug 2020 04:31:06 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v8sm2310878pju.1.2020.08.26.04.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:31:05 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [[PATCH v3] 3/5] meson: Mingw64 gcc doesn't recognize system
 include_type for sdl2
Date: Wed, 26 Aug 2020 19:30:33 +0800
Message-Id: <20200826113035.1564-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826113035.1564-1-luoyonggang@gmail.com>
References: <20200826113035.1564-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Fixes this for msys2/mingw64 by remove the include_type for sdl2 discovery in meson

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index f0fe5f8799..1644bbd83c 100644
--- a/meson.build
+++ b/meson.build
@@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
+sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static)
 sdl_image = not_found
 if sdl.found()
   # work around 2.0.8 bug
-- 
2.27.0.windows.1


