Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6250EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8A0206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8A0206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD75C-0001R5-5q
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zM-0005W2-FI; Tue, 01 Sep 2020 10:10:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0003ob-PW; Tue, 01 Sep 2020 10:10:20 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6bsM-1ke9Gu2gpC-0183pD; Tue, 01 Sep 2020 16:10:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 20/44] hw/i2c: Fix typo in description
Date: Tue,  1 Sep 2020 16:09:30 +0200
Message-Id: <20200901140954.889743-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hYVfATmajBOJ5pMHRvVK/fipsf1zG1zZ/XtU8JI2X9WJq7CHULQ
 mYpzqLoNZg1PKspU1/YvMNHLNUepZjpGzSJiD0hrP146o8ZxLfgpehL7byyIXDpMty138zb
 4T8zQCmMiuVkwUL52kM4W/Orl02L8SgxEB3cRCXYjIR13Mf3lPdfJ00oPD6XrwbS/RtkhfJ
 CMnUXt6aYIMx9wCNhy12A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kN98XEpLlwo=:O68hlzn1Ic//0t/WUETcAS
 MahSO1PzRNOppKyucS8r4QyONTGGbFqxwk6VVUIU/NreYfaTa/P2H0eH96Chsb/NMwAxQn18Y
 fD1PevIfY8Kd43/ZNWjhl6QjbQwJijM5YBZTzFdypNpiatGoa3rVcOzFMugb7us+QoFp6ymLz
 tnl7miZFmTs+JdJtdNtn8P4tZuFO2rlrt2xSdmbG6AqOPIiIj/zFmG/K412ZhLGWQ/Vsz+SYn
 CR6SiH3q/y40YLJ4jvp8OceyQ3lCLFlzTe0+j1TvjTl/3b+MKUYXWOlT2lqrjmUI4kmvGIoZZ
 5TWeccS7G3ixE/VE/X/vZsY7eiq10zDO61JM0aPoKyE0nG+ifPgTFZjBIUwWIStAVvySOEudr
 Ypja26DcqQs8zbMurFI8U0KOXz0SAA6yLUTpHiea5N58gIYuSsRFvoQkhjHZhcjTtWT3u+QyV
 HbNzmRAth8G8pJstV0ZaY8BUzHVcowP2FWNRO4EpUIfv9Vwn4+r7MBMB9lachyHQ5HKutiRZC
 ShxNeRccIGKbuLNKB6dW5uFjl4/Bqc6h4NtBD9gnkqpD5P0aseMvWaw0c4DOPXBxYG4DQowjF
 in1HyyjEUMYKWmDpt0ECfliPHdfzll8Azmy8syP7pfv9J1lWNsK60UWuze1GZ6F5+g211zcc7
 bZUt+nukyzm6U75b/YvBYfhiKJ8iMyPGxWOZtJyAE+I+MqTCj1krZJchpWmidU9LOvEqpocy0
 Pb/B8TvH+pWmh112rYZuzEteD5HzgUFYb96QWe97lH8gl6r85bfcvITN0+Gfv3u7XBUxjCBAd
 JHoyxQN0+l/7zgJCwQRiAxwgkZ27zzFKOivHVMspJlXX9nYeU6/AclT1v8vBxDpY9EJvO7E
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Remove the second 'and' introduced in commit 73d5f22ecb
("hw/i2c: Document the I2C qdev helpers").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200811151643.21293-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/i2c/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index a9c030a51233..f57808851e22 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -102,7 +102,7 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
 I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
 
 /**
- * Realize and and drop a reference an I2C slave device
+ * Realize and drop a reference an I2C slave device
  * @dev: I2C slave device to realize
  * @bus: I2C bus to put it on
  * @addr: I2C address of the slave on the bus
-- 
2.26.2


