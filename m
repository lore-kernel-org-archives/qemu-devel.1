Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D7C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93C42076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qqosrcT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93C42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9rX-0002gA-RJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kQ9o3-0007UB-PN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:48:35 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:48570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kQ9ns-0007Ii-Nz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:48:34 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id AFFC42E1538;
 Wed,  7 Oct 2020 16:48:22 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ik6Cu1aMCw-mMuGDsjm; Wed, 07 Oct 2020 16:48:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1602078502; bh=ZZPzobQal8lCEHU4wrHkcot3nA1nqc16IGhJSbJivFw=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=qqosrcT2aestIef5CRd7iLscVM0kG/uiQoB++LS0Kd2Ts/G9rL6N9Tjoz7d+okg24
 gruPZpChWWHRHhSfoRwf33WCOeMPzoI8XAMSRwZGzYE/sFtp3zwf6ZmGHtJa7N8Tft
 K2feM/2+ygSyMq34r61BIN/mvNZUeeG2de0Nkkkk=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:413::1:13])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 OPBmtt5AQX-mLoeectr; Wed, 07 Oct 2020 16:48:22 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] docs/fuzz: update make and run command lines
Date: Wed,  7 Oct 2020 16:47:59 +0300
Message-Id: <341c0f5346459669223f1720136e3ee7e9b1a949.1602078083.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1602078083.git.dimastep@yandex-team.ru>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1602078083.git.dimastep@yandex-team.ru>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:48:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: alxndr@bu.edu, yc-core@yandex-team.ru, stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After meson and some other build changes the qemu fuzz target should be
build as:
  make qemu-fuzz-i386
And also update the run path command line.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 docs/devel/fuzzing.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 96d71c9..7846b9e 100644
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


