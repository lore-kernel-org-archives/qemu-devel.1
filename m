Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63176C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6E220661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNXgTA7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6E220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVva-0002tI-9D
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoF-0000Xo-Ue
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoF-0002iy-19
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:23 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoE-0002i6-Ri; Wed, 05 Feb 2020 20:18:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so5131491wrt.6;
 Wed, 05 Feb 2020 17:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=26NlFhB7W/cGbdiqG5QYqxUB4TwmMhCNQJ4yaNv34Is=;
 b=mNXgTA7kADDjSX/C1lu3LYdrez6H66N07uAVR5iI9y1uJV5CkjfSACSIQMDrNLEPuK
 xyjDVSvzrp6xnJeUbAGN+71rquyTKTnICaQ4FhoqIvxXhH13hYghOS2mlhZ3ZVKl/6Kn
 fiN4rUjbe8louxbxG8us2qDadtUvJeWCC5KjQUshwkOX02jFbRu0LVP80Bz4dfek1G5w
 rlLXVqxVseaSkylXtqtldqkwKfuMj9cbGl1KzsYzkan67WGvSJvtNPNXiAREv6HopDGD
 jctgDLuZPDgZhmH8umZjxVTfac1FQWp2n4H3TTrVdCEBqyDEs6C6i3kWQEF73bTo7I7B
 OgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=26NlFhB7W/cGbdiqG5QYqxUB4TwmMhCNQJ4yaNv34Is=;
 b=OTFljgnJ4gHbXMjnXUei/fz8ObrU9VJ4bUZOrvDb8k8s336WOfDEgfrO1UXRhkrQOm
 FXmGIuSzkorFYJmkI8wZ1P3eoUXah0Lbzsu93aoEjsimX9TrrOdPaK2LJO8J7ytOXBVq
 OzScAh71GpiffMwMbG6O7+xAs65KX0+5w3FWYAsh8VA5dFIRmfOKKN1nGPhUvgvyV3pJ
 +epZ1B3I1i5cVDjjoPHav1krTLIhCnekfNvB6adCjDCzeUqwMv9L+Vf4DSrWU0BDNe5i
 ZF96Iu0eoyBEI0VRz9cqPBcCKM3JiyU/L0ZqF5wlftnbaj48e3JmphmpweR526DO2znX
 4kqw==
X-Gm-Message-State: APjAAAVdTYYzKr+ZvtT6T6sGVnIFcJ84XgGteJ/GDaxneEWNLpqWrJyQ
 /bF1/2LkmXdgAGZDfTFKEQ/dIImT
X-Google-Smtp-Source: APXvYqzjqbMCkaksaMMEAI9kvtXH78k2e0Hc49y2UubO4C4CrxexqH9Gb+y/mwp0xaYh9AcLGQYqzA==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr376135wrg.266.1580951901629; 
 Wed, 05 Feb 2020 17:18:21 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/30] hw/arm/raspi: Set default RAM size to size encoded
 in board revision
Date: Thu,  6 Feb 2020 02:17:36 +0100
Message-Id: <20200206011756.2413-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We added a helper to extract the RAM size from the board
revision, and made board_rev a field of RaspiMachineClass.
The class_init() can now use the helper to extract from the
board revision the board-specific amount of RAM.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 651585ebfb..43f8b1d677 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -295,7 +295,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
     mc->ignore_memory_transaction_failures = true;
 };
 
@@ -316,7 +316,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
 }
 #endif
 
-- 
2.21.1


