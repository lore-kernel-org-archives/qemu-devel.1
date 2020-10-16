Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3A820874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfCZ0sO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3A820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQzp-0002Be-MY
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kTQxu-0000x9-BE; Fri, 16 Oct 2020 10:44:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kTQxs-0002FJ-NI; Fri, 16 Oct 2020 10:44:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id o9so1391387plx.10;
 Fri, 16 Oct 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CDzdx/1UJfogJTVpgLESFHJ5lcap1Y1F89XQnkxTn4o=;
 b=NfCZ0sO7SIdOtubWPfSSWqmNvROfU+9/NF5PgAPOPArT8/b7ilITW1DHZ0+GRVvODC
 QiwbvLrBHENZ3uEcg8o8r2oPNwMGf9MeIe5KceYvDVCQv3bQm9zOn5sbS4ZRVRrroBKs
 cXzeNy4PG1PUBCqhZb1npzIYnI/jQsauP3kNDNmCVculLNtAUWPfMicJOFFYZysNXwqV
 gaHdNT60+Posxovt9ZnxPWpEAJJpFsn+/1RLnHdvPISTzdEgfMCERu4kAJRn4inEgkRh
 NjGeQ/sowh0tLQyVVh0EHhI2TG9fAazyBgerim50SlD92kvppm99Puqp6b2PrG5kgDV8
 h7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CDzdx/1UJfogJTVpgLESFHJ5lcap1Y1F89XQnkxTn4o=;
 b=qV1m7CtgxebObPZBr799hxREzcnEfNufKz2sfkrKiU7SSMkEsDhaMxxwKQUHmzQpQL
 9C1Xmp+oNLwTh6fr/wFgAlJTx3Q54iv47LIXxY4rsw03hz2bsMckHxPPIuPtVKlV5/0c
 GxGYnvMFRY0b4yYIy0pxzcCjmzp26Uj1fJ6/fCtNGw3VTwAz4eTzHnK53iiUOnyp1SrL
 wxmx9pRkqSBEI+o4K/vAVf6iIRG5CRffZUxOGWW7gC+HvH85SaPrLPm/JAhG1TaKdXzG
 IXM8UXYIiyyy3gREtSHOw/WKqA8u7eaSbM0K86GqLN5fvil4W84siTsJZlRuffBokqKp
 S+0w==
X-Gm-Message-State: AOAM530WUmu7liPMS43onHAhwlYsbOa7Lp+yeBO5R4AHx9F6xx4P4WCs
 wPZOqF6GQAYNGRcovVbSyOAmgD2XJmX8RE++
X-Google-Smtp-Source: ABdhPJxwSV1Qg5FoAg85UxUTHmtan3oGVDfx11H4IKV6oCSosDvLyG21QnasInobH8MDnA3ykB5y8w==
X-Received: by 2002:a17:902:7794:b029:d5:ced2:cc20 with SMTP id
 o20-20020a1709027794b02900d5ced2cc20mr377030pll.25.1602859454866; 
 Fri, 16 Oct 2020 07:44:14 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id j8sm3226521pfr.121.2020.10.16.07.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 07:44:14 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 6/30] semihosting: Fix Lesser GPL version number
Date: Fri, 16 Oct 2020 14:42:43 +0000
Message-Id: <20201016144243.26817-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201016143509.26692-1-chetan4windows@gmail.com>
References: <20201016143509.26692-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x642.google.com
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 include/hw/semihosting/semihost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/semihost.h
index b8ce511..0c55ade 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
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


