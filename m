Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51179C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA0620717
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J74/MtX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54193 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYBas-00078z-BQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:43:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYBa4-0006pk-Pd
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYBa3-0000u0-Td
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:42:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYBa3-0000sy-O0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:42:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so19983059otr.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Bqs/6JZQ2VMQZfbn/Hm0GGVCQE4XtYgUeQQ3q0dslq4=;
	b=J74/MtX3Ie2v94DpsEUc+TefzmsXIPBigCvEkGmUevRrgI9BPWVgyVQfUo6t9itxD5
	YB5c8jis6U3LOxJ9v3J4Bmy41N+igy5N7A/5ynwCnKL1K3yhMsDTTX8n2IY+rX1DF/9Z
	Kd0tg6I/HTp8f7c4A8vqDwRPaxUbnmmffWw8JZ3S2UaDEKzNP/ww3jQi5VyrPXIIYrae
	c9bzTjqo7+E9zvfFj1UE0Anpx9mC9TUcNHxmhwH+yGkM6Lw8GmlgrkuvPa0OrFgfK5Qh
	2ObGnbsKYDuzeSvryQeamo8LStimXINoQSfrRYkTTaurQHZPEAe/lrjEKQgtA5qvwywr
	HucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Bqs/6JZQ2VMQZfbn/Hm0GGVCQE4XtYgUeQQ3q0dslq4=;
	b=rEnrWw91MQezixzOCynS2sVZQv+uDdAY+EYZj/yQK2DMtnZGzT4K0jUON89/KwAAGS
	Selrm8Kwg1OA7t70Rfm5zaPWSvUgpBZMG6TqQHRrzluhiCG8Xnj/wW6bbUIq0m5Cq6Ih
	Dqhqh0IC0+Q6+yJqosPzgI2UkzduovxyBgoyvN90+4U4PHNarJ0cwWWv+pHXON22Xa75
	bqMfb8RpknGGaAzwse6aUKwBRabxZzGnQCjm9EQun2PA7ZfYVDc4UrOSOxQwa6RfCXeT
	Dclvt4tiGqJ8WJx1Jm1gTKNnj3zmNnTaYcvaRKB0ACjBNY+QPJ0vje2A833m3yjSnPaB
	VBqA==
X-Gm-Message-State: APjAAAWIhKIQ51ZjJ9gkq4N5wM4GhtJP9bY2LyxLIumLygw7lew8flz3
	7W0111q1pNj9Gr6I7i/fkn2g053q0rmc/w==
X-Google-Smtp-Source: APXvYqzmvkKYe5tf5Tcssy7BKwJoVjyit7CV7IKeLYBEd35Hra/588972CsZDeQv37iAafkEMHHlnQ==
X-Received: by 2002:a9d:7dd9:: with SMTP id k25mr4460406otn.350.1559662949922; 
	Tue, 04 Jun 2019 08:42:29 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id e4sm6277421oti.64.2019.06.04.08.42.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 08:42:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 10:42:25 -0500
Message-Id: <20190604154225.26992-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH] decodetree: Fix comparison of Field
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo comparing the sign of the field, twice, instead of also comparing
the mask of the field (which itself encodes both position and length).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 81874e22cc..d7a59d63ac 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -184,7 +184,7 @@ class Field:
         return '{0}(insn, {1}, {2})'.format(extr, self.pos, self.len)
 
     def __eq__(self, other):
-        return self.sign == other.sign and self.sign == other.sign
+        return self.sign == other.sign and self.mask == other.mask
 
     def __ne__(self, other):
         return not self.__eq__(other)
-- 
2.17.1


