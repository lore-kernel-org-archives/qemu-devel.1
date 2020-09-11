Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96E7214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96E7214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGorT-0008Pw-Oe
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonx-0002lk-Fj; Fri, 11 Sep 2020 15:33:53 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonp-0000oZ-5C; Fri, 11 Sep 2020 15:33:53 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Md76B-1kp3UV3saB-00aGKf; Fri, 11 Sep 2020 21:33:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] Makefile: Skip the meson subdir in cscope/TAGS/ctags
Date: Fri, 11 Sep 2020 21:33:19 +0200
Message-Id: <20200911193330.1148942-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MrHVAjpRelqQJOP4hIAj+9NIxnoOOpmCfTXNZKY5j5cnzohF2r5
 ab/wkV+l6CIhQ8MZ5yoqGAzCZ504nGnx1PVxt38BDUzlYyG6Qg392ZEPkaljEBbKvXbd6Jp
 f8W9xkCiWxdWLPiAv+AfR8txbnDRaX94EGLGQTSHDxSxj4Fj/WBwN0JdYvdP51myD4E/J3X
 YkbNMCWLbILUiirXOZHpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wP4UtN7fN6I=:OmSpA/3FqvmXSi2z9V0z7Y
 0VTlzInQafdSVlM9hnKrlvrZUzILtP4pIbJXPtSEXhZR4U8S7IkadZgfOJ+EGESKoG0wCGB4s
 3WJ4mbvhRM7DlihiZU8FYkWj6La/8VAbnLYolYvmvamLNmTCvsCxVletfLo7EF2FWlZFUl9OB
 LmeU7kHshB539ILL6mSfV27XZQ7/KtaJgDdPAYrl0Ov788kffW5LF/JrLJo9zOnaH4NaOcmt1
 GcHejQXf5RRVxIBRW8LPJeAvwxBg4JBMg3GZlxZbHpgxMF2+jDQnCCls5ingy0wdwcWTHHUhr
 Ess6VouZFLYKBiK0MWFhVfrgqK0VynDViwLzt7j9siQDACUthpxzgrk4pF42P+qYGolOJH4uJ
 sWjzpVY8Il573U5kemYDA5aZhgyRTSlLEoMmZ7a61+JID4nNLalzEJQBaPW+x/sNWsVKVhmu8
 tBUc7cVnqyw7Ct3TBD0psUigUVz6ZAQ9Y9WIVB77YrTIZXniK0flM6X1UzsE89w6nT0XhMhqe
 NcXBCajVyTYvGLdyLWOirH63RYWaGgRcuq22iW7JTkxSO+Tfs08DV66gnjoskmSlCpL73J9lB
 q5e5L5QLnM7QYMITAgFu2dzosOnMwrYWF/AbP2W+psP0EmBe9jMtfdIFnZOuIcEu92H2OTiOR
 lgxNMZiIXCmY9LVSwjgzTbHUnqf8iaRr2c+En0X8ANW4wYSjDq+RKpYMWiqyQiO8E4GzX1QKh
 opO98FbV7BxzjzPLR+KPcB62V4RlVz6HEQG8722HTzgC+pAFzvujuU8WLgCT5yxR4caby+RYJ
 ZrBzE4kidLWPdTSTTrGmQievbnrZh3w4h9UbVlG6fd3JwpL900YG20eCSDls69XBSYXYCPK
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:43
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

If the meson submodule is present, we don't really want to index its
source code. Consolidate the find command in a single place and use
it for cscope, ctags and etags. Note that this now causes ctags and
etags to also index assembly files, but this is okay since they both
have been supporting assembly since 2001 at least.

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <159916247553.691541.10480293747685886851.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 83bc40b255db..2ed19310cf74 100644
--- a/Makefile
+++ b/Makefile
@@ -221,20 +221,22 @@ distclean: clean ninja-distclean
 	rm -f linux-headers/asm
 	rm -Rf .sdk
 
+find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o -name "*.[chsS]"
+
 .PHONY: ctags
 ctags:
 	rm -f tags
-	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
+	$(find-src-path) -exec ctags --append {} +
 
 .PHONY: TAGS
 TAGS:
 	rm -f TAGS
-	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
+	$(find-src-path) -exec etags --append {} +
 
 .PHONY: cscope
 cscope:
 	rm -f "$(SRC_PATH)"/cscope.*
-	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
+	$(find-src-path) -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
 	cscope -b -i"$(SRC_PATH)/cscope.files"
 
 # Needed by "meson install"
-- 
2.26.2


