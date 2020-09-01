Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C011C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63379206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63379206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7BL-0006tB-HH
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zP-0005dD-4m; Tue, 01 Sep 2020 10:10:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zK-0003qW-43; Tue, 01 Sep 2020 10:10:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVeDs-1k3Apo3JLQ-00RaTR; Tue, 01 Sep 2020 16:10:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/44] vnc: Remove the superfluous break
Date: Tue,  1 Sep 2020 16:09:15 +0200
Message-Id: <20200901140954.889743-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pdv3G5Oqe3F2hu2/7gXBOoL5WAz0XamQawEsYgcNF5YJP/+Ca2e
 uOh/8pgWD95l4+aXRbKkcS2L8wlzNnsLkCqOQeXPQPezwSpu4Fbx1AgRX+3PDidXqnLTjz1
 /o8JqoRu+huLR2afrbh8O9XGvEjdXRTWwQGM2oSLGfKdTN40dy1hRjGpsuIJka2ncQaQcFF
 yTeU3ySy+s0gU/0nxSI1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NBEvsUduZJk=:wiYh741gjlNi3HyZ5q/vZX
 tKaY8C/UQgnh7K67xFxkgIYsuxcOFkLirpNbGpKiJZierlUpL2V7QGuUsuS0IjcgsnCSoHzDK
 6kd0XGKB7VVNDXsjlOMjTnJd4Phdaw/V/CwBd9CtCa09gojNJP6CJ85fU5lpoG8LWfJm1qSyG
 xedyQA2PGl16zp1QtQ+Dc+vdbi5hUanQwpESSWcE2BRLTNyL41PnLjKaO8eEVk0fmRUq5qdtj
 K6TDAfW+pJ72N5zDdqcuE4WnJl579jBWTyHwCoUleZ4Xo2QaJE9DbODCdFGWI3enB9FuRwQYF
 Y8TBLKqDgceLBgdH+e03TiZLvdTYZTECrJBcgomVUYX3soCTnauwmVSkf7w8ZSs6j0OqLWT1K
 Ym0vpEZfkFa8avOFq/cEcu6QmBpLpzHSfivy74zWeYZxrNNoF1oWByF7sUu4NzUz+U9TYrtSg
 +JMu4Qy8rF9uwFhst9e2JH4Pa7ET37oGMxRFu/+Cy55qRi/DqrqCkBbjhju0C1GOrXkZbjKyV
 iPA1eMMHOFBA7DJ+x+Vk6lkVcAgbkG0YIfTznUGw852ROmLehJMcZIAPWoPZor+rWlh8N2Ra+
 cw44jaFID4795kyL/rgkiJ1Vt7fmovn1wme34yTKYzBOk4KLPAKRtf1SMXkDwuvaryqKizC/d
 qcXFtja/xcYUOxYHUrmXf/6uVPUaBz3K6LQ033doMwm4ZAQSJD9KXZGtJPT4ml/fZHs59d9oc
 J72D41vKp3k3NzStFsB7eXP+iVBcpj2E0ImfgfeIxYrTj92x5iqWWkr8B9pBmKYHQudovRnX0
 RqXZQsTTRjmMA/RZLrbUR4hhzFmob3Czp2yxvYPK2so7fkLA/wjiWEk512hmeJzIzrl9Mlw
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
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove the superfluous break, as there is a "return" before.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>a
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1594631086-36509-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 ui/vnc-enc-tight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 1e0851826a84..cebd35841a92 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1125,7 +1125,6 @@ static int send_palette_rect(VncState *vs, int x, int y,
     }
     default:
         return -1; /* No palette for 8bits colors */
-        break;
     }
     bytes = w * h;
     vs->tight->tight.offset = bytes;
-- 
2.26.2


