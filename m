Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349CC73C42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000C320861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v26oM0jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000C320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkp68-00061Y-6b
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 08:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkp5e-0005SR-OB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkp5a-0004JN-T2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:19:20 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:47061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkp5V-0004Er-GM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:19:15 -0400
Received: by mail-io1-xd44.google.com with SMTP id i10so42576891iol.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=OK1MSHEGp42FLTG7BTsbKchHFLEmkUzYclHLe8Hq4YU=;
 b=v26oM0jvUUWY+r4nVhU9Wex7i99pdYiVryuZ4XqT1omD/ocoX0jCOI17Gu/2qvbcj7
 22NkJmtrDQQ8bn7KOXW5Ll0per+cUxOfZEAaSarbzqLqVxgm1E2vxtkB/40uXV/wYCnL
 nRDWzEuVyZU9kzqV9DCaxsZ9kLuH7zKHaVuRgJKezdtWNe+DFtvmJnpT4laLvuEAZnKx
 lG86NdrkpOVhKCSjOzfkt581kL1QKL00wt6ZIuUc1O7AxaLNzvnYt/49WDIZVOEOEskb
 h0d5jqqK9a9nufDSp9MEBOK26gXVPNme8IuQhOoOLYJ5UWYljqBIWGU17sec7pd9RRfG
 5DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OK1MSHEGp42FLTG7BTsbKchHFLEmkUzYclHLe8Hq4YU=;
 b=VgJ7KCqGfT4RmReLM9696dHLGHujSrNcLyqxPcIuesRV5x72C3mIZZ4i8m6xPwVHci
 eZry+MwtuBXMNcuODUeFz7+/4tsnmr2tBJsbNVud4LKqeu69ll7NO4YlJtmWAJTuTiwE
 VGC9saOgy8arI2xwb+unLvy+Sks0olrd0b36b/IFpa0sjAHgiVCSjVNKbFogl945jQRZ
 AIZFelM8Tdeux1CqOR89FMlVdaK3TBwAE8tF9HNxKXXCwtk2vQw07czDi/Pla9SoU3oU
 IldhibxA+XlSNyQkB0b2DLmyx6qRJw3p/t6Kyyhlk3lUwBl0EaZ9fNE2nTdturBb7pWF
 dPfA==
X-Gm-Message-State: APjAAAU+YCpjcU8JfEoIgRXigZZUJnMgqBPVVeeJ0QKu+OExHVk0cVTQ
 YMjJSfPSY2mpp6nUDbbgsuZBfyJt11w=
X-Google-Smtp-Source: APXvYqyllbPftZP7ADZPemXU1xRKXRDG3sibqZHpfi0nnAC9UfLVXhNjlQk74Be7McD6mk8Lv9rihw==
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr3590987iok.252.1562674749840; 
 Tue, 09 Jul 2019 05:19:09 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id s10sm13592593iod.46.2019.07.09.05.19.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 05:19:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 14:19:00 +0200
Message-Id: <20190709121900.25644-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: [Qemu-devel] [PATCH for-4.1] tcg: Fix constant folding of
 INDEX_op_extract2_i32
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
Cc: christophe.lyon@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On a 64-bit host, discard any replications of the 32-bit
sign bit when performing the shift and merge.

Fixes: https://bugs.launchpad.net/bugs/1834496
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d7c71a6085..d2424de4af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1213,8 +1213,8 @@ void tcg_optimize(TCGContext *s)
                 if (opc == INDEX_op_extract2_i64) {
                     tmp = (v1 >> op->args[3]) | (v2 << (64 - op->args[3]));
                 } else {
-                    tmp = (v1 >> op->args[3]) | (v2 << (32 - op->args[3]));
-                    tmp = (int32_t)tmp;
+                    tmp = (int32_t)(((uint32_t)v1 >> op->args[3]) |
+                                    ((uint32_t)v2 << (32 - op->args[3])));
                 }
                 tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
-- 
2.17.1


