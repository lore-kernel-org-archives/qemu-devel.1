Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C234C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414422075E
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALANuYbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYkH7-0002ul-Cq
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 00:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3V-00042X-67
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3U-0007gV-82
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iYk3U-0007g6-2R
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id 4so10068380wro.7
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 21:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RoDkq87PVBTW9aFVtZ0L8lH/ywykSKiy6WnoU09+ajM=;
 b=ALANuYbvZlZQo1eauLNGljnP8/eV+58YkOMfqPgXh5av/L/MC8Qx/ry9SAEvKYKzwZ
 oOdFJ3N/sB1QfTGoYJxEDVy4XMPJROqazDZaTtdyUYF2mf88AEaonTAM02BkHVtyBW/L
 HxvDgRO69XZq2iNrI/31Cjl+FQgUDQYtB68qzGJtv9dkvNSFHyP9c4JtS/iLphRTmiDP
 3zX3EJ2o5sCaznPvMg2aO9VJhMWGVW8B3qoc4TdXv/Af0c8WsfATrR5LdHJmJtzCJbwS
 /hK7aQQr0Vz16D+isbCA2uAYI7GxfSLwgK++B8iuS9Zl/UTuK3HjVZqU7W7E8g/uwTzD
 gACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RoDkq87PVBTW9aFVtZ0L8lH/ywykSKiy6WnoU09+ajM=;
 b=UI+9n3yBff8exaT8AQwnRuTveDRAM1PngRmE4l+MZqxHVmefl5zAPWAfeliCE+ZgTt
 Q4IHBtErMHi2hDI7l3mEeriDgz3jtTngo5oxSSW28c2uLf019MM9zXcFMRXr9C4JgM80
 qOBP5CSSAZQbmfBU70UwUvkoPM4s9mJM0D+qGT5Z0DD2QoJs8G63Gs66UPCDNLXOtgG4
 BqKgpLUCoHP5S5tvsuKLx1sJ4luGbZJgswkoc8fIwArH8njvJjTLtnY+bccqlLBH3OyM
 vIPdHaGX7CngTlKInYkCQ+USpVFFQ+l6NuBVKUFYXkSXcmcmclZxcwmjN2m6LNAwVnA6
 4DYw==
X-Gm-Message-State: APjAAAUmy3DHDs6s9akN7jlDzwuOH64lyUZxk7BCPn2vLLa2VEQCvQX9
 icxJDfVUmcZTBUcCXTTAaoHWa3Ga0OZuiAKP
X-Google-Smtp-Source: APXvYqzqSbQOrzRYFUqBuLg9NDeIM6N2JoxON/dlkALDou/Ote96qeFAXFWnPw97K+u0mS9XdQPK5Q==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr16992272wru.220.1574571806840; 
 Sat, 23 Nov 2019 21:03:26 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-10-38.red.bezeqint.net. [79.178.10.38])
 by smtp.gmail.com with ESMTPSA id t185sm4173976wmf.45.2019.11.23.21.03.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 23 Nov 2019 21:03:26 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
Date: Sun, 24 Nov 2019 07:02:25 +0200
Message-Id: <20191124050225.30351-18-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191124050225.30351-1-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include AVR maintaners in MAINTAINERS file

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..ad2d9dd04a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,15 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target/avr/
+F: hw/misc/avr_mask.c
+F: hw/char/avr_usart.c
+F: hw/timer/avr_timer16.c
+F: hw/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.17.2 (Apple Git-113)


