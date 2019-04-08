Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D44CC282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544FF20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQy4Lkk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544FF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPuE-0006yn-IO
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:45:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPsi-0005xO-Pa
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPsh-0008Mv-96
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:56 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDPsg-0008Jk-1K
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:55 -0400
Received: by mail-qt1-x843.google.com with SMTP id x12so14424554qts.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mluOeCvZqHaE1UNzjY+qDA6Y1LJdXS+eO+yepQydSIg=;
	b=dQy4Lkk8cZpXRqzijj4ZgMQK3sWos5iH7VX06x92Mhn+InqG+ne29KIU1/xkyKgY+S
	s20a1zY+5nQ3DVqzOgPCYKKfN1KNB1E6TB0559aH9qU0+chcnIDVkFeOHDvGV2HOYsYA
	E0G1Rqn1ny824l1FfwJqRDAZwid/Y/5WzeRxBcDlp1DC3jWCazKIYoFa48KxpPIKEfh6
	/vlrgVGEV2LHCZ6PwJ+PBjqVuIogRXKA30fvzg8AkBHYo+h9sWWxXaYdBFG182mbtZQa
	2mBGYmpD5MF3/Y27zD+hXlTyNh4CAAzMHAycNfNUSqpgXgGypjHLcXsCYEXTNKKGrX7K
	K+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mluOeCvZqHaE1UNzjY+qDA6Y1LJdXS+eO+yepQydSIg=;
	b=Qsd7BAwXsqQwHEoK0FFohzEMwYk/YjR3yo4WX+b6Z4d58FF9AEkNc9yE4hbjXb2dk3
	Ybzz7nydPnDl+Y6FRlXO8xxefIDYFJHL9eOcL+i1RXOZb58RBJE4EWhjAnj9PaDxoDZU
	okNCpOTjxOTEHIYOkot6TZUR7NjoS8gdoSSEIPdCiJlVJOhzI+CQXNN4aT9JkOCBWxCQ
	8DToK58iAeTX1AYXkTVhq9EjiI2DcNS+csx1VVUhT+snCSmDt88EIkhVUc4h967epQvw
	VkV5UBIkpxXvqjaRTQhHbTUi3M4uXKLDYhS8CZERRoR554GQPhvYD/DaVPoDeXm4aE+U
	zREg==
X-Gm-Message-State: APjAAAXRfiMHDeoInBsrk3rRYezd1mgqtxqcj1SfhiEx8AH6xBKH3bg3
	Gg/LmUzObYe0DMjfO9M8xSM=
X-Google-Smtp-Source: APXvYqwBwOYxS1ATkC0/LKaDIMiY6xypKPYOXj0/KSTLUBb4DDap5zWf836/efsdzRu+zvnUzx/wPg==
X-Received: by 2002:ac8:2acc:: with SMTP id c12mr22132566qta.108.1554713033308;
	Mon, 08 Apr 2019 01:43:53 -0700 (PDT)
Received: from localhost.localdomain (104.129.187.94.16clouds.com.
	[104.129.187.94]) by smtp.gmail.com with ESMTPSA id
	d75sm17603259qkb.74.2019.04.08.01.43.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 01:43:52 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Mon,  8 Apr 2019 04:42:13 -0400
Message-Id: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Catherine Ho <catherine.hecx@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408084213.ma8v5yjnCeYEL4Q5P9XBcdUeG1v86CMdM9KaaCCc8bs@z>

Commit 18269069c310 ("migration: Introduce ignore-shared capability")
addes ignore-shared capability to bypass the shared ramblock (e,g,
membackend + numa node). It does good to live migration.

As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
until VM starts, but it does on aarch64 qemu:
Backtrace:
1  0x000055f4a296dd84 in address_space_write_rom_internal () at
exec.c:3458
2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
6  0x000055f4a2c9851d in main () at vl.c:4552

Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
druing rom_reset. In ignore-shared incoming case, this rom filling
is not required since all the data has been stored in memory backend
file.

Further more, as suggested by Peter Xu, if we do rom_reset() now with
these ROMs then the RAM data should be re-filled again too with the
migration stream coming in.

Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
capability")
Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 hw/core/loader.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fe5cb24122..040109464b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1087,6 +1087,15 @@ static void rom_reset(void *unused)
 {
     Rom *rom;
 
+    /*
+     * We don't need to fill in the RAM with ROM data because we'll fill
+     * the data in during the next incoming migration in all cases.  Note
+     * that some of those RAMs can actually be modified by the guest on ARM
+     * so this is probably the only right thing to do here.
+     */
+    if (runstate_check(RUN_STATE_INMIGRATE))
+        return;
+
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
-- 
2.17.1


