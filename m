Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F8E2311B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFWUQsqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F8E2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ffX-0000bk-7J
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fea-0007n5-HK; Thu, 06 Aug 2020 09:09:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3feZ-0007oW-48; Thu, 06 Aug 2020 09:09:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id z18so40380813wrm.12;
 Thu, 06 Aug 2020 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aZaaBObzjbQRAqFN3X3TVgwXNHIqW64X7jNO99AsFHw=;
 b=GFWUQsqKpfcZy1UQ3GVTBNKhdClOKS9LzphkSqGx4Ar3xdWF0L3ecjlU6Nc1tx7dE3
 zgHGT9vEZD8xb8ABLfnhW28RgCJJOZrbL6lUIHGWJInLXoOhkpBFdkXQxVeHitor/cF2
 cTXYlWoTfuY+ee1HwPzhyrkjqBs162IpN4hCJt4DeqMQYSbt6w8i5QaEtGwiXqBFAE/Y
 JSUFjd9gtfvF75RWP11dw7J/QZkTqY0HFo473PU+RCq8EHoJVc1UgIks7oI3LyhxZmnr
 FDwzunUUc8aHem45dhHJWpXWQG5Vt8VEvS8Y8kCuPS/I7Lh7s7aeuCCayct5Cxib5rXY
 j+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aZaaBObzjbQRAqFN3X3TVgwXNHIqW64X7jNO99AsFHw=;
 b=A9v+W2lE82UzYQOW8+1e8TBwaqf4gLnrjnuzlTWg6sJn6hg5N7XZGFPfLO7O9Xb/a+
 f/BwoUSpb3Km32IZ8D0L/T/W8eGH7DmNKIdxluqDPZqgeJGGsHcxt2YSyaB0nv1eayQl
 k6IMIP/CGe/nfq4BuQljgYAaa7aqbue+hUelojWWucMr1J+oCJ5XZG2FN8KGkLBl2YHi
 p5C0Au10eVrCJvpxZs+GcEiXKYDt2XoggPcRhIDhDQks8drz4du0hs+iVIyXAVpYJCFF
 PDT/2wk/JVmrfBQQkwf47xefwqbVVASzPs1SNbenh3mN/4uCiwImlzIx/IqYZEWobVDN
 +vtA==
X-Gm-Message-State: AOAM53095t/kGuFMG+YTTIZ5yPny7ZA/N+izeCh6m+y5wwGYweGYvhRv
 Jxjl/UlJOwoh9XMrYSNfWVcEqXNs
X-Google-Smtp-Source: ABdhPJzFZn+6CgmeEdpQ1cqO8rTZa5qgZmPRosXwkQVGoJJeiV8EzIF0T6sCpDrzQunsC7lmgtoeSA==
X-Received: by 2002:adf:f806:: with SMTP id s6mr7643302wrp.252.1596719389027; 
 Thu, 06 Aug 2020 06:09:49 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm7092799wre.5.2020.08.06.06.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:09:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/2] hw/core/sysbus: Fix a typo
Date: Thu,  6 Aug 2020 15:09:44 +0200
Message-Id: <20200806130945.21629-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806130945.21629-1-f4bug@amsat.org>
References: <20200806130945.21629-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 70239b7e7d..77ab351ce1 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -64,7 +64,7 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque)
         .opaque = opaque,
     };
 
-    /* Loop through all sysbus devices that were spawened outside the machine */
+    /* Loop through all sysbus devices that were spawned outside the machine */
     container = container_get(qdev_get_machine(), "/peripheral");
     find_sysbus_device(container, &find);
     container = container_get(qdev_get_machine(), "/peripheral-anon");
-- 
2.21.3


