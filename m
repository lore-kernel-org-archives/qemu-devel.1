Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6702520739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3auPICe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6702520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldY8-00064U-Jq
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWw-000485-E8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:26 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWu-0006St-60
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:26 -0400
Received: by mail-ej1-x641.google.com with SMTP id k11so3719212ejr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BGnnG9Xy3PNvVbxTp72sTTRXPqYJOpLdaAYtg1CD7cQ=;
 b=i3auPICeDDoEZ4FZOmBZxJBrd9eYomLL3m2QlivoaxqV+w/q/d4jLvc5aTpCAgJ1uS
 MKmT2OgHb/OgukZTegxB49/lMExI9c9oovhoE3uSDW8Ye53j7wWI0ZP5gkWEpAFwoIEv
 LHZzsMabFxtUAIwzhdJm2ISIQzgxAlzcMMbJn+0Miru+V5SkeGaoPzCOP6w0yMl9+Rv6
 5Hu948A3BVwUZGbvq7bxG9UgTyYY2KYH+ZvTadcCWwD4eMNVOp3nkep5XYj5geTE+mQb
 FPVEqjKH22yFhU2/tykvBS/Acegfa1wS73HR0c0V4m+6/AXBJc+Rwtqw+3go3mBtLpTl
 KuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BGnnG9Xy3PNvVbxTp72sTTRXPqYJOpLdaAYtg1CD7cQ=;
 b=rmtIYwvCrrcrNP9ecFqMabENs2uCevKuJLHvYIvQKng+cpRx2zLSY6EP4YTfZtjtRz
 TXN+dAdZ/0UOTjgbt8EUMNi8AeD2OVQ+XYgtkV+xq2jVbd6qeDMrxvJO5+c8Sf+vT5FH
 mVN/e46hZ0CK3o1XM26OhR1DYNo3zTyp0dxmYjdeFTZ0DspwwLuTrmCAGbY0EIKaznIl
 AkFeoncDY+k1CCK8CFcD0pNIdfaBx/jiikxf24ztMPjpnyj+ZESqCWY4nPLKQ0GmnSwu
 QwEH5b5lJhfxuaBE7E7nASG2rApu9LZlcHw1P1PfTe5kyb0yoajaAs8WQXefOmUljomY
 tOmg==
X-Gm-Message-State: AOAM530kF5n1w+hRgGRgHJTCSRX3T2GebROeA8sXU2cWftzEYbHjggwO
 P+umixWZJXOG81BLEpiE/czYuOWo
X-Google-Smtp-Source: ABdhPJyJ7z2GQoiaFsH29252NwfGINjmU2Z3dGt85MaVfsqQ9fuW7frWYqwAkw8RLlP5ybWFs9bdXA==
X-Received: by 2002:a17:906:aad8:: with SMTP id
 kt24mr569129ejb.527.1592421322922; 
 Wed, 17 Jun 2020 12:15:22 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 01/15] MAINTAINERS: Cover sh_intc files in the R2D/Shix
 machine sections
Date: Wed, 17 Jun 2020 21:15:05 +0200
Message-Id: <20200617191519.14842-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 81527b94ad added hw/intc/sh_intc.c, but only to the R2D
machine (it is also used by the Shix machine). Complete the
previous commit by adding the header to the R2D section, and
both source + header to the Shix section.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..67c495e841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1261,12 +1261,15 @@ S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh_intc.h
 
 Shix
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/sh4/shix.c
+F: hw/intc/sh_intc.c
+F: include/hw/sh4/sh_intc.h
 
 SPARC Machines
 --------------
-- 
2.21.3


