Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A34C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90B221556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYq4c2EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90B221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if8k5-0005HB-KY
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 15:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1if8ib-0003rE-6a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1if8iZ-0001Wf-78
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:20 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:33440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1if8iZ-0001Ti-1j
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:19 -0500
Received: by mail-pj1-x102f.google.com with SMTP id r67so52436pjb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 12:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B2dgeFyQNx8b5X5WuIjoJHfKEmBl59OpTUa7fU6YWNw=;
 b=JYq4c2EW2nXAZJtO681g0EFoJ3fF/F0oFx3jInLDhZomdnRo0pmecwvOPv+DG55CdP
 VjaEyJmez0uZKYHetwX4qcSrW/VFPP4Mto7gEQRfSU9VG+UEPhTe7lbdxNLW4HPFpDa9
 ZxVRsbwoPPWED/FRKJhZGG6P/TD6bwCwBwjgV93pyZSNfF/xQNgDj+qVUDqYBcd5mPyU
 pMtZh9IrHHdTYUMlPabAGfl0UwRHIEk8Gzk5aAyOd8DnnDzpeeQ4TnqNk/6cy3KZ79N1
 n2zOVF0JioZMS9vcAiR/mNNI4P+rcctA9jf7okrTnNQK/d6b3c3DccMLIA9OSqAL+2ii
 NJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B2dgeFyQNx8b5X5WuIjoJHfKEmBl59OpTUa7fU6YWNw=;
 b=NEW8sD9XiuuZY7kMSxvGpw1YineVRwGua5d9Su43bYj247Jaam+LC9SHbi2VXdDnSS
 +Gd2QklvyPRJGQ8UADa0ekNQzLZyjHk2NckqrBE072nFMG+BiFc+O8F+OUyAxC2aEyHe
 stsCu3mMGXp1pWMOwIaSX68WBeN/ul5xnUvUyclH7aKlGpWF248mRAaCfEuCTzTlU72L
 SaVNb9lMIi+yf1UCuqQsyq+MKXuYbpkCMOB269LollMp1sWWFaPQ6V+n9rTr7adal1xy
 Z+hUMwL40U22xksF1jVVnBvXD5iAaneK1fHPwUMxzM1ub4JAUu2M5+T83MwIMqr6G+es
 Hb7A==
X-Gm-Message-State: APjAAAXaBqFJd6vFBqPqgJfxBaJiiBbFIstdSPJkU7ERyTVt1b347Pns
 M0pnxB+Hb2XeEOBqlNjdOOAOApbD+Zo=
X-Google-Smtp-Source: APXvYqzf6Cvn0k2V49HUiPzepaZVJVHtddhX8MPWYtMeN7APyzmshUwEvO+xEUQz/sV6c3hGDjEMtg==
X-Received: by 2002:a17:902:b18e:: with SMTP id
 s14mr5572316plr.261.1576096576030; 
 Wed, 11 Dec 2019 12:36:16 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b21sm4280335pfp.0.2019.12.11.12.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 12:36:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline
Date: Wed, 11 Dec 2019 12:36:12 -0800
Message-Id: <20191211203614.15611-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Found while working on other parts of cputlb,
this cleanup can be split out independently.


r~


Richard Henderson (2):
  target/s390x: Split out helper_per_store_real
  target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline

 target/s390x/helper.h      |  5 +----
 target/s390x/mem_helper.c  | 38 --------------------------------------
 target/s390x/misc_helper.c | 10 ++++++++++
 target/s390x/translate.c   | 21 ++++++++-------------
 target/s390x/insn-data.def |  8 ++++----
 5 files changed, 23 insertions(+), 59 deletions(-)

-- 
2.20.1


