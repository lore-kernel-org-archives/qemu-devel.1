Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BC32072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL4/daqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BC32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj948-0001tz-QN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj92l-0000jH-U2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:17:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37772)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jj92l-0001GJ-3T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:17:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id x13so4077457wrv.4
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WqlaXS3QxdxqfMosW/1XFmEqeNq3VHuVyq3ETph0yF0=;
 b=XL4/daqktfyeed8YAZ65SEXZEs/3cp1x6YxG/Va9eqZy9czko1tW4H+RLYC1iRXNId
 q8fptx2FenDVrvXEPwseg4MKxxMU18nYgaXavwaRRH7XHRAuPVxho/vjYVMsmJ0+NS6/
 VHaXTvLFoB/FReV4GIPh878tnk8T7jvjvFsHlkJYny87kT5HeqeBRRNHWrSzgz31eQid
 4EOzZizYtSMEnr8MGqPJv4XywdzttmyLutixJX75zrHpjfeOwNBE2kB2ldBfixFx/8eE
 JwgejpagJjFRtA8iXTCL4DoPPpqGI56L73ubH7UzmeSC1TYTjdF/8/K1DXFKxQvNprdD
 06nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WqlaXS3QxdxqfMosW/1XFmEqeNq3VHuVyq3ETph0yF0=;
 b=MjflJNBiw86pn9ZI674SnULjU/EPuwUBwUXRLCTkmNnl9iMI/2pMSr+8SYQMxHqSif
 aNvWu4k+rE7ped5YWkTewgV0HNuQATtjmpCEGvA1aBZ5TqQl785RaeaJdyKMURK3CHI7
 KzVcczfGQKwmnKse6IghdVB9ZVMp4Eslc7eKgv8XOrQCtpz/HB7Qma5KBeXX0pZo1A+2
 tm6KsHsz+kPZMv8NE472XtJ6ay3oS0Fb1rYwUcoVt5W+O+sdoXnLWcTedV0jBri4HTow
 P4hqV8OEa6K9VEZPjCFzUKVqp3UPKIydDv6/DoI7X9ufp0iLOzjhlnBTRWfXLJwZ2xMx
 hRpg==
X-Gm-Message-State: AOAM531DrLTkgDPDRkJ9GvcjUbFfx4x9O3Ugxu4GXiv1ZtjEal6sunQs
 mM5emsnQ1Do4nsXGK1FxHlplY0IKqn0=
X-Google-Smtp-Source: ABdhPJw3wtVcjyiT/wUxH+jErFtMHNVWjTOP1/q64Kt/o2m2oqmZs5eT5KJjdTxdRDFMDuHXL5Bcqw==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr6009166wre.275.1591827470647; 
 Wed, 10 Jun 2020 15:17:50 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id a124sm1374589wmh.4.2020.06.10.15.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:17:49 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] Resolution of sh4 maintainership
Date: Thu, 11 Jun 2020 00:17:42 +0200
Message-Id: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series consists of a single patch that introduces a new
maintainer for sh4 target.

He may or may not adjust further the details of sh4 sections,
with recent discussions in mind.

The idea is that noone imposes his particular vision on the
new maintainer person, but that we let him organize himself
the way it suites his style, and his code situation, and his
target position.

Three "Acked-by"s were deduced from the content of recent
discussions on the mailing list.

Aleksandar Markovic (1):
  MAINTAINERS: Adjust sh4 maintainership

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1


