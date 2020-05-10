Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2380FC54E4B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA62F2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBv5STKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA62F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXntu-0007Kp-Tq
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsl-00068Q-Do
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsk-0000yR-3r
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id j5so7750405wrq.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GDBNV10KgpUsGXFc3f+hxEzh+3eyGAg4+UfQtj5vvV0=;
 b=oBv5STKqJtO1lak4Z//MEJJ9c1WfMNCFxdg4ZhgmphQukmFy/IyqdZc1QUfyk7OZUG
 BmSS3Cm6orbaoahN/EZ0XTfGDoR992PYz2Q/Y+a8rAyict1NzhxLhmTtfuhyjUe1A4oZ
 JGI3um7LMiZ79JV6T3dAbGsoeLGyuMJ1euNh13ljwP5YHjJyzp3KuJp83+bhUPzamVH1
 pUXra4h5ZeeLsMZBkW3zBPrYd0yWGnru7ZN44kXVBP7eJr95y1VZGh/5lG6Vr7mSHWVB
 l/ppxn+EFWbm2EAJ5KZegQXx57U92ZPjyQdycqUtXHv0hpbdZSBqjXPN/Ss00SU6OGPz
 feUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=GDBNV10KgpUsGXFc3f+hxEzh+3eyGAg4+UfQtj5vvV0=;
 b=raroZKTLItLci4Hjs+H42XXub6hZb/UOpDhnVjCIJs10sq0LohkBW93Cdr2Yu6rVah
 /ZwDAJiIqEzkYDVJNqbixAgKnvU2c+aF+bLWWddwMrEbEN90MhZHCWvsMF5OH8aY4AI9
 vEMUP2YuzovI9Knf483aha4Q+3fu/Lc96JiWfchLGn+GKilbn1KvkhvetQF/HaKqlQ/0
 mpR+enpQoWKBiRiGok49iEGjNKcaq1F1yaOXieLeSN1ZvxiqMztmhd8nvtUqIOv/eJgk
 N41UCUt9E2PvztZKMcIAewZJe+Q/ITYLXR9uvAqSFTJKi6ocq9sOU+vHPv0XSOulYodZ
 AkbA==
X-Gm-Message-State: AGi0PuZXzRYlVRd9IDTTleSrsUdquYLlHfPonbf5PQ85KtUNxdRrfk9s
 PGhMfesz1P4qh4FARAM29SeCCjo+534=
X-Google-Smtp-Source: APiQypJWkuf+a5hZGf9IsAKlbGhjrc2msT+mfHnno3zfLnS8WsvwJMU1XNGiMdhmuxTijL87zsR5vg==
X-Received: by 2002:a05:6000:1048:: with SMTP id
 c8mr13903962wrx.1.1589124523872; 
 Sun, 10 May 2020 08:28:43 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
Date: Sun, 10 May 2020 17:28:33 +0200
Message-Id: <20200510152840.13558-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New Spring, new opportunity to clean this device :)
(v1 was in 2018, v2 in 2019).

- lower device priority
- follow qdev model and use properties
- convert to trace events
- describe with slot name
- move under hw/misc/ and cover in MAINTAINERS

Peter, I hope you are OK adding it wit UNIMP device,
as both are very similar, and don't have much activity.

Only MIPS/SPARC32 targets use this device.

v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html

Philippe Mathieu-Daudé (7):
  hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
  hw/misc/empty_slot: Lower address space priority
  hw/misc/empty_slot: Convert 'size' field as qdev property
  hw/misc/empty_slot: Add a 'name' qdev property
  hw/misc/empty_slot: Convert debug printf() to trace event
  hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
  hw/misc/empty_slot: Name the slots when created

 include/hw/empty_slot.h        |  9 -------
 include/hw/misc/empty_slot.h   | 19 ++++++++++++++
 hw/mips/mips_malta.c           |  4 +--
 hw/{core => misc}/empty_slot.c | 47 +++++++++++++++++++---------------
 hw/sparc/sun4m.c               | 23 +++++++++++------
 MAINTAINERS                    |  4 ++-
 hw/core/Makefile.objs          |  1 -
 hw/misc/Makefile.objs          |  1 +
 hw/misc/trace-events           |  4 +++
 9 files changed, 70 insertions(+), 42 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 create mode 100644 include/hw/misc/empty_slot.h
 rename hw/{core => misc}/empty_slot.c (66%)

-- 
2.21.3


