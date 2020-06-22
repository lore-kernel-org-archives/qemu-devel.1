Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B07C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345AB2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiUJ905T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345AB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNXY-0001TY-Eb
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUZ-0006mm-6N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUW-0005dx-TZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id q2so14474522wrv.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c2Ux+T+fS/HESUzVrNCO1n2kjnwyS/C8XASbbm6Vx/0=;
 b=SiUJ905Tp4BepS/nhSEDC8wpgQWD2B9BJWGJEInLKFctofPnZeoJqSoB1wyM3LzkJu
 iwTxDYqyvvB7FFfJF3Y6XZOuCLuRIaZysyfIWzX7rYaaY5EwbF7scQLhp4O6rtTOWBcF
 +a0q7MDtJym+hAHU7NhnvmsboLIudwNEaON3BQZCTIV5W7M6Vy0YS1aTFytNW4aiwLcZ
 I9gOzSGJ/1F/01faouW1Qo6c9zc5nLee92r2UDqLRGUy0yrz6vnbdpSNJ+rTyMmdFtqW
 IMSBXcIH3cTus08xv83hZinL+83PQruG+sqIUIFy4B5ynBIeUI0leuLA2QvcHOvgfJL8
 xGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c2Ux+T+fS/HESUzVrNCO1n2kjnwyS/C8XASbbm6Vx/0=;
 b=X4MUw7Q84jY6bcu7mAkDXO9grOFd43kWUZNCK5Xgglg/3r1pr5jR8gzvk89XVJXyIx
 y4Bb8L2HT1qIHSFDgCG7hqSXvDywy1spT+rSplxnIcOJwta2Grs0c+8oPtL5mIm96DVz
 Zf9R0Kzk+BZOiCIJ0B2tCbmC4+DrFJ7FsTzYzIjZbo8YklJvxcE+eq/Hyz6Deamevz82
 YLdbVMfIMbNiRiAkjZcgg1eu67fo/76J6YUJ4aluu0E6WwBDPV7S4u+a7qcS7a3yl2Y8
 O896FYFcuqk3LgNbDSfb+9LjCLXDXjKwNML80oemnKl0kK5sHmunY9pgbYItyH7+2mas
 2e1Q==
X-Gm-Message-State: AOAM531wJFXw7SiviLe94zdbqvXeSWK/wZtEGuNVHZ5OPPSixF9xvkP/
 YjSZ+qzE5GPSw51WKvCLQwoXBQ==
X-Google-Smtp-Source: ABdhPJw+BUQf8wqVHYoX3/6ywPmXoZGVpq2xrD9cWqOMNGAIKk4+3o/lpr4O9YuILCwDOD8n9/dE8w==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr17219444wrn.392.1592836326792; 
 Mon, 22 Jun 2020 07:32:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm20640436wrh.54.2020.06.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD6D71FF87;
 Mon, 22 Jun 2020 15:32:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/18] iotests: Fix 051 output after qdev_init_nofail()
 removal
Date: Mon, 22 Jun 2020 15:31:47 +0100
Message-Id: <20200622143204.12921-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit 96927c744 replaced qdev_init_nofail() call by
isa_realize_and_unref() which has a different error
message. Update the test output accordingly.

Gitlab CI error after merging b77b5b3dc7:
https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4375

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200616154949.6586-1-philmd@redhat.com>
---
 tests/qemu-iotests/051.pc.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 0ea80d35f0e..da8ad871876 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -142,7 +142,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
+(qemu) QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -214,7 +214,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
+(qemu) QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.20.1


