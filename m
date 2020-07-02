Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865FAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5504A20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5504A20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Hy-0003D2-JL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17e-0000mH-B8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:34 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17c-0006L3-BL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBUVj-1jf9IE3rIN-00Cx8Y; Thu, 02 Jul 2020 17:27:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/12] MAINTAINERS: update linux-user maintainer
Date: Thu,  2 Jul 2020 17:27:10 +0200
Message-Id: <20200702152710.84602-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lXhXPznCtWYYW3+WyUHDrGvvWVjzfXO6GQjA6wBzYeNZjV1tOYi
 uoDfny3oXNdUl5yoNsWkmyXphKn0c8P1sr87micitv6oFDho16LIgO/uUBM2b9Q0EVtXKa9
 mCjvgxhk7mJDLPJULk4CiQWBdqaaZysMoUsQtwXDtM2ygrJSPTGAmiPUNPRPOgfE8Ca5wgW
 6ZkNFZEwKo9yBADLBckAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:THQ+ikUN7eU=:MjZMX6pFxd69XlXO7zCrLB
 womscvlv93L7pueBhjno0L+jHjkkym1t06gDJlRkf1eiKYwuk5rnNZCNSIxn9S7pci9BHbNWa
 QOk9rc2Zj39hF0JkkzTAK4B5lgRL+nGtzZglLOAH7rXiqE7aD1t4vHh5rO9ZL1rLp/A/bT8pX
 rbAa/oeRVetdKEg/pEo4Ngh6Z6Ex/oix5WehX1Mqfy4rfw64+pblsM8dg+0791/DLysv6CRrp
 IdSVaCvG+2YnOMMQU67Gp4An9G7HdzrY6TXjOWX09+gBe0LwYxRGWbzyJ8atLv2fSUaDrQWmr
 mp09pvtJOzjZbPPjKQprTU/HiYE3zoCN680ymkNX3EAnaZYD1tPCsm1C+Y/skg1q1v1QWLXL7
 n9Ya036KVg5i7TzGwVPagMK+iJpv44S493nipBlrinQVtTO3xVC/2xhVo5NrplsTA6c/sbdlg
 qH/8jsv6OuBduAdPTpPQQD7oYev3FfSY0NjvwQxGg0EQuD5+LQvMZEx8bLYi6/NBnLDJU7zG8
 g1Zw4wfAo3XA1XCoB/nV8SSvchZE5X6dSK+b/U0w7BkC7aJC6HlBdXDye58zSyGRKHK4oZM+c
 VCYwQUzCvVFxizk/mDCXKSuy85yFxDQh/1q5x3rrx2qwzB/Jod6T9DGeNQsvsbzxkZyQxE2Vk
 HnCrfvodJctpF/962w0fzRyNgcELMvVWdzmv3kTLcGsHXkp7sxtk00cUd2EyMnmazfnpzjjX3
 lzPcqAq9iZyJTihe2wv0pIavqeCw87ixYjR/g8Uzo6qzuCnm+4fNeAB4F2q8gXLxQb5+BJuit
 ZyTJaeAq/jHToM7TUyvrxH/9EKmitVUQc8ylZleWCk/QvuJ4JQ=
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:57:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Riku Voipio <riku.voipio@linaro.org>

I haven't been active for a while. Pass the maintainer hat
forward to Laurent, who has done a stellar job filling in.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200702111636.25792-1-riku.voipio@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b1d..29a23b6d3a5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2629,8 +2629,7 @@ F: bsd-user/
 F: default-configs/*-bsd-user.mak
 
 Linux user
-M: Riku Voipio <riku.voipio@iki.fi>
-R: Laurent Vivier <laurent@vivier.eu>
+M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
-- 
2.26.2


