Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A29920797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29920797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEFw-0002ax-CO
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBa-00050s-W7; Tue, 13 Oct 2020 02:53:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBZ-0000Eb-Cf; Tue, 13 Oct 2020 02:53:26 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhDEo-1jy8EU22Ak-00eNXF; Tue, 13 Oct 2020 08:53:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] tests/test-char: Use a proper fallthrough comment
Date: Tue, 13 Oct 2020 08:53:03 +0200
Message-Id: <20201013065313.7349-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9Xfjz56fO9lF7hiKITH/c1toHpSmo850v+vuEsOpzUHK5gLk8AW
 VFifuVvIm0s0L+SZX2PmKFq3KnyA5+dn6kf+SdXI4loRr3otXiaCPEYRLZH5uCNN8o+A7rT
 uLJSu9Cbh23y30iSXVHRPaA0es2aVmm3Cva5lCMebGKQrAHTkEkcttiM5X83U8CRpxr8C94
 cFpZkVi4UVHm7bhMTMaiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qttuLacMo2Q=:91ngz4MfHImT2rvpnHk0o/
 ajj0inkzy8T6dq6T0TznUlOToBjELm0Nb93RON2YoUL3An0eCuXw9twsMbHKUCqBAtdIZ5k2E
 QKqC6f2JgeSwzj0pFWbIixI2hy95/WTxxwqa0TwfMZsfGzx7am/zXSqOLnc+jyqfk1Drxm7K1
 NZQTgxVUf4uzcmwzcCAdQ+Xl7cn89aR1VwnN0TXervd3JkvWlG9pJOpmCAVTTA21XGAn8iTzl
 kIQtG+9FuktWDlxA6gH6FJDkBEC3iypF2PRiyB5LQS7mTtJEA59NTHVoRNEG4yrZz4u6k5JLv
 BR7YT2IPBlq2l5+X8LkkMln/tyElIyw+H479FA9Qfl+iRbWKcTG3Vj7m7k4SqLOG2rxwgl+pG
 DXceVGfXQ1u6SndaEnAJMYr+RZSqYt+fE2zdHQc9gc4z0rbsuhInGH6NUAuRpzDTBDUahKEkC
 nFCSifd3/1LvRWzyQE2+6c4u+NPy7UOhWyStIwiGrkCl1F106dxsnCncuw1uMd+SRAZG8HHQ9
 1gqkLarVltIzZ32nTwNeciM0Bnpktgawgo3BjFjeWaRaKBXthQC6iIbtDzx5mE+hQqDtxOeee
 KErB4jDqWBDk1/+xb5VYVbT3F1yefreNZN6ADkxzVB01wmE5mU1OP54et7qa6v6akRLhYGGFh
 UxAqQVHfl8TVZcg1O6WT02qkT8HJ+455Kt6y6KZD+AqoqMhLK9wKSOcuHIqljD1ozvdOwBrQI
 KRS2V6L5lpUp2l5RF9pAkFBRv4kiVkjQB7A7jvnuHYrtFyOncsfRhO/8YuYtzLgQFjv5noJvD
 fIy9PTLyIJ99g4juz1tCTCpyGRhrnBEANoITh9lcwObpxtB8ofMsx+DCCh5BhOnLLDuTetQ
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

For being able to compile with -Werror=implicit-fallthrough we need
to use comments that the compiler recognizes. Use "fallthrough" instead
of "no break" here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201002171343.283426-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/test-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc60..9196e566e9ba 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -70,7 +70,7 @@ static void fe_event(void *opaque, QEMUChrEvent event)
             h->openclose_mismatch = true;
         }
         h->is_open = new_open_state;
-        /* no break */
+        /* fallthrough */
     default:
         quit = true;
         break;
-- 
2.26.2


