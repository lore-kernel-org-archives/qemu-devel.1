Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A15B217A0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZpSWSqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A15B217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJlo-0002fn-7n
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFJjO-00088K-4k; Mon, 07 Sep 2020 12:10:58 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFJjM-0004hj-Jr; Mon, 07 Sep 2020 12:10:57 -0400
Received: by mail-ed1-x541.google.com with SMTP id t16so8473511edw.7;
 Mon, 07 Sep 2020 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NOlAGBlVpGFb+l2jqStKkdOAxUpLbdbmm0jNUbEPCfI=;
 b=bZpSWSquCOZv33MvSdhnH7AdxafOZ1zRe/c5ApAIrjV5lvavevSE67/V3X+50oZpMj
 CULaGDqXLHjQ/jmv+xoj570lKeGlH9GSiVuSTzfsflLmrbgxkG3Il7HX4/Hf5jauibl1
 RGkH/Nj/16B+k4GYtt1q5migwF4ewArVaG6SUVzCHrZxF0zEA8z4U63ysdw71o1J7X/C
 zFjT/bFK6LzGtda3u7SZLG4AIKQrukkbWgrjK6P0jvLV7lEsSXetDoRCu9FyWmsiSU7B
 H5gndCuStqPsFIeoeyYobbQE3czaullDKyYAZm7bGAwWp38TUEpg8dBhYBzRwYlkqQ0t
 kmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=NOlAGBlVpGFb+l2jqStKkdOAxUpLbdbmm0jNUbEPCfI=;
 b=jUCijUH9uztyC8U/FMkAyVmoUAhgY7RTjMCbulg7KdzDptkjmBEn4iHCEZ8qGBjfz6
 Aq8CryQ851oIwNhETiLiyVVJO0dpoW+QETAfhg3YSqG71rjN+b/xJhw5zqsT6L0Vr+FO
 jlH9WBIPw7dytm1VnITRpvTUoZ3up+j9btNVj58cW5uoR3Ig2hAQ7evIWkpRMLHLBobT
 XKiVs+SSN9UYm3bV78Vj78EnrWIHUEG8Asx0GdR/qaALXMv2snK6YxjkEmgFxHbbm5vt
 we/JK0lKsWt6kr/dRYoIp+QN2qA5loNIHOznXRyhal+trZWpk3R/9JKdP5LpkgMtHR5f
 GJcw==
X-Gm-Message-State: AOAM5323w2VjiKMEGEWzURRv7xHL3L1GNIv1Uh3GiQM5kudn29sgE6LP
 NIGKacd7lRolEI/kwDVRUyXktn8kdh8=
X-Google-Smtp-Source: ABdhPJz1zK8fIK+fvYFmDKfCN9BKl0LjsJTGjKxmeMuZLa8pJ05Lo4HOyzOzb0M9LHI6Cn6xvnlFtw==
X-Received: by 2002:aa7:de03:: with SMTP id h3mr23145859edv.232.1599495054318; 
 Mon, 07 Sep 2020 09:10:54 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n26sm15422975eds.71.2020.09.07.09.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:10:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/git.orderfile: Display meson files along with
 buildsys ones
Date: Mon,  7 Sep 2020 18:10:51 +0200
Message-Id: <20200907161051.41527-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit a56650518f5 ("configure: integrate Meson in the build
system") we replaced many Makefile by Meson files. Adapt the
git.orderfile script to display the new file at the same position.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/git.orderfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 73fd818d7f3..a021afc2d51 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -18,6 +18,7 @@ docs/*
 configure
 Makefile*
 *.mak
+meson.build
 
 # qapi schema
 qapi/*.json
-- 
2.26.2


