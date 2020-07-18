Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E37C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F226620684
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ictH+GHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F226620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwml6-00051h-7e
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 09:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmkO-0004BG-7W; Sat, 18 Jul 2020 09:19:24 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmkM-0006pB-OQ; Sat, 18 Jul 2020 09:19:23 -0400
Received: by mail-ed1-x544.google.com with SMTP id dg28so9738280edb.3;
 Sat, 18 Jul 2020 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=KjUtoZZqM9NA23xjBqHKp1zQEaxmX9yjbn2a/J5brxw=;
 b=ictH+GHXftQdTaLHsB04YtXafJueuET3qkfXS1EjpWi3VC55h9NA1KOGQLMKxaKVq9
 8GlGv/g9MonfwyVgq793rE+SjLvehg5Sgy0B7hDgBa8+q+KoMLFhDNEWkHbEpyLS3LfS
 237ZPNCJ89gsEXkbRsnanA9Uz4BmYMPhJOZasXPzntwEgrubR5C0jFYBrwq2UErW8c+j
 AmK4XHKVYaHmwjXtpvNj/8+w3gohSYtnYomnbLuaQEi//EV96W0iXBm40WHKFqSBh8Bo
 NLRYL0a9eW7o59NC7b7zQjod+iDoMtuFu3gH9yE9ZtxL0nxh0ovSemJqrp7m1M1Tp3bH
 /wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=KjUtoZZqM9NA23xjBqHKp1zQEaxmX9yjbn2a/J5brxw=;
 b=T3p9NFfPHemmBkJMBXxihwyS2GU6MfeOeGUQYsbDYHQPUA91rVBQ7G+7bxR92IekXX
 yy+AqzT1KOfeCCUD4W5K2YX1Q9xDu5stUOn7LL+34BfCe8fg0AOZtrsbW+5k4c+U4S0V
 JGLVbRgx3mMEVJs4eqydWhVRGsxpsvAcjn88DmtiVGXzxa6FPxTArUvmODZPvLhT6+6W
 Vcaj4wxpfy/v9yphafm49wYtgweVxqIY3MJrY2xX2jOiGZ4XPrAOa4tlGhPjh+NGJyQR
 9mkG+UqKsVrUI0tls6VnY8oOGWRtzYaCDCuBdGZ68JRZRUwGHkAn5CkZeqoRBa2mP+BM
 s/oA==
X-Gm-Message-State: AOAM531zss+4odbOvFBE5VFWHRxB0V8GGsrnqxAGZ7I2oHk5tuBDl2ly
 7SfEsnO1iCnwHowtEeajXYHY7EXCCikPVv0h77pWCz3Nwg0=
X-Google-Smtp-Source: ABdhPJyVflJu8k/hRoYB9hfjCTLGTWHRS4gLeccnSE7tpouUq4tc7z5D500S7UoycYxTshlZaP0XSjoJiCAaaWJPTJQ=
X-Received: by 2002:aa7:db4b:: with SMTP id n11mr14011006edt.137.1595078360883; 
 Sat, 18 Jul 2020 06:19:20 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 14:19:10 +0100
Message-ID: <CA+XhMqy95D8X-QvBcEfL=a-Rkgy6aJtheskkqZwQkreru+T_Wg@mail.gmail.com>
Subject: [PATCH 0/3] configure: fix forSunOS based systems
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 63a3c9639d708a796abd958607aa6376fc9b99f2 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 13:27:52 +0100
Subject: [PATCH 1/3] configure: fix for SunOS based systems.

local directive make the configure fails on these systems.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index e93836aaae..5d100eba72 100755
--- a/configure
+++ b/configure
@@ -59,7 +59,7 @@ error_exit() {
 do_compiler() {
     # Run the compiler, capturing its output to the log. First argument
     # is compiler binary to execute.
-    local compiler="$1"
+    compiler="$1"
     shift
     if test -n "$BASH_VERSION"; then eval '
         echo >>config.log "
-- 
2.25.4

