Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D0C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 01:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D12206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 01:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvEniW9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D12206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9LP-0008Ha-90
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 21:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9Kp-0007rZ-EO
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 21:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9Ko-0007kO-Fx
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 21:42:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9Ko-0007jx-AG
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 21:42:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so4283036pff.9
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=2x5r/u3yVJ1K4h91LFq3Q8U0CUtZZLLK8Tl77fcA+PM=;
 b=bvEniW9Owz+9Cu+dTxSfAt8h3sxZ8h8of3xQfQH6jR0FCxIEGmaOtKQQuOM8fFaBgE
 RYSlIES6YjBWO5wTviYcMQ/jucKllDMqLvnR6uuZVe8bueu34TKK9HEzha0M9cjO655y
 gI8P1LbByJnE4jKKDjhmZTxBO7bJKpy/9Bpr0emDEyEjXEx8kdguukVHgsQJnsubwLoU
 BCMMuGprC+bmu2eAj+6qF8uto1dcuNtXXjswSXIgv5gyzz7AOBGw9vKuTK/kicRqYLu4
 MKdAgHOgsPTEIoB+qJxb8WAIKWwBnM8dc2awqCnxIcUBT09+XsgwH/tGpVGIQGFllvRv
 h/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2x5r/u3yVJ1K4h91LFq3Q8U0CUtZZLLK8Tl77fcA+PM=;
 b=Yr4exxIGBsFWdleAh3KTwlPCvwPO1csN74S70TNbjy1MP41QZsNT5xbyL8mwW5lP7O
 o+tS1MEUvu0l7yjdSXGZOo/aJufyvoUZVTx117BrgWeyR2OU0X977uABZ0b2Z1dqu9on
 zjZH0U9i68DbYbxT42uEBPbJQ0AOJxTpfd0X+3dqSau1pj/4KEi+luhgiQ7b5Wg/UYV0
 s2jFEgdVzQjezEA0IH8bqxD8qtjS6RBwmaqUkmeJn2WsHPmRSWaoclZwBjnesULxmLRI
 Oc9+eTxCtld+urXKJGkUPXVxtgAMuSJO8Xqmrm1SE2bce7C+YZ4aMpAJnUOQ6GeE11/3
 dApw==
X-Gm-Message-State: APjAAAUrLQUzNmYZ+RDPhaprexDyoIzKfQzfUX6FbfDv0DLd2j+mdy5X
 o7AoJXpJC80LuB7UyFYpRoge9V/PRFE=
X-Google-Smtp-Source: APXvYqwjm781Gor/W3W20iSGbip/cYSSKvTIrAZM2bVmBDn5WM1WCXgR6S+vI2sITIouDioLWbkFgA==
X-Received: by 2002:a17:90b:d8b:: with SMTP id
 bg11mr18684402pjb.30.1560130971849; 
 Sun, 09 Jun 2019 18:42:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id i5sm7290403pjj.8.2019.06.09.18.42.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 18:42:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 18:42:49 -0700
Message-Id: <20190610014249.7346-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH] tests/tcg/s390x: Fix alignment of csst
 parameter list
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
Cc: cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The parameter list given in general register 1 shall be aligned
on a quadword boundary.  This test currently succeeds or fails
depending on the compiler version used and the accidential layout
of the function's stack frame.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/s390x/csst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/s390x/csst.c b/tests/tcg/s390x/csst.c
index 1dae9071fb..084d80af49 100644
--- a/tests/tcg/s390x/csst.c
+++ b/tests/tcg/s390x/csst.c
@@ -3,7 +3,7 @@
 
 int main(void)
 {
-    uint64_t parmlist[] = {
+    uint64_t parmlist[] __attribute__((aligned(16))) = {
         0xfedcba9876543210ull,
         0,
         0x7777777777777777ull,
-- 
2.17.1


