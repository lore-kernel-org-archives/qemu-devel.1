Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65E6206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+4MIEwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65E6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMqZ-0001q7-2O
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMq0-0001PS-7k
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:26:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMpy-0008Rh-J1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:26:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id o2so20856119wmh.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e2BF+A9YUkBVWlpybbuT6qU8rSkjv4EZulEMn8kcqu0=;
 b=N+4MIEwMPYNxMh4o25IFxTZbZg4oePBYEdRfnUBC2OmenTZZbwiVXL3U0Ptz4CDtq6
 vDvZgXD1ec10qzIJfc+a3HIhfqizup1BiNXORiQ5tlDMfg9o4VsB2gAo8Nk//WuyxT58
 kX6m5TzRFFIAq7x1ysltcsYu0PsomWhSF0L24hxZvhGXOlZcUDWt2Oqofob2z6PVwjCH
 TRjwC3DgCO0rJYo0b360py1Ba3EDq9yjynlZK/k59ZIW7pYVvQXPDqTfngUtXSCxEyOI
 ksHVS1Le/GOd6spfLkAwuiONj7tbtJyNhxg3PST3PNtFXzeJbHq/FyXkf0kc5E7jlrex
 3Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=e2BF+A9YUkBVWlpybbuT6qU8rSkjv4EZulEMn8kcqu0=;
 b=bT6y8RKkxTJwPObuSJwo6MudkSrsX7pfyBWWbv/C7N5H7eIeZLtqoQFZiIjIhkopal
 DOZ2hUhLbACVYON+2Nif3FBmDOci0tKp5M2Xu9pXZ5PXKxVd/ujRt7kJEPMN4vk5ZK3Z
 kRK6pGhNy3UQjdiSpOhhyYkUymGfdI2eqDwhECNPY3YtSTeUr8teldKG4Q8d7WfKDXd9
 Xb+sAKPgPfPgYWx1XKYLp1+3Bdl92F9HgRfJYsWGcJRiPd0S2DA5xa9pAug+ehF+bdpG
 StG96ebzG3rtSpneYSywxyFsxa3sJpgJKEuSEfZjLfuHS8jkkViSwfBVPQvOm4Y8BBop
 EF3Q==
X-Gm-Message-State: AOAM533+O94dG+u4VaBESYR/yIooQNVXk9hYxX+Z6wx47gtyIcSdAoOp
 F2hl5skBTip+DiLa4AIaRvG3108b1NE=
X-Google-Smtp-Source: ABdhPJwbrSBTdMNAN6e7OHgq1vH8IAz8BeHi6cBJ2J7Y2QoZ00B+035VWi4lVKS9Dl4XVnoZ8KQE5A==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr22422594wmh.41.1593548794348; 
 Tue, 30 Jun 2020 13:26:34 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 33sm4921361wri.16.2020.06.30.13.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 13:26:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance/machine_rx_gdbsim: Use stable URL for
 test_linux_sash
Date: Tue, 30 Jun 2020 22:26:31 +0200
Message-Id: <20200630202631.7345-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yoshinori said [*] URL references on OSDN were stable, but they
appear not to be. Mirror the artifacts on GitHub to avoid failures
while testing on CI.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg686487.html

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_rx_gdbsim.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index a44f2c87da..41fce0e908 100644
--- a/tests/acceptance/machine_rx_gdbsim.py
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -50,10 +50,12 @@ def test_linux_sash(self):
         :avocado: tags=machine:gdbsim-r5f562n7
         :avocado: tags=endian:little
         """
-        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb')
+        dtb_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
+                   'rx-gdbsim/rx/gdbsim/rx-gdbsim.dtb')
         dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
         dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
-        kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
+                      'rx-gdbsim/rx/gdbsim/zImage')
         kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
-- 
2.21.3


