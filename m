Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C1420772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/RQIAnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C1420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Ip-0001Tp-MA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AV-0003xf-TP; Thu, 02 Jul 2020 13:38:41 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AR-0007J0-El; Thu, 02 Jul 2020 13:38:36 -0400
Received: by mail-ed1-x542.google.com with SMTP id e22so24821443edq.8;
 Thu, 02 Jul 2020 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V32P4Tg8tngZvoAREzfxIAi+hfyO1ELSZiDrTWBPemU=;
 b=b/RQIAnnkn/xUXjo9FBc+h8r7bZtv6d4HQANBqlldwIQ6JsROFhT/tBF+G1H5GoIkn
 4LzB6IcqbWbNPn9Q44Xe35MNdHsuHm7/0DqAcw3vzjiKb7qNz8l+m59BjiN08JRiHGZX
 2f8P1Zi1KurH6IUTP/cKoP+Ret81rkjbqWncQfg3yTKmi/8bzYLqjoGlF4gJWrydTrgV
 j6TtDHY9h98bB3b/32xtmJsYVd8Fd+M9nAS5vD68YHPlX1sfw5eJcZqjU39w23T9I3Dk
 dV7iv9+c5w3WO23VHi/ju9/09cRogQwylFvls4NH8dATPeobfBYw5SilnppK+QCkabjt
 7dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=V32P4Tg8tngZvoAREzfxIAi+hfyO1ELSZiDrTWBPemU=;
 b=PR+tp91xhBT1LwAYAoTcXJu18rjr41qi3HEXexT9HGgbl7piqVNhPpjS+VQ6I6t7Ro
 njrjwx9G5ZRQzfx8zgTEEecQYWpKzs3klKvm1RZCy1uAtzHLwTYao2KY/INYRBQgkS2D
 eTWk92+OGOZFIEkJKynHmKDtLB2vtuUQMI19UIm0HKQcNAZUgCRJAlbl/G6kELq9LYhu
 uIY3JxJ65hyfQa/vrmBpNKtHwOTYC38+CvkVgncJwUJcO0/hVl7fsk2vRKmhEuWLeon+
 RVjvDqnpxIHL7y45gLOtwDNNAaCTCR5aZQ8DPr8FFRkVsDVWIhEWSkpCdUQrTnxiQNIh
 fPnQ==
X-Gm-Message-State: AOAM5303RMfzRjafsUtMidbExilEVXSF/e5mw9t6CIkeX3ryrpn1yhRf
 7DruTVEY5c26VxWn7dLxKSg7l/xnpHw=
X-Google-Smtp-Source: ABdhPJyN8w8nfKOMnqV5XlctY+smbAvKFg1vCVavR3+GSqK0MQxY/0AKKogUbpvUAhwpdjpsVBqDfA==
X-Received: by 2002:a50:b941:: with SMTP id m59mr35542006ede.321.1593711512195; 
 Thu, 02 Jul 2020 10:38:32 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] .mailmap: Display Jia Lina name correctly
Date: Thu,  2 Jul 2020 19:38:09 +0200
Message-Id: <20200702173818.14651-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Jia Lina <jialina01@baidu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correctly display Jia Lina name in the following commits:

  $ git log --author=jialina01@baidu.com
  commit 3d63da16fbcd05405efd5946000cdb45474a9bad
  Author: Jia Lina <jialina01@baidu.com>

  commit be1d2c49eac647f55172bce8e56ec09745c8d045
  Author: jialina01 <jialina01@baidu.com>

Cc: Jia Lina <jialina01@baidu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 66118f3d1e..70a9848cfe 100644
--- a/.mailmap
+++ b/.mailmap
@@ -103,6 +103,7 @@ Jakub Jermář <jakub@jermar.eu>
 Jakub Jermář <jakub.jermar@kernkonzept.com>
 Jean-Christophe Dubois <jcd@tribudubois.net>
 Jean-Christophe Dubois <jcd@tribudubois.net> <jcd@jcd-laptop.(none)>
+Jia Lina <jialina01@baidu.com>
 Jindřich Makovička <makovick@gmail.com>
 John Arbuckle <programmingkidx@gmail.com>
 Juha Riihimäki <juha.riihimaki@nokia.com>
-- 
2.21.3


