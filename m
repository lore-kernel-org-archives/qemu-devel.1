Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C108EC76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9457D21849
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MpAzmhJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9457D21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8er-0007y2-T3
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54344)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho8eh-0007Yz-P4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho8eg-0003vo-7p
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:49:15 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:55452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1ho8ef-0003ps-0W
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:49:14 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3483B2E09D4;
 Thu, 18 Jul 2019 18:49:06 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 oz18j44Wov-n5mSKrZ9; Thu, 18 Jul 2019 18:49:06 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563464946; bh=qo8eFFcNkygNkzQYR5TWc8Z72JfaTz6f5XKJSQWTKec=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=MpAzmhJS9jZ8iSiclXNoLxmtk50V2jq1jMyE9kWthXSQUZ00+0WWjH6aiCsj++OVL
 Q11ilq1pAQD1VKzNbozsgOsGJ1u3l+eH57qHZaykMPfhZ6vt6mfmibRhXnwfgEHinr
 3SJnZdTs6Ud1BSI/GIL40/gOI5onVTiQtBudz4p8=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 cmpVqxIemG-n564dl0a; Thu, 18 Jul 2019 18:49:05 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Thu, 18 Jul 2019 18:48:52 +0300
Message-Id: <1563464932-24284-1-git-send-email-wrfsh@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
Subject: [Qemu-devel] [PATCH] i386/acpi: fix gint overflow in
 crs_range_compare
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When very large regions (32GB sized in our case, PCI pass-through of GPUs)
are compared substraction result does not fit into gint.

As a result crs_replace_with_free_ranges does not get sorted ranges and
incorrectly computes PCI64 free space regions. Which then makes linux
guest complain about device and PCI64 hole intersection and device
becomes unusable.

Fix that by returning exactly fitting ranges.

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/i386/acpi-build.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d281ffa..5cf88a6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -758,7 +758,13 @@ static gint crs_range_compare(gconstpointer a, gconstpointer b)
      CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
      CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
 
-     return (int64_t)entry_a->base - (int64_t)entry_b->base;
+     if (entry_a->base < entry_b->base) {
+         return -1;
+     } else if (entry_a->base > entry_b->base) {
+         return 1;
+     } else {
+         return 0;
+     }
 }
 
 /*
-- 
2.7.4


