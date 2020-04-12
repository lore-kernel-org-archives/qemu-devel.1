Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD21C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CE3206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMmBxFo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CE3206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlK4-0002fu-HI
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDc-0005af-3W
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDa-0002Mq-QV
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDa-0002Iz-Jx; Sun, 12 Apr 2020 18:36:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so7921171wmk.5;
 Sun, 12 Apr 2020 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ka9JmXySXeITJiplOCZ70eou6aa9wIREycqvE6xVzj8=;
 b=JMmBxFo9W6guTx5y4YNMxVa9hls4ECr2UCBhgY57EoSt12UEVLCUR6IhrLpzCvw7ua
 NszSCCW40ZDuWSywzpQhnrrbJt8Thby5lQ4kMxuEXxEOVFrlZKVmjL8AN+effCJTHFp3
 ETSt2tbUFllDgoUNUzTVpzBh90H1CVvNMG9Hzu8r/Q4UrPdU72hb4UpUUNn66xaqJIJl
 LP4BB+px1BenInjryZ65FHZIVZ/z3cfiD6NowjgTU26Do6trRpGEXwh8tAUiMaaLdaAQ
 LHP76abRP2DfG5/VtAMeJj9hdY7xwJs1y7uLeLPqOlG6J2foJy6/MPiLal6O6KKZGMPm
 bZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ka9JmXySXeITJiplOCZ70eou6aa9wIREycqvE6xVzj8=;
 b=cT73/eVznmEGv/xSs2nltyYqyySFqEymr+xPE8UOH8aE7QIXkohbUSqULTIq2YrkY7
 x9QDoEUozuGzcZ7BhA133Gx8BfKxeftSs5RDpielsZjPE3Zr3y3X/7//KVcBBugkIYZB
 grFfcros9q509KhQqI45s/B0jGtOD0YBQ1q0g//XdN2ODiEIAs2Uf4z+Lw1JAPuAf/XH
 ApT1HSM3K0peaTRozUQXiK+wIj2kqC4E5doir2lY0CT5bUsoSZdmnq2klF9jKko6vpvT
 jWGJMfhm4BmtDU2ZZbGQVJtdzpXloz6A+OTJwCK1Ivqpdlo9MhtN5OOBHZo3BRtj233g
 2U9w==
X-Gm-Message-State: AGi0PuaxlGAPass/L3RNI0bJB0+QHffnZKJc3cwBI4/69Sh7tj48ofK+
 WOvqMEDNNdT6iyc9N0SSiTWDgYVkJ6NbAA==
X-Google-Smtp-Source: APiQypIcDBTzHy9afHTEKenZpgFui7COxKU3aK4xCsUxL0gvOGvtESBAoCAH5blkM4AkDANLiBCnQg==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr15569288wme.75.1586731005469; 
 Sun, 12 Apr 2020 15:36:45 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 06/24] hw/arm/aspeed_soc: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:36:01 +0200
Message-Id: <20200412223619.11284-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/aspeed_soc.c
  >>> possible moves from aspeed_soc_init() to aspeed_soc_realize() in ./hw/arm/aspeed_soc.c:231

Move the calls using &error_fatal which don't depend on input
updated before realize() to init().

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/arm/aspeed_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 696c7fda14..debd7c8faa 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -183,6 +183,7 @@ static void aspeed_soc_init(Object *obj)
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
                               sizeof(s->spi[i]), typename);
+        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &error_abort);
     }
 
     for (i = 0; i < sc->ehcis_num; i++) {
@@ -360,10 +361,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
-- 
2.21.1


