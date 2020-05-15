Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2751A2078C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrcHqTpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2751A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbcV-0007PD-8n
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZL-000293-Or
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZK-0000xB-W5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id u16so2943291wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Peitioauv/zcrWgnE0w1JUSarAbB8IhuZ1XyceMYTE=;
 b=WrcHqTpGSRiqh/XWWT8QL6Mub5sTUpWwXslO0JMNezCW2cGCgT7z+/g6oB9IX17MA/
 xzRiYoIHqknObckm7cKgcywcQEZf22FCN34WvPKi4UMzQlwUC4QRhAXV5EqLATh2WQAv
 Qekc3QzMoEzLaVi+wtZMSz9AlYhrwyl1Ulq2wDV+9ieCGFT8j5KQ72dNbj2nVvesPqZb
 zU4/PV6GQP8tlY+KJWUKHT6dGkfnO/8zmh9+4pXtECva9mQjagsucrwa32n9EnYQMy/C
 pxm51nJE1D8Ag9H5h3Wc2kz0PQXOO08XEV1oOuH/vTnxo9aD3EkcDCqcF2yDu8E+QWrz
 25LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Peitioauv/zcrWgnE0w1JUSarAbB8IhuZ1XyceMYTE=;
 b=NGEZiIv+Llpwoel1NT82rj1kXqrVipNZv0QmhIQzlvOB54Nj47GnrTmkxJYOPnlZtj
 N5QyVqOkj/TE5JXYsztRvnpfhQctE/j38vevjZJmSkNarlb/6asS5UWwKOgqD/JimWDi
 Dpmh52TAcdGS8nYh7mlKGLH93uJ7BJ1dNC3X1/+jq7TkUJDE8g0x8ylbl2sgCR8yMk+0
 feCMw3M4iMzYChna76fWpWEpmEQJELtK9oX9mHmJTENdnTKSchxNB/tpKtehERdmmcIL
 zfBDZy9HEINyzL6T/XSk8CVoHFyto4RzuL4mggb6aJZynIzdGlaBZhssuHTROLnJwbeM
 5KYw==
X-Gm-Message-State: AOAM532qN3vEcvzM58k4suNecF3vY3pPp+xkFwRNWo3Iwwy+UmzOE5ew
 ZTulOlyxin+3sypfZbL+iFpCMA==
X-Google-Smtp-Source: ABdhPJz042ZF80BYxuDCBlOmZEwESHfVU68ZebtGKIxa0eujX87IY/3TaadU6Mltf3j85hpAo5mnuw==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr4287554wmf.24.1589553849644;
 Fri, 15 May 2020 07:44:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm3503903wrt.69.2020.05.15.07.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 380431FF87;
 Fri, 15 May 2020 15:44:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 01/13] tests/guest-debug: catch hanging guests
Date: Fri, 15 May 2020 15:43:53 +0100
Message-Id: <20200515144405.20580-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If gdb never actually connected with the guest we need to catch that
and clean-up after ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200513175134.19619-2-alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index d9af9573b9e..71c55690546 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -80,4 +80,10 @@ if __name__ == '__main__':
         print("GDB crashed? SKIPPING")
         exit(0)
 
+    try:
+        inferior.wait(2)
+    except subprocess.TimeoutExpired:
+        print("GDB never connected? Killed guest")
+        inferior.kill()
+
     exit(result)
-- 
2.20.1


