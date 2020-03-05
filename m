Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B880C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD7620870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sieT12oT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD7620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9trN-0002WJ-T2
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPK-0003ja-Gk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPI-0002i8-Eu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPI-0002gA-8I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id g83so6438357wme.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RzB+Z8qRSlkYR5jjZd32X9gmPCCsZy1SF2ry7LYaxxA=;
 b=sieT12oT/MSYkcgdUn6h82ekgTnC1A9e6Lk09FTx6Kj7HLqB63dTaztX4YBwVJb5Os
 W28nJPVoHsbdHSU3nQ8UE2gaxTCtKoIjDUYPPQlIQIzpA1kEtwDT/73m8kl96fwKHxiL
 m08UoAuvBlzd+/C7V+gKKjAxvXInCndcObHhT7FQPmJJTrnV4iG3lQnrWkcNkdEGdv8x
 VZ6RVCq7KqKBa2yI+x1HpkKJ8v36D2OclsjPzYWRhknnQWxKdDJdSd4zjbQQXxyJ5DDP
 MDlEge3DIaRY0+iM5JJaTCWKuKes0HahpIJdZsDEtsILjyJwz6H8oQn7F6rL1x85wcmQ
 nz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RzB+Z8qRSlkYR5jjZd32X9gmPCCsZy1SF2ry7LYaxxA=;
 b=iG3YPTwzqiblTc3vIDvI+CAEb8faLwYIDKA1VnCzeoXY5rzM7IPWvV/Q6Uaifxx8D6
 piXxE2fcQeUWlxs8DzkcHQ7n03szHJz9sZ43eZjb5weltCMAavXgt0MO3NhFn1F9auvs
 zwvmWq9wtYSjkhs7z8RQm+0OcwxsOuHONsCtR0XPMDCgKWPsuA2mA/z8GFZ7KAwjST04
 OuCkO1Ig/66D4q+H6EvYvWha26ldpSDfDkGxemwr9qeaypGIcCWeIy/B+zeOG28FedaF
 mV3J89snWiBVJJXtxpqauXe1pkdp3LXBZ9r5TfqRB6iL3CP21gLiJdc7KfwAejWQwAyW
 7SjA==
X-Gm-Message-State: ANhLgQ1lLqI64t97OWAr5DyT9gjt6BI8pwA/zfRvYNjGCM2JLFVcN4ZE
 zOcnUwqOLebBkY5ybxtZiO53OQjlghj3Rw==
X-Google-Smtp-Source: ADFU+vs7ghi3pmrkjdUrz958wCE5MDbcdQpb3rnBgkTaaQ1O05hIjX5bAYbDh0tbt84rGRyUIjamfQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr9925271wmg.136.1583425890998; 
 Thu, 05 Mar 2020 08:31:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] tests/tcg/aarch64: Add newline in pauth-1 printf
Date: Thu,  5 Mar 2020 16:30:49 +0000
Message-Id: <20200305163100.22912-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

From: Richard Henderson <richard.henderson@linaro.org>

Make the output just a bit prettier when running by hand.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-13-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/pauth-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
index ea0984ea823..d3878cbeb6e 100644
--- a/tests/tcg/aarch64/pauth-1.c
+++ b/tests/tcg/aarch64/pauth-1.c
@@ -29,7 +29,7 @@ int main()
     }
 
     perc = (float) count / (float) (TESTS * 2);
-    printf("Ptr Check: %0.2f%%", perc * 100.0);
+    printf("Ptr Check: %0.2f%%\n", perc * 100.0);
     assert(perc > 0.95);
     return 0;
 }
-- 
2.20.1


