Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C3C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B11920936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B11920936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZPc-0002iy-Bs
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZOF-0000WN-5j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:59 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZOC-0007Z1-QL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:58 -0500
Received: from localhost.localdomain ([82.252.154.198]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvKL3-1kIcxf142z-00rDQ1; Thu, 05 Nov 2020 08:08:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] linux-user/mips/cpu_loop: silence the compiler warnings
Date: Thu,  5 Nov 2020 08:08:34 +0100
Message-Id: <20201105070837.558332-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105070837.558332-1-laurent@vivier.eu>
References: <20201105070837.558332-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mB2wYGg5fJmamHxht+mWKsCvbov7nBc+/AkihQD+UANjNMzleP3
 5lfScrPwvmH59imx+R+7m2HyXm/wyh5BiqHIj7v0HWMpIlY9omplsLzc42RG66F/oM8iO5T
 1Za9+C/icYIu6BtSzFtOc59pY21P1UzhPXFLbg5CFl9c2HxK+302RrioHYnbts/GBt4A1y9
 s/dmsOGU9vJxL2twtU4ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDY63zzMv0E=:n0XDVufOE5aKGnydyB/wmz
 j3VC8TqXEXKsTVxRT87jIHQJuuLtuxpCIpL97zIH0S9HaRGl5f8WT2lklm6Z2+x0EIDFUpHnh
 a5i6Izw8RbmshqaHDjvoPx+6p5yRT56+lGvKpFBEJ6CIoa0d70lPr7VTSiK7PTXVFmo3W9g1i
 2emKB56OXxqoq5pKh03wMaUvVRzTIS1yCOYgjxa2QO+fDd54HmPYAwsD0VTV961WAhDaRbWqv
 wYNdMW6AtGIYip5y9Mt+2VM8+ko3HjCHmSA8zl1GJIsfMHXjg9n2NWzhPC1xMxl5Ponzgj0C+
 juHCMTMRntoKC0SWTtbkmojdjeFnjnnFNUtsMmqUZruGV2GXGK2k/PvAJKK+rbp/UGWjNYfMG
 bNAWlTt4PxtMKeuFwQfLI+hqZnyfF7IEhHWfBw4Ggs9nHr/r0lHJ6dTxIQLRG
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:08:48
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
linux-user/mips/cpu_loop.c: In function ‘cpu_loop’:
linux-user/mips/cpu_loop.c:104:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  104 |                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:107:17: note: here
  107 |                 case 7:
      |                 ^~~~
linux-user/mips/cpu_loop.c:108:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  108 |                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:111:17: note: here
  111 |                 case 6:
      |                 ^~~~
linux-user/mips/cpu_loop.c:112:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  112 |                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:115:17: note: here
  115 |                 case 5:
      |                 ^~~~

Add the corresponding "fall through" comment to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20201030004046.2191790-5-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/cpu_loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 553e8ca7f576..cfe7ba5c47d8 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -104,18 +104,22 @@ void cpu_loop(CPUMIPSState *env)
                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 7:
                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 6:
                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 5:
                     if ((ret = get_user_ual(arg5, sp_reg + 16)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 default:
                     break;
                 }
-- 
2.28.0


