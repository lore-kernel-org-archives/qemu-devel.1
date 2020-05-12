Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA38CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BF7206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="W3m7XaTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BF7206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZ9x-00054S-An
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rad@semihalf.com>) id 1jYYN7-0007vl-Fg
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:07:13 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rad@semihalf.com>) id 1jYYN5-00071M-P3
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:07:13 -0400
Received: by mail-lf1-x142.google.com with SMTP id d22so5159079lfm.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=avK/Z/6wqRuOjH2arcvxV3LyvE6xojjat6vnYZ0J980=;
 b=W3m7XaTAzx2SnS6KIhm0qcuQjCKmTlTgsEys3eS5uLR4a92ZV3iXeqMGB/ED1Slo+q
 Y7BPFmCHSBmS/xoOWHKuXIzJ2kLDz6zfJ1ux0z5rJ/kok0ZlGSsV3XgedL8K7dr5nPqw
 RrHoIZC9f9r4yxlJ7FNcxRpUDi4M3gka8YFDwXIzxbB+v4qG1TfAxV1dqT+6mS8a4CiL
 SanfpeiyJBdRU7XBm0UovBsipGlRas3PNoH+oe21JBMApUvqiy5kAVsQW/3m76J4EVBz
 Y4yIWB1XWqCjqkDQfkaegXvaNxCm9IxWRh4yLwtySjb/q3TW8Gc9BYeDwTyYnh5X2AmA
 JOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=avK/Z/6wqRuOjH2arcvxV3LyvE6xojjat6vnYZ0J980=;
 b=tFskVQJcp1wVVyk+erHVNZxiwErqzHLXLvM9XJ8UHQ9dE+lggy1Dq2JT+DN2ePQwZA
 M9rlWWrv4dGghKAIWYnuucrxLsE4GLhMrQ2qgdO6boUNUX/V/7Ol73RDc9ygfncNwS2y
 ExAH/NjgauljNSc9xixbWuJzHDkNEzJde2T1tJoRl/FTn/7RtnJ5a+iBBg7ZOL8aiIuX
 707ZTuABH3X+disPN4Zt6ps5kEwNx2ocIo4Cah/ric8nWpIXeISUgZkAF5Jr/W8OsBLo
 VoIOnI1xCS4u7Bf+H+G7Eiaf7HYACkuupx54NrCgrBy6AWx0pB0cNjm3GCq+jfYi+qAT
 rZyQ==
X-Gm-Message-State: AOAM5301SPctvMV065Zw9yMYSStznh9Q+Z6je0qE8iIPnNW8gUKyWcJG
 tRiZbV668/Wxj4peUm6zAQTtng==
X-Google-Smtp-Source: ABdhPJxen0CtdcekiRq7qj8NHeniTpvC7nwwXqXpruWmJIiQIkMeFasUXJlgJnW0LtjcjKB1+4P5OA==
X-Received: by 2002:a05:6512:1051:: with SMTP id
 c17mr14582634lfb.206.1589303228751; 
 Tue, 12 May 2020 10:07:08 -0700 (PDT)
Received: from unknown.lan (ip-179-133.ists.pl. [93.180.179.133])
 by smtp.gmail.com with ESMTPSA id w203sm14350355lff.38.2020.05.12.10.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 10:07:08 -0700 (PDT)
From: Radoslaw Biernacki <rad@semihalf.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>
Subject: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
Date: Tue, 12 May 2020 19:07:04 +0200
Message-Id: <20200512170704.9290-1-rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2a00:1450:4864:20::142;
 envelope-from=rad@semihalf.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2020 13:56:41 -0400
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
Cc: philmd@redhat.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My Linaro account is no longer active and stop forwarding emails to me.
Changing it to my current employer domain.

Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6412067bde..668da447e3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
+Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..a9d6893036 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
 SBSA-REF
-M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
+M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif@nuviainc.com>
 L: qemu-arm@nongnu.org
-- 
2.17.1


