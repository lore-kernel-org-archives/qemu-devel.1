Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3250C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984B42078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984B42078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDJp-0000k8-Q1
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHl-0005Vy-Bk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHj-0002aw-MV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjxW4-1kzEI03xea-00kPxU; Mon, 07 Sep 2020 11:17:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] linux-user: fix ppc/termbits.h
Date: Mon,  7 Sep 2020 11:17:47 +0200
Message-Id: <20200907091748.376101-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
References: <20200907091748.376101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jbfamT63ByKgicL18n+NOk+WGLQ5ri9tl1iJxUTyhdVCJtk26up
 QUAA7RbxsPcF0ALzWe9+6fR2VirMm2+Gb0ypvZ2LQL5LqvbTAYWSBU4GXjL4CYptmxvNiEi
 7tR5OsHD77b9AJm5FNyGN0PaZMW/JE4IUaeWhghozbq4nemENndf8yBevKq/vKxEVwmVbtM
 QfuUEe1X19Ck/GOCiKxcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EfuTBAaUjK8=:fY6Dpel4KIoCuH3NVoUfQH
 +VKR2wWXPPRkghXhWWzHhOENfDR9I7jko8cLn57LBv549RNuNRcg22PMeb/qX6nzBSGjN15+q
 cLDj/fR6wBm7LStVxbKCu95Gh/ns0P2U6TKrRtxyoFN/lMifIcG2aCnDihOj9c9nrUwz3JzMo
 JS8pl8AQ2jZR4uQ2jgU5xsOcg4yrOlvUMJHUAJFP3JHtBuJRO1wv/qneLc41brfYTH0c3oyKh
 SKgylYVohGrsExL+Mcf3Rna91vyZQy//Qk7N84eCV+vBJ5vyGiC6cuabMl0oNSLZU08UbKprq
 P38UyoPEgHFzwVKnJ26V2omL5PS7dIvsUMcE/Qx5f7T7g97NVglXnG2O2KFf3EkK3FHxPThpb
 3g67Y5DAPKLlXmLgaEQTn+2QXXRtDXbPpSpoqVOZ783U2nCfSpryVRjEUwofKmP2PCx35OKcR
 aekSI9Pzd0AwIQrD5TM3FWoC/jW5XtENOaOHPEcBOuk446QJ4tPpZLGJoF5m4IIvcsohGot1h
 ATDqMzcj5mvRZOnGySXdvs/CyBbX+A4JQCaET1v9p1m4PMcyD4MKI6yeELiJPSVv0P/uvsuIF
 RId4JetrmZQaseIjfMrQmgT3/Jlixoysv9A6+hdzn23SCiQ+mpwVW83CpUvL8cQEk0tmRz6pl
 I1CPXLrtf/JpzAoaxqqlWw5DAT9i25rVwogTthPpJjOTFMAnU/9TPC6PWUhbiCWqI3OeV63Vz
 /M/ueYplHcIZU/k/HhiF9A3GBocS8cJIHfoMogYBKP4WTyFdACbY7+HqI7BMgH9T6FzJ5+rK6
 51dK/DUJ5bZXbjzHHdmatcw2qUgLSA383LnQyzdX+cKzkLNmJw/HjIpRITecHxCpHMJ6ybg
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:58
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip.Bozuta@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ppc, in termios, c_line is after c_cc, not before .

Fixes: c218b4ede4f9 ("linux-user: Add missing termbits types and values definitions")
Cc: Filip.Bozuta@syrmia.com
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200830181620.422036-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ppc/termbits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index 7066d1e5523d..eb226e099980 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -14,8 +14,8 @@ struct target_termios {
     target_tcflag_t c_oflag;               /* output mode flags */
     target_tcflag_t c_cflag;               /* control mode flags */
     target_tcflag_t c_lflag;               /* local mode flags */
-    target_cc_t c_line;                    /* line discipline */
     target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_cc_t c_line;                    /* line discipline */
     target_speed_t c_ispeed;               /* input speed */
     target_speed_t c_ospeed;               /* output speed */
 };
-- 
2.26.2


