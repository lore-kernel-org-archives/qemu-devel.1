Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB03C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6657C20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6657C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi9D-0005bZ-IC
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:40:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxK-0003HK-2e
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgA-0006Cp-5r
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:27 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg9-0005yv-W1
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:26 -0400
Received: by mail-pl1-f176.google.com with SMTP id p15so5645680pll.4
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=bWnhtt8L+gQXw/3z9MmLUNiXj8flc6h/W79W61MZMHg=;
	b=mTUkdoKD75bVKE4peFYSHLrk6eNZE7H9H/80BmTi14tI+pc915O7EIkhcIHGXKdDQi
	iqfEeYPqye6UiBr6d7KoSP5fSea1nDiRNhXiJh6QASClC4+0Jm28J1yIz3MAq2Cn88sW
	0/837q1sncxo9pYNLYOrtXWvt2O5zUq3tXBAk7yLR/mZp+trolr/EMZgdcR5tm2o/JR5
	eHLTv2PBDf1jcLuqZu/w4cBydLBialJc9SAuuV3kQhd1/mBrncTKWUU1QueLklH+5pQn
	jR4fMuRA7Jsll+ofFgPCYfEryl4gA4ux6c6T3hzAkYIJGiGliaSYjbbC2itAby+d2yHq
	MT9g==
X-Gm-Message-State: APjAAAWj9OareDS3eqI/ccrXWei1dY6OsepcayWu/SBPT5OT3ovk+HED
	kXa8h0r0SRTlsK7xQACNLAJEKA==
X-Google-Smtp-Source: APXvYqzPY4KMGwUG4O/4o0INh18c6RX7UotZarvjlgyOQqrSOqH/Vitk/FeTeONJ3jc6Bn5cScvGzA==
X-Received: by 2002:a17:902:521:: with SMTP id
	30mr78464887plf.62.1558833020841; 
	Sat, 25 May 2019 18:10:20 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	a18sm7424737pfr.22.2019.05.25.18.10.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:20 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:33 -0700
Message-Id: <20190526010948.3923-15-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.176
Subject: [Qemu-devel] [PULL 14/29] riscv: virt: Allow specifying a CPU via
 commandline
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 352646303420..84d94d0c42d8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -399,7 +399,7 @@ static void riscv_virt_board_init(MachineState *machine)
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), VIRT_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
                             &error_abort);
@@ -525,6 +525,7 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
     mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
     mc->init = riscv_virt_board_init;
     mc->max_cpus = 8; /* hardcoded limit in BBL */
+    mc->default_cpu_type = VIRT_CPU;
 }
 
 DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
-- 
2.21.0


