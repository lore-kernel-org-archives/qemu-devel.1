Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A3C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2D620663
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXrJhk5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8eQ-00058L-SZ
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8No-0002gK-Rd
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nn-0008N0-9V
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so7074098wrl.12
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p9OEtyJxKpCurcZ78tvFjGcFFhrcGCOfm14aEbv8zLg=;
 b=NXrJhk5C5IvU6W5U32laCsg37+2rVuP0dKFXPSn9bNBBEDnsy/x2HQJlsX4v6dfKMx
 DL7FKJjG6tcM12Hyy/ZVdLx69i+1cdPfDBryRcd8TgPG6NSi7LZMLZgBRPs6QaBnydn0
 XqAM8CQ+4qbBQ0p4jpnXwABMuzSOebZZG22Le6vxeKh7DXZnqaVn/5/oJaAWsB9qAkSt
 4iwPZuyzXlJpAx2fj+T/2E3/h4+jYuPZ3Vpuigaece5bTMnGqVm0RJqNhzlrVXRC0HIO
 lIBwJH58Mo0rtce+7U/wN5eUXJV7o23CZ4Sdv7Pf0flIIg7DUCjb6AnTMH8VFlOGrfag
 I3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p9OEtyJxKpCurcZ78tvFjGcFFhrcGCOfm14aEbv8zLg=;
 b=dG+PAg8paMrnXXSz0M17hS7+qgiYdESAKeDGTU5tHIDbyu9Mq8NmABGpwB7DDVhDGX
 AR3ZgsuDvzx+NxJUeFFSxsb0IjAWfdvEgubvPr27IYqyXrLXvYgDPs5sERbDW7vRX9kZ
 PQ65UGKr5p1nqjlOwJivbgYGUQSeGw8AgWP3MYdr7goNM2Lytfc4TJ0/GhZ/BdNgOOHp
 twKsZPPyniPFLhTDKb4+d0Et1mD0RJBF6ECnP80ma4Kcg1K6rrSOEXL8HU+DwAx57ueN
 yD2qLS8AoAZyp1G5b9oi07HDUoEAiKW6CcXh57YeQRaXkF+IWknmqvtnXrd2ke/A7Pdj
 gUjw==
X-Gm-Message-State: AOAM531OHt08bF63+Ao4Dz9PaZpOhgvZAVpBzlaWbrgaaHxqdprLoXZC
 v9AL450oQOty/C/mrF4XQNkJ+7+Ox9wK2Q==
X-Google-Smtp-Source: ABdhPJzXMBtrrj5KBH3NqjSTVRspLKN32CBfRwzgATwaupKbBikQ7UZy7NYzWE+DETeMDxpQS5kskw==
X-Received: by 2002:a05:6000:108a:: with SMTP id
 y10mr7910559wrw.41.1601834713757; 
 Sun, 04 Oct 2020 11:05:13 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 20/21] contrib/gitdm: Add Yandex to the domain map
Date: Sun,  4 Oct 2020 20:04:42 +0200
Message-Id: <20201004180443.2035359-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>,
 Alexey Krasikov <alex-krasikov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Kagan <rvkagan@yandex-team.ru>,
 Anton Kuchin <antonkuchin@yandex-team.ru>,
 Alexey Kirillov <lekiravi@yandex-team.ru>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Alexey Kirillov <lekiravi@yandex-team.ru>
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: Dima Stepanov <dimastep@yandex-team.ru>
Cc: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Cc: Roman Kagan <rvkagan@yandex-team.ru>
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 7170ddea7a..4e6bf16e4e 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -42,3 +42,4 @@ wdc.com         Western Digital
 windriver.com   Wind River
 xilinx.com      Xilinx
 yadro.com       YADRO
+yandex-team.ru  Yandex
-- 
2.26.2


