Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9083DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63228206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63228206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYoT-0004rc-J7
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jhYgV-0007EA-W3; Sat, 06 Jun 2020 09:16:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jhYgU-0007fF-Qd; Sat, 06 Jun 2020 09:16:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MnJQq-1jI9Yv2r3c-00jJkg; Sat, 06 Jun 2020 15:16:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/19] linux-user/strace.list: fix epoll_create{,
 1} -strace output
Date: Sat,  6 Jun 2020 15:15:52 +0200
Message-Id: <20200606131607.1250819-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SBmLxARCpMkkme1rs+rXrj3ycndHosz/E65A48jUjsIk8xZVuTb
 hGoLqcJ90InbFK1IF/hN9weDpJfCbe4f2LlVMbdQRTDMC97Sdq3BowBWeK+t9iMNedARH3h
 EqnJ3+yTYt1bXKhUijwg4LqOxc1CZzwiq+tN23uWN6Plsf+GkUtUS8xpNJCAw147fcsvlZW
 lvFQJd0Tce1e5F52zV/YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5V+2sR6BH/w=:FwAWrkIhVbHT0E0a8PAVMB
 IMC450gHNB/4u1wIjJ4LOrN5FNpwoUOGRLSbQCToyfeBq7vUmXCSLxvLvpzXqqgHFQSQCXzo0
 5wlPhmxV6ogvRSKVCMNJBcYKLnVrnal6Yo3VEY/z8DATwavxOwIu0mWR2uB4828DgFb3xLNfc
 9nIXE9jk31uwPh68Xr3TIG+X5sngIL0ch2m2TTt6TwA8BAxGZf6OYOh57Sa2kFlpfBnZjydi9
 eWnY7TUxvZ6OCqVnuEMOgOFyPyTThGzzRPQiC8Ii/5h8O6MnT7g/Y5fZY7vh/LeyqFrCSjk6e
 7u/rqfw7iojMlpmMCX4Ag85uglAHofRvo9Pp4dfcH+0akSJyWX9sbw4pVE3LLoLWzue5oXZdV
 9972FTDrBENX5Zm8oz5WwRJXl2INDjs+2swrfPmwLmWN1vtPBwRV1TqPqL/ggBz0SZanbC5C3
 fDUzmw0U4uQBY1s2JU7aaDN9/elGVAvwGfoHfW0dgsOPPieMgmKulwK2b6YEgTFbvUk9WuQyi
 GBT+s6FUZVmLzs1MrwfVLFqMe8j+XOuZSUSwN6qlPDeL7ikxIWYZhvvfc8hpT6yoPt+ppjUkY
 fwLjMYr6YUdDycP/AXcSMXlzdThu6BrnW+hIrXiCDGr8nNzhbv8MLK/iwtx/Gk8AcV9qridGH
 bzaXcDKHPTGQoCCI9x85VDKV0uXoQApOGfUBLFNv96mlPdE9YLJq994hqwE5c2c5mBSUoo9kp
 8mR0RMfHKGVXjinJTD57wa8xlsX5GSYHwFhT0+v7JWanCgFmpvxYr22je7JlwDVBXYV23tJtf
 IvafQYEHthT2o6Rglr9dulK0jiM0I+EjK/7iqzzX5DE8h601xnTJLEv8jwfErYY11IakPI+
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:19
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


