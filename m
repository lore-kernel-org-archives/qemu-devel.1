Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AEDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1ED52076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UliYB0t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ED52076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1ek-0003aF-R1
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1ba-0008DM-Ls
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bY-0001Iv-VK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600855348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bKFDeA6TNFarCR21Rqa9fEYC5lSqx5iWxJX3Ui0tQJw=;
 b=UliYB0t/dAJpL6XFNZsfFYCFfZTTgq60PTPwr2butFVrWEUh6MmJ3P7K7f3Yz1upcWHD7o
 AfiXlzwYQo/M5GO0QF/vcUkf8HB/7P7IZBHyGIE5WyCYsygUZSTB3a1TZprA5OXl6FemwE
 IfR1ubOgdIbqXK4+mmwoSkhUXlE9HEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-Dcq0tz3jMACsM8azqJ9SBA-1; Wed, 23 Sep 2020 06:02:24 -0400
X-MC-Unique: Dcq0tz3jMACsM8azqJ9SBA-1
Received: by mail-wm1-f69.google.com with SMTP id b20so2128096wmj.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bKFDeA6TNFarCR21Rqa9fEYC5lSqx5iWxJX3Ui0tQJw=;
 b=KMkwkiuETxIzP4BuU/qy8bdRf/sxW1WhrydgTS7LTOe+UsVmiyx4T8t5HNYpqmy/v7
 DBiP+uy/Vve/7n9/2G5tw6/XKCEJ1UBIZInFVaYrlC82O1V32EoVDKrZ/baZsX4vBOup
 7/coHLGJEWsSdH8vpoJQq4V6YhdGpoKiPsaUEStFpJ5UbJJ/ehtKVYCeP4yhTlAZZjQI
 xRiplDlWUU0ex8fM5bMfNC7h3uUx5tIG6eyXZ1jl5mE4C6onY9d5AjH5hLsrT/OX/Sqf
 0MR+HGsx5HqTFZ+ANHNuV0Ylu0A5oZO6HCqmbssqX1QWAFchtnm1WXEvlJx9TP1QxKD8
 vUTg==
X-Gm-Message-State: AOAM531o1kSxnjWfjJ2A979I8aKu/5zSBJ8xm/Eg+mjPpAyeyLfSg1NH
 PJDayVvLpT9oMeOEK+bJV+koMElBtGxVDOn9gGawEMZ/lTi9nFZ9awViSCBll9yxQfXtaXYW8Hc
 lXuMmInHZJFyomME=
X-Received: by 2002:a5d:4388:: with SMTP id i8mr10069950wrq.365.1600855342874; 
 Wed, 23 Sep 2020 03:02:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVOD1ZYhbpxBN7+kEeszU4FrAemloNE6yZkyXPkeRfThfL4KMnINkuhR2GVhIneCwJ4ZKgKw==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr10069935wrq.365.1600855342715; 
 Wed, 23 Sep 2020 03:02:22 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l4sm7474643wme.43.2020.09.23.03.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 03:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qemu/bswap: Use compiler __builtin_bswap()
Date: Wed, 23 Sep 2020 12:02:16 +0200
Message-Id: <20200923100220.674903-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement Richard's suggestion to use __builtin_bswap().

const_XX() not updated. We could use le_bswap() definitions
but they are undefined, not sure yet what is the best way.
Meanwhile I figure this out, these patches are ready for review.

Philippe Mathieu-Daudé (4):
  qemu/bswap: Remove unused qemu_bswap_len()
  qemu/bswap: Replace bswapXX() by compiler __builtin_bswap()
  qemu/bswap: Replace bswapXXs() by compiler __builtin_bswap()
  qemu/bswap: Remove <byteswap.h> dependency

 configure            | 13 ---------
 include/qemu/bswap.h | 69 +++++++++-----------------------------------
 2 files changed, 13 insertions(+), 69 deletions(-)

-- 
2.26.2


