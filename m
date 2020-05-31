Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EEEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDAC2074B
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPgx3uRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDAC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfS2P-0006s6-7w
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRus-0004F3-6L; Sun, 31 May 2020 13:38:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRuq-0004Gq-0D; Sun, 31 May 2020 13:38:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so8627245wmj.0;
 Sun, 31 May 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jnJt4nNSB0E2pLIKum3vjItQrLzo5DO2iXhJKs1nBc8=;
 b=kPgx3uRgc7TXjjpq1UvXYDhszlo8l3sRGueug/C8vRhLjgvZQ5Mieac9b318WBFJ2/
 aeYe32r9/P1YQ0T5IBGEZZ7DL+Wy3+63lPgyyyIx0+YmMwTp5IOUGd2IT1wgrMl/x1tR
 KJz6LeuNQroYjMDQHIcgiF8BdxJylz7XpfRhndCHWb8t1o//QCW5SH5/lCsvTvNfTjTe
 II8tGrhBafOYy7pR3oJLWiTvPSFZijdqdapNq7SavzV2LWsL6fiHgv7zZkvxDTXFVwkn
 nhmlNB2/Qmcnalw8/VjytMqmdx2T42K5JNc3hbG2/fcaGN2tjOK+OXLUHm3TmUzbuQVt
 aGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jnJt4nNSB0E2pLIKum3vjItQrLzo5DO2iXhJKs1nBc8=;
 b=TYNByybJ1CAG82yeJhlodW38/5zSPHyFCRkn3DcHpb7WB875ZMHwk15IK2OAqv3Giq
 4cm2Z9pU17TeG7wi+nn2BSybywhHTJJHxfE3S/h+xtqwki1myemnWufjgPvRrfueVzJm
 6sMC8tVE7/lumjStdzuLPM/F9OTc2qjSHI8mPiuatXvktSICtPfIus/sX4NQmd0A+SYY
 X9gPMNDU5PUuze9MO6e4Z9XR1C91nDvE75FZm86wNWK28yevXrA1/2HHDrPjg35cVhVG
 wmaFr4rUncs/iSxLQnxFzXWiXehtol1JDz6+V22++1Hf3L7GBTtWa1ljwhRdVbiy4Fj2
 X5sQ==
X-Gm-Message-State: AOAM5304AZPmvxaNhREyiGYY1y+44Cg7yNop0jcCeF+tP5CqN0wKXci5
 Pqay4cdoSLkeKk9Jmkw0VCNrJdhb
X-Google-Smtp-Source: ABdhPJzC9j6ttjFbMxV1i2cC0ijncxDDP5cwavA0spex0KcuX2eB8xIhSwUxzBVMqmUzJNtm/2Oq4w==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr17828736wma.101.1590946709508; 
 Sun, 31 May 2020 10:38:29 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l19sm7973121wmj.14.2020.05.31.10.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:38:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] target/i386/cpu: Use the IEC binary prefix definitions
Date: Sun, 31 May 2020 19:38:14 +0200
Message-Id: <20200531173814.8734-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531173814.8734-1-f4bug@amsat.org>
References: <20200531173814.8734-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3733d9a279..33ce4861fb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6159,7 +6159,7 @@ static void x86_cpu_machine_done(Notifier *n, void *unused)
     if (smram) {
         cpu->smram = g_new(MemoryRegion, 1);
         memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
-                                 smram, 0, 1ull << 32);
+                                 smram, 0, 4 * GiB);
         memory_region_set_enabled(cpu->smram, true);
         memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->smram, 1);
     }
-- 
2.21.3


