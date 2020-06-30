Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFD120663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP8YexjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFD120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIA3-0003p4-87
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8o-0002Ii-SO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:38818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8n-0000HY-DK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id w16so21081273ejj.5
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cCxOIsK10p+a2KtrC7RA0Frnv6gsVNI/JAZEh1+Xa7E=;
 b=IP8YexjI8AnSGTNxD7Mxj6+RzzNyPdOF3CN/X1CafzDaFz1FvHSdzXvFxPCpb4+5Xs
 uccyktrmXo2mgUiTs03u0iLz+EkajXIxKpf0xSYMH6tH73hz6EZsQ4pd03AfqTPYJ93t
 hhpsb4ZbS57My6yaMH7mwhBJ3ukC/visoCVaI2kK3D/hgjvNPSfXNjZ4bTFBZbFZKkfq
 oz5cHTtRh2lX5DkzxCBQ4qcvogt82TTp1rv4qDInjS5Hmu/64xQQaZfoVqcNnbIPC5Qh
 UsWf+1wi7BlbMm8x81cxiRai7WpeoSMs0WWbH/jcsGgBaAWDMHmclWukJ0K8uVSiZbnV
 4kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cCxOIsK10p+a2KtrC7RA0Frnv6gsVNI/JAZEh1+Xa7E=;
 b=j928UU74S1Bo9woCarjZ1zpu7+eoGaZhD/E8BgpVl3XKbDYFqE+hpSbgKKOI2Dct/3
 7L7IhWD7tWSOyE6gRC1zWIDOMFzg2K3f6rMlNcSxcAV24NzoM3KtybcHeXDiKHSY/JLH
 YvwhIN7tJJgK+8iWN5MiqLBDyf1s4w0ZDh038PxK1bN0+zqV8vWYBJ4DhjajXcHpj60B
 D+D32u/fterz/IkDohR/4vYMDUw88S3niP7ZLHSzizcM2lLtP17dutmI6tFaxP4FeTZw
 ZvUqBvnHdKQsgQS0weSaCajZcD7luUhgk/UI8xotJGmqHL+lIHQaw3jOv/0t8CZZedjr
 JGYg==
X-Gm-Message-State: AOAM53397vzgxfsQccXvn9iEXZxt3AWAlN7Vi+HJggOAjAF790ZPAdcm
 ZEIU37f6Yv2eYr9RfobaCb9g6EDZ
X-Google-Smtp-Source: ABdhPJxgoBwgLpOpihz0yvTyNadGEUldgbFhu++Gj1Ya1eP5cyL0//JByEMzx1SxH1ScY9yITuuAxQ==
X-Received: by 2002:a17:906:7115:: with SMTP id
 x21mr18448315ejj.86.1593530743605; 
 Tue, 30 Jun 2020 08:25:43 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id q21sm2272398ejc.112.2020.06.30.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 08:25:43 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target mips: Misc fixes and improvements
Date: Tue, 30 Jun 2020 17:25:29 +0200
Message-Id: <20200630152531.20657-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A collection of pendind fixes and improvements.

Aleksandar Markovic (2):
  target/mips: Remove identical if/else branches
  MAINTAINERS: Adjust MIPS maintainership

 MAINTAINERS              | 10 +++++-----
 target/mips/cp0_helper.c |  9 +--------
 2 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1


