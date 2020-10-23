Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1CC2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiDTN906"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwKz-0003D7-Ov
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwFS-0005Uw-Ka; Fri, 23 Oct 2020 08:32:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwFR-00033p-1s; Fri, 23 Oct 2020 08:32:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id j18so1145824pfa.0;
 Fri, 23 Oct 2020 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sPIubaKDXBZyfP5/7ULBVygvzUJbLkV4DcGzF/tKnNk=;
 b=RiDTN9064xAWIcAQBAIiAGN1Xv1ZJur21GPNk/Fhdrt87Z5b3DrXvp8Z/+Ci6GVfLR
 t9OjlShAsWIlE2lT+6wR4tbqXEtNOyIbY9xATrCNxN1QSrPof0Nlbx5IPIaNelHkMr5v
 Ewyt3sakLU6UmEjkTpLZXbiMa+IUe3lP1M07UXgxGYwkh7QFMDQOLMIkg29kFuZ1Firs
 3Jj7P74pQ0lLQG0dcsLOV9JPUIISyaG8pHamTTKIRXGVL2LBgdP4MikZz8mnEO+CCFuG
 DvDLcNquzcJaHC828lMZ7+DWPQO/gFZZCzRnN6ERWGJC1kPQl7JNesg3LyLgVGsz6zZG
 aasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sPIubaKDXBZyfP5/7ULBVygvzUJbLkV4DcGzF/tKnNk=;
 b=dvRLoVtypNXpJRfWQsSgcK8j2H9btp2FI21azvSWmRaP0a6IsE6hemcgCy3ej1Bn9b
 H+zU5QLGkzxznu8iD7Do6nbCcWpVYMTHnBhkVEgdLT61E8WPtuNdiqTZ5C3+gc6+5e2U
 ehXufIm5c5Cim3V8c8O3FGLkjnlK7LDrdBfWgBsHTrtAnBjLtOCeBgB54GKJVXRBgplh
 sXQ4sn/TLQ/Or6TVrK7xUGEKx3Ey2P0B+83CpLiVzuNMOof2ktxhPtzaxKEARhlg+vwZ
 V8ZlZr5nJmPiIUNDyM1/sNgMLZlZZR89q4ejCZaaNsIQZRm/s/RfDuyx77CV4sw66PEO
 gIXQ==
X-Gm-Message-State: AOAM532blFMhWLTdAacgyugIq5K/PLMg7Ppdq7PVKoVEhMufqW0spba3
 K6sG0D6DWvvPWc266d6martbZzw+qTeTv5y7
X-Google-Smtp-Source: ABdhPJzAjyDcjIcpAWDPJNqKmjZlsG7wIouwOmbu1eABuc/W6im9Y6IYJ97xTk8DtUH6UaLZPSFQbw==
X-Received: by 2002:a63:541a:: with SMTP id i26mr1889571pgb.117.1603456363064; 
 Fri, 23 Oct 2020 05:32:43 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id n6sm2280197pjo.31.2020.10.23.05.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:32:42 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 20/30] migration: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:31:30 +0000
Message-Id: <20201023123130.19656-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Chetan Pant <chetan4windows@gmail.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 migration/tls.c | 2 +-
 migration/tls.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/tls.c b/migration/tls.c
index 66c6f43..abb149d 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/migration/tls.h b/migration/tls.h
index 0cfbe36..de4fe2c 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


