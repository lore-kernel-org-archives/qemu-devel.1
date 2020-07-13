Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E1B2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E1B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuQo-0001lR-Kx
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuM2-0001fD-VR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:31 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:62005 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuM1-00037d-7w
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:30 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 74F90C5892B163EB7FFF
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id 06D92Pxo037591
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:25 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020071317023036-4267744 ;
 Mon, 13 Jul 2020 17:02:30 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] target/openrisc: Remove superfluous breaks
Date: Mon, 13 Jul 2020 17:05:34 +0800
Message-Id: <1594631134-36688-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-13 17:02:30,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-13 17:02:26
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse-fl2.zte.com.cn 06D92Pxo037591
Received-SPF: pass client-ip=202.103.147.172;
 envelope-from=wang.yi59@zte.com.cn; helo=mxct.zte.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:01:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: wang.yi59@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>,
 wang.liang82@zte.com.cn, xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/openrisc/sys=5Fhelper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/openrisc/sys=5Fhelper.c b/target/openrisc/sys=5Fhelper.c
index d9fe6c5..d9691d0 100644
--- a/target/openrisc/sys=5Fhelper.c
+++ b/target/openrisc/sys=5Fhelper.c
@@ -289,10 +289,8 @@ target=5Fulong HELPER(mfspr)(CPUOpenRISCState *env, ta=
rget=5Fulong rd,
=20
     case TO=5FSPR(5, 1):  /* MACLO */
         return (uint32=5Ft)env->mac;
-        break;
     case TO=5FSPR(5, 2):  /* MACHI */
         return env->mac >> 32;
-        break;
=20
     case TO=5FSPR(8, 0):  /* PMR */
         return env->pmr;
--=20
2.9.5


