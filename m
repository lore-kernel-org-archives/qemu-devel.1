Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9ABC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE29C2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdrBxQR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE29C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9kM-0007Ql-5A
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jP-0006VO-16
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:24:59 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jN-0005xE-QF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:24:58 -0400
Received: by mail-pj1-x1041.google.com with SMTP id q24so239684pjd.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ts0zlcysq7Z7LnCNZqOjSuw3X0uDuA6thMDLW6rqaBw=;
 b=SdrBxQR5v7JC05npAx+IZqXYmNWFkhdhSgkIuWH40PcoR/InCbH1Ao7riPx28CyfT6
 odC+eaxeNHrBagdVLz4KGykxRMFbFbh5UKTkzTxPvJvs+0yDRVI6k06V2kbXs8ccFUh2
 TWzkez8nsLYaF+wnieyevA/UQ3qSWF2U+07nZuIxdDXDm3TF+FtKhi5GtgVeyh23msr+
 rp16q05jA/3ohOZWjsovcM95NidVND9OWfQ3lURhaEPkwoxnv8lgiXautmoaNWmhPo6Q
 s7FuqBUFrDPViflvFtQD4Lyd72OyUrHSQe8qe3IC+vTT86Ssu6BZTePWbmDEE44XKmP1
 I4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ts0zlcysq7Z7LnCNZqOjSuw3X0uDuA6thMDLW6rqaBw=;
 b=epDNfBv8/Pp2Yf4JWOCf/x3N52pZFCUp5LjLe9yLnLDdOPC/IMlBq0psafMC8TsC3W
 PNfgVIWu1KCT3FICpMZff6GZ1N2CsydgsKadza9N8MIgapQWQfOEIV4qFtliLnPmf9YY
 q9EbuWf6UUN7B5DL+WQDehQtZq7how1osi8S2Ia47aZzl6rA/z+CIJxIzCLbaJba9l9H
 d1oXJ9zn1dJjR7bLjUyHMlD5sthXkSIe+D1IA8x9EtYV/3NDvEDXkh42KnOZcmCMAm5T
 lLycXEWdUe3tInc6uZcZVclAkQLGhp1AjeLY3K+nYCltBpPFRF5LTskZxtaC6Mq8MtgZ
 vJig==
X-Gm-Message-State: AOAM533Wx1HCLZcZndQxc0jDlDY+4bFyog2/S0CahAZKjwQ9ygvyiikl
 laWLqiL8R2U0xtLcDKDurRHlV7m0xXE=
X-Google-Smtp-Source: ABdhPJwy19FzBBJZl05NTFRsxCLtikgmf0LyYDQZ6uWNYC3PBegCZFSxmKxbM4B3YjBK5k6V/Zhb/w==
X-Received: by 2002:a17:90a:264c:: with SMTP id
 l70mr1636677pje.18.1589923495832; 
 Tue, 19 May 2020 14:24:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v5sm386134pjy.4.2020.05.19.14.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 14:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] target/arm: vector tail cleanups
Date: Tue, 19 May 2020 14:24:51 -0700
Message-Id: <20200519212453.28494-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3 fixes the reported bug in EXT.

I should make sure I have fixed the bug wherein RISU prints a
mismatch and still exits with success, which hid this problem
in the scrollback.


r~


Richard Henderson (2):
  target/arm: Use tcg_gen_gvec_mov for clear_vec_high
  target/arm: Use clear_vec_high more effectively

 target/arm/translate-a64.c | 63 ++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

-- 
2.20.1


