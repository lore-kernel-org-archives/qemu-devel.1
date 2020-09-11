Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A218C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96ADB2226A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="egOhFRGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ADB2226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjho-00023i-H3
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGjgx-0000QJ-G3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:06:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGjgv-0000Db-VF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:06:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id 7so6713237pgm.11
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OKD9j4Rq29JZiCsyPqcO56a2Am+dOJ4CinQxr6oX1w0=;
 b=egOhFRGETBo0UI2CS8uFrnIvikzsZN9BUJGrcBPzO7H5idwxOLLXCkxu4xMHt2n0KR
 qubFYiPgOeDSQVNHhcbjM86b+Olc0awBJoMk6T4QDItMJ9aI+4CY/8GgjrXZ4yHaFqlQ
 LZf1mf+rteIvCnSm44ELKEGjlrNeqG2ethA2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OKD9j4Rq29JZiCsyPqcO56a2Am+dOJ4CinQxr6oX1w0=;
 b=GoOU5yLOCIq3g7WG3CorOYZDztRTl41MCF/So9+eFsaT4qfObmDuOT2EPmHNeYeOc3
 NdycLfKJzo2b8ZDX3m30kMOteQeKuY7MdW6WtTCn4tBij/a04IJSXv4ZFIu2IhsNqJud
 H3Cz1Wigg/2wfHHRJKDZdmaWRoFj6tUjfT43CZv+Y1OQWj1YJTlwOcmldcd6UjvzMFdf
 VMoPkImrnqKsG87kJaRGYm3OvMAwJTOjiH0NP3LtvjtPK2xmP6jh3+FJbaV8HrFnO7p6
 JXAIj0/FdAXJvNrMWK5cFAMz43wQ+kLnfavKfxSzyLvKP/zfxxPBHgr1tNrPU1DKcDPu
 QlVg==
X-Gm-Message-State: AOAM533TODRZa63minMLtzDCKJpBd2lIGRYjbPAdFaqJUn+nngGgnpW9
 7StNOURUbT4etI4DdOX89emPP9r4zqY4SqEh
X-Google-Smtp-Source: ABdhPJx69pUIDgJhfyAyGlg9ec6MFOSGKnXw1bII+ptLxMQu1qhIEwVBda+/a+3GI2lhsjdNgdKtlg==
X-Received: by 2002:a63:4d5b:: with SMTP id n27mr1734904pgl.360.1599833171745; 
 Fri, 11 Sep 2020 07:06:11 -0700 (PDT)
Received: from localhost.localdomain (211-23-39-77.HINET-IP.hinet.net.
 [211.23.39.77])
 by smtp.googlemail.com with ESMTPSA id y5sm2203179pge.62.2020.09.11.07.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 07:06:11 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/2] colo-compare bugfixes
Date: Fri, 11 Sep 2020 19:05:06 +0000
Message-Id: <20200911190508.1316487-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=dereksu@qnap.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 43
X-Spam_score: 4.3
X-Spam_bar: ++++
X-Spam_report: (4.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Derek Su <dereksu@qnap.com>, chen.zhang@intel.com, jasowang@redhat.com,
 lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The fixes are for the bugs found in colo-compare during our testing
and applications.

Please help to review, thanks a lot.

Regards,
Derek Su

Derek Su (2):
  colo-compare: Fix incorrect data type conversion
  colo-compare: Record packet creation time by QEMU_CLOCK_REALTIME

 net/colo-compare.c | 7 ++++---
 net/colo.c         | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1


