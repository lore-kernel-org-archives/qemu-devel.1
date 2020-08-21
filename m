Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D214120855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFJCEte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D214120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AxT-0005AS-UY
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar7-0001MO-Mq; Fri, 21 Aug 2020 13:29:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar6-0001Ao-02; Fri, 21 Aug 2020 13:29:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so2641302wmi.2;
 Fri, 21 Aug 2020 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2uqKLIwnsolMGUBAKKhtdES03ym0NQX3Xf3uXXgGuNI=;
 b=GOFJCEte6vgw1DpRYWrf+Q0HHyQ6jO6cdeleJDLpiiak/0YzCONV0KKBNnURzWG8fQ
 Noa1jHIdqpTidGIrnVlHoS+AxzTt7HWna4Mp7/bHy27Z0rZ/Wq+3NdFXWUtOMDXIVqay
 RJ9sMD5FQ1lIdBFC6Vuy4rQVkfx43hWUxnZUMiz0NR9bWYv55JXYYPSoMJujEuu8L0yu
 eGX+MeJ3dsymOQRTyNySkvi4Iy1FZDZQe+mkRl3OtjtqjteEkZEInHN9XN2eVvDOmELB
 iu8M7ZsBpLQ3q3lHtnU8Sh9pdKlaVbnl/cPwSTGOK7KyASmv1QWx+zCU6e0QlV/IksAM
 JfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2uqKLIwnsolMGUBAKKhtdES03ym0NQX3Xf3uXXgGuNI=;
 b=lSJeGsRFVadnf3H2L1ZB0zxcD/w8uu5bVvb03Y5fj1uYtmSEmfuHoPaUrVW/ECCtXQ
 TqOTdUoYbiGS3orI4aCYO/9NW9FkR2QTc2G9Id8JOijKhzIb9us9ZbD5g7FpJkDWGvNo
 4i6isE2qzpprD8RLNftT0ThNS05NXBl/phopiRz5s+hnJFoXERt3HutWpLk6lwmdR4vX
 JOpnE5bENWHzU+6HHjaG5Fnqfy5gLML2uEr6it/m32vj2hdlLXmrZQ5zN+9co1Nxbbsh
 E9UDxJ8tv/BWFgE0oza4+KdHeohxgJzB9/+TrlJanLH8fdS9hOisL3NKYzdWcQALqjbr
 YUUQ==
X-Gm-Message-State: AOAM533eKjun2ctbFAEX0gtSDJk8jIySuO6rQw7WS4vB4TYHzUsK9BRH
 3vIG+/9IhsNGm7FMjC7FGXxI2BQDc5Q=
X-Google-Smtp-Source: ABdhPJw8bSU0cDBYdXqx/w2ehEAFcH9OK9YmzU55s8zc4gGZ4LsyDpqb9+azdLjq7uzK77ZngB1fYA==
X-Received: by 2002:a7b:cf22:: with SMTP id m2mr5009939wmg.46.1598030969538;
 Fri, 21 Aug 2020 10:29:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] hw/sd/pl181: Rename pl181_send_command() as
 pl181_do_command()
Date: Fri, 21 Aug 2020 19:29:00 +0200
Message-Id: <20200821172916.1260954-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pl181_send_command() do a bus transaction (send or receive),
rename it as pl181_do_command().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705204630.4133-3-f4bug@amsat.org>
---
 hw/sd/pl181.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 649386ec3d1..3fc2cdd71a1 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -173,7 +173,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     return value;
 }
 
-static void pl181_send_command(PL181State *s)
+static void pl181_do_command(PL181State *s)
 {
     SDRequest request;
     uint8_t response[16];
@@ -402,7 +402,7 @@ static void pl181_write(void *opaque, hwaddr offset,
                 qemu_log_mask(LOG_UNIMP,
                               "pl181: Pending commands not implemented\n");
             } else {
-                pl181_send_command(s);
+                pl181_do_command(s);
                 pl181_fifo_run(s);
             }
             /* The command has completed one way or the other.  */
-- 
2.26.2


