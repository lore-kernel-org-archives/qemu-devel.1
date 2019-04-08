Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E868C282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C4120879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJew8/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C4120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJZG-0004Zl-9P
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 21:59:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJYR-0004FZ-Dr
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJYP-0001kQ-TP
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:58:35 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:43609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDJYP-0001jY-Jh
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:58:33 -0400
Received: by mail-qt1-x842.google.com with SMTP id v32so13617111qtc.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=UJ3xa018bb6QorxLPMflAByB25j56KTQmZ9gqnHPprM=;
	b=kCJew8/6s4lhtAl5liMq4jkTSTagH3ub9OnaQGW9Ix6QwAMZ2pF1WRKFRBYV8Y77hg
	QW+mkzGgsr2wvkvVEFiYvD2r4xc9zXD7LtRYPAUYeDbVxgLPxuupWRJFVlxnfBJgt8rE
	3nsxPwejHA2IAkUeS12v7LcYvee9IWsLOdE1swh6cMOtkcaI6/gTzsL/OmXtddKjvlwh
	qGfXMmvkbyJ1ocPyMUn9AjWxAyGbSSOhVomTUwTYQ6Co3Q+mVR54Zk2khrKHSb8I2+AR
	TNOdZBbgX9p37KePuM8wFrRHvLu7O3DU9k0KAI63f/ZoscSdeSC7x69KRZ5ypbqHOdq+
	0HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=UJ3xa018bb6QorxLPMflAByB25j56KTQmZ9gqnHPprM=;
	b=VU4/t/uivFQAwOAwuz7rb6rPV/gtNa0jjEbovZcZ8cQiEBb6qxPD7Z5ZYdf2anL+gN
	cf9ZfICYFDlIqNc5MvWTuf4dS3R56ch0bBSX1vaF/G65IfUPBl9Zt6akwikNNV4U+76R
	hLxs0bSldoZjqCpNp7wU+VDkruyUqFuCV+kdYOLEik7an/3MdhTmTLYRC0uWf6GPJhyO
	KhKKdN3/GpH8UE8H4pWGrD7iH7pKdysF/6yJjZZRQf73YxFSLZ0newuZhk0cucGLqcrD
	RxgY13z/ki0acvwozCg7cwI27Z5F0/MYRvO1n4I+ygogiAeg5jQ5TmG0d1sj9EESlHeY
	FZew==
X-Gm-Message-State: APjAAAWsDgSKNwv4sceJl34nPG4bwithTc8RRpIGXiJr8Vrk0BR3EV7N
	WRWYfzdhk/mTBvBADCbtaEY=
X-Google-Smtp-Source: APXvYqxxcwRxAXl+XkPwLOALAdnFrYt3xaTBrQvMOtTbDRTr4ACidbT/kvLTemKxObDlaayQ4P7JIQ==
X-Received: by 2002:ac8:3216:: with SMTP id x22mr22512777qta.114.1554688712233;
	Sun, 07 Apr 2019 18:58:32 -0700 (PDT)
Received: from localhost.localdomain (104.129.187.94.16clouds.com.
	[104.129.187.94]) by smtp.gmail.com with ESMTPSA id
	m41sm18055059qtb.58.2019.04.07.18.58.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Apr 2019 18:58:31 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Sun,  7 Apr 2019 21:56:56 -0400
Message-Id: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v3] migration: do not rom_reset() during
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
Message-ID: <20190408015656.SjMbI6AL5jMdtzP7RP8a2C-JlVLeYnGKdMIBVkT8bNw@z>

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
 hw/core/loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fe5cb24122..946bb8ff00 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1087,6 +1087,13 @@ static void rom_reset(void *unused)
 {
     Rom *rom;
 
+    /*
+     * If we do rom_reset() now with these ROMs then the RAM data should be
+     * re-filled again too with the migration stream coming in.
+     */
+    if (runstate_check(RUN_STATE_INMIGRATE))
+        return;
+
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
-- 
2.17.1


