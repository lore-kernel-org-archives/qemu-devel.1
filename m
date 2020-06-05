Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0652063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0652063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAsI-0006Dd-L2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jhAoo-0008Nx-73; Fri, 05 Jun 2020 07:47:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jhAom-0006mc-MZ; Fri, 05 Jun 2020 07:47:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MILnm-1jmcql07nw-00EMdf; Fri, 05 Jun 2020 13:47:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/19] linux-user/strace.list: fix epoll_create{,
 1} -strace output
Date: Fri,  5 Jun 2020 13:46:45 +0200
Message-Id: <20200605114700.1052050-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CGhHXAc2i7kqOHRCZsc0t4kcXx+63+sWpGTRZu3br4h8jHywjym
 l6i8R3CQ74MFoNwzwQHR8TbFwLf8shwAMm0JdAoZIyMuJJIv2f3CzfUi5y3LpDSqN1b+Y0E
 9+/BgF0XvdseStT4xSWMJY2m7pd/yc/HIig5mAMEaTK3oCtvYhuKhWSyX3m5mGp9l/ES/aT
 0sUFSw2eAVgNJVUnzkr1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pxSAJMT5SRY=:uTJzpIGbieBpkBn3I1BBEM
 cCSMckUDkci6qJ8IxWayHnBo142FK1L8xuzTA5Fex2sO9aRajPj7gu3D9A7fG2l2MFcVK5tEh
 gYczV88N0DY6fCbN52xkKbMCPPzxb+8nHNtuppkYw7Fd5uIeTjnp2k7er3aFUtAy15po5wi+G
 jS4sivP91UJA8SSdzazqCLsJjnVHizFdmXE+j106BydICUsTG6HtYYg5YwZOGA7V3hxfsLQR7
 oX6ueoWZvYkZtobo3DLoe4efxu+5ieJjdb+ZFOyrm0fnNqkAoUPEUQK+sHFm+eW54Yd8lL/Ut
 GRiljo0dUzDMjB3O+W9AQuKvRrM9t2J5F/SctVx9RDKiZ3LezFM2CYbyxaBOk751dMRvf8ova
 2ZXVOFE3RUpNRdy2rxP2ZxvEu3Jtk/MCtN+wR7TwmGvcFZHzk0rK//fnkqVD5o4I9llC9VLKJ
 vVCmhcUP2iljwcFTXGNTE/I+hL8LBkOZ9uDslFohdX5Kv5w5aYgU+n09jeYG/KKiCAjZlgl8U
 omW+DytrFvc6L0xG10R2wuJG5yBBm0Brd84RpLpb0HKUtKYNZukNmk01lABGACrsx3Ath9bmq
 wC959SHWOP/oirUUu9aFbDKZV4kSEgR/D5uJrxw8pe9CB2gT4MGiay1XV3IaVMGVpi40LjT1a
 zbAJrc4VK04yRLCGRBQ7/2jW2NM6we4R0HiPnPcUP0umRzb49j2tuolM2nVo5HdFoD2/KJa+c
 0BQ3JaDxqfERjhWxUr4/FGrmFtQxG6C+9ekS3skGWWot3cxVYpdF642e1zKv0rAZPN7Z7pvnG
 IYkcU3ojFoJtifcbpfLZH23uiLWYHLEo1JE+KVQuBSYNR5Iq/+ac2zQDUS7RoB8xEG1KrGx
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Sergei Trofimovich <slyfox@gentoo.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

Fix syscall name and parameters priinter.

Before the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
...
1274697 %s(%d)(2097152,274903156744,274903156760,274905840712,274877908880,274903235616) = 3
1274697 exit_group(0)
```

After the change:

```
$ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
...
1273719 epoll_create1(2097152) = 3
1273719 exit_group(0)
```

Fixes: 9cbc0578cb6 ("Improve output of various syscalls")
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200416175957.1274882-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a80e..9281c0a75828 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -125,10 +125,10 @@
 { TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create
-{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create, "epoll_create", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_create1
-{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
+{ TARGET_NR_epoll_create1, "epoll_create1", "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_epoll_ctl
 { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
-- 
2.26.2


