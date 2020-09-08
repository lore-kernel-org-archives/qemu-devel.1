Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D6C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A9A21D81
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSGn/3oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A9A21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFd0J-0003MB-Hc
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczD-00022Y-SS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczB-0001Kt-2V
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id w1so15865066edr.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SZgrhu9aERib1Vmq6MMAjKBnZrWMmX7ACgfRSB9sMAQ=;
 b=HSGn/3oFz1DR/wObleEHGJW2GFisCB5IRGaLCpc/qIlbRoDFFi1/oDjhAM/YFlDgNp
 9k7OJxvbU4342tZGUNptWV+WGXXjRBMYco00Q2IyHgZnUqokAzJKTRoYp82xgWqBWzLf
 5le7m7vP6CZupNHcYXXiUpmx7AB7viBRqi/OHDRIU0z09HxCMbxyT7eFI/NITJpGZHUU
 FJjy/pfJiKQuBWzAr5v41D97czbbv3QYIsiZ2DIpiyFOxjMkXBM280fMnU67rgfjrMFJ
 A2dYhne16F4qRCrb8SEfUTH8MU3OpEvZqDGhwVlyYhBk/AVTwXBvkVEyF5fhEXx4qjgY
 lCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SZgrhu9aERib1Vmq6MMAjKBnZrWMmX7ACgfRSB9sMAQ=;
 b=CI406GPCZf5wQYgDCtzcvjvCk6PlS98l2BIa46a6aYu8I7qBeh1pxG1LGWRl1jI5xS
 amvqnObi2pscYGjAO/8fjR7+Pk+pRJ4hkpLJOQjX51ZZdbRCvv4Re+ohVaB5El0iJKfx
 ZYkdEc/tazNS52V1/Iw+DBAizAgBTtimSJrr0uJA/+HIuGjxQ42RMBnye8ptVWwkvDvO
 KGgwDwVE65mavI/7narTr8wvCx1rPL4sRlbrwJ7mH7bnvkXdW9sdTCLn60eGjCjOFcSJ
 QWtZAfVDUdnIkysXe+jcePe/I+Mr1Del7b/phPHHYhAULkATm2IS1FnrcaNxFHEQUBju
 q2UQ==
X-Gm-Message-State: AOAM533k3C7TCEhTqWe2PmfTL3xlQmiLBS5DQ0/xqOTpjKBfbH+rnuEU
 yJCzsgeOR9iAwKVYMB9u46wbX3A9i/I=
X-Google-Smtp-Source: ABdhPJxFRjBEXTtSb8zCqlE3CEj7YOedou8CrvIoU+SrS8LPiDD/0hyooFmL9tWa2sqdjBRlvCRzKw==
X-Received: by 2002:a05:6402:1012:: with SMTP id
 c18mr7560163edu.77.1599569071519; 
 Tue, 08 Sep 2020 05:44:31 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u23sm4396604ejc.108.2020.09.08.05.44.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:44:31 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/mips: Misc patches  
Date: Tue,  8 Sep 2020 14:44:24 +0200
Message-Id: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x52f.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A set of several, mostly FP, refactorings and improvements.

Aleksandar Markovic (4):
  target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
  target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
  target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>
  target/mips: Refactor helpers for fp comparison instructions

 target/mips/fpu_helper.c | 276 +++++++++++++++++++++++++++------------
 1 file changed, 195 insertions(+), 81 deletions(-)

-- 
2.20.1


