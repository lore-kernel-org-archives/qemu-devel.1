Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE43C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D1220874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D1220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi05-0006hX-Ek
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0006QX-Mx; Sat, 19 Sep 2020 14:45:56 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrq-0001UJ-3z; Sat, 19 Sep 2020 14:45:55 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgzWP-1kyoJP3uO5-00hRVN; Sat, 19 Sep 2020 20:45:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] qapi/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:50 +0200
Message-Id: <20200919184451.2129349-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1A5PPQHe8J8WBrP0ysvdQGSXaCtVcCkbVyJEDYTNNjm6fLCf3fR
 2rkQF/B/Qemwjmgn9o0h/Idm6aZqNOl5FIx4gnmuuK1VilykXW9m1/RP75cQ/e3KoTWmlk/
 R5R0eBc/M0H9tdRgYVj1JSl8t+jHkZznKovwTdXURH//nMzc+I0mfVf5yEOzjWXirt7L5rU
 zERq0B3p1U1qfNU1JJGcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6fzmJmeTQk=:JWfJ79hfOl9VDldrolIK8y
 n8A+h+VX/PphEIjkVw5orpd9PXMB/l8kMhY3ROrmY2WkkKbtKD5eHIYfnXhD6srZ4uIhCSQSR
 PHrp40lkyJQjZaUX8o4zk/GW8BX9SVyZA60ImVreQcPG8QUO1Kv5wu/QjNDEWdJjQVxWy0UzH
 Hqg2W/LEGCGeK4RyGAZNVeLispufSYGxWk59wVHrGf/FriDOQ0nu7grkSWXOLciJZgdhgs6b0
 TxlKN51eDetSqLPm7PfIFrFrnzSB0boKAVXVn9rtArCZgq74W7TEQ/eqboxLSn7Ps728+jvcF
 E47QawrQpaHtWwow04n4vExj2rJ6pMSml5VBMXNb0n0CNNdu5DMS/7n+W32QvUh99wHmbcaJx
 gSioClSMFFDwCIAYbrn2rOr636pwg/xZqS43BbcTzVL49xhf3OTO8iTjYw/a3RkHFSYRXKb0v
 supX0TlL+EREGGbjlDl05o4HZ2x/V0RNmIftTVZaODbmK1RtqPfAzhds31f4e3QxcC57Wwo6h
 uHfr4Yh6VPJjTSdSeODdENcphVONZZHrfdBwjlVd4W14h2uyAfeA3AG/Cpa2Vsp0/RMZZbKGp
 Ot9M0MhvwE+Q0mlAF08B6DW53viQcmO2/6NiVGiIRcJxN8Qi1FZXH+k5Dqom7iO6hCgUYvR9q
 EFuUfncy14mdCb1KjJkeuq3ITGZ9/8mXn4RC4Ht1CGnMowwCIqNrkv+CevS+evHkT38pa4kO8
 bdgEy04biBHKagzlVNyKPsUwSz+Ik0HcwaWkEsrsNX8/sA3Hl0zsVbSJkaG9/v3lU6l8MbnaR
 9lKENm+EgA8+0FSvyS9ZAyCLFqjRbiqDF+bLzUJbwiulNcBR3SSRjzNSucVadCHJ6ulV821
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:05
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
Cc: qemu-trivial@nongnu.org, zhaolichang <zhaolichang@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the qapi folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200917075029.313-10-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qapi/block-core.json | 4 ++--
 qapi/crypto.json     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2d94873ca02c..3c16f1e11d6b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1795,7 +1795,7 @@
 #
 # @block-backend: corresponds to BlockBackend
 #
-# @block-job: corresonds to BlockJob
+# @block-job: corresponds to BlockJob
 #
 # @block-driver: corresponds to BlockDriverState
 #
@@ -2067,7 +2067,7 @@
 # @target: name of the destination dirty bitmap
 #
 # @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
-#           specifed BlockDirtyBitmap elements. The latter are supported
+#           specified BlockDirtyBitmap elements. The latter are supported
 #           since 4.1.
 #
 # Since: 4.0
diff --git a/qapi/crypto.json b/qapi/crypto.json
index bb7930d33209..2aebe6fa20fd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -336,7 +336,7 @@
 #                 written into added active keyslots
 #
 # @old-secret:    Optional (for deactivation only)
-#                 If given will deactive all keyslots that
+#                 If given will deactivate all keyslots that
 #                 match password located in QCryptoSecret with this ID
 #
 # @iter-time:     Optional (for activation only)
@@ -354,7 +354,7 @@
 #                 keyslot to deactivate
 #
 # @secret:        Optional. The ID of a QCryptoSecret object providing the
-#                 password to use to retrive current master key.
+#                 password to use to retrieve current master key.
 #                 Defaults to the same secret that was used to open the image
 #
 #
-- 
2.26.2


