Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56801C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C354C205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg7WKHp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C354C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8al-0001yr-RJ
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nj-0002cO-Mm
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nh-0008Kn-WA
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id z22so346375wmi.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LaY5OMJTuJB3coCyNEp5+1Eng34+zKoYopIqac85NxU=;
 b=Zg7WKHp9DOySak9zhEDBqaNXm5+XgvI75Wl3Mf/2U2CECMJX8mp3vMUiFjZ1MNt/Bu
 x/wkGWh9JMN+/aUv4smNf2uhJTb/S9GokdOxK12sVriuHlIjRgDJez/qIhQzaOatskf7
 9GDmLWBX6fGOuHwzli+FkBNwbOF0eskSJ9ntiFSx8EDdKj+EjctbS9mIdgAyRcqtPv2V
 q3WZ8Ouo+crvWRG+It3t/wfAcw3bETO/cEOxl2NniO7AsDg6qRgO/PDdxgousWCFou41
 KzCF7d+6e/aEJsrI7lyFuUwsLa0A3pX0E2fg0QVbYa5XHpb2xjWjxP7XzWkM6FHNC60C
 AbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LaY5OMJTuJB3coCyNEp5+1Eng34+zKoYopIqac85NxU=;
 b=BFuxMYBc3fSWY12rJOXf+O/6hooqADvPFynGJEpRRkABGS7xMNVWV/vQ2VneC/klmW
 o2zjuS9JDEkWT5cewckgYNUhkfA9heJ9WFTL2tXfWaipyAVZLRLzeqZE3dx/wWsLUwsQ
 gh7dBZuJg4VYZfO1OnlI7HexpWSB9NYJSZMHgGFZjy4WP3BHdcVzOeshJ1cFe0bxi0sx
 OxeqUEoAb+Y5EHVWR1z74X3l9t+oJqkBe6cIuMS19dXXDPyRb1mDe6tJhE47Dg/TKbJA
 cLqgXVKfRXEZqo45KoWFejhND5/jypwg4ZecuTXnMnj1ct18H50Hc4qsBO9EF0HwS+FF
 DQ3g==
X-Gm-Message-State: AOAM532aseL+McGz7iCg2vFJCUHs/g4h8NcoykJSdftjYrg4mqq6fL0t
 33r+roHwPQOHtH7mIU7VU4wdYgECbVEONQ==
X-Google-Smtp-Source: ABdhPJxQFC762nP/112xKSUZlGROObPnlX2ff65qbwDap36yNHXqfTSQN125bDtPZW6zMnmcPSIJ5Q==
X-Received: by 2002:a05:600c:230a:: with SMTP id
 10mr2239378wmo.151.1601834708526; 
 Sun, 04 Oct 2020 11:05:08 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 16/21] contrib/gitdm: Add SUSE to the domain map
Date: Sun,  4 Oct 2020 20:04:38 +0200
Message-Id: <20201004180443.2035359-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Charles Arnold <carnold@suse.com>, Fei Li <fli@suse.com>,
 Liang Yan <lyan@suse.com>, Juergen Gross <jgross@suse.com>,
 Kirk Allan <kallan@suse.com>, Petr Tesarik <ptesarik@suse.com>,
 Dinar Valeev <dvaleev@suse.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bruce Rogers <brogers@suse.com>, Chunyan Liu <cyliu@suse.com>,
 Jan Krupa <jkrupa@suse.com>, Jan Beulich <jbeulich@suse.com>,
 Lin Ma <lma@suse.com>, Bo Yang <boyang@suse.com>,
 Larry Dewey <ldewey@suse.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Zhu Lingshan <lszhu@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Andreas Färber <afaerber@suse.de>
Cc: Bo Yang <boyang@suse.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: Charles Arnold <carnold@suse.com>
Cc: Chunyan Liu <cyliu@suse.com>
Cc: Dinar Valeev <dvaleev@suse.com>
Cc: Fei Li <fli@suse.com>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Jan Krupa <jkrupa@suse.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kirk Allan <kallan@suse.com>
Cc: Larry Dewey <ldewey@suse.com>
Cc: Liang Yan <lyan@suse.com>
Cc: Lin Ma <lma@suse.com>
Cc: Petr Tesarik <ptesarik@suse.com>
Cc: Zhu Lingshan <lszhu@suse.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 77f2a140cd..65a6dcb74e 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -34,6 +34,7 @@ rt-rk.com       RT-RK
 samsung.com     Samsung
 siemens.com     Siemens
 sifive.com      SiFive
+suse.com        SUSE
 suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
-- 
2.26.2


