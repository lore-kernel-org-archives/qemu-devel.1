Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32A620724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwxPg0iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32A620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFQY-0007nQ-S9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCZ-0003Wy-DZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCY-0002cC-Fa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCY-0002XW-96
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id f3so19592646wrw.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sjkBQghb6dsOn8Obc8m8iZPN9+qM1PmqISTfmTmQMJM=;
 b=YwxPg0iHsCSPaktGuzy8ylRnnQUt3CH0dXDHXHjuLRbkmSWNDVTyATTcl5UpbYp6N7
 OCtDHSZHMZLxVGbII/g0jBz8CHS0tnYCNRwv3TKEdQMAGrasO5naUJNOaqwIEvM4xPKI
 kNXGTrOIM2DJYg6gHTcR/w0p6+Kxspw+uzgk9SJasK1sv/gliqpfMXDQA+edb9XF6SUI
 OU9ZrAPaJsK+4ta+TT6A+UsMbX4CbNTC+JB0pppUL0Iso3Qnma71E3LEN+jEmoUpsvD9
 guOsRmCpEZLS2ggCEfCuvbhs3R29DU6CvrOGQT+HTupsXe2gVkwgUrM+W9Gsn0bsLF0J
 AD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sjkBQghb6dsOn8Obc8m8iZPN9+qM1PmqISTfmTmQMJM=;
 b=VcujB3N/iFB6vl4RP0VtMmXVNiupZ+Udr7taLWvKI6yDQHUWd8m2Is8GIfEwfmoXm/
 rfPqjX3jMz+ruSNeKa+hDWFPOBoCGszjvJqvs8da7EKC8tSlwFdyDPX2X0UrqyBwxsxB
 BaRQiAe27a7uqqU8BxFOodYxu2Ai7jLhAsMAdRY+yV4CKtlNJXVJR3YS80XNgcYdC4tq
 /cPUz0YgUSM3nqiUYjGDZqYvruEmIChIqqo8S7IaIomQd6lSBUFP1vdtTkZnZbvqJ7Gc
 yf9Wm8xmhsLDVHvNs1y8XoHdUyAjKyGPgcEBYBYsbZipZCg8aNytB+cYi4fcESOg4/0m
 BH7g==
X-Gm-Message-State: ANhLgQ2HQEBVdXD9IqDoi70FM2QRPXC9YUfzw/dVDXvfrj8gw2l458nn
 4JvI3ClWpBHmvk70RJJul4CQM3DM
X-Google-Smtp-Source: ADFU+vt1kb+mvLjU9MyOiu/k6dNA3MohKQtf/Fly/dw/SBdGtR8qUOo69BcgMOKlfKmLSrZ0D4fWrA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr7084621wrv.104.1584462980975; 
 Tue, 17 Mar 2020 09:36:20 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] MAINTAINERS: Add entry for the Renesas RX architecture
Date: Tue, 17 Mar 2020 17:36:05 +0100
Message-Id: <20200317163616.30027-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-2-ysato@users.sourceforge.jp>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..3463533aee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -276,6 +276,11 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RENESAS RX CPUs
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+
 S390 TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
-- 
2.21.1


