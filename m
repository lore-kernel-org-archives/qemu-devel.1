Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D4C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5390D206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBzsahkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5390D206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTIO-0006zU-Id
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAP-0002Zd-Mj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAO-0006tP-ID
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAO-0006ot-9n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id c127so2930345wme.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nNUQ1Y4cRjYakwD1/VEaESjAd4g6LoxnSk/siZZWkF8=;
 b=BBzsahkYMHN1bUqaKimPLIy5lUpTNyMdXxIMLP2VDf+O4snVM/luAnOzmmQKdH/0f+
 22S7h7SP7Apd7k687MSH7rnH4nh1q1ocjSHdRZyP+v9pHNSPT4p71HhWMfWO4iK4mmF9
 qRxBOlmH1BhqlMueIwsq7lCaMyouvxhjj9KHdZhe0MxNkpkmQs7chARtKHqwg9J61rs5
 6Y9TLgmMRFHLqZ1PRdWK7qwC7vJSTuVWrF50UHtQjRhzezDMcKxdLkaqVqsurgd9OTNu
 7ibRzGQEozqElkkDJ6Un1V168tBNAC0SrQu2q7VobjE5N5seqT4PtHJdShLv6HfFueJ6
 v+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nNUQ1Y4cRjYakwD1/VEaESjAd4g6LoxnSk/siZZWkF8=;
 b=MfVsvtfKPKfrpaC7pR8Y7YY+Y90ogQrwwD3LHPjSIIUgzbq8EclKHaHvf0jh4B9cev
 jMHWfXkXASFErzJi1wi611uAXsKJojqwOktEfDItWTLQX34OL4xJczlPtxqY7ec5qElE
 3wst6wnXouXZI1NfXgcV6JS8dV7B9HjXRLSDVC9tJ5Fx/QzUw45aUVK71on5CAxuquG7
 lsOCde9SO4QBgh4pMSrgrgkJDUOGd9N8kd6mueia97yDO/09AKPIPAg6MOAIBv4nyy/4
 BLWxOn590/2uY2aOFkq8cIpC6Vf1qE48ICLQSdKaZcwrH+VaSWYEQOiSr9xSC6ftK6gA
 x2Bw==
X-Gm-Message-State: APjAAAXzApMrEGzOaDtPU5MRY7RaRLJxTp3ZR0gTSoh6OaG4IKkMxJcl
 fyaBmq+mmax8SoYNWZ/q1AcmdHVv
X-Google-Smtp-Source: APXvYqw6n+L+VBESTBif0ChLZ6cbcL8eWgaYVUc2Md0wAs5ROxaKo5qHJPrTCaPLuIMguDWP6FlfZQ==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr7316668wml.154.1576890167125; 
 Fri, 20 Dec 2019 17:02:47 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 6/8] tests/acceptance: Do not set the machine type manually
Date: Sat, 21 Dec 2019 02:02:24 +0100
Message-Id: <20191221010226.9230-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ba21bde93 we don't need to set the machine type
manually, the one set by the ":avocado: tags=machine" will be used.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_avr6.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 7a7d8afc29..394b3d4f8f 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -45,7 +45,6 @@ class AVR6Machine(Test):
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-        self.vm.set_machine('sample')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
-- 
2.21.0


