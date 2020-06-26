Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC618C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A90207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXlB87Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A90207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop2A-0004DW-SV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop0f-00026B-Nm; Fri, 26 Jun 2020 10:07:17 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop0e-0006NY-6b; Fri, 26 Jun 2020 10:07:17 -0400
Received: by mail-ej1-x643.google.com with SMTP id w16so9511212ejj.5;
 Fri, 26 Jun 2020 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RuzXvA/aTpuOPYIFxer48+fv+OoNhJtBmY1ds60T/Kg=;
 b=cXlB87Gpa4No3MW4eJDRBmhS5xsEQHwXHtJf4i8s8/j18Xm4rlsCi0fXOjGRyNFSZP
 9mF0MwusP5Y6O4EHdT2zFknqMa4AjNjfsN9CrNasgzemhd8uxBdJnv+FXgBeJTXyLV+e
 i2ejkt9cUycfBANlsNhXhOnVSD8tnEHIJeIqtZGLxvmUuYEka/DZ8GRkGJt7U+gpgnWJ
 sK0caCcTB+IRHacWnbltI14ik3yz4le0plrUbD0vWVHG63UrEEFjUBW2GTzCBj36c8tD
 kxQYeh/7OJBcfMqK1A+1wiJWI9Q4jOZLIrWG2WEc1e7xLLfVZ47Gl6yqsRNC083gGrUT
 LVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RuzXvA/aTpuOPYIFxer48+fv+OoNhJtBmY1ds60T/Kg=;
 b=L8mSHFD/plWwGmmg44CPlHqCI1EMCLw38dXNQva4ptzeK83002qvLS7pHj9eu60hfk
 0SikiLaYTVhB9awUgfytu11D9S0O9aqcZtmAIUviS/qimGCmVcZnYoQoZlmCXw5OPwnX
 fUO8xkN9TPLryn9Ksi0vMLCsQVBzYeKE6bdUSJDd4Vud8mxkFrdKO5lV0mzTzlh1N2v3
 CX3o/4Z36o6ED9sCSW+M1M9hFyc3hq6nKQpZ+T8AYfnlfHNoGJgcgUwO/dv6VtFiMSFD
 d/5II3OFNzxydQpUcWy6CYi5KljCV1wb5NGHVaMYRsmYTq2sDiSyCUQW+PhJRmVdPUZD
 Tsgw==
X-Gm-Message-State: AOAM533DaA9M4rqyGQKkEacMB96nzKUEVVGpPJ25COXnZZGjdpmOjotx
 ja4nwfz++s5l3FtTgomB4DidcgTX6SnZ4j+Eou6D72Zwi4wPcw==
X-Google-Smtp-Source: ABdhPJwGcjkIj++hulhg/MQbba/bL/T4F9hqHMsepu/2cWUqK/lkdMZ46c/XodkhXqqOE98RlerRjWzPP7A6vXp/WDY=
X-Received: by 2002:a17:906:3154:: with SMTP id
 e20mr2836396eje.171.1593180434332; 
 Fri, 26 Jun 2020 07:07:14 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:07:03 +0100
Message-ID: <CA+XhMqxQ3o_h7_Fwho7gu9x9Pw5jCw=z-goVMyzJgQYqZR-cgA@mail.gmail.com>
Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:56:14 +0000
Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
 failure.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..1d3e4c24e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>

-- 
2.26.0

