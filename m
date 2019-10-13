Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5682C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D6F20673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZ8KyX3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmLB-0008Jp-IE
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJE-0006Y7-65
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJD-0000pY-8f
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:40899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJD-0000pH-34
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id d22so7128579pll.7
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sg+1BNlUkd68yFef7dmXTKIYOAnPSKke44HmN/xx+JE=;
 b=YZ8KyX3n98lPMRNNLxxbBPtqyQL+1RcyxjRf5ebHPt72kCDP9DJtVKJavJ5IbNwa8K
 l1ou1neAD1J/+JgaxgefntvOnjbt2vNEEZ4LxQW8CXzLozaAupm2gVx4M/FUtov6fZfI
 HeCSm8yjIf5pKayh4AFiC+KmvrEZCP1qCdzmPuTYKfHl30mmb2GMUtqC3VvMm17YDBS5
 NHAhPnAzCgGVeGLrjbxWN4G5s9O8Twkh26N9sWBsGHRtqHNJW8UYuJEw3TRQzRoEOpMT
 +Os8j7p0Fstwn3auy8jY8ou1p186LHNYgwJg7e+wbHhIl/yFuRqoRooh9oN0Z2n+LWVx
 ccXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Sg+1BNlUkd68yFef7dmXTKIYOAnPSKke44HmN/xx+JE=;
 b=RQAYr1hewqjAt0+qfKOJkJ3cjBl23pA5clUkY0JtKNDWPKZDQGQ8hnJ5kLOcP9EBv0
 sZI72VxNoNdxjI2m+dbXbBh0QIxyYnCYZM6p9s6uG6tWO9VjdPP8Ka/2gf7XHJyL/gbK
 +Xr8o8u/hdZPdwfbvnCe5LtSGjllGFPtVquIlII0RDfv3jBRcc5qes1u+5L1gISq2sJh
 S0rVjXh5MN4QnvbaOgHj356DgwUVndBfsih/8LGWGm5y1RPS0VAJ2TVCmBPr0bLW/F/F
 /EcPXqk1jgSPLXMGWMC502+TzLhUcwImu/TYy2sBkMZxeBowOJNlGxK/yI2Yn2DjBZ89
 AnxA==
X-Gm-Message-State: APjAAAVRZoKXbjgVCdjlD3EBlVf09uJ2PyOWNeQ+zDoASlfp0a/lLey9
 tf7WeAABOjW1gNOEbReR9ibvJATFf4k=
X-Google-Smtp-Source: APXvYqxT0jyAUdpBLWRRKQl6FWsqo3B9nVCW+zXTFI+ebzNXOeCKpcSTG6sK3orJr5ucNBAfnah65Q==
X-Received: by 2002:a17:902:6b02:: with SMTP id
 o2mr27028052plk.302.1571005549768; 
 Sun, 13 Oct 2019 15:25:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] tcg/ppc: Introduce macro VX4()
Date: Sun, 13 Oct 2019 15:25:23 -0700
Message-Id: <20191013222544.3679-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::631
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce macro VX4() used for encoding Altivec instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 9d678c3bf1..8dc5455600 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -319,6 +319,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XO31(opc) (OPCD(31)|((opc)<<1))
 #define XO58(opc) (OPCD(58)|(opc))
 #define XO62(opc) (OPCD(62)|(opc))
+#define VX4(opc)  (OPCD(4)|(opc))
 
 #define B      OPCD( 18)
 #define BC     OPCD( 16)
-- 
2.17.1


