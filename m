Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D802C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD68C20897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jWCOfV+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD68C20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5LL-00035z-Nc
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JS-0001iy-6X
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:18 -0500
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:56004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JP-0004yO-Ou
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:17 -0500
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9ACDD2E14DC;
 Mon,  9 Nov 2020 14:26:12 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 4DtuoANL2Q-QCwu9b3e; Mon, 09 Nov 2020 14:26:12 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1604921172; bh=rafnF4txtTtm3ahBh+bma80RdC1bn5g/dQ0z5VS5iDU=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=jWCOfV+Xg5Psk1C9q0lSF3ALeUlQa6POmyZVOWBCF8ieCN99oHfl1R/SCsS0NNKjQ
 CI7VertwTu8/zvHtI/mJhOvEs6QC1wSlqw3us4cpVe7B6JepMP6E0E241F9TSo6S2Y
 ZwNLLrW5+ws732bqsRwxTSH1OnYOEAL6rCurzHVc=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:605::1:0])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dhixZmtAax-PrnSumc4; Mon, 09 Nov 2020 14:26:12 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] docs/fuzz: update make and run command lines
Date: Mon,  9 Nov 2020 14:25:51 +0300
Message-Id: <b7ae9363e9e32d0d608eab92cd48fe6f6db8a5ce.1604920905.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1604920905.git.dimastep@yandex-team.ru>
References: <cover.1604920905.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1604920905.git.dimastep@yandex-team.ru>
References: <cover.1604920905.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 06:26:12
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alxndr@bu.edu, darren.kenny@oracle.com, yc-core@yandex-team.ru,
 stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After meson and some other build changes the qemu fuzz target should be
build as:
  make qemu-fuzz-i386
And also update the run path command line.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 03585c1..590900c 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -32,15 +32,15 @@ such as out-of-bounds accesses, use-after-frees, double-frees etc.
 
 Fuzz targets are built similarly to system/softmmu:
 
-    make i386-softmmu/fuzz
+    make qemu-fuzz-i386
 
-This builds ./i386-softmmu/qemu-fuzz-i386
+This builds ./build/qemu-fuzz-i386
 
 The first option to this command is: --fuzz-target=FUZZ_NAME
 To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
 
 For example:
-    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
+    ./build/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
 
 Internally, libfuzzer parses all arguments that do not begin with "--".
 Information about these is available by passing -help=1
-- 
2.7.4


