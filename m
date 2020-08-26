Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC121208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC121208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=azoff.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvgZ-0004i2-62
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <azoff@azoff.se>)
 id 1kAqSg-0003AX-5h; Wed, 26 Aug 2020 04:07:14 -0400
Received: from ch-sth2-lb01-mailout-snat1.sth.basefarm.net
 ([164.40.177.83]:48888 helo=ch-p-mailout02.sth.basefarm.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <azoff@azoff.se>)
 id 1kAqSd-0004l2-Gn; Wed, 26 Aug 2020 04:07:13 -0400
Received: from c83-252-213-239.bredband.comhem.se ([83.252.213.239]:59936
 helo=spamfilter.azoff.se)
 by ch-p-mailout02.sth.basefarm.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.84) (envelope-from <azoff@azoff.se>)
 id 1kAqL5-000Xcy-90; Wed, 26 Aug 2020 09:59:25 +0200
Received: from localhost (localhost [127.0.0.1])
 by smtp.azoff.se (Postfix) with ESMTP id 2A5721C125A;
 Wed, 26 Aug 2020 09:59:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at azoff.se
Received: from spamfilter.azoff.se ([127.0.0.1])
 by localhost (spamfilter.azoff.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JURnplJCQFF9; Wed, 26 Aug 2020 09:59:23 +0200 (CEST)
Received: from burk (unknown [192.168.20.5])
 by spamfilter.azoff.se (Postfix) with SMTP id B32DB1C1007;
 Wed, 26 Aug 2020 09:59:04 +0200 (CEST)
Received: by burk (sSMTP sendmail emulation); Wed, 26 Aug 2020 09:59:04 +0200
From: azoff@azoff.se
To: qemu-devel@nongnu.org
Subject: [PATCH] os-posix: Restore firmware location ../share/qemu
Date: Wed, 26 Aug 2020 09:57:05 +0200
Message-Id: <20200826075705.8961-1-azoff@svenskalinuxforeningen.se>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: 83.252.213.239
X-Scan-Result: No virus found in message 1kAqL5-000Xcy-90.
X-Scan-Signature: ch-p-mailout02.sth.basefarm.net 1kAqL5-000Xcy-90
 6ff6423ad6e9f3fe3ddb3182d5d6286a
Received-SPF: none client-ip=164.40.177.83; envelope-from=azoff@azoff.se;
 helo=ch-p-mailout02.sth.basefarm.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:00:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2020 09:40:12 -0400
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Torbj=C3=B6rn=20Svensson?= <azoff@svenskalinuxforeningen.se>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to commit 6dd2dacedd83d12328afa8559bffb2b9ec5c89ed (v5.0.0), the
binary relative path ../share/qemu was searched for firmware, but in
that commit, this path got lost.

Consider the following use-case:
* QEMU is built in a docker image on one system.
* QEMU is supposed to be executed on a plethora of distributions/systems
* QEMU is not installed system wide on the executors
When building QEMU, the --prefix configure flag is used to generate a
tree containing all the QEMU resources that needs to be transfered to
the executors. The path to the root of the QEMU tree might be different
for the different executors, therefore, the path stored in
CONFIG_QEMU_DATADIR is likely not the right one.
With this use-case, the only likely path is one that is expressed as
relative to the root of the QEMU binary tree or the QEMU binary iself.

Signed-off-by: Torbjörn Svensson <azoff@svenskalinuxforeningen.se>
---
 os-posix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/os-posix.c b/os-posix.c
index bf98508b6d..f016ac374c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -96,6 +96,11 @@ char *os_find_datadir(void)
     exec_dir = qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir != NULL, NULL);
 
+    dir = g_build_filename(exec_dir, "..", "share", "qemu", NULL);
+    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+        return g_steal_pointer(&dir);
+    }
+
     dir = g_build_filename(exec_dir, "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
-- 
2.26.2


