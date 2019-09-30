Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F5AC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BDF22501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7wTKz4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BDF22501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Co-00065j-Qs
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Al-0004So-SQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ak-0005WV-V0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:34003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Ak-0005WD-Pl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:30 -0400
Received: by mail-pf1-x429.google.com with SMTP id b128so6246246pfa.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sg+1BNlUkd68yFef7dmXTKIYOAnPSKke44HmN/xx+JE=;
 b=A7wTKz4tl834f4hFOk1ubqMUF86wjT2ZJQ0ZYUpwo83HXup3na1a16G4SqKHdMdnGr
 EvaCl+o3KCGuKSnJlq7RNuipIbxNcgyoFL2iUPi1PWGjY6xcZlQfttOQTfi7LA0TqyU5
 qiI90S7yNpLgBsgJtjIMz+pU6IR777kCC5PRvItN2Wg1Hih3aVv4778Y4cKGiihwwvj/
 Q9+B1wNCXFd9N1RVXDvXiVzuLETQl8aq6BxfHn6f9bxk5q3FA5KVKMEL3e4WNfdV002c
 OwxA/ibcgvOiSTHGXXihrEvHRG8SQ6+5BWWMYhf150Jn/HuCIHGakNL+ZID0nCzcfnTg
 MqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Sg+1BNlUkd68yFef7dmXTKIYOAnPSKke44HmN/xx+JE=;
 b=E1cyz9NUKA1KSSCW5yjbdvq1Li0uzRwT1e7cMjMtuogaGvsz7418mOzLXaBjCzQmJG
 9YtyYtNsPuWOv3vZbdJ7i+xtKFXouBPmMyxVK42SJch0V3pyxWUbOVNpSN9Vr4N5lpNk
 4JLKZ8se+Oa0DXCAp+OCgh9pF/Ck7lxh4Qc+VBIdbmGSzjsQuwZJ/xdRjDsOPRadiPw2
 4KlbKKU8F60IQejbRUU8dijiTJKjOnJyuURcTfTjbRKWT6b+ktWL6e4c4IwpjGhFh3DS
 eXvvnyWphgDJtcvKDsEzLXcikHDbA1WFnYLMye9VT8ffX510J7lZ8ytHoxPXYgwlU1TH
 /3ew==
X-Gm-Message-State: APjAAAW/ilrUYSbqQaE6vu2GN4cGrvrTOG/CGaUSCJoDdJnst49XgFpj
 Dz4+/MA9NfF7xQNlfxUCwDbWlqUjdR4=
X-Google-Smtp-Source: APXvYqx1gmmv76p0r+gt3gWTbqiZTplCVCKMKRIf7HmYMlkGgIsoNPLP0/1iamTK8XCP03lSIGil2Q==
X-Received: by 2002:a62:870a:: with SMTP id i10mr23240492pfe.259.1569874889503; 
 Mon, 30 Sep 2019 13:21:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/22] tcg/ppc: Introduce macro VX4()
Date: Mon, 30 Sep 2019 13:21:05 -0700
Message-Id: <20190930202125.21064-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
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


