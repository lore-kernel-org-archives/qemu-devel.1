Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7F3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8C4206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU9BcQu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8C4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshc0-0007Sm-2V
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshae-000637-TS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshac-0002dF-2A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w3so32828164wmi.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/eabS94ZgSH5/Wdy5wo3EcgCByb2tiRA2oQ9r/afG8E=;
 b=WU9BcQu+nJCiI1kdtGH/1jMKGwTtFnVrD9PBRqJXj4kO1B4PRvxPntRoafmahHz8Wr
 X/92d/RorZgvRSM8hYPM4glH4gX2CVJoh01XnBoRKrApUPzUYqMRx96RlmmhJF1+5752
 4qF7bgwS+kjZgJIXJETXReN+23EwxbwDD8CLn69edRJxOpxVpg0aQT+F/SdaQixB4a9u
 hoQ/F6UcB6vd/48eaWWV7TjMLoNGG2gspjFB1Tre2yH5XMvHZ0HZmhmj/ymwywHyTnrd
 EANZ0ifkNj02rRuO0fcjTL1Bg0ZSG5guSkyC5m1PwGaUUNE5ObPCQYrBsBW1suD5WC+z
 zlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/eabS94ZgSH5/Wdy5wo3EcgCByb2tiRA2oQ9r/afG8E=;
 b=lTcas6zjofBGyQAIffb1aVwYwsOHMVYK7qMFyEPMJEIzw839LOk+lAk4bV7dinPPVH
 TjoJ9sKh7H8ACos24818NQ8KeshAbmrJmfwql+/QjYTBwyLfqoS6kQTlPKw9T0bFF9Io
 tgE55Qb3bKihLSUBXmmc7b+2OuV7ZA/sQ9ik4UsIYXlQsCF4Xtw/FDtlyyLHUHyPAXiD
 +CTc+usBQHexjTLFCJZVmnM6qqGXCUkx7zPagcnG+4Nfv2GdPC+f8MYumqN6bn1q3HYh
 ejHylh4IaksuFoMqNr8HA2YofBlx9Z3CDxT0ZmAj+JvSzx93gsPyf6oO0GXWVlN7hB9a
 QKjw==
X-Gm-Message-State: AOAM532kj0RUvB5vULXXLubwMJlESk1OoOjsXqGJEeXL3BLkgfpw/Vnd
 n3iPYHxm9dE7YQMXaXaRkcSu1MUh
X-Google-Smtp-Source: ABdhPJzZel25BMOLLuqCI2jDF8a0iRC16wrzI0dL2mjfbi0eQKgkG625Ki1lZJ4ZzW+d5Ob8ASE7Aw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2577853wmh.121.1594105224184; 
 Tue, 07 Jul 2020 00:00:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r3sm30763634wrg.70.2020.07.07.00.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] target/avr: Few fixes
Date: Tue,  7 Jul 2020 09:00:17 +0200
Message-Id: <20200707070021.10031-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- added missing 'Fix store instructions display order'

Few fixes on top of the AVR merger series Thomas sent yesterday:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
Based-on: <20200705140315.260514-1-huth@tuxfamily.org>

Philippe Mathieu-Daudé (4):
  target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
  target/avr/cpu: Fix $PC displayed address
  target/avr/disas: Fix store instructions display order
  target/avr/translate: Fix SBRC/SBRS instructions

 target/avr/cpu.c       |  4 +---
 target/avr/disas.c     | 20 ++++++++++----------
 target/avr/translate.c |  4 ++--
 3 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.21.3


