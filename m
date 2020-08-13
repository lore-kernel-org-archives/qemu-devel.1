Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107DDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EA920791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTdckqOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EA920791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6HmT-00083s-Th
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 14:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlF-0006rU-7s
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlD-0005xw-KC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id a14so6135631wra.5
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uhfZmbPHKJ0sUv1xRkRKUkWexALtAnTFEYNxyjbUa1U=;
 b=cTdckqODVxh4M6lfwjvJDi4mnrvDd1F0rjM4zcND0zjpC/4yn+CCb/02TDqTzmO0Dx
 WcPVPKo1hwkLjgY7IZOF72qRmq3CGcGOv3fTKZngflHrEkvPXpjMoIO7q1yNVIqpJPPC
 oQvNtsLbAIxp8Wg7QNeKI1Bmur+lLcqCDicp0etG6nWQ3OVSL9oYmJ/RtpYtOKPLkf8B
 0ZKf6XTubsrKACw590++XlB+Qu+hxoWUHucksD77y4ihdhca/5UtoRbjDUPLB5zvPt7M
 dmG3mqM/l/tPCp9PWmukxGcpUD2Ea5IQavDkcQsAcRwuPbdQclCq8bIt72mYGQ1JiQM8
 psGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uhfZmbPHKJ0sUv1xRkRKUkWexALtAnTFEYNxyjbUa1U=;
 b=FqUMRtX989gFsGnL31q/q5YKoawBpsVBa3I+7sl+AaXRzr5HWWv92s+XJPE+Yy4Ks8
 LE+NViK3Gzyn+n9XA3hb3IMWECaW5/Lz8D5P4XRUehOSfGNWuedEwQ3Tuf8lZnd95k8f
 qSO2cVPwIS4dgBzdyTh9B0DwaQg9gVCV3CjkocxLTLGxi5WQN5YwQYpPyRfWpmo9GYTN
 o3H1AXDgdIaE5J690Sgnv9OxhKXMRvm9BmCxcbW10hvhXDqPjJPWnIg/VbVnvNKNfCqG
 Wib97oBz1dX1sbGFOp7er6UojxEhH4u4kI+QPkof6zDnl/JRBMWcqpD2Sxnh00VNUXiM
 E6lg==
X-Gm-Message-State: AOAM533nQDe/1CmdUEPfjEBo3pDEPEkPhIiahQyyHpbp1uAX0JHxTIzl
 cvSwWvV9PT4cEwXdeSGtzn65A1M6
X-Google-Smtp-Source: ABdhPJw7DnHk0n5MkUtYphoS6ugtWuKUcLBCTX35PllCJiRsg2dPVQ+Q+88za48BeEOIP1cQbJuVDw==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr5112215wru.272.1597342529920; 
 Thu, 13 Aug 2020 11:15:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h14sm10039926wml.30.2020.08.13.11.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 11:15:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/3] target/mips: Report unimplemented cache()
 operations
Date: Thu, 13 Aug 2020 20:15:24 +0200
Message-Id: <20200813181527.22551-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few patches to improve the handling of the 'cache' opcode.

I'm not sure why helper_cache() is generated for user-only mode.

v1 was:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg727959.html
Supersedes: <20200806122612.17167-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (3):
  target/mips/op_helper: Convert multiple if() to switch case
  target/mips/op_helper: Document Invalidate/Writeback opcodes as no-op
  target/mips/op_helper: Log unimplemented cache opcode

 target/mips/op_helper.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.21.3


