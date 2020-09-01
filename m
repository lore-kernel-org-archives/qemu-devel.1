Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D81206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D81206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD73M-0005lq-8Z
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zI-0005Jg-0P; Tue, 01 Sep 2020 10:10:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zD-0003lB-NF; Tue, 01 Sep 2020 10:10:15 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mf0Je-1ko5QT4B2I-00gX3v; Tue, 01 Sep 2020 16:10:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/44] scsi: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:14 +0200
Message-Id: <20200901140954.889743-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HzRXYpiCsJmFhJLmVx9r5xwCiEBP4G5Vuu71TcsfpxASRr3Mg4d
 aNQpvBU/2hWBekRmpiEmkkTbpCPF4Sf1s7PsiHofcFxyPIRSJRPPaQcLNPyeFq0Dl02DXjn
 4Jto+Ld5cqj3NSrxTXeBUCjuUMRpeTdbCUzsCuwnTH5v8VXNJQk9Iizm4ZrAET0a3XSycmu
 ySaqib1Cn8na8umEx/Ypg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Ypi5pdDBr8=:A36Z2u8XPqSZFNVnpgpyLr
 VymfU3lEb7oQMTPbvbpgTxwf5bz7lFr0QuaHArnnWtymtxDZsoFzGFNRhBMjMsy67tVGUSh4a
 wchO7QVtOiVrGy0F7L6Ixyw7i5FL1eUdXiNx7hy0TsxjBrozK5+GkoY4AYVCkcYcIYKOJqnvS
 usjwjz9GlgC9pRZRRXaXoQCST+pXAwTBCrdhO3cLHKufhaT2uC9jN2MBq+MnCB9OOZ8DSsZ91
 cs+labawHeFC0xlfSQCk3zOsdxvRFQLGD4e+2JuNRJ+ObuCQh1t4ezEfbgYe0m8VWPzZPlqJb
 VcHlefApzOSpgupVYCW7B5bIa3ISQiQ4nuQvBRTWgs5x7bi6oCgDzZ6IScvYwkj3R2EwqQgZx
 1BKX6ZiLp5xo566HqEeeB2qFpq6XOMmmowHo+tRBcwXhjAWipUdKSOgXbXWHRF6YZUDqhY9EW
 awFKQGCJeg0+6wQbMBljmR/9lrz0YSBDIrZIP8gLPy1MVnDbmOUfOgscy58GHsSPDweER+hPv
 ONaCXTof2mKdpd12ethQeDACpQqKwVN4E7/A4zA4m+qXSC22ouqhv7vIfmLts3XWBqnNgXVYI
 NJyKFUSI/A10B2poi7zYRO35O8RVMbPTZafzoULfgqQoP7+w2EVnMdSruBS+cVrt7Jz9o8caj
 f98kJFhPJRJZf8R5U0orPVNH7mer1HJnzvx8T1PLqRVPAcdusW09dyM90zp9lNpwhuFGMhLlA
 Ax+htbzHQIJQxuk0EVdba7f2u/+LTWZMNEKfDaRSuX550pw9VU2gBHLxjXq2zxXDrdbbaMlYE
 LTYsR1oJEWOeC1uwzWqD8crXB1N1psCJ9FmrJDF+6o1VBow193S0bRhj8L60SUvn5T5JymT
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1594631062-36341-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scsi/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index c50e81fdb87f..b37c28301489 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -32,17 +32,13 @@ uint32_t scsi_cdb_xfer(uint8_t *buf)
     switch (buf[0] >> 5) {
     case 0:
         return buf[4];
-        break;
     case 1:
     case 2:
         return lduw_be_p(&buf[7]);
-        break;
     case 4:
         return ldl_be_p(&buf[10]) & 0xffffffffULL;
-        break;
     case 5:
         return ldl_be_p(&buf[6]) & 0xffffffffULL;
-        break;
     default:
         return -1;
     }
-- 
2.26.2


