Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4C4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C19020866
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rufbzsce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OV9-00072c-Me
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4Ks5-0000gL-5e; Sat, 08 Aug 2020 05:10:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4Ks3-0000Xh-9N; Sat, 08 Aug 2020 05:10:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id g19so2371953plq.0;
 Sat, 08 Aug 2020 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/7LujT5lRtrL8lKMtajUMzUZudhf3L9UNPDuYcY0R1g=;
 b=RufbzsceFD8EMrgM+spB6gifSxX+b3QqJxx0GemUo3/9W+3kAzrIDy+BcE7w+yho8W
 gO42pjS2kBQyfy/sKx0/xh8BJPHi0XT+18NbaSUvWU/D3o22KGZr/PKNM7grk7aNYmzm
 KMf0Ag5RVLwn18Rqx7K40ZCDFdqQb/koPN6iBWEnp1qK0gi68khSKXFJ6y8aLaEY2qWF
 cHUPe+4GU9eDq1FQ0oRX4bD89i2ZDFg8IyIlLe4JFNqXeKrSGgxSk67G7QCMb8Z7W7nc
 RCWNMsErksyxKicIhTgP9CQnhjblv0hqZrFqwwKg3DdYEXYDSSFn4YPfeFodClQ3aqcq
 uAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/7LujT5lRtrL8lKMtajUMzUZudhf3L9UNPDuYcY0R1g=;
 b=iyDvP43llm6mNQrTWclLxlUbpuPL4KnNY1BVIDQGVFC2FRW9WijsGDQQ+tnQvX+SVM
 TaCXinX5BxhSzTZWqkWs35FW+do8d+EM5Q+UuVgt9lD/4IWE6vAJm9Fag2eGuSw1GeHf
 F/2tN3zjVsXNeZoMu0JyrpeSiDDxP8eYsNzSgA1CLMDxX9vjca79CiEo1shNMjo9dbCQ
 AwkGDfL02aMtDeME/q2Kmsc/CjAmAfWLQEy1gWIjajK7wpCwFzexdf90gX701mWm+ChJ
 HBbkOBLg3ubxnOCpxqPGRql4929fRFZITxU+KeMm/G96NLKnQOyDT2+WQPz2epXhhigs
 KqmA==
X-Gm-Message-State: AOAM5337RgbJ1wpVntMAdmTs1kozI2gAqQ2oxxIPaLjthQbPkYskW1lq
 /2C9TWN6bmytmWH/PC2/rxo6jZ7doEE=
X-Google-Smtp-Source: ABdhPJyVsyhRF3fQLigC5TYELywW6C4YtzwD/4EXzFYPTY9HYbUZsa+CujQ8Rx3Xd7YtUlFByst6UA==
X-Received: by 2002:a17:90a:c693:: with SMTP id
 n19mr17663232pjt.53.1596877828600; 
 Sat, 08 Aug 2020 02:10:28 -0700 (PDT)
Received: from localhost.localdomain (183178047145.ctinets.com.
 [183.178.47.145])
 by smtp.gmail.com with ESMTPSA id i11sm13312700pjv.30.2020.08.08.02.10.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Aug 2020 02:10:28 -0700 (PDT)
From: Hongzheng-Li <ethan.lee.qnl@gmail.com>
X-Google-Original-From: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] riscv: Add enhanced PMP support
Date: Sat,  8 Aug 2020 17:09:46 +0800
Message-Id: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=ethan.lee.qnl@gmail.com; helo=mail-pl1-x642.google.com
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
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Hou Weiying <weiying_hou@outlook.com>, Alistair.Francis@wdc.com,
 palmer@dabbelt.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

The ePMP can be found in:
https://docs.google.com/document/d/1Mh_aiHYxemL0umN3GTTw8vsbmzHZ_nxZXgjgOUzbvc8/edit#heading=h.9wsr1lnxtwe2

Hou Weiying (4):
  Define ePMP mseccfg
  Implementation of enhanced PMP(ePMP) support
  Add ePMP CSR accesses
  Add a config option for ePMP.

 target/riscv/cpu.c        |   9 ++
 target/riscv/cpu.h        |   3 +
 target/riscv/cpu_bits.h   |   3 +
 target/riscv/csr.c        |  18 ++++
 target/riscv/gdbstub.c    |   2 +
 target/riscv/pmp.c        | 174 +++++++++++++++++++++++++++++++++++---
 target/riscv/pmp.h        |  12 +++
 target/riscv/trace-events |   4 +
 8 files changed, 213 insertions(+), 12 deletions(-)

-- 
2.20.1


