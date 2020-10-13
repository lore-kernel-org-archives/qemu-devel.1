Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADD52080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADD52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIre-0000nH-99
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpe-0006yS-JD; Tue, 13 Oct 2020 07:51:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpa-0004xH-OH; Tue, 13 Oct 2020 07:51:05 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MkYsS-1k3SOc3l0A-00m0XR; Tue, 13 Oct 2020 13:50:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] qemu-img-cmds.hx: Update comment that mentions Texinfo
Date: Tue, 13 Oct 2020 13:50:39 +0200
Message-Id: <20201013115052.133355-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7hJfZXYvKH7Q8vgDKY8yqrMF2E1WSKYdgFspLCZqZVgMwXepTi6
 tIh1a1lwgK/YeA7gfWMFuxVeZj255wBJqrWA+M1fM6GiapiV9IRc2YtoGVwrJjsNTRIXA6l
 Qz0sLl3fKdIR0ffcgW3h0Ggioq7MobEPyV6Y9rlRxNtr7K/sYZNHgcpl/Vb5WPruCyk8fVe
 KFKuDsgJd1S0ej7SRfoBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8eQJ/hbtFhM=:MIRGn0cvSV7LXrptDu+HCV
 lTh8fyF8xHAy/SRX+pejULmUvjmGT8pdLc9WaoLURhsKcz18F5bBCshPLQbLu1C/af/YEFIby
 /KFUTNgcvN+iW/rviHteP4luT61NQNAnwuLydI1TnZ/s105zBKPPjSdK7gDktibNViknzOZGv
 GQjJZybCujbA+m3kdTtR1gp0pTBU4sxycE15oU4crNlySgvs92lNYoKVSXFO/FuQAtilDoEyl
 J7DitJ5X98K+x6qIh9SdvinKPA+hsaDh4YvmB5EE/1ImFZiJkrivGhacQNOXFqyWh4fzFzLbD
 g/Po4cRIpu7CeNr8vCOoPsauQ4WJxDRc174DTpW2+QCP9ZTyOV3dRBTNnXO+HI6B3otfjH+u4
 1GCVX9BE27BlJ0f/+/heR0g6nybTlY+OILhiApak+HibfVIw4f6V7Gc7Frj6w
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:51:01
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Missed in 3c95fdef94 "Update comments in .hx files that mention
Texinfo".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200929075824.1517969-2-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-img-cmds.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b89c019b76bf..cab82342358e 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -1,5 +1,5 @@
 HXCOMM Keep the list of subcommands sorted by name.
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
+HXCOMM Use DEFHEADING() to define headings in both help text and rST
 HXCOMM Text between SRST and ERST are copied to rST version and
 HXCOMM discarded from C version
 HXCOMM DEF(command, callback, arg_string) is used to construct
-- 
2.26.2


