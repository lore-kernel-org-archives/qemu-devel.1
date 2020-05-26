Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E102204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnL9ngTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E102204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddMi-0004df-8r
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJe-0006Zb-Sm; Tue, 26 May 2020 13:24:38 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:41912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJe-0004ND-4b; Tue, 26 May 2020 13:24:38 -0400
Received: by mail-ej1-x641.google.com with SMTP id x1so24673275ejd.8;
 Tue, 26 May 2020 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nzoy1AWlTOTo2Vla8z7lKUcDunyptX3S9k4CBZFpAHk=;
 b=nnL9ngTs6y+idNtc7cuTjI9ljzVR2ApgvxutfqI/6bBIhbOwxevqwNoN6EphiHe8pj
 bPJADMFZMlswDN/JDeoZTkYAlMwotxA04+SgM4C5axa69kI4w/D+5av0YfSUdgjQJFac
 dPpUTIpebKAxR8s1UsbgOEn997KcaDntXik3lNFQ7QCtTH9qIZfH3sBdQSRqjNgXr3yS
 943vnvdrmlaaRvPu8IujyRN1jqbiPzDICrvwmbVDNbjQ5a9Z52woF4ZjZAGTr6l4Y7Ya
 FIKBX2pSHDFbkw1HPEb/Uaevr8trFo1WlLLkCxSckD7zslgbn6w5bnhxgv8VYDS1DZTh
 5kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nzoy1AWlTOTo2Vla8z7lKUcDunyptX3S9k4CBZFpAHk=;
 b=d03aiKDT+KRZulQKlboSN6vpyyusXdQWrdukSIJJW9dYwrPDX8cHc+OMqNpA61RmXE
 E5Ql/FaOdWVVt/UFaAaeUfhSrVs/92OXzwZ22P44ns4uN44ZNZ2Eu0F4rujvBpYk8Erq
 oCR19RsD8bCi3ZsLJmrbusdeVf/xGsTiEgLo/Y7SHEiQGUpJ7+CfLSrmVSd5o3Oxg+V6
 LiclmmIsi8LZyPj8oU/I7k9m7eBvnNiXafijogso7pQwj1+nuz3YqOxJRN1dbmeCorO/
 FATUtYsf4aJskAl2+Xd1h1m5ljkM3pNgU4RpZldr6GTXauLlN9NIOCtd9aWHXBQVC1y+
 B6sA==
X-Gm-Message-State: AOAM532p7opN3Bdm8AYag+aijtvYI6w4Yn/IQiUgNb7LYdLqD3Pg90us
 OHYCUKHTxCTvS2LZnnPhBiEzvgN4SJE=
X-Google-Smtp-Source: ABdhPJycANe7Wy6qzm4YTlQoJ6T4Ej8ZDStbCnFv3eXvHVa/T3usj/YjXbveJ1ln7d282lq7FB6Nqg==
X-Received: by 2002:a17:906:5e08:: with SMTP id
 n8mr2080984eju.132.1590513874770; 
 Tue, 26 May 2020 10:24:34 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] sysemu/hvf: Only declare hvf_allowed when HVF is
 available
Date: Tue, 26 May 2020 19:24:23 +0200
Message-Id: <20200526172427.17460-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When HVF is not available, the hvf_allowed variable does not exist.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Fixed typo s/tcg_allowed/hvf_allowed/ (Edgar)
---
 include/sysemu/hvf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d211e808e9..fe95743124 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -18,7 +18,6 @@
 #include "exec/memory.h"
 #include "sysemu/accel.h"
 
-extern bool hvf_allowed;
 #ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
@@ -26,11 +25,12 @@ extern bool hvf_allowed;
 #include "target/i386/cpu.h"
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
+extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else
+#else /* !CONFIG_HVF */
 #define hvf_enabled() 0
 #define hvf_get_supported_cpuid(func, idx, reg) 0
-#endif
+#endif /* !CONFIG_HVF */
 
 /* hvf_slot flags */
 #define HVF_SLOT_LOG (1 << 0)
-- 
2.21.3


