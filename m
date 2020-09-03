Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A48205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjua9vm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A48205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDklf-0001NE-Do
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfS-0008Lf-Iy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:38137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfQ-0001YM-NR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id d22so1725634pfn.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bq1eYS85B3lVfUWOPYt+//P+vJhXogDV3XY3bX1W5SI=;
 b=Qjua9vm4Xb2s+TOoRz8gpA20TD505Ci12y11ViB0+MiyYsBaKii5dfLwmQtVdGjPkI
 EGNZQMgUivNRybmo8F0IMnESP714Ig8xxOfRmHDy5tDjjv+AJhfcg3uWH9Om1VCAIfFW
 v/UOMkB1e3E9Gv2b7Ll51H2grJ/frYg6pkpNwwUc3C9vrkUZIa3LwOHZURtjz6ByJles
 v+E6n6XkRpQhMLz4ya11EF3f+KMuaMA58Eqbh9/ydQSCJp3jGrmSL3SEPQH3JcwYeQq5
 VsHCuFPxUaFy0mDrEiDgRKraMTsISd4oNYsf8VIN22+8phEDSclp6cuHVqWBIaagjXjd
 26Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bq1eYS85B3lVfUWOPYt+//P+vJhXogDV3XY3bX1W5SI=;
 b=D7JccgknVYU3DV/K1XnjPLfEuhV1icgxDa8P4M2bFlJBzMaLeFUurPQb5RYGpRA+9N
 +qlFZocHFq+88a/lab6MfATCXD5xWKvl/3XxqoMZTQYlgG03N6fQktlsOgxkS+ApYZDJ
 DX8RWu2Y7PftZvB3t8cxN5ItdCCBYtjRaSuPoMZ04ZD/qVJRH0z3WV2i8ET9WCeslLqf
 XeDeovQeCG3K5Sn+OJ1B7WEXJAwnqYitmyYAB42EEXwzWi49N7W6gmEMJu2d8iMF1z1o
 QVdV+CipiiSkN7cH1HBwrTcUcoyYmZ3M9kBmMQA/V+1dLFPZ1A3+0J1TNEmjy1gJdmqa
 u2+A==
X-Gm-Message-State: AOAM531fYx2rQobe7cPXNu60nXRiFl7WZWq1FObHhmxzRWNkdaUJrXDC
 ODdCM9/tZip59IKC6/XQW4b15Q/DQxJwa/+6
X-Google-Smtp-Source: ABdhPJyVQK+5CBAl6B2nr7dRouGpaxenn3rjtGw7mjxuUUKrMn0ABbAg/N7u0GU3bGST9HgeG3N7+Q==
X-Received: by 2002:a62:7bc3:: with SMTP id w186mr2714255pfc.221.1599121943019; 
 Thu, 03 Sep 2020 01:32:23 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/12] meson: Fixes qapi tests.
Date: Thu,  3 Sep 2020 16:31:45 +0800
Message-Id: <20200903083147.707-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error are:
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qapi-schema/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..67ba0a5ebd 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,7 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['--strip-trailing-cr',
+                              '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


