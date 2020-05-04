Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C314C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3567120735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK4n3KdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3567120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVVXW-0007ST-8I
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 03:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWe-0005yt-K1; Mon, 04 May 2020 03:28:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWd-00063I-3e; Mon, 04 May 2020 03:28:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id e16so14504685wra.7;
 Mon, 04 May 2020 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=96iBzta4O9kSIgAh9Y5rJmFbm049HKou78PdDPCrlZs=;
 b=KK4n3KdSiRBhzMyGrF7B5DqOwpI3ssvm4mTqX+C4IxIwWAoCDdGiyptc2V0CSeQcve
 Z1Qy0ScxwxuSQ0LoIBUn7UuW2eqd7a9XrMcsO0VvPQTDJ3GEWZwfHvp4BB2hi7kgKf6J
 4282JKXZsrqFPkwKLEXtQ3n2SedjBN8w6Vh4rsdEYerZZu+4zc7w9XIUis5YC/A6ZXXY
 0WM9vzvB3a9Qyd/BrDw8xl+KdB3GXwkRt23nslI5WWtmKmZgMkbPDteyHrnWkVqxt27p
 rbjQm2yWdSocXzxVcv9KkuKMVfxpPz0CHn8gO/JoWwg/0TD20hRJogmbU6kvOdnF1HsL
 RRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=96iBzta4O9kSIgAh9Y5rJmFbm049HKou78PdDPCrlZs=;
 b=BebqYPKBjVZ1Mhq25Dnl4CJ3YbdnsapvlolmCXdFElnU/d5f3cuOlSVC+IOYchDk0g
 j6T/OLBC/wB++zrVnpU71aAPWW6HK28zSGWfYlMzXWPZWbfdRs9hg6c2t12ALvu0L79l
 SM6TTsgN3oIWYU8rFLvmViRNT9AGhQeI1YligNtJlw1vbpIebk1NJnWVQP2CbEqYAQwR
 NqqstaEdr8Tr7XNuLue/kasPE6MUlf0B3oxD6cvm9MmnqGJlE77QZ94BGp7O8OYBmWzD
 g4fcfK0hB07F3pMK4broi1w+o5OL6mkqX8OvVG3VQkqb8xAJb0/EuyBfvhUV9LUOm25y
 GiVw==
X-Gm-Message-State: AGi0PubBUytPRHDJrcCp5hZm21J5JpfhzLQ6KVpULvXeiYYRLJmPaieK
 qdQAWbkYLxkMC5owlcmZOZsdPXoo
X-Google-Smtp-Source: APiQypIb9DMBOhnWpKATi6A7i/dgS6pb2betkvmCpomSQjdnRRozfeDUmFgm768PQ74XHA8DXin/2Q==
X-Received: by 2002:a5d:6582:: with SMTP id q2mr17729016wru.343.1588577304812; 
 Mon, 04 May 2020 00:28:24 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w83sm12590159wmb.37.2020.05.04.00.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 00:28:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/arm/nrf51: Extend tracing
Date: Mon,  4 May 2020 09:28:18 +0200
Message-Id: <20200504072822.18799-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few patches while playing with the Zephyr Project.

- better display of unimplemented peripheral accesses,
- better display of timers use.

Philippe Mathieu-Daudé (4):
  hw/arm/nrf51: Add NRF51_PERIPHERAL_SIZE definition
  hw/arm/nrf51_soc: Mark some peripherals as unimplemented
  hw/timer/nrf51_timer: Display timer ID in trace events
  hw/timer/nrf51_timer: Add trace event of counter value update

 include/hw/arm/nrf51.h         |  7 +++++--
 include/hw/i2c/microbit_i2c.h  |  2 +-
 include/hw/timer/nrf51_timer.h |  1 +
 hw/arm/nrf51_soc.c             | 20 ++++++++++++++++++--
 hw/i2c/microbit_i2c.c          |  2 +-
 hw/timer/nrf51_timer.c         | 14 +++++++++++---
 hw/timer/trace-events          |  5 +++--
 7 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.21.3


