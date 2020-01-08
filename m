Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE5C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B692070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkG3FRq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B692070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2d0-0008Vj-RO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jp-0005sj-LA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jo-0004YD-BK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:41 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:44339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Jo-0004XU-4K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:40 -0500
Received: by mail-pg1-x534.google.com with SMTP id x7so855185pgl.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6n04cMrSwYKJN+WltOGUDVYoZYjbN1VCm/ZSKjIjSXg=;
 b=HkG3FRq7bdqt/MxvnAH2rcDApBL0sz4ExqPTg627ih4IpBcpVgQ8qV9OfQf4eO7o6C
 3Cp5uThxEfAMbwocG74A6hou3+2OofRO0wKaMWRlNMp4SzZqJHA6Q7Hfv7RWq8HNbGZM
 WrQTE4YCOIAGb9v3Rtd6ULE5Pja33tOqdMqlFQjT+hdLGV80QAGBLZqSoFW3mzSztXeW
 InmeGUDaEvbd2Y9TLH8nzaeplqCbZNfiaQMyZHDSs3QTUb8hTKCbpErm9nSATNVs7iXL
 0nqPx8ENIMML7vrkjV/7F1/lDazbOFzMkGXndSVZTlFqFGksOQRm1Yoy8BaM5aAgP4ez
 OvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6n04cMrSwYKJN+WltOGUDVYoZYjbN1VCm/ZSKjIjSXg=;
 b=pt84Zomq5P6TvYHVVO0TDuaqgOrzx/lmVt8CVAY787W914pDhix7SLk+7N1c8YJXR6
 IJCRHfsuDb+NkvUqw1DAEdwMmSrFGzrum0hdAbiRvxdmhLSSrtPItd68bYyiOI/+XIFu
 oqHoQ9GUMALf6WOudbmewFu12FB9eD53tlT/dWjHRoHs2bhXMFnDlMinsrBE1PQoYUXt
 gySptHlCv/xr7ZJz8MtD3Bpns3BrK3rov10sIbl6M2cIE5gjqkaaumX/fqBwzgWUWv1z
 EyIzAIWn3kHldxpN0W8brDmgatc7NenOOrczdIh7Fd/WRe+5UmhbSaQ/V0PoUwMe8tbP
 y1tQ==
X-Gm-Message-State: APjAAAWkj5toGiXQHg1h4X25p71nnfGikuG90ZH/NUDV+o9EqJ0ealsx
 4QNevQiRuhfZAfmLpKbjwwNshhI5lA7ZMA==
X-Google-Smtp-Source: APXvYqyYmoq2OwzPG2UadwgumkGZ/rc9sUHJm5gENVjXKnE6JClxv0DTApy69QisZRR9aZKvxwJ60Q==
X-Received: by 2002:aa7:8246:: with SMTP id e6mr2932738pfn.102.1578455259030; 
 Tue, 07 Jan 2020 19:47:39 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] MAINTAINERS: Replace Claudio Fontana for tcg/aarch64
Date: Wed,  8 Jan 2020 14:45:23 +1100
Message-Id: <20200108034523.17349-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Claudio's Huawei address has been defunct for quite a while.  In

  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06872.html

he asked for his personal address to be removed as well.

I will take over officially.

Cc: Claudio Fontana <claudio.fontana@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c6919c455..dcb46db5e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2396,8 +2396,7 @@ F: plugins/
 F: tests/plugin
 
 AArch64 TCG target
-M: Claudio Fontana <claudio.fontana@huawei.com>
-M: Claudio Fontana <claudio.fontana@gmail.com>
+M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
-- 
2.20.1


