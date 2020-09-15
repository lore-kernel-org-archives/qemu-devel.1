Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6979B2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrprkJGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6979B2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAIe-0003Ng-FA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rk-0002El-94; Tue, 15 Sep 2020 08:15:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9ri-0008MZ-DE; Tue, 15 Sep 2020 08:15:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id j34so1880700pgi.7;
 Tue, 15 Sep 2020 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=qrprkJGFBTA5f06N9KxqbEvcszJJFVkFgeYNFSrFkFTWriKydAnxEsTb4WjU2uLvUx
 TAcCdcOcG/F+z2l6IcYHGt5MuQI2SpzTZ9fKUlQhqBeIN3Gu0K9CjdixtWJChjCETUxC
 ewZdeRWwbXSo2IqruWVmcTZ7DwJNFLjNNl06E3Ob5Tx8rSMAdBp99IBpNT7ZRaUoLdYK
 JkSGEAfO7lwzxGpTYQZcy4G4WJAgq3UVZbSNZyGX4I6bSURUCwtKIz0AWR9XlY5iew4R
 KzmHktck7nP9xqkzPp57mepP5V0cDkTLS8NtwEG755C3AZ4JnU+oDR27YTINOG17sALa
 tf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=KLcF8tF1AQTQR2rOaQRRxGKy3oOg5d0NitcUyNTmSZ8YPmXZtd878vBacdYMVV6Mk0
 Om0RWwJFE9gKLYTUfyJfvcyCBfzEfKvflU4DruegCUlxdS5B009x6c/bdavuTA8MN36U
 DsLhwntBJsKvEqRRatlREsaB8HpgDlTHcnU2ZSAoaaum8PKYCMZjdh8JUDghKYkzzmGK
 Ea6zqwH5kUU4lJeOlQ330DBKMXQwuspXuvRtogwJQPn+7M1mXy0IjwuuFUyrU5MRqkPe
 Nd/JNz9tcL3Kd7PNgdbHgUHBg9FCAtVP6atB9QbEeJfJ394zVuk0hvkn16XVYIEa6xdX
 chZA==
X-Gm-Message-State: AOAM530XbFEd7s2I+PPK8w9b3m9R1n5kssLZSAZTNoLMbqpeRHGY9d+W
 WY36WlN5Z/54YGoiRGeIW+i8bNbu8bQdKn+rDUc=
X-Google-Smtp-Source: ABdhPJxYNjhoyvAfLT3zxUad4QAMR3RLj8w9OhaHENqD4FUV7HyOg3nFjnU3lx1npoZijt39ond7IQ==
X-Received: by 2002:a63:4a0e:: with SMTP id x14mr14849667pga.222.1600172116266; 
 Tue, 15 Sep 2020 05:15:16 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 22/26] rcu: fixes test-logging.c by call drain_call_rcu
 before rmdir_full
Date: Tue, 15 Sep 2020 20:13:14 +0800
Message-Id: <20200915121318.247-23-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

drain_call_rcu is necessary on win32, because under win32, if you
don't close the file before remove it, the remove would be fail.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-logging.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 783fe09a27..8b1522cfed 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -210,6 +210,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    drain_call_rcu();
 
     rmdir_full(tmp_path);
     return rc;
-- 
2.28.0.windows.1


