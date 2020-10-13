Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56789C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B3F206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3F206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJ0g-0004wG-Os
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpj-0007A6-Od; Tue, 13 Oct 2020 07:51:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIph-0004yI-PS; Tue, 13 Oct 2020 07:51:11 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDPuq-1kaaI30EOU-00ATrN; Tue, 13 Oct 2020 13:51:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] block/blkdebug: fix memory leak
Date: Tue, 13 Oct 2020 13:50:47 +0200
Message-Id: <20201013115052.133355-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sXFJcObT6HydYI86ubWnhmwbL5VRqq6w5mYyPUT9X0c+XoSZesJ
 ki/HYXs18sIOT5gKFSpY4Pkq8xbC/ydcpcXhjPvQH/Y3TfP02xlo6d5B9tE9pKCiU+R/VHg
 KBICRPWN2sYPjceAylf33Xg1fLOZ/nuEkRXSu8inPyN8MZ5/MUY5LVNS01Zu8lHtiSJ+Mk0
 oPz1uQXY5JO4pt5oxMKPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Choe0KraBmM=:4NazQIya4DsCzxILkh8r+M
 V/D9yQKoLJ5VwnnE5F8AcNQnOxFggI9w6FzdbImZcW/gRR6BRV9N57wyegGIdMoG7HFoz6z96
 RmNUXYPDjdVjDjTgNj82EQoAOCx0D9C9jfIhZt1g9WXPPEodISv4V+82rEAs67d07Y0GiQuwJ
 wBQu1TqXlwQHHsPpV6ZZnxV9OLzuAOjGG7ezLoeNUMvPx1Vd+FhjftIyDJp/Cd830FYIn5SC9
 DZhBvvTxnGLDZO4onaS9ICYNLgVATq1jF7vFC1rw+rIwmrGMiq/kffZ9bTp2ZdNxTtfklQJad
 tm4jMZwyrEpIHFrevdFDhs1oa/euVdjSpHA2U+0svtw60bKV9lOwEfvzg/se9El1D6oozAs97
 +eJROf7R6D8q1E5s/O1e6WZOdR36c/Xgllm9dNO8C9+BnEzzdWMtFhDP4Jr16JuzILd3Cmf6J
 YBUWY6yktj45nJAAmgjUHUymOZ4g+Cy+YTFegz+BNZ4mzRZNtzxeD32OFRXCHmpDAkXClx2c9
 rFTtM52VgJytRSdlyo96RleB0lkj3iJ1N5+LaBooRHtPeLhILjW4JENq5iIC/Do/3RfHERYQR
 jjMQXRQktRL/hA5k5w3D5JFLwPGGUbxGwpk/gOyX7baYPldcdn9OJX87VR073av1AgN4EgBch
 XipcDznMWcNdSN30BqJaGAszVu3cCSX2cc9ROnppaHgOBQ+3Js64ByTyhBE1exF6jhhto8E5R
 ZPQ01gBvqI1NrWAok8nWJYBGpoF3axVBdOdx8jjWiNJkwadRQ7C880QdT5RB8kUgzwQt1au/L
 Or2h//1V+KqzzmHKwGPQQAYwYDfnZTX+WJTaLVF40rYf7hj256qfMV9Bo16Q8L7l5Mm1SJ5
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:32:45
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
Cc: qemu-trivial@nongnu.org, Elena Afanasova <eafanasova@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Afanasova <eafanasova@gmail.com>

Spotted by PVS-Studio

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1e903f928eb3da332cc95e2a6f87243bd9fe66e4.camel@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/blkdebug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index eecbf3e5c479..54da719dd151 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -215,6 +215,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
                                  BLKDEBUG_IO_TYPE__MAX, &local_error);
         if (local_error) {
             error_propagate(errp, local_error);
+            g_free(rule);
             return -1;
         }
         if (iotype != BLKDEBUG_IO_TYPE__MAX) {
-- 
2.26.2


