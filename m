Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F1C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815D92078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815D92078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDIR-00071K-MB
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHl-0005Vs-8V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHi-0002ag-9u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1rGy-1kHP9226vo-002JmW; Mon, 07 Sep 2020 11:17:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] linux-user: Map signal numbers in fcntl
Date: Mon,  7 Sep 2020 11:17:46 +0200
Message-Id: <20200907091748.376101-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
References: <20200907091748.376101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5I++V1PHEcNFxv/1ac2bZzma1ITTIKhJYuE8s/AfKGb4vpTiCw3
 YGroeprqgP2T2IC7BAs8yLq2OqzkW5wXeGuu6aHmX8V73lD5D7HDkyE7WV+tRbq7XOfVQe8
 V8pzkuT8r2q4Ytsr8iQKDDDhfmRh7bpdDF4bvnlUKY6KOCnruLFNUqdsgPjzIOYnj2YL9Wd
 HQxM0SI9pxIfLnk2p8r3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:omUjcF4NAKc=:ZiK7KcfGJ4VdFphpz3bv5T
 QjDk1zQVs/ji+alkD+HVlHEUS6w/8TbVHOIW0fC4WV68iHBmO2XNi83e1+64MZsKl52olhn+l
 98a+3Ar/+tBL/5QO52E3F5FKnTppjxTvFLt9XlI+dawq+cjf20xczSeWLTe0LeUUUmEwkojfm
 i2QgDM6S3dfmeTHzNL4x10rU3ep0WkbwPcwoJ58C54WZReQ8Cvtsxvu7omwO+cDJHMhfGeR9t
 7T9kIco8jruh8sPtqgFlN7V0XRN8WP2zt61zVhyuyXWRk53MzlFRVD2d5j+JAhcy7KVM84Eqo
 7QhRydGxhXXY6XxhsnsBcVTyVVk3pj8cNGWfSY2zRvkpTonWFJrDMEJS1tZNmzkcB5C+iRp3k
 ssvtVtEw2R6XSjlgtDIvceW6Zw/onJ4dZrXQ9yc07rD14R1klwE3Io+jmbpnZJ1TH/kg3kdLB
 U/5bmwWL3kzQbdwJ5bRVEUPGcoLfYJTwL0KexXF5OHBVUHfiB7xSJwB7NxNYiBF3fGibVQAwE
 fmPxL0OvmvH49xvKZflrRrCNUXYYaTl9lp9j0YXiiraHDQmD78BETTWmYBf0sOyViS3al4gvH
 bEdMHPmIliI204zuQx+u3evZB1oEr5FCAKKAglZf7UESaG4P725ES/XVEfhToWpeO2onoIbBM
 DpzieR40HqJtKaSHolZV1czD1cPEG+87j9yzPneXRvGPWKXKcsacW22kJuE9tHCW5JPPH3o0t
 a79CGRmOZJ7ShJpJFTrAKqW1rvMm0dzSUGd7SKPONtgJ+6b9uOl8ThlyrBc1g2+riLCOR/4Xs
 vPwc/6YBvZ/KHrA7D3cJ83IhdhqzKUWz7PCRCVV2IC7Bwj2B3ndlfLDmmrwFTPeR4tLjlgV
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>

Map signal numbers in fcntl F_SETSIG and F_GETSIG.

Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <72cc725c-f344-b7f1-d559-401867067d80@members.leeds.ac.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 07220eee40c5..55ac5c320825 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6874,10 +6874,16 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
         break;
 #endif
 
-    case TARGET_F_SETOWN:
-    case TARGET_F_GETOWN:
     case TARGET_F_SETSIG:
+        ret = get_errno(safe_fcntl(fd, host_cmd, target_to_host_signal(arg)));
+        break;
+
     case TARGET_F_GETSIG:
+        ret = host_to_target_signal(get_errno(safe_fcntl(fd, host_cmd, arg)));
+        break;
+
+    case TARGET_F_SETOWN:
+    case TARGET_F_GETOWN:
     case TARGET_F_SETLEASE:
     case TARGET_F_GETLEASE:
     case TARGET_F_SETPIPE_SZ:
-- 
2.26.2


