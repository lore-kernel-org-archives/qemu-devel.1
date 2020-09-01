Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F51C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC16F207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC16F207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD70K-0007wA-Nn
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zC-00056h-TO; Tue, 01 Sep 2020 10:10:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zA-0003jK-U6; Tue, 01 Sep 2020 10:10:10 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHG4W-1kQKNr1Hvc-00DCqj; Tue, 01 Sep 2020 16:09:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/44] target/ppc: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:13 +0200
Message-Id: <20200901140954.889743-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZbH+rJepN79lncnQpsYNFzMEuLuiiZ2geGMjuq8OFinTVqXaKFJ
 JI4rdrKSp+16cG4AV/IExbzfxOEaEIPg3tIcvpqBGXBLcMkigX9WmwRAVRKn9yAtth/9ANJ
 ZOoGNG5bEc7H8XjJ81PbhDqxBrzoKsGFDzaPY2zQoGKv1p90RqR9uFPl9v0ACs5NAWrUMdg
 01gunrxb4PU5mAe8o1ftQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dlKzjC/Y5v4=:skUHDxNZh9Yn9b3Sm+TQW0
 eziOsqP4HfKhN9CW2JgtTwG76YbWhDPQfaqxcouY1TtGatMLkoDbWm+qW/8xhUCA7moKwDk8y
 4FBGlrKIarPmTSYvEup7ntmN/UU80B7ev0HVgpJu3nnkCtJddK/RHatwIMJ9IZqYmOtRe87W+
 Lb44CnbuZ2Ta/KM7KLi/kl4EevPE6/cu9oQmeZtWktyIgX+oAUcmjyDOR2LtMEw09nCVlvCpN
 Om1A8CNnVNx2kuPlTSDbW4t9yUrVntfStGu8aO9EsjZEoBRFiSuAQlmkw51pbdspHUFSIoucl
 BHVkko1ZnbDUS8x6QZZe1Qg7AlAwUOduZmhaAckPh836Xzcs/bGGrhNtLHKabqMvjOzewK/5y
 RUX1A/5vdViXf+iD9WP14kMSr/K4al6I8am1UkQtYkYRR4PgCDtVRoqE/b58phPuAFUyxNEsJ
 YCAoglETDrRLKCSMAQD3XoS10t0Zd/KuuwaynD4j6V3Xp56PtXDy/PQJnZErFriMCOV1/45cn
 5Ei+wTcbTZc+VWtKr6IiHLFTBrcTHJ+S56kPHv1GOZ7ALWUvV+AHyqdE3gfPx116seMqOnoHb
 0Te80v+jLLvkdEEAlbm/5UyAFgmuDekKHGD/58lkhBQP8PBi+mdUpAqGfG5bRNCbksVfIvYyt
 nCml5axXHmhD/TNbfLf2VQAlCpG4iLoVSXOvuUpIYpCwnEVvRc0qZpaKZGX3KorPy9B3obF2b
 uDnKiNdHV/AypImMVnW3XepXCon1zrU/yBPDOsZNZ2uNp1rtxt+hyHtLfEagIBxjM+z0EdLZU
 F/u5ZGMwFNEn70+wFKR+k5k3LHdFIRZQcVJRhXu6W8+s0zJ3Uo2iF1p0fhtak6R95wurQ64
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
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
Message-Id: <1594631025-36219-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/ppc/misc_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 55b68d1246e4..e43a3b468667 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -234,25 +234,20 @@ target_ulong helper_clcs(CPUPPCState *env, uint32_t arg)
     case 0x0CUL:
         /* Instruction cache line size */
         return env->icache_line_size;
-        break;
     case 0x0DUL:
         /* Data cache line size */
         return env->dcache_line_size;
-        break;
     case 0x0EUL:
         /* Minimum cache line size */
         return (env->icache_line_size < env->dcache_line_size) ?
             env->icache_line_size : env->dcache_line_size;
-        break;
     case 0x0FUL:
         /* Maximum cache line size */
         return (env->icache_line_size > env->dcache_line_size) ?
             env->icache_line_size : env->dcache_line_size;
-        break;
     default:
         /* Undefined */
         return 0;
-        break;
     }
 }
 
-- 
2.26.2


