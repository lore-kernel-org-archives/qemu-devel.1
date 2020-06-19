Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E24208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wiud7yBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E24208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKkI-0004XF-0M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUQ-0000ui-TH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUN-0004Ps-Qc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586468; x=1624122468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=awiPom2MLm4GSUph2K8Os6CU9vKiSvuIpuRuIMNfHzs=;
 b=Wiud7yBrj4QtFNn/8QFcuvHgrvWbXa+gJaZOcnSD1wc7Bi/GXQNXMswx
 D2Bp5HLzGzbpmxUFPLK7hdbgxw3UAHwPq5Ikn93pduB6WjwaNPEdd3n+t
 pm2A52iQtwgvl3gl1QCbNh9IVSA1Y6H+iQ4mv1Frt3CEZVlWuevpwv4gz
 g+inFV+b4S9O2EAH11htCNDzWo5QEfue5pEljpLyPkN9FnlyiBrSe/m8Q
 z1lHqdBQ8Z7kjGhZ6XyGG+GpS7pePFE1MStvOueV+ODZ6A/Zr6pWeXXlt
 G8+ecpzRF7HjU5DBMofWZwVMm1zyKvi/5Vfhln9p8wBL+kL68f2LfHrUK A==;
IronPort-SDR: D3SzsxhkntV8jQMxiKGY2xwPVcc147raH2PNC3Oig7cLD1QsNi50/Zc56xaUk5WYLL/y1xXttO
 l1IMx6DtEABAeLVQm/2rFPxxOBPDu6dnOrWUMUtau0ygmtQ+sV/Zyz/OdES+HQiR/NCML2MOzp
 I+N5wjgrvXNT5cyF9nySHRyLzgxnVw/6cRvZMR86BvVqrXWykXiARcZ7HzTz/1bkTAwZlTlciO
 HDdg4gdKexaTgkaUKYH5cTmR27wBiF0tc7EA8x/RbtomHFAR+t6KB8BJPZn3fp+g1/FyodSqN1
 3Mo=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417012"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:29 +0800
IronPort-SDR: Gbdt2w1RBiaEWpwP1wFdrJG1TL9g74AE4viYJsDnMh42xm3odZ6vSmiFvwG0J6cB/7WKJvhPqg
 eDF8VhNTYUUFOGCNFKsQHp1D59HuwbUfM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:04 -0700
IronPort-SDR: bWhma3ycjeD7EZVFJguWugMJAPaMigYkcXp1FcLRv74xmyzecFlKIC/Jt7BbdQ8qUTCc+v2/cj
 iGEo1SbJY/bA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 24/32] hw/riscv: sifive_gpio: Do not blindly trigger output
 IRQs
Date: Fri, 19 Jun 2020 09:58:09 -0700
Message-Id: <20200619165817.4144200-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the GPIO output IRQs are triggered each time any GPIO
register is written. However this is not correct. We should only
trigger the output IRQ when the pin is configured as output enable.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-9-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-9-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 0d0fd2ba5e..aac6b44cac 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -76,7 +76,9 @@ static void update_state(SIFIVEGPIOState *s)
             actual_value = pull;
         }
 
-        qemu_set_irq(s->output[i], actual_value);
+        if (output_en) {
+            qemu_set_irq(s->output[i], actual_value);
+        }
 
         /* Input value */
         ival = input_en && actual_value;
-- 
2.27.0


