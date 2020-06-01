Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCDE207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeXAw86m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCDE207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflcj-0007pC-FY
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRj-0002dS-8m; Mon, 01 Jun 2020 10:29:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRi-0002dB-F8; Mon, 01 Jun 2020 10:29:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id t18so52114wru.6;
 Mon, 01 Jun 2020 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SXUn2QQFzfY6E+figfmQGRv5xI8cdi2Y+xrdtsaM+Sw=;
 b=MeXAw86ml412WTe/fsbzOJTWxjk+Rldv3qgzlTd0jJQsOtea9XegxhBH/8V5pQOVnP
 fXogzJSZ+hjZIrhND/m9A/vKYTfmeAue9Qox3ZjWrudLmjNTRT6YUl7fSOC4OPEIlXJx
 RDxRfuk+01gSofzmvWqhy4bmcEJtYSyOoEDLf9Vz3tGnb4sbwtp/IvgM0YmiX9BnMdy+
 m3rwE3Ca/xJv9Yp5SGAtoLPnH78Dt0QnoGznahyxH5L6k+XnfS/yXI1RBRVSkde7GJaA
 PWlTD9aL49q5TbVDMJrh3zuTWmQZ57Gq2f36LyP3VNPOpbvIdY6Grm5OwshvQp3Xu/wS
 nDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SXUn2QQFzfY6E+figfmQGRv5xI8cdi2Y+xrdtsaM+Sw=;
 b=o1lvAHGXI/KlN6lJg4Wo5aCt80igXiMp90Yoz1AAn01plAnwL4eWoiPR3plAmw069g
 SudOd/k0XynBfNyrl0ySFAWHekNIR39jva2h6+8N9ZY6xU8ERkf+1hpywvG9SIkWBFe+
 4P26weToUpcGMUyOQjHhHRBSTHy0vd1Brhk0c2yUngNyD3w6AW1pnFfTURQgVLxgK9ja
 60U/KXCt8z+RTy9U6P08Lb2No4Is/60j9n1vULQh1SG7DoxIruzMptFuS4e2TbfNFrKF
 gDN0zYTEo6WKXZOCGe5gpxdJt05jGZkzONnyxItcXiE46ToYhXVH33KQapmFy+3wBukU
 dNbg==
X-Gm-Message-State: AOAM531+Swbmundp9XEzSJLq/5zkcyL2rc4Rl9Sdh9rhKbMhChARw52Y
 2Ite7MNMxoDAievtgkoFBMyw0+RR
X-Google-Smtp-Source: ABdhPJxGfoEw6g2vJ9OfpCjaYwWCmMl8Ah+Lnpp6R9LdwbX3+s5BYxOV3Vc5ZpcNzQGowCfzq7ym7w==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr21567252wrr.282.1591021783964; 
 Mon, 01 Jun 2020 07:29:43 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id u12sm6824954wrq.90.2020.06.01.07.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:29:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
Date: Mon,  1 Jun 2020 16:29:29 +0200
Message-Id: <20200601142930.29408-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601142930.29408-1-f4bug@amsat.org>
References: <20200601142930.29408-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/xen/xen-hvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 82ece6b9e7..94fe5d65e9 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 
 #include "cpu.h"
 #include "hw/pci/pci.h"
@@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
          * Xen does not allocate the memory continuously, it keeps a
          * hole of the size computed above or passed in.
          */
-        block_len = (1ULL << 32) + x86ms->above_4g_mem_size;
+        block_len = (4 * GiB) + x86ms->above_4g_mem_size;
     }
     memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
-- 
2.21.3


