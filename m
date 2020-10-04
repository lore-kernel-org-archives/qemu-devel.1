Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD89CC4363D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F331B206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kywiiwls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F331B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8ii-0006Q0-QJ
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8h7-0005oM-90
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:25:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8h5-00026Z-Iz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:25:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id j136so6585210wmj.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9JR01Ay2v5ejxYhIOCc1GUk0ay2p2mOurCw+oBZeVjU=;
 b=kywiiwlsblELBwiN30D6034mWYABHw1bjNzZvp+6hWNl1GDJ46jRQuXzxOWqcVA4oa
 Kh8k5Bfn3PXiXTSm8RGsO55u+yA2OKLJZO/xGDTeb+5CGqoC9gVyUyxSg4BakwFO2lbP
 dJ73J/AHpOJOjzbpD4tUSHbOsOc1zZK+Zmbnq3gWjGWwASSbCsOt36LxQ+GEGmBTbFQp
 Aq1i2MfWi7vAq0xD8gu4iiFgZuhC0j7KkIIcmCUz9lZChGkR2tRB+elq3+qyw9Jqijws
 kRjEpRI+g2ABp8ohtZ6cxfJzrhRlTsHm0BGLsFd38/bokBJx59ACvgi3HYoJc2Cu3rnz
 9bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9JR01Ay2v5ejxYhIOCc1GUk0ay2p2mOurCw+oBZeVjU=;
 b=TwK4fdFcaN9xHJzBtVmX8e7HisUNkl22js6IxaTZU6O61pJlNzbF7keluExZElrsAt
 JGyCJmqS4rZpK0rARfez0mlC7kBUm4TkvnG7uLIvokSJofrlbpYQ1JPuM8mygeLxmTXy
 hjI/hmSl/GALtrmb+9PT4PGu/fVywR+iC0yuhHj4OW+LWspsffSpUwpLtGRn7Kab7DxI
 HfIWG3aZkf7mU7tlVF/z1zLOyndr6j799PlJHFTGOVIcEYAeQD+rJbUed7dzfUeZ+hVq
 jaHq77fEW/RN8tY63BMAZjv5TtLMvgvF/FNJbNt8vkYRHFxNvXSHU0Yot4oCIMwQci/9
 gMIA==
X-Gm-Message-State: AOAM532rY4OfmBKbRJqV1KFoeR4TZSb/Jw8iwauiS+cPJcMz7fFuN1cm
 vFchhUc/AK+yPdw/F6EI0Gptb16cYcLRtA==
X-Google-Smtp-Source: ABdhPJwI4ROob7KTV9F6/M+HmBVildWpwXOCg87y7ei9GSoe/j+lkuvhsP1vU0NLPt9c/QoWUTEHKA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3106258wmc.184.1601835909231; 
 Sun, 04 Oct 2020 11:25:09 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k15sm10533906wrv.90.2020.10.04.11.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] contrib/gitdm: Add more individual contributors
Date: Sun,  4 Oct 2020 20:25:06 +0200
Message-Id: <20201004182506.2038515-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
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
Cc: James Hogan <jhogan@kernel.org>, Paul Zimmerman <pauldzim@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Sven Schnelle <svens@stackframe.org>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, David Carlier <devnexen@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These individual contributors have a number of contributions,
add them to the 'individual' group map.

Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Helge Deller <deller@gmx.de>
Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: Kővágó Zoltán <dirty.ice.hu@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Michael Rolnik <mrolnik@gmail.com>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Paul Zimmerman <pauldzim@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: Sven Schnelle <svens@stackframe.org>
Cc: Thomas Huth <huth@tuxfamily.org>
Cc: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with your entry, please
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
---
 contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
 contrib/gitdm/group-map-redhat      |  1 -
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index cf8a2ce367..b478fd4576 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -16,3 +16,25 @@ aurelien@aurel32.net
 balaton@eik.bme.hu
 e.emanuelegiuseppe@gmail.com
 andrew.smirnov@gmail.com
+sw@weilnetz.de
+huth@tuxfamily.org
+laurent@vivier.eu
+atar4qemu@gmail.com
+hpoussin@reactos.org
+deller@gmx.de
+alistair@alistair23.me
+fthain@telegraphics.com.au
+svens@stackframe.org
+aleksandar.qemu.devel@gmail.com
+jhogan@kernel.org
+paulburton@kernel.org
+vr_qemu@t-online.de
+nieklinnenbank@gmail.com
+devnexen@gmail.com
+jcd@tribudubois.net
+dirty.ice.hu@gmail.com
+mrolnik@gmail.com
+pauldzim@gmail.com
+linux@roeck-us.net
+sundeep.lkml@gmail.com
+ahmedkhaledkaraman@gmail.com
diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
index d15db2d35e..4a8ca84b36 100644
--- a/contrib/gitdm/group-map-redhat
+++ b/contrib/gitdm/group-map-redhat
@@ -3,6 +3,5 @@
 #
 
 david@gibson.dropbear.id.au
-laurent@vivier.eu
 pjp@fedoraproject.org
 armbru@pond.sub.org
-- 
2.26.2


