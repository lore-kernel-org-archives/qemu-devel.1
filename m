Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E3AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F80F2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wg4xnQgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6K2L-00034P-1w
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6K1W-0002Ee-TR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:40:30 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6K1V-0007lk-2d
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:40:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id u128so3417719pfb.6
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UDVbJ6RtSEpTAiMOaXq9bLxMjjHz1VxatRJs1f25vVE=;
 b=wg4xnQgCzEi78+EsPHq/SsPhGl/USCfxIvqqWbo3YxrJHzd7TtFjdHS/hwxc+JfUKl
 WRocehyCGDyeiSscjkfNVZlk1xEV6hMmIu0R0BdV+2+N6ksSfA0v9Yw2nZjYc1LBYXWK
 CWwBqLqy5uf+boXs8MBpxCu4Iq2v6buIOT9YzozanxU1+lmhJ1tv3EYfgUXhAs9787Y4
 mMTtSrNLi8wvzCKj/Eg9SXcCLMtcyy0ZrK/cSd/18Da/WmyT8dZ0IxYu+LGWdjyfZq/z
 FCGVZveWjKB/AB2RFQYBIodnb85FizzigAmlwvc1w4FyJT+3CAfOo7eS3PCv+z/OYZ/i
 i0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UDVbJ6RtSEpTAiMOaXq9bLxMjjHz1VxatRJs1f25vVE=;
 b=eDOPUTKe0EcnfQbmQlzvsghxaNqOC1HQVs7kSjztc6xbbfCa55AOmD9Q5qvc7u1KQk
 EdGI1OKMzhPW9Egt7CpU15tz3gFO7M2qgYGpsdGBDHr9q4jOFUbKf0pzLH+Ew9zuyC+2
 fu+FaBCFa/aU2eYydaypK27NdkEAmeCKn7tTr+zgE7JOHpgyc6zJZYpbEOlKNFtQCg0y
 gnPoS30R/vzZkN6lL3k96JS0H3KV3P50/jqrpVygpYBQUzSAMBh+yAK+545zn4tFFFli
 42A6NoSaW302KvaEXjWOU3DhMiT74TAafTjj6VFJWo2MavxvN/ZCWbMyYfvhml/Ajm/3
 UFIQ==
X-Gm-Message-State: AOAM532EKxjoJWebc4FCtLewQU7I5FE3kiBtWIq1wXq95JGQeKXpzq5l
 vKl+LiGgpmqViXsUexuW16Y8jTKMDx8=
X-Google-Smtp-Source: ABdhPJw3qx4siIpnlztHxdLDOUoGeEYlT3x6UmPgUK46URD9gk5J+0qBG2iSnMXiLFzMT43lp+yhkw==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr5047106pgk.363.1597351226212; 
 Thu, 13 Aug 2020 13:40:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q5sm5853313pgi.31.2020.08.13.13.40.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:40:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] cputlb: Make store_helper less fragile to compiler
 optimizations
Date: Thu, 13 Aug 2020 13:40:23 -0700
Message-Id: <20200813204024.3077275-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is the patch I posted in reply to Shu-Chun Weng's v2 at

https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg07589.html

with the patch comment adjusted.  The patch itself got an official R-b
from Alex, and an informal ack from Shu-Chun.

I plan to include this in tcg-next for 5.2.


r~


Richard Henderson (1):
  cputlb: Make store_helper less fragile to compiler optimizations

 accel/tcg/cputlb.c | 138 ++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 59 deletions(-)

-- 
2.25.1


