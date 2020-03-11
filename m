Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DBC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480E1206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="rlgUXYXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E1206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4oj-0001H5-S9
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jC4mR-0005Pe-Bq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1jC4mQ-0000HL-Ak
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1jC4mP-0000DG-Ty
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id m3so2986067wmi.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=j3gdc3TumaCPLd0LPj5fkERHdWmWPqCYiCKpweTX04I=;
 b=rlgUXYXqocYFuCgj3WrWZoaHVVXO+h4twagDCgunurp6ZkEpdm8ipA1JqOCdxVBpZc
 M6RwUA8xn+OgANHT7j+UM3+fXc61PGdDYV5fcQdbusViscXppHfW36EHdCM1thNVPX4G
 G3O1rzicmZIyPptiVXea/sBMheJCjRfdycMcych4bY5kDC/KFm+QMvA5UTPDUl8Gj/LH
 fKM2AcfF64AE+QnAfUPL7oEsdWT/l3og4u31Inw/vRuqN7fy6684hyS8cLKgD0PqgZcG
 ddoS2nIdfhHPJGs4m631azgXt0EqcDYdiXcIeDHtI9cVF35n3PtbHwz52vr6Mx8+mAq8
 u2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=j3gdc3TumaCPLd0LPj5fkERHdWmWPqCYiCKpweTX04I=;
 b=pjtRxtKzA41gWfwiNYqFe5lXj7DjJaXtnZj7pDb7iV4H82zKZR/pVZvGTCqAw2cE3f
 S+oZvLq7s7D7qUw494PFAjZKG/qsavepJedwY2B3EVj3lh+sKpsASSEw/zdkhOm8YX54
 TOoMrxBhCt1XVsTEhAnYaJyEy2cBK9h72DNxlUuizrZtzcyZ2oLY0677PF6U/5kUakOR
 6rfZx4IURPNDi05kqlyHGHeGEVBIMuVPKFg/KtxRzhUaXWDuoKqruuD3qUzBUj9w4Z+P
 JE9JixnMV8n5UDbi0RpKKEdmcr8q1eqbu2w3xmlQLRyBn8cMS5FYjMmKeiZil0+0Lwdh
 /TVg==
X-Gm-Message-State: ANhLgQ2NbsXy/TpvGJNMFw/ZUnQ8Ethjo70ZDgo120xdxKapFaq0zE7Q
 h2E0m1sT5SMK6naznvPIZCq+/IPdZeg=
X-Google-Smtp-Source: ADFU+vu+yS8PFSoFQE+kmA9ZxitRwSlgyGmPLzmQyZyf1r/F74S8nrURwJw/PJKOxsRmcTvpKNcaZg==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4603653wmd.23.1583946262938;
 Wed, 11 Mar 2020 10:04:22 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id o26sm8510925wmc.33.2020.03.11.10.04.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 10:04:22 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] QGA - Win fixes
Date: Wed, 11 Mar 2020 19:04:14 +0200
Message-Id: <20200311170417.13415-1-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series addresses serveral issues with qga-win please review
them and share your thoughts.

Basil Salman (2):
  qga: Installer: Wait for installation to finish
  qga-win: prevent crash when executing guest-file-read with large count

Sameeh Jubran (1):
  qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error

 qga/commands-win32.c      |  8 +++++++-
 qga/installer/qemu-ga.wxs |  2 +-
 qga/vss-win32/install.cpp | 11 +++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.17.2


