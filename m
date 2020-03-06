Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90137C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3532072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mit8FxkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3532072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGv0-0000RT-Hk
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbw-0000eQ-1h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbs-0008ES-5J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbr-000887-CM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id i14so3195297wmb.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AHdCZ6f524TmUpBjUFoFjPeX4noFjGjqB5SJT2Ug8KE=;
 b=mit8FxkHjUBzMGABXzUXDuH8/C+4cQE9KtQvG43DvAPodGs7bHWKUsQikZeOEw+voT
 6QDkg97lOpBUn6nxLbgNNBLaNojZu6ZZwwcZt06/9kdNtnIhVHqwCXlLi+Vuahz8ttuI
 O4dzRLowSX+vZ06IA6IJjwq+yyB9CgdZya0DmnU/KGgJKREKD0ml4qcfb82DWD+QxfOS
 rcs5/RIw+b+lA7Yf53DFmzw1PYj5wLaauGSx0mgbJ1t2Bg+fpnWe3EM2RN4ajDISwysp
 UdtzEYgEE2TzHk2dFcdxuKGbcRfWkHSMSu255p00C1O3vnnvDWljJQroOUfJv1c2tNVx
 Aczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AHdCZ6f524TmUpBjUFoFjPeX4noFjGjqB5SJT2Ug8KE=;
 b=GkyeVqasxy0NeyLWi4br5+7U7+PWsGrBG7VtCmIlnD2Gccs0KhfzxwUZj4agGllXRr
 dQ+7clwmcDGUppi/maMGECKAZbAS1y58YVSI8xWBg2BEhE7QYozvz7YWQFX9mtEet/+5
 uDJeE5P3spZaCCt4AKw2GFIOwyCyiKe+YbES8Wl9xQBiWyj+L4hyPFyKkgHa+Q1aHcsd
 aoYvSJYD9kNZFrP76mRY0u7SLeqvdRZn2kk4ORvbwa7biEiUTYSiozJnndNePZGjT0Rc
 esHd1Mw4fvMuGd7TbhldTTOeq3QQ3dLOa83sIiWnTKuy5bDqEU89Sxi2eFKkwm9mJ22A
 +7Rw==
X-Gm-Message-State: ANhLgQ1s2fGtBEttLLB7FU9W7SSYHh7oDw1eqTWmh5+gAkOxQGZRksDx
 4Vx1Nbj7ZuZJxMPEonccLJSqRpUJyeCSFg==
X-Google-Smtp-Source: ADFU+vvgmCciq++L4mDIssDTMI5iHQls2jRpxND6t7vLJtYnyHZO13b/saDQuAUz6zghzPsQ1t18uw==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr4960232wma.87.1583515078968; 
 Fri, 06 Mar 2020 09:17:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] docs/qemu-option-trace.rst.inc: Remove redundant comment
Date: Fri,  6 Mar 2020 17:17:49 +0000
Message-Id: <20200306171749.10756-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

The Texinfo version of the tracing options documentation has now
been deleted, so we can remove the now-redundant comment at the top
of the rST version that was reminding us that the two should be
kept in sync.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/qemu-option-trace.rst.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/docs/qemu-option-trace.rst.inc b/docs/qemu-option-trace.rst.inc
index 23cfcb48537..7e09773a9c5 100644
--- a/docs/qemu-option-trace.rst.inc
+++ b/docs/qemu-option-trace.rst.inc
@@ -1,7 +1,3 @@
-..
-  The contents of this file must be kept in sync with qemu-option-trace.texi
-  until all the users of the texi file have been converted to rst and
-  the texi file can be removed.
 
 Specify tracing options.
 
-- 
2.20.1


