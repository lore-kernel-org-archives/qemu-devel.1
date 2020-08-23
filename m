Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C7C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C7B20724
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C7B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rTc-0006TD-Ga
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSq-0004q1-8y
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSo-0006do-JF
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:19 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MF418-1kPJwh0Nr6-00FWNg; Sun, 23 Aug 2020 16:59:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] linux-user: Fix "print_fdset()" in "strace.c" to not print
 ", " after last value
Date: Sun, 23 Aug 2020 16:59:07 +0200
Message-Id: <20200823145912.1171738-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fQMcgnkCFnxaicvpaHt7bUk2jrLc0OM4pV+KWmfeJkkP9th9/bI
 C6fQgRJtnV/Rb1qJMKmmHGl+wooO4CTHGk7JMsVBGhDzIm+7roVuwx7S133uJTI1e/6XU8W
 SwKBWdhTTymLgTl6D5XUG2v2XxZmrrp0TF9aub3lHCCUrYE952lGnolDBeja4PlLEXeWzVU
 4VOF7zsoUDeu/am2JFjQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dY4q/t3LkVo=:g5cyiyOzHR2xYXvjbQ0oDT
 GWdfL+ASgrDN7F1nopAnQVRHr3nY70t2nl6Uf+2ezmh9elwcx7JohPNXiqeVfyvVYJhHNqovx
 U0P9PNcAL4dJdlo9muJzFk5dvuO8QBSDJVRAnnaie/M8Nrw4dYICHTkv3cELhnt6FlxH2qeAs
 QQdTJVIHJOuFf9NpMP3DDBKzvHzbjBoTS0z3VRPIvE8od3Mwp/JiiMoPtxuQ8JWjVEBVEUv27
 lgfqMTYGISLE/aJ1aP2gVS7MerwM7I8Dzxh8eDmj3h1LMEtl2UPbvuBmztwFSQ3Vr36fmlcrD
 X6/zY1jL3LPClvjTC5e0tz/ZZf1rt7ctYX5Ibjy29d+u325MNsf9i+EuWp9vhqoWNDG0RaUFS
 UNw0FYoVQUyZV41+KlxXRBuxDLty2dfJkGppVbLkVoeifKDGcS1nco7BH+/xdm2WJdR3RRwak
 loemA2yA8arWLrSKX0SFbh8eLgCUMDKGQUonNq6l01q4t74oidNbLWsNINrhFX/mC5+9mcvVr
 VpYSAUSCSXNuel5BwHlaC/0VBfKTERL8YuiGkCf9Q7sWkugRIAO7+sy5I/aVsF1i+Sdx3dL1l
 gn/0KZr467rL2WtSEC6FEehk54mOq3+lTgoKbQbpdrLIN9WAzLsW6ytyELvWxFFwdjVTRmgqy
 saO1Tl7CB/4oBxibLxLtrglUlUIBLJf50MkbJj3zjYQamBNfFP1+J88BVxvjEqS90Y4tFwqEJ
 gIn3OEhRs+E9yBO/Riuh2IhMbAP5CR/q1DGlNwb/77XKrCaFBq0uEJv4l4qayDB5dPva504Ln
 K5/pH3hFxrT/zoqyupKLH0/fzAT2/7cf+/I66b23n1S/K5+PpFjXDUvWbXW0ASIYNFyrOaU
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:17
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Function "print_fdset()" in "strace.c" is used to print the file descriptor
values in "print__newselect()" which prints arguments of syscall _newselect().
Until changes from this patch, this function was printing "," even after the
last value of the fd_set argument. This was changed in this patch by removing
this unnecessary "," after the last fd value and thus improving the estetics of
the _newselect() "-strace" print.

Implementation notes:

   The printing fix was made possible by using an existing function "get_comma()"
   which returns a "," or an empty string "" based on its argument (0 for "," and
   other for "").

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200702160915.9517-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 13981341b327..5e380486433c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -541,6 +541,7 @@ static void
 print_fdset(int n, abi_ulong target_fds_addr)
 {
     int i;
+    int first = 1;
 
     qemu_log("[");
     if( target_fds_addr ) {
@@ -555,9 +556,12 @@ print_fdset(int n, abi_ulong target_fds_addr)
             return;
 
         for (i=n; i>=0; i--) {
-            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                qemu_log("%d,", i);
+            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >>
+                (i & (TARGET_ABI_BITS - 1))) & 1) {
+                qemu_log("%s%d", get_comma(first), i);
+                first = 0;
             }
+        }
         unlock_user(target_fds, target_fds_addr, 0);
     }
     qemu_log("]");
-- 
2.26.2


