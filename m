Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EACC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3117621527
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3117621527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRtb-0008G2-UT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrc-0006jg-Ef; Tue, 27 Oct 2020 12:30:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRra-0001Ug-Gn; Tue, 27 Oct 2020 12:30:24 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnIxu-1k8KKM3sG4-00jJLH; Tue, 27 Oct 2020 17:30:19 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] Makefile: Add *.[ch].inc files to cscope/ctags/TAGS
Date: Tue, 27 Oct 2020 17:30:08 +0100
Message-Id: <20201027163014.247336-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
References: <20201027163014.247336-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lwAoRVrohGeB7WJ6j7hdr33oLFKyBmq5ScQM1zrGNlldj2BtP2C
 96oaRrn06VdjkGLBE5so/rs60uBTrdit/SAliEgAqU8oxMLvdnw2QFwVvtgfg2weJbMJeVC
 IH2njN2T765vL0U87yxzCgrUgu6UuAARXduYWzCuig7RUBZiXpPndDiCsn3NeF2HNX34Hyv
 IV0CF6vCW0bMEiq/qka8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gs27+63ytVk=:vn44x3byg9FBELRHrrPPkZ
 f3NUn0kVBAHaW1GdkFx6xHJjMFaCcN4spjnP9lgXT0izDUdb58eo5TFHA9fktsNpRdlkfBGLw
 zgxranBYfAaq8Dq29i/tEW+Qt+cLhmfMcBRWIpT5MQa9LdOfaEyily0in0aMAnOQnqIIXcI0u
 c9lbcSdYdlivpvRwPiyWgRlDfZYQfoJmHQfn6q0qmDw5tVZi1H6n8X8aTt6ttOURBBjsI7zge
 0SUcia+gB71y9/j1++oKZvEnIcHB3Tv4Amd/J3Fsx73JYsn17/4pUs+EDHTViLErqYpzC7nqc
 msbhjjM5iJzS1qFWbgL/Xb5Og2jInLX6DhS5S08Cn+OO+kpTRutwx+FU6KCu2X5mbP8W69PLr
 gj8BAyB3vkcesO/r7/zvX93Pz3J+fv30zrsJM0gbwXOVN0SSaZawpEuB/JmWuzUh4egTY/gL+
 esQOYCuhXA==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The code base has some C source and header files that don't get indexed
because their name ends with .inc:

$ git ls-files "*.[ch].inc" | wc -l
66

Add them to the list.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160258069310.900922.1495166540282536628.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 18f026eac3d7..5a7ba39ea75f 100644
--- a/Makefile
+++ b/Makefile
@@ -219,7 +219,7 @@ distclean: clean
 	rm -f linux-headers/asm
 	rm -Rf .sdk
 
-find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o -name "*.[chsS]"
+find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o \( -name "*.[chsS]" -o -name "*.[ch].inc" \)
 
 .PHONY: ctags
 ctags:
-- 
2.26.2


