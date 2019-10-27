Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3554920717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAbyknVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3554920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOo9M-0007ql-QO
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 15:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7U-000520-Q8
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7T-00074X-AR
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iOo7S-00074A-5e
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n15so7623692wrw.13
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o1wHkGpALGvZ5p63/MiA9xsAZrJ4m0uNdKCoG3szFwk=;
 b=uAbyknVUXU3ctObcttpT3iVlAy/+80G6AkgJzlsCMwl0lLEtO2JscJ6o2JjjrZb9NC
 lq2eUcXfNVgBs1TdsdA9oiMzPs38mGc6zaLZcfbgQ/UqGOfw8gUggYL05c5VpACTAqjT
 ux8U52pC6eZArjix+T5Xv41MmhO/8m03zAjyox+YOO1qscYmdke7iY4BGTRPMHIkmW/Y
 DCvNtg21f2pGQFSK6SCnsx8NOJVoLpjLULWC4fed9lX5+BgIv+gObHrhhnmAiaE4mItO
 uIJzHTAfRufXPbeBvt8mgpl/qPFDuBCA/MlfqQMC2j+7hkV4xoYWvUOvk8kd/aDKU9Ho
 KIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o1wHkGpALGvZ5p63/MiA9xsAZrJ4m0uNdKCoG3szFwk=;
 b=RrVWieFNtEYwkDBp2dBH1nW/vv6hoLVl2pxDD7l5mJU+x2xQ/ERfC5LIqsSfC067vc
 7ZIyjVJR/QsiEr5K8naPSxTjTTOORsrSzKJDyWGj1T5FY1YTr/x4451L++tZCY3Q5ipM
 lsJULXqaa2MycQK0PFVg5uEtTyxzMlAGCYkMU37XoIP1kyGkCB4O3XodO9GQCu0EcGDl
 wJfXRLhdJYsu1HuO20NF6MAyNfu++v7VxDIJkyk5a/7eKiktv5qXRS5zJrbBkxQNyufN
 cdKhYyivporU4bGdSiC5+e4jZlv8ac43STdDUn4/hFzPFzEMwsdqGkcFQMrYy8/3cGUp
 zf4Q==
X-Gm-Message-State: APjAAAWkUpPGL+bFr0Sqf2BGPxwqxVpZmPWoAVnmfDfRinNlJkftj1kn
 YFjnVIMqGUxP/WB8OeApXF4VDg==
X-Google-Smtp-Source: APXvYqzacz9ahWyK+Witf0Htzx3vyL1k2z1IJb6ZAJcnwBknjFyARViCzsT6rPkELtQ7J54yKoN6eg==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr11601943wrn.213.1572204144907; 
 Sun, 27 Oct 2019 12:22:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm10888083wrk.86.2019.10.27.12.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 12:22:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E3DC1FF87;
 Sun, 27 Oct 2019 19:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/3] a few gitdm updates
Date: Sun, 27 Oct 2019 19:22:20 +0000
Message-Id: <20191027192223.10855-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 856bd2c28e108ad0eb909bbbf3774f6f8bd7c2d4:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-25 21:57:41 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-gitdm-next-271019-1

for you to fetch changes up to 82448ecd110ec1c4af1504a394b5ea5097dcca3c:

  contrib/gitdm: add China Mobile to the domain map (2019-10-27 19:16:30 +0000)

----------------------------------------------------------------
gitdm updates

  - Add a few individuals
  - Add China Mobile

----------------------------------------------------------------
Alex Bennée (3):
      contrib/gitdm: add Emanuele as an individual
      contrib/gitdm: add Andrey to the individual group
      contrib/gitdm: add China Mobile to the domain map

 contrib/gitdm/domain-map            | 1 +
 contrib/gitdm/group-map-individuals | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.20.1


