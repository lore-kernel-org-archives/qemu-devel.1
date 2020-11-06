Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0984E22202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgGhXurz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0984E22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Kh-0006NR-Ug
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HX-0001Il-55
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HM-0003Mt-GD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id a65so2015751wme.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QYh4fqsTUmygUQnFOlahWVe+fg0vJdk1jBVyhCmuVzY=;
 b=TgGhXurzeK/6SCMeIdYb5EgqG1rGmSPxa36k3k1ijRIJOqpABh5fz2bdSxsH5Xlvyj
 iNMYLag1H1Zcr+LZ7NxBlG+6pJ00DmaWqNSdgyq98aK1NGLz2LONtEeO7+LPk3ikiQsT
 NzpHlFjQj8Hv9cH4EhysMTlshv1FNKr+6ENu3/AwBdWCIBKrDQ5hvJzOHMzIdAnc83Wy
 4hDvfXrJsTpeQEb4V923Cm6r6/KD1mYLRAAEpd2YcFuDorNEg9jKUfjdAw8JOaybUqRH
 ngE81ItqAKFHDAUhzDZRJE874ShX9lIqd92t/zN4zZG4FL+AewKE6oTOfHQLyCrFVEpa
 nshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QYh4fqsTUmygUQnFOlahWVe+fg0vJdk1jBVyhCmuVzY=;
 b=uDttxqweOCn90kXDiWR5/Z/ZCwBTxMi1AX4oHPcYXeUjvMcUyKRTtTDLtOZKC6HnqU
 Yac0tM6t8OWl1z6Kzz/LlEsuK464ff2x0T4zOxHYDAFfW3AzwziBSsFTSUh45vEp3dul
 GJYbthb8zz30mv/nO61Qg4pnfL63q65+V26RA/8mSwICs4hw02LsbRt6y5ezyZ+SJDy8
 2Snfv4LnE3FaTlXqfdRvYdEn+Fl9uZ+7lmvxWD9VeGDFYQ2lbP5gKqBiLbBYeneypOb3
 Fp42YChTvQtXoa7jJFfFaYF//6m0B41SxDY5aHTRKD5DFEACePeSC94tWvO3gbV0oHmU
 gpRQ==
X-Gm-Message-State: AOAM530Z3CHVqhloGlCpe6NhNtdWDcyLUaaq8kFDQlX2dCfKF4jc5gg3
 DvcFCxq25h1EK6V7Cv6f5uYpcMopPBYhKA==
X-Google-Smtp-Source: ABdhPJzMVKjD9Sx5vS61x2GVQiO6eIEg/xLoYvrYhgbIHqVRNc6XM9RgzGEoap/Gq41/VvEWqgDNeg==
X-Received: by 2002:a1c:c343:: with SMTP id t64mr649744wmf.140.1604682715820; 
 Fri, 06 Nov 2020 09:11:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm3162649wrb.1.2020.11.06.09.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:11:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/4] hw/net/can/ctucan: fix Coverity and other issues
Date: Fri,  6 Nov 2020 17:11:49 +0000
Message-Id: <20201106171153.32673-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset fixes a couple of issues spotted by Coverity:
 * incorrect address checks meant the guest could write off the
   end of the tx_buffer arrays
 * we had an unused value in ctucan_send_ready_buffers()
and also some I noticed while reading the code:
 * we don't adjust the device's non-portable use of bitfields
   on bigendian hosts
 * we should use stl_le_p() rather than casting uint_t* to
   uint32_t*

Tested with "make check" only.

thanks
 -- PMM

Peter Maydell (4):
  hw/net/can/ctucan: Don't allow guest to write off end of tx_buffer
  hw/net/can/ctucan: Avoid unused value in ctucan_send_ready_buffers()
  hw/net/can/ctucan_core: Handle big-endian hosts
  hw/net/ctucan_core: Use stl_le_p to write to tx_buffers

 hw/net/can/ctucan_core.h |  3 +--
 hw/net/can/ctucan_core.c | 23 +++++++----------------
 2 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.20.1


