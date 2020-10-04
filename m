Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF228C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85060206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pG/+RZ0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85060206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8RL-00076A-MR
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NX-0002FW-Bz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NV-0008J7-VH
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id e18so1181490wrw.9
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QCT4q5u+oiIGVxW8dsha6dI+UyuXD9P/qaCjAefvMtI=;
 b=pG/+RZ0m7+xm2UGnJVnZsQZcF/2MiWn7Gl+sOE7i5n1GX2kBwAgesOc06EqgxiQ8Rr
 uyBAXm06rBX2ILSIlr+hhVGsiD5OZ9QqgdoTnbEsKibcPffJEgK9ga10LhWpHVOTf4CN
 L6GGhGdkcX0Szk+7h7t74sxD7pi7A+Rj5rsfX1gc79zp8htCeJ6UtTRGM83BpufVRVCc
 t1VXXzxioYVVkIiDClxuiCCSyjLhWezcm3bGllx1Lsboxmheuvv+DsQwYwXp58z1S8ZA
 FexrOR9vTImWshaV3emk7tQ+ygLdenSb5TYGiP1dwC1UsuW6VkxzgcGqqTzKKBYvsRP+
 Ifkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QCT4q5u+oiIGVxW8dsha6dI+UyuXD9P/qaCjAefvMtI=;
 b=pYTyFKaftISI157TkEXdciSvCsgS9bDwEK4YrngMocLQOQLSoDmdaMbvCWS+kBr/ys
 TsyTqG4sYtxXmsuTEPRc6HubysSDXbgEDKBmFXtaJbmVvZ2kZkDC2fOVh8UFV+bwd2Jx
 gRIzLbajU+aslbBuQ0akEgR/Exhnh6y3x2H7OBQaoK8tFBxHkfNiBhsJyj+n3CH/EpHb
 ujHNyOey+3Wmu8In2+gCdNKDvlWk7aRXoo+LhkHJMguwx/H7UjwtK4OkM+6P7Bd3aFAb
 6CHQg7N6SXBiBXqcXQIOmvYMNabBq6TRDcNwyYLvQvAwkqUUVN3KYvR/C+gnrHe/wk+j
 eFsQ==
X-Gm-Message-State: AOAM5322sODd1qRNSyMyJPohiEj8Za9vpUrfNPaw66Ug2GJswPeUIGGd
 /N8dKu2jTGktGWT02DHoGp2+tCm4gj0=
X-Google-Smtp-Source: ABdhPJyJij5poH1fCNF1qU3Qq1SXhG1qBkFBlYtyy4b16ejwCkwORLfPzUayyS7/oY4JSPtbRkk9Jw==
X-Received: by 2002:adf:f084:: with SMTP id n4mr6272477wro.16.1601834696388;
 Sun, 04 Oct 2020 11:04:56 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/21] contrib/gitdm: Add more contributors to IBM group
Date: Sun,  4 Oct 2020 20:04:29 +0200
Message-Id: <20201004180443.2035359-8-f4bug@amsat.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Author: Leonardo Bras <leonardo@linux.ibm.com>
Author: Leonardo Bras <leobras.c@gmail.com>
Author: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Author: Anton Blanchard <anton@ozlabs.org>
Author: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with your entry, please
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
---
 contrib/gitdm/group-map-ibm | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index da62fa3f44..7c9f996b42 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -12,3 +12,7 @@ jcfaracco@gmail.com
 joel@jms.id.au
 sjitindarsingh@gmail.com
 tommusta@gmail.com
+leobras.c@gmail.com
+pavel.zbitskiy@gmail.com
+anton@ozlabs.org
+npiggin@gmail.com
-- 
2.26.2


