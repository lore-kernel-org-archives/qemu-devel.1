Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A5C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3002065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMqB7tx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3002065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUbx-0006VX-JG
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQm-00089t-8V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:48 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQk-00011h-CS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:47 -0400
Received: by mail-pg1-x535.google.com with SMTP id v15so6316063pgh.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=cMqB7tx6vU9uaTDHrEaPkZZHXhQ2xUynCgUO7vzFEk7/xoweBtz2J0y/ZON6XMFNLK
 UAjQLulaxsAj5a0vjvRjAUhJ5FkJ0Jzyga5E4gfyDiHMMnKyZ3RD21AARLwKi1EznpJS
 9CWExvEpm+pYDBBnbo+Ef+zXsOpj3TCRug5QfheHxXlU9Q/Z++1FGDsM1oDsVcdwjYcO
 ZxaTI8dk8Veb1boKIHu65Q5JUAZhCm7/4Mc3nNM/0GXSYLG8gb4ClQBruDpj5C81WkQT
 yWehB7Z1ire3QeXZ3Ri7rBlc2uNWKao7yCrM1TPd0S4sPCWJNugKmeddAAY2j5LYkZfS
 7K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=PavrD5XKUnQqiBoZr8ZRPTzpVTRBf2rB8+FEAccpFPUwsrlR7GNWr9IR2OAlFaxlsW
 EFIiHtNUsjDqXN01jZs6vids+4mSn/mOb5d+3NRwnMr1VQPaxbPAMKje4cH9nKtlEYTh
 LV0RuGSozr55rCsuZDhvaDiGpjeNCaShPShFi5YmPAQNThGxTn9wOeSWRh9ioToZQTF4
 Cg0OpT4H5NWCIpMKvaddt2B7FDXiQ3qyw023Lh07ci7Fcy5DY2kzKT3quvxvumphoJN4
 bRdmsRoEp+xeMcj6RvuIQPRZkvItpUgQhGjXLNA2UgZ+dITgNwo38Bz1+aajlzseCgoq
 KynA==
X-Gm-Message-State: AOAM5332oh7i0aqVEQ0hE8CeYPdDSZrW842cINyJIgutjRII93EcF6br
 FKMM3snDuBi5TFswit8f9HbNFR25W2eUJcc7
X-Google-Smtp-Source: ABdhPJxbvr7/AnBoZcHyhsW0W12ecYhAkPOLPxHO5o9UAm5fH+F+qXKhj+2i+WaiwgQOkytgV7QdZQ==
X-Received: by 2002:aa7:989e:: with SMTP id r30mr7131267pfl.205.1598344544576; 
 Tue, 25 Aug 2020 01:35:44 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id bn14sm1146683pjb.0.2020.08.25.01.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 01:35:43 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Date: Tue, 25 Aug 2020 16:34:58 +0800
Message-Id: <20200825083500.359-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825083500.359-1-luoyonggang@gmail.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x535.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..a3585881e1 100644
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


