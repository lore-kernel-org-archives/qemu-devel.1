Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF1C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0577521773
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LjpxKAVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0577521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKJu-0002yd-9B
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:13:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK4B-0005au-SD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuV-00049B-1K
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuU-00043c-Mo; Fri, 24 May 2019 19:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741660; x=1590277660;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=Ao9gCKvSoFwU8QM28M/2smcm/7HnPQ04kDU0bSYTT4c=;
	b=LjpxKAVl59GihkIhlDqlGxptAk7eFT41ajImGuDiN1hvp44H2vEMMudD
	xlGjnl7fYIx9jD06F43VX7MOqdVlDP+KPbKz8RcaY0HqIwOITYgSNePSU
	OUNJ5jQlwmiFBIHL02d8y2n9v4E9tO9/v57/m5XuQ6O+zjAHSOtdy/ixD
	MnY/KyXN9o87HfyQYJRifvIQuPdBgmTiUFB9AclvLs5bW1OL11WhiDjqH
	5o5Z6KmNq8ZRLjKZk1DhNgLMbZJHmLF2llKuiwB2GDyAI995DZYXuvC3l
	692dyUlf2siGciNQoZYR+3HWAn7bhoSRKR9JGlMLRR4jc793m93lY5ZI2 A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307756"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:36 +0800
IronPort-SDR: M4vZR1WT3BnaDfJn6gm5ZrtaWUWxrGlajA66TCYNwu7ZQ/x7Nai3ZQp1O/tNxedV7jCqOsbtw2
	jqF0iKreY0/Gia7bVKxhIN0LrNqQThmjUAUCF1NfwreoHzO7MRzoP6jN2Hli048gJipqs/TzFU
	KWZdRYi2a3jSX5/cnKq97jH8IhFbAOD+vpoaPx4Ka/d/iNitxfLYBR08saLzEPCsew/5pi2lQU
	oz+IJ+p4NCKIy0+o5QGdQvxeTddTyvEQ/KpJp2/WhD57eRml/rr0hJiv9S+ECzj25YIQwtNWi2
	lS+iA+KvNNrym3vT/71eI2AZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep01.wdc.com with ESMTP; 24 May 2019 16:22:53 -0700
IronPort-SDR: Z9W+cSivcv6Qg7ANGLOVFQAudsfnCj9b17C38Ak/aZJSvs6TwyudBf9emLGuUGhgvvYDeWn+S0
	wQhdCC2HiFh//oVaLxY0u/fSJxZcV4qYVPncTVO36O80RLzWygs0nw2n+ncAa3MKJHhszLPmwH
	va17x86+kd9sFE19QsaEh5zAPEEJ9rK9qlQlZM7+5Zu83qFkQogfheRYt6hUchERzbJZ7v2okH
	CBJb7Vt60XzuC/KdIINYr6Gsyszo6voyb76ZcQUHCfqazXAf0CKcGyZc/EZuYpKVCV4udAyR5G
	0iI=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2019 16:47:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:40 -0700
Message-Id: <668f55005ffe96a231306ba4d8022e43142b25f5.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 02/23] target/riscv: Add the Hypervisor
 extension
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8937bda918..3337d1aef3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.21.0


