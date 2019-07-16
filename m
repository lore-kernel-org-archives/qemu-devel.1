Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E9C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DAF20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DAF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPuJ-0006ZO-Eg
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnPtz-0005Yn-4a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnPty-0000PH-2s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:02:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hnPtv-0000Le-Qy; Tue, 16 Jul 2019 12:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75BF3308FBA9;
 Tue, 16 Jul 2019 16:01:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 695BA5C88D;
 Tue, 16 Jul 2019 16:01:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 18:01:42 +0200
Message-Id: <20190716160143.394-2-philmd@redhat.com>
In-Reply-To: <20190716160143.394-1-philmd@redhat.com>
References: <20190716160143.394-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 16:01:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] hw/block/pflash_cfi02: Explicit switch
 fallthrough for ERASE commands
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous to commit ddb6f2254, the DQ2 bit was incorrectly set
during PROGRAM command (0xA0). The commit reordered the switch
cases to only set the DQ2 bit for the ERASE commands using a
fallthrough, but did not explicit the fallthrough is intentional.

Mark the switch fallthrough with a comment interpretable by C
preprocessors and static analysis tools.

Reported-by: Coverity (CID 1403012)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190711130759.27720-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 83084b9d72..f68837a449 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -367,6 +367,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
     case 0x30: /* Sector Erase */
         /* Toggle bit 2 during erase, but not program. */
         toggle_dq2(pfl);
+        /* fall through */
     case 0xA0: /* Program */
         /* Toggle bit 6 */
         toggle_dq6(pfl);
--=20
2.20.1


