Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4B823103
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrXu+K8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4B823103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fBq-0000Fl-KK
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAm-0007VS-Oo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAl-0004JZ-2v
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id f12so8008717wru.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Afl9idIAxC8ImPasKuGcioFCcu5UpCjHW0zgglrVzbE=;
 b=HrXu+K8CcF0rZKRG5H3DRt5cpeIK+G01H/cdY6h0K9cyhaz2j0PW+W+e0f4j6sIFkj
 g+I0jioWYGrPtsFvE8UlUL2CAwE3AIZ0eQKOZaljB3WO01ZfvPqpZp43IHPXZkGqXWcv
 Aph0ZhRlmCNJWPmLjrKY+rpsASAkYfb3fuN5HGxc+psiZQQ8lX8OEsxuiD1J1/fFJjWD
 TELxbPUyd9LGAIg+o5qCQJWCkgW+Civ4+tblsLnBPXSEAXBy1eusMwj2t4dAwqbYad/t
 b2NDc9HW2yyeK3vVCtXczKfJa8kMSHcyUTELZrojg4yqTa5ovDrSnU+2DUtzWwwcdd4u
 p40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Afl9idIAxC8ImPasKuGcioFCcu5UpCjHW0zgglrVzbE=;
 b=YiMc+qk5u0PMoiOsUhhAr6jB7L97FVzLRkMhc+ooMsm7CWW7JmMwKPUPPus9msnAUS
 VZX1xsgvVCK0G+0lPPYTM0DLUhMCgX144fgz4X4Ge9F5EI7YNiM5ormtfIOLf08gfEGX
 X8HJgg9Q5MpdCdADblme7RiBd4zRXZcdrwhscqRmaowF0cYVglfbjECoNPQK4e4VK3eV
 ZkiYlitsxxsvuRPXDfoHr6r9OmPedd5L5+Fc7l6GDZNScVZ73byUdSxxgHYketaeM3Rc
 yanWnVbr1ti1xY6DcE17E0hADSi2AeGtw0SKM9T649SY8UCJ1SgJlagZX5XWGheEF7HU
 lGfQ==
X-Gm-Message-State: AOAM531F+xJKpIrFpT4h+UT4aL/SRsbWi0UACIjmzT9F5GpqYsqq7AIe
 YDK3taLryuRRgYeZUMEeIwrOwqWv
X-Google-Smtp-Source: ABdhPJyyIYppCu9qhUqMvtCdNvs/fDz6snh9wY2OrFWIySynBpFZI4ICrVf3BQYJ1EBQIBpZdLiA4Q==
X-Received: by 2002:adf:f289:: with SMTP id k9mr7421842wro.203.1596717540813; 
 Thu, 06 Aug 2020 05:39:00 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm6615395wmb.15.2020.08.06.05.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:39:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/3] hw/clock: Only propagate clock changes if the
 clock is changed
Date: Thu,  6 Aug 2020 14:38:55 +0200
Message-Id: <20200806123858.30058-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches for the clock API:
- remove unused code
- only propagate clock update when a clock change

Philippe Mathieu-Daudé (3):
  hw/clock: Remove unused clock_init*() functions
  hw/clock: Let clock_set() return boolean value
  hw/clock: Only propagate clock changes if the clock is changed

 include/hw/clock.h | 30 ++++++++++--------------------
 hw/core/clock.c    |  7 ++++++-
 2 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.21.3


