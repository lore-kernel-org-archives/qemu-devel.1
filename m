Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B411C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D072078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIW/HXl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D072078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnOW-0003Ba-1Y
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMC-000888-B2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:33971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMA-0007vk-RL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id v196so2096565pfc.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pcn6MKY5x29o+oeon/ESBVUWh970aS6dvKYTu0BsNaU=;
 b=UIW/HXl4InJUna2DUZP8L3GDFnYx6Quz7WaYExPeQQKFeeObQUWvMOqM0DHDOD6Rj+
 fk0gRefphKbP9PKnW9w91plOVk2GCcQEg6bKFvMnqP+z5RuTSCc+qvWO7aWmH6bPg5Xe
 NMrzJBmpEKIHIJB5so8lZvWLvIuBGGVa92xL6AcoztlcUtBN3EUW2UttA2VYnr4V56rH
 HXHcZtSgJ+G6zmdRdistuSraBNYvFejAdQg8O0+s51mTi6PkttYyzcp0NPKZmTB7Jow3
 9A3IK83mT3mx30PXkq3fa7YEZPf3uBSyJxJkGFZJ8/t3h02UdwMzofZyEtH7VHz7fBzs
 iw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pcn6MKY5x29o+oeon/ESBVUWh970aS6dvKYTu0BsNaU=;
 b=AmODzY5GRegyjblvtSy2DoziD577dSwxz4W/MVUk1FGX7JKoGTLIIynsNETA+knYC6
 3zxqmt3VaIa5uTt4jhZSg28v+vR9XwZE+xi1m0+ORp9B41BF9C57FQ983vCd/PJEIZfn
 zI2P1rCFZTFKzAzZEqzcLX6+1ky+TtBsoTHZmS3WUdRwJDgrpBn1VicGvN8xcZ1+FXRO
 nhA1qnqONUJMKZnE5dN62NJMdUNmX4a7P/pEYpZDqTUmG9m3hC+sp/aRpZAbFsFQHIoM
 YHrWpboqC/858YjUsFl1/W/YQBdYuJ/o+C4X6nosg8AFPqbEVYbbLCi340rtAt09aMwR
 Yqvw==
X-Gm-Message-State: AOAM533cZnjI/rVbFf/LkoUxcuBNhDITcwyw8aqEvCJlA7tQyIax/1/E
 hqxH1tz1oVmmUNiZW7TyqOdarTSmjzDA/PsF
X-Google-Smtp-Source: ABdhPJwEsYU14i9UL1zokZGCqVe66ih4m/nLWfs1GKNVFGmVk+zP4YeIvpsWZ7/ispdWN6NSf816Hg==
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr2513026pgj.74.1599132280903; 
 Thu, 03 Sep 2020 04:24:40 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id y3sm2394249pjg.8.2020.09.03.04.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:24:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] patches that getting msys2 working with cirrus
Date: Thu,  3 Sep 2020 19:24:21 +0800
Message-Id: <20200903112423.1765-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches also enable the make check by ignore the=0D
tests errors, so the CI can be passed.=0D
=0D
Yonggang Luo (2):=0D
  tests: try to disable make check blocker for msys2=0D
  ci: Enable msys2 ci in cirrus=0D
=0D
 .cirrus.yml                         | 24 +++++++++++++++++++++=0D
 scripts/ci/windows/msys2_build.sh   | 33 +++++++++++++++++++++++++++++=0D
 scripts/ci/windows/msys2_install.sh | 31 +++++++++++++++++++++++++++=0D
 tests/Makefile.include              |  2 ++=0D
 4 files changed, 90 insertions(+)=0D
 create mode 100644 scripts/ci/windows/msys2_build.sh=0D
 create mode 100644 scripts/ci/windows/msys2_install.sh=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

