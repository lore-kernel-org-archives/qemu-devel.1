Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23D62082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDwqKKfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23D62082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6DgS-0000wk-CC
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Ddv-0007L3-EF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Ddt-0005q1-MJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Ddt-0005of-FR
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so6448834wra.6
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6pwILuly/tQOEXgXaQAJSOL6rUgEAdfqnOF4URTUd+Y=;
 b=NDwqKKfWGMWpBQezGvZ7dfLE8eaJpTb5rWpflqkSAcDPRG7NoZCrHMEFWmNXJcaMiA
 9lqr+RKebCANIoqDAG979B97e+57lhsly7G/2tcQ5shBV3xHlFeA6UrTxigKQKzQq9HJ
 YAss1C9/3T1grSzujs76ghMAOuVLPWAdb776M2YQ5j0wuHmtyecYckelsW0WzsVuwFxk
 UDXJRFw7ugRuS5mDiHSpMgTQVq1YNP+1iqqKexRmDTBlHrtsfrL5e40UhRPUJh7zgmTF
 VC2Px+0eeEbjg7oyR9C1da02NCPuoN/gDKw3fqmxnLWbHW0aWLnTvA4FyYOVkvhkHOFA
 UkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6pwILuly/tQOEXgXaQAJSOL6rUgEAdfqnOF4URTUd+Y=;
 b=W9d/qPTBlP+AFDNlzqwgZSNtP9xJwq/IgbALxtg8z6O5V5yNlJ8kw0qBrCy54rEJIV
 Y7xq7pUObvXwcskRp3xaMSJUhZG6lLdYSN2ZYQ61s1X26pikqmCNVMH3eMSuUQTEKxAC
 ph3UEgJFjhdlZqBnqIapAGlNbzdYhDRZXg8Rp/7WszGsv8LobI5MqJ6OcFxjIevphb9V
 Zc4yGNPAI+0ocUwSZtoJWbUOPyYB41LyThpZsqaE3ftoX2CD/hHryO1d7VUt8sf86/9J
 OXUzymR9919JgIsq7iUfbupSQqC9GuzY4DDE23uyRNW3u3RJRKuA/bYCPbRHy1aw4lRE
 ObVQ==
X-Gm-Message-State: APjAAAVKFElf5AcU94QHK68z9KKQJiLhz5/uMlB6R6CtAuqBxL6PPwfS
 MxoT1FzKhGb4T7C8Wbo7n7WDRw==
X-Google-Smtp-Source: APXvYqw8ccbxRPJs9H8FsB7ArAc36sQ+mwWswPS1wwa/L7CYuINI0O6A9Ko66DIny+s74U2J11ORrQ==
X-Received: by 2002:adf:e945:: with SMTP id m5mr7119069wrn.25.1567774028184;
 Fri, 06 Sep 2019 05:47:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm7467305wmf.42.2019.09.06.05.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 05:47:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A96B01FF87;
 Fri,  6 Sep 2019 13:47:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 13:47:02 +0100
Message-Id: <20190906124706.19145-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v3 0/4] semihosting fixes
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

I've re-based and re-tested on the post-decodetree changes. In the end
I merged the A32/T32 patches and dropped Richard's r-b as the code has
changed a bit.

Alex Bennée (3):
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile semihosting at translate time
  target/arm: remove run time semihosting checks

Emilio G. Cota (1):
  atomic_template: fix indentation in GEN_ATOMIC_HELPER

 accel/tcg/atomic_template.h |  2 +-
 target/arm/helper.c         | 96 +++++++++----------------------------
 target/arm/m_helper.c       | 18 +++----
 target/arm/translate.c      | 30 ++++++++++--
 4 files changed, 54 insertions(+), 92 deletions(-)

-- 
2.20.1


