Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF74C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C019B2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C019B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIxC-0000wV-NB
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpd-0006x4-0N; Tue, 13 Oct 2020 07:51:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpa-0004x9-3C; Tue, 13 Oct 2020 07:51:04 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWjUc-1kzOZd2WjY-00X49P; Tue, 13 Oct 2020 13:50:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] target/i386/cpu: Update comment that mentions Texinfo
Date: Tue, 13 Oct 2020 13:50:40 +0200
Message-Id: <20201013115052.133355-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VT0tRzQgQqS3Xn0HZeurVsM0NOuomd8i+kDrc9WfR6rfSC0AD65
 KBlMjcoY5E58Xcty1zGECxlCi8s2c595UvYVGDFNH0umsQdIJrFpbdTL0FP5v3NBFgQ+4h0
 N9SiWL6Gkioww76ygNYNSrQtAJconPb6d09XCz/hpaAz6fCt/m+jmWNB3lUGiM3dWctllK1
 O3Ignd1JhFvN5Ks8YPu2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hIZlfULOJxg=:fLkuQqNTb1EpEo+OnhFiSz
 KpB/NQVx0vRNt4pm6N9vRBxfFYZG29B5+No+yZAs20lonUv8pBRGdnAsbPRUwM00lUEYmUNkh
 NzNzxEHqbwyFKED3BU1mlwXIj2H46lWYayhOL3HhjXt+K9zAat9WQgC6G0JEf5qKVH7Deo5Nu
 UNR93boD7E0aW0icFIHOUbVgISzloDu9q/WvqtRZCfNOwET3pwuhgOK1NHyB7gJ0EPnEt8L5N
 YSGBdrz2zKnIPoLZ8uDdhTo5Oypn/e8n5wFT5C/X8rMOnQgfIK1of3yIfsCpxPacQ+SBx+/bv
 SXkFmGR6FyGKCvS2l1NF0um2D9YjnHxTb2DKoNPVPTT7OMkLWT/3f7FguwBgEgdGoFE2GMu38
 D/u3SW6X56J2Fe7A5ED9paQ/+JF9X62UNJcy8+r2j+IDEUnUWL6UvTNZNxpdaAj3GkF0HX4GS
 GNYZJXBPT2OhnOndHf8ojTNkdEEEvCVLR1hdBPoaPsCJz9BCXsBEfGdyIAfzQyYdIDancn8Qc
 sd9sRw6jpkx+cqiVf5vhHUuCisBZA8+/yGOyJdLcNQfluzIPgDJ6PBW6cORPaVIOB8V7EYDKr
 g/tkIU6dh9bgEdby5ztVenP0Ee1New2BnL0mpHMAUth2j1qzghzFhuv5qRl961yhNHdeHwF51
 WfWOo++pWwvDTD164QXtV4IQ8dAdsGUkmMcIdrg+iVHReqwLEJgm4odbflP5injV65gv9zUJY
 U9UVC6sWMV+krRmZAPJX0uuff2yo+nLmzD58jcWj/v9aG09qQ/NwJ1OqyMGxsR1jksV5ZkEKQ
 X6yz9nxlR7cswkAwOX5UbfOPT/X/XazenhZZoCvYkmeg4p6dHMOtx9px74SIlaUeqOPU/Ax
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:50:58
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

Missed in commit 41fba1618b "docs/system: convert the documentation of
deprecated features to rST."

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200929075824.1517969-3-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f37eb7b675f4..9eafbe369075 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4127,7 +4127,8 @@ static PropValue tcg_default_props[] = {
  * We resolve CPU model aliases using -v1 when using "-machine
  * none", but this is just for compatibility while libvirt isn't
  * adapted to resolve CPU model versions before creating VMs.
- * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
+ * See "Runnability guarantee of CPU models" at
+ * docs/system/deprecated.rst.
  */
 X86CPUVersion default_cpu_version = 1;
 
-- 
2.26.2


