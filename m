Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA8220656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6kzIVD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA8220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJuf-0002zI-Ao
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJu0-0002PU-2j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:53:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40835)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJtz-0002K9-0A
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:53:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so5474423wrc.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n+vcgdFVpwYWhcXEEfAjio2aJoK4lcTJB69gTdUJSx0=;
 b=I6kzIVD5GsqmAKsIibERp0+GKcehvUILGA/MPoqY3IrL8Wt/or4dgWDeEgbAlnX1Zb
 SfYTsRvjkoxidQQdJGs5XYN4/RL89wj/3tne/5ZzjnpsC4HzMCytSsxDstGYdbbEpQNS
 9HjGP2jHFKXGYqvB7zbuYd95QoWSg70O5q7AjU6VNFAFXHEhVSobE/uBd/vTycgB5/rp
 3nsjB65wxUk1rNfrPe9UxPX/zNnUyxsVnoHqF2Np4sM37KTHk61NpLqkuVXlpkZ75bSO
 kvEXh3Ilyr0mkAuD1K5pDk7yu3OLd9SI9/UufKbiu/OR91l4Vlu11+3ry41Q3WhG+ipq
 6WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n+vcgdFVpwYWhcXEEfAjio2aJoK4lcTJB69gTdUJSx0=;
 b=fuGTHk/9rM/hkIleFilKyVWa0eaafgUtFnPPEapfIP/6fIGV/BEU5ulP8KsDRUfHEE
 Dx7pf5wzBKGNKKkjnYQcaLLIkkZhrLw8yuppTcaovcbiq7Zyk2o0ZEjmDyRv2Zo1aD2a
 57kglHFTxwpdoQ4s1pwNKZLA6+HG3GzoMZPakuy0TP8f9xvKFMtic7D7VHZOltjTvF0F
 lwZmsTK2e44nWpQi8Sz6ZJjZxk/skvQ1Zl/UbgGsvz6ew3wOBEXUpRMSrJFY1Q30GA7g
 JN9oSShV1+gTJSE6562brgEj9mvJHwi9cCQ2v0KCF2kZiOiBQqhuN47zqS2hauYDgSkS
 ofYQ==
X-Gm-Message-State: AOAM530Yn23nKc5eFIsmdXs5cvayb78bfr5eAliBICYEFKztnPSkuNit
 nATF/FAxiOOa3xdm8i+GX5YTl2+rcac=
X-Google-Smtp-Source: ABdhPJzUIEe/9BV+YN8QGsLW0KDsY7lRIToJAKxPUS5olWfz/UhyZObyv61qPE8aVqHIzWOXNUD7mg==
X-Received: by 2002:adf:a507:: with SMTP id i7mr9406545wrb.0.1591869212227;
 Thu, 11 Jun 2020 02:53:32 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id i10sm4060257wrw.51.2020.06.11.02.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:53:31 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] Resolution of sh4 maintainership
Date: Thu, 11 Jun 2020 11:53:15 +0200
Message-Id: <20200611095316.10133-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series consists of a single patch that introduces a new
maintainer for sh4 target.

He may or may not adjust further the details of sh4 sections,
with recent discussions in mind.

The central idea of this series is that noone imposes his/hers
particular vision on the new maintainer person, but that we
let him organize himself the way it suites his style, and his
code situation, and his target position.

Three "Acked-by"s were deduced from the content of recent
discussions on the mailing list.

v2->v3:

  - keep Magnus as a reviewer for sh4 machines

v1->v2:

  - improve commit message

Aleksandar Markovic (1):
  MAINTAINERS: Adjust sh4 maintainership

 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.20.1


