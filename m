Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D695BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7397C206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d96Oz6Hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7397C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpZn-0004AI-Hr
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUU-0005iF-0t
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUR-0003zk-Sz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so2958268wmq.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3VDR/9d2hzi8lxo3Nu2LpF4CoSrWU5Yw/0MhLqY02Q=;
 b=d96Oz6Hn25AF565foWMMNtgALM3AMe9NEyYb4z6KGSKlbZQmkfwbiYvwEMppPngfhm
 VGVG5u5G4HJtIrhmDWkFc5Qjw3VK/J9MFOXR3qAD+MgXvE/cXtg14U/FyjClel06rKmw
 iheeS65m0mK++q0BnsOFKqYVoK/+C3R01Rg0Gz9UZANGH6YSrAovjFHjGRoPEqhx4L4A
 5MWVNtrAxVIvd98PFmBms0iZw7A9YKGh+ey2K4ZlucrILADxeBDkEX+m54n5b8zjLFWU
 UOF4DUi0if6TbJio7C/Pasuyo7+SRuC9q0ljnkGZIQfJh4uA0japaHKSv5ZWAIyBc/nN
 vZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D3VDR/9d2hzi8lxo3Nu2LpF4CoSrWU5Yw/0MhLqY02Q=;
 b=GPVDUHq2/hGkMeuUudTMq+uMhjEF9ly6u7XM3diTAIjUag5SDlJzATfCy4T+fmCHNE
 TH0miED1dmzJf7vT6ELLJsL0F2yoVooD5MKKutG8eVgrYVZLEe69KaW8B/l87nNlZnX9
 7T+pjhwQMzqt5gnQyEvH64IfbXaxGnx/66/CL/3jh07t2YncjTsApQVgKvSNYV7af4Yc
 X7soEC/5ckTOBTLlRx3Db1yqFPl6xvXCRjWEG67P6As+f0EBETPQec7797c90ixoN+nK
 s6a2uCSnGhQ4vyX/ZT6YoA75ZSGgrj3R5tU6psGFKb/Cb/0pdrVIHzPfsEOu3mrj6Czz
 CTcQ==
X-Gm-Message-State: AOAM530tMKso09C+oSiNFKRGEoeYMEdRbF7UFVUi3BZ5TEzxOM78/Ymu
 LrkHZvVOQw1Qw0pnAnl5weI=
X-Google-Smtp-Source: ABdhPJxc/er874MHOAjy0K3Vfpu2KRaGXxVruOaTo4ADV/9xVyqwc6PXUSvattEpuB9Y0LSyTCu5bw==
X-Received: by 2002:a1c:417:: with SMTP id 23mr5515858wme.1.1602000417968;
 Tue, 06 Oct 2020 09:06:57 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 02/12] contrib/gitdm: Add more individual contributors
Date: Tue,  6 Oct 2020 18:06:43 +0200
Message-Id: <20201006160653.2391972-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 David Carlier <devnexen@gmail.com>, Finn Thain <fthain@telegraphics.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These individual contributors have a number of contributions,
add them to the 'individual' group map.

Acked-by: Helge Deller <deller@gmx.de>
Acked-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Acked-by: David Carlier <devnexen@gmail.com>
Acked-by: Paul Zimmerman <pauldzim@gmail.com>
Acked-by: Volker Rümelin <vr_qemu@t-online.de>
Acked-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/group-map-individuals | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index cf8a2ce367..641169fa63 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -16,3 +16,10 @@ aurelien@aurel32.net
 balaton@eik.bme.hu
 e.emanuelegiuseppe@gmail.com
 andrew.smirnov@gmail.com
+sw@weilnetz.de
+deller@gmx.de
+fthain@telegraphics.com.au
+vr_qemu@t-online.de
+nieklinnenbank@gmail.com
+devnexen@gmail.com
+pauldzim@gmail.com
-- 
2.26.2


