Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19693C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A2920782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW0PYfH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A2920782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcEt-0004XH-2L
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcD4-0001BJ-5J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:39837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcD2-0003g0-KY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id j13so1535513pjd.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XRpRfNQbgoJsRKfqSFaFNZt4aTrq25ysudP80W63BlA=;
 b=UW0PYfH+4Do+KZru0RhDAA+O3sqo0zCdVS37UudBs67TdAPFOtT4hX/Iq61zYezTwx
 /t1xRbeWNuwdBEzRSNbM1WhedDGt9gwhRyPOanrY1GU8e3Qqbvfa7mtDPYDc5F4Nv+B7
 2T3WgxAFDLKpVYKegC4sLSGWuKm++JFrqekSmtrVEzkTUoUi7V+66sFzH/dXErzxeX/e
 fNyfKkGIV/MFlauEGwENu5HW6nJiOSfSUM72ffmnP4eTQBojtjbKHQqSO6XDWZ3E+L1b
 ze5m0+RWlqaW91FufIkP6BtTEXpLzCFCKmIMAlQx/EQPgQ4rsSXnZiRn2dTx0Qttr8Po
 HjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XRpRfNQbgoJsRKfqSFaFNZt4aTrq25ysudP80W63BlA=;
 b=uRnq+hV08IJlEs5r3l8S9IEB0VM0sz8bh61HSo8NftDOdPUlcaT1dOYZdwEB4FIViH
 I6OYDKCtKTcMGDTot5y3LFotqFpGWNsveHZbStsfS4LU7DYS1DZfitt+jeUB6SZ/WM8T
 6gKB9tVbljjUoSyRPCyraZHxl8ilByyUJtbUO5md1I55po/3fNNaOZ0Kaw6QIOVtmeNC
 xsXLTq6syK+xLZLaswb/Q+77faQCu+sWq41Y6LMxcUVdf/GLGWGVSUQNldTJ5KxA3wcM
 v/Tl/bHuhE87WPfnxVyKZR1t/D9p4mhar7bjfoBN+gU9eBkdl3xYLGl5RxzP9woKV31w
 ggog==
X-Gm-Message-State: AOAM530Ns/CV0Fawh3j/oLfcGvfzCGfQCFAVix+iJgUGeCtI6RiMA9ZA
 kOTvE+tCB7MmPTVwInEw0Ehb4OEblCLMFKueGiM=
X-Google-Smtp-Source: ABdhPJxJLGxml9TkEdamMlVcmGc4DQuf8MMVUhQB0FGY41LxKOoG6TIBwhXHsLVmr5pK3OwwevZeHQ==
X-Received: by 2002:a17:90a:a61:: with SMTP id
 o88mr2369044pjo.201.1598374446648; 
 Tue, 25 Aug 2020 09:54:06 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id
 193sm15988527pfu.169.2020.08.25.09.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:54:05 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Date: Wed, 26 Aug 2020 00:53:40 +0800
Message-Id: <20200825165341.520-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825165341.520-1-luoyonggang@gmail.com>
References: <20200825165341.520-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1029.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Fixes this for msys2/mingw64 by remove the include_type for sdl2 discovery in meson
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


