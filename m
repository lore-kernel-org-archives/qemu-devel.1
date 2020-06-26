Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A702C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53390206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD3cX9rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53390206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorkh-0005M0-Jz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUn-0003fm-MT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:34 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUj-0007yM-QK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:33 -0400
Received: by mail-ej1-x643.google.com with SMTP id w6so10014708ejq.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/aUEanK9DpNRcSmbtWEsbfQi2wy0eJYb7dBT3TVKbyg=;
 b=kD3cX9rjTSfQl5qK+WNBuQC87FVHK8YdlL1Re68Ym/ISz9A4qfyFkcyBg90I9Iu5G3
 VAX1EtsLOxiUU4xEIma0sYxNlkOyQYy1JoaJSJfc0GpWPRp4nObC1yP/UzowuCoE/ZXx
 o/uELLZIm0Y6F19NQmIYM17JGqVAb126tdsDxKFscXHlwDI6z+vEGyxOW7JAF248Ymvc
 tfLWyw1K5LVp5AneqNbOSXYhFeAA0xA2X0+XjWXdyBe/QuQXN2cpkIQXtaKOlmZ7zcdq
 8vJzRWYgCsNDtv9g7Gf8CWWYDfVVLY3TDb+3odOGk60/UAp8s0MxqQ+3liETSs7iCkie
 tb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/aUEanK9DpNRcSmbtWEsbfQi2wy0eJYb7dBT3TVKbyg=;
 b=TtuxTQ8E1uiSo1BGOx6KWykIk3WZhUzSAxBFms7dItuimlxH6/usNePWwfmKXLebfM
 lEn029cueDJoHRejNYH+4JcVOHsZTBykK1wx3B6GdKnC/nMHUCDlq2WCcTCOi53+mPyI
 jjvEKM7QyuZaCE7lsp9msR1kG8jwRsLdNunMl+lfU2WPVVnp8vpSIZo7VTB6fGnOLCwf
 cLkM896sjBl0wkkpfOKeoCG+yZDxBKILKhzkhBDE+84envQoC6Kjr5SjHhpbROAegOvf
 ttyArhBTEm9s84GWc7Dz6OAz5HCN3lzqqORxatr9rVXIhLg0rUnhnGBaMVH1WqLp7Bjg
 P3UA==
X-Gm-Message-State: AOAM5300S3C4dvs/R/IGlA0qq1M0Eio62yWQ10yflInLtoTZLV1QtYMc
 7TDdPKp2fsRsatEi5ylLExBOEGJo
X-Google-Smtp-Source: ABdhPJxZXDyWJ5NF2wDS2iqfoyRte4Yjwf2deye+gfI/Dn14KuK1CVv/qYm1gluUWu6BozwqE94ALA==
X-Received: by 2002:a17:906:fb99:: with SMTP id
 lr25mr3311871ejb.49.1593189988260; 
 Fri, 26 Jun 2020 09:46:28 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.224.183])
 by smtp.gmail.com with ESMTPSA id rv16sm10894889ejb.60.2020.06.26.09.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:46:27 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, rth@twiddle.net, eblake@redhat.com,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v4 3/3] MAINTAINERS: Add 'Performance Tools and
 Tests'subsection
Date: Fri, 26 Jun 2020 18:45:46 +0200
Message-Id: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
References: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit creates a new 'Miscellaneous' section which hosts a new
'Performance Tools and Tests' subsection.
The subsection will contain the the performance scripts and benchmarks
written as a part of the 'TCG Continuous Benchmarking' project.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446c73..c510c942ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3019,3 +3019,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+
+Miscellaneous
+-------------
+Performance Tools and Tests
+M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+S: Maintained
+F: scripts/performance/
-- 
2.17.1


