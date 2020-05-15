Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF57AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 01:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC6820671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 01:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC6820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dlrobertson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZlFI-0008Dr-0C
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 21:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@dlrobertson.com>)
 id 1jZgzZ-0007sQ-P7
 for qemu-devel@nongnu.org; Fri, 15 May 2020 16:31:38 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dan@dlrobertson.com>)
 id 1jZgzW-0001MF-Sd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 16:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589574677; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FK5oeI31N33mT22UUqeqjU0KOktrJGPsBN5jnO6UUx+jFVCpypjZXmVInDK5k1zNTALB1qF8uTavIINJalz3hoGk1q2GeoB5+d2Kcv85ZIwsTA2h75+Jv2S4pqmtXbdME42B7U6MixwpROa/MOy3dhbpQLCE0ZLj/nngfK2YLcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589574677;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=RbY/htvP9VYhStNvO45Jo+jy4ZSfQRvFXGRW2SB8ejE=; 
 b=lp4LFDbMbTSGAJcX/rN3ULLmvCpQV6nOgfGAEgJAJPaWf486laYphgOx1Na0kxX8AVAeEDO8C4WZcQv27+HAXCoHpKUlRjTuE78l3QxJOLthokJTS/PtN1HxMLpOLkfIS7H07H97mxcqcGSoNr8mJ/Ec458FbGLoVQkTPw28EGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=dan@dlrobertson.com;
 dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-96-255-47-18.washdc.fios.verizon.net
 [96.255.47.18]) by mx.zohomail.com
 with SMTPS id 1589574675866437.24441338353347;
 Fri, 15 May 2020 13:31:15 -0700 (PDT)
From: Dan Robertson <dan@dlrobertson.com>
To: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20200515203015.7090-2-dan@dlrobertson.com>
Subject: [PATCH 1/1] 9pfs: include linux/limits.h for XATTR_SIZE_MAX
Date: Fri, 15 May 2020 20:30:15 +0000
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515203015.7090-1-dan@dlrobertson.com>
References: <20200515203015.7090-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Received-SPF: pass client-ip=136.143.188.13; envelope-from=dan@dlrobertson.com;
 helo=sender4-op-o13.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 16:31:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 May 2020 21:00:30 -0400
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
Cc: Dan Robertson <dan@dlrobertson.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

linux/limits.h should be included for the XATTR_SIZE_MAX definition used
by v9fs_xattrcreate.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 hw/9pfs/9p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a2a14b5979..68c2df7333 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -28,6 +28,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/xxhash.h"
 #include <math.h>
+#include <linux/limits.h>
=20
 int open_fd_hw;
 int total_open_fd;


