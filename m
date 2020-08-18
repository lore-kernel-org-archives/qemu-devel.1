Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9D020786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKtq+lEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9D020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83fM-0000le-HD
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82ky-0006ac-A2; Tue, 18 Aug 2020 10:38:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82kw-0002yt-MT; Tue, 18 Aug 2020 10:38:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so18476509wrx.9;
 Tue, 18 Aug 2020 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y9Bd2jpxuNuhoVUEDpWdgjoBSmiOW5VBx9T24Qn6sLM=;
 b=jKtq+lEWGxa6CIR/mPKPYdLGwbZidu0flZWPy7qLJk9n7SjrqM1bI6WZxqLKyQPDF0
 g55DA8zhSYDjgzeZa5bpjGj5ga66Bl24MfhkKd3yPzruL0EgeyE2QJiRN0S/CBKikuv6
 8NQF3DLbntnsjOhMGVS4ibpo2kuWgYwrBBixJXp3f6z3fiI9e6AdUMod4Apw31Usly42
 PeXsminY8X8kns9qjBWU0G3jJ6i6rvaO91+D10qA4UebeOvFfOIOsQoJ9vKcmJfo0r8P
 pHFRkuDUVgB4ipOiRj/aTrdL+FN6FOBPJpu6Zp7AvSu7i552W3/nex0iOZLfA+5rXJdL
 JJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=y9Bd2jpxuNuhoVUEDpWdgjoBSmiOW5VBx9T24Qn6sLM=;
 b=emN4GLDoqAeSL/0J6HYotnfViISW+/JXJBdUe4/zd5G0rVvcwdrbP5C8r5QxFQDhbM
 KlrMpesyeM6355bMyz4iAZZJIY10QMkree+P7nWXgpTxqbOttfYmcjm760ukx8jTjQwv
 CzDDKlkLGBDxytAQ1IE+yBer4iesNWwbIK38OQFVwfdFuWHYZn9gAtq9R23jY4nQvhJB
 XYKKJ24atq+HOrdF7IdGH4mK4fn5N4AUGxg7QyuxGT3bFuQD//e97nzQorgGCHe3zlFk
 p85tFTOpWzoKW2VTDL7OCNTT7VM8pBqXtrjvwZGKBo1v30zoB4Uvth251PkXxlnprFoi
 ABTg==
X-Gm-Message-State: AOAM531m8jxbfxESB9lwQwux2YhkZPSIFBPL4TEskwg3umLMXo/dsjsB
 vgP7JyerHcUkqRbGR9lS1dQAymlBZuM=
X-Google-Smtp-Source: ABdhPJzUgHxXWUZv2OmnIyqs8mG3Z96ND21xUYkcBkhXK83eryol/GvcJtISmFNav/c1hFPU1okrIg==
X-Received: by 2002:adf:e504:: with SMTP id j4mr21050257wrm.205.1597761507948; 
 Tue, 18 Aug 2020 07:38:27 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z8sm139177wmf.42.2020.08.18.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 07:38:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/core: Make qdev_pass_gpios/sysbus_pass_irq arguments
 self-describing
Date: Tue, 18 Aug 2020 16:38:23 +0200
Message-Id: <20200818143825.691110-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simply rename qdev_pass_gpios() and sysbus_pass_irq() arguments using
self-describing names, to make the direction the GPIO/IRQ lines are
passed obvious.

Note, currently each function arguments are inverted :)

- qdev_pass_gpios: (from -> to)
- sysbus_pass_irq: (to -> from)

Philippe Mathieu-Daudé (2):
  hw/core/qdev: Make qdev_pass_gpios() arguments self-describing
  hw/core/sysbus: Make sysbus_pass_irq() arguments self-describing

 include/hw/qdev-core.h | 10 +++++-----
 include/hw/sysbus.h    |  7 ++++++-
 hw/core/qdev.c         | 14 +++++++-------
 hw/core/sysbus.c       |  5 ++---
 4 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.26.2


