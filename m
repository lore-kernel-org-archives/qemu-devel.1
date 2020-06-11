Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C5CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC48920691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4o5GJq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC48920691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLjo-0003oT-Tu
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjLeY-0005RJ-NS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:45:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37259)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjLeX-0002sS-Md
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:45:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id y20so4735998wmi.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pC/1r6bLcbUYMgGYcCP74vPOzUsgfzpOLsAhOQZDN00=;
 b=Z4o5GJq+unFbSgKPhtn0x5pQUvYQBVWoZoxB00vbch/Gu2OStMbq5ZqBd6uO1Imgjd
 C4x06Bf8cSLyD2RzQvluycL/hq/wXchMXOcIJwd+bxbe/fO/t7V5BQJoXdENmzLgAu/U
 aOX5qro1KLxkf2WVDnlmm8Q6KDtStoW3AxitT0hdvaloXNRUfb5JiW97Xq1xLKWDSxAR
 895VXvsCYf60enUpSyahvr8b3Le7lhdd7XhEXeDgDy2mJH1VZLX20Q+e18YW98Bxooag
 BLIfMs8kszlKpIiE/xadx+0z+rsB8wrnrDzhIE2WU0UtZTbCrVR6zUiKPD9rG1Ljp1o/
 uRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pC/1r6bLcbUYMgGYcCP74vPOzUsgfzpOLsAhOQZDN00=;
 b=HckTVseFTPr4AcH9uJS41QeRxE8cT0L719LjQKsIJvjKTE9WhpXwyxLmydNmmRlniQ
 sk88Zvhvr2vfpaQSXljq3l+pzM7zjDN8YBgNgkaUCZyoeCjBwuVrz9TIRMuUxvfy7Iuc
 IPUC+ZjRJQSZEHL7vt04Y9LoibYoet8lUlKl30QskY+pTZlUK3GRGpeGrjNN+9pakLcY
 i9sqiRUW6jZQHmsSaDMeWK8IrxASseJWuySNGe3ELWH+HFV79QdXCLDdQ4TuCCQhWkZu
 6s9xOB3xoJqakWDLLTMM9ydSaHVdU33mvamPSXpLSo7TQ+t8Wbcr0dKGzt3xiSxt2d3I
 JbJw==
X-Gm-Message-State: AOAM533qtJXVHCRKDIRaji5Z7OF1iZFjDqlVpcDIhTpILikYiJN3NAiS
 7WsR5XNsgR651BnSAaR0j9Kyj8in48o=
X-Google-Smtp-Source: ABdhPJzeC+bKl0DEJVGdE18nAZdbd1uGvw/A3CESB6OW9YUzEv+LFCpkMB0McXMzSQIagsvfH+ODrg==
X-Received: by 2002:a1c:451:: with SMTP id 78mr8263860wme.83.1591875941680;
 Thu, 11 Jun 2020 04:45:41 -0700 (PDT)
Received: from localhost.localdomain (net53-38-245-109.mbb.telenor.rs.
 [109.245.38.53])
 by smtp.gmail.com with ESMTPSA id g3sm5089107wrb.46.2020.06.11.04.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 04:45:40 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Add Swedish translations
Date: Thu, 11 Jun 2020 13:45:22 +0200
Message-Id: <20200611114523.15584-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x332.google.com
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

This is just a reactivation of Sebastian's patch sent almost
a year ago.

v1->v2:

  - simplified commit messages
  - corrected overlapping hot keys

Sebastian Rasmussen (1):
  translations: Add Swedish language

 po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 po/sv.po

-- 
2.20.1


