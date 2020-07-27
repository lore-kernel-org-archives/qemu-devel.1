Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A88C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B1F21883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxAtletE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B1F21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0CTm-0008PF-Qn
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 19:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CT0-0007Ei-8I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:34 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CSy-000607-Eh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:33 -0400
Received: by mail-ot1-x343.google.com with SMTP id o72so8024392ota.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=hMWGRB055yRZUhDpcH5vf6C3dA/ey8uxPz41nKnCIII=;
 b=bxAtletE0Yre+1pkrYLi3KVVzTC7VkL0BErNvMqsB4H/OXNGmrngzdecSKG8lvLp9J
 ksuyTrEOh67ztrRPEK8H0j+3AisHHlo8wu94rwHOmVF5dtDxDOOya1wY7caa2LGlHHdt
 xxG//euqZtd9QJXeVd2H4sI+ziadE+/yC/1kn2meRS84/5MXZtrENJV9jDT23+4UotC3
 rSxipCRh7WrMgzs8k8OLf7Qiw7SrC/TDRR8q/7wAUMMndWsMhzmlzlDqiMD6TMH2hy3Y
 mSYfuj/F+pCTV8HQHNIfsLd6h/QHD/xHklDFXzVg21aJ5cz3crB4758aM9aNLT59Iaur
 SP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=hMWGRB055yRZUhDpcH5vf6C3dA/ey8uxPz41nKnCIII=;
 b=FIMSrz+TYHPB0rziIZaRDx8hBgRY57bKjFgWN+n7ImPZHO8NnvalIFvOSRMcfnP73Q
 lerk/00vGPcjiDxN0cMaMd9Lk9kSqLyYheg1nAk2gdHcbVYv5IuXjXhMf/inrQHoE5mL
 roCdLLDyCfjMg2+uUil+w1YvZu6hwc+6JzQF+vu8xviAFIWUUUfbMea4nNTzVq6cb2BB
 OhIiDplnHQ4IEiblxivgAbmTSOn7YowuM9KeDSu4knw9dI0C7APubbkJkxyd9008rlZ1
 CyM+irEW7MnJkvPCdtm48srY1dAteZ/Wv7aVWdDMLxvNQmAHN4X7fM/EdFxd0HyRy1Uj
 YgnA==
X-Gm-Message-State: AOAM532/kn+g+djP6FHIp233KDxEA2r0TGK53UVZKHOE2bCDm90VBNjT
 MuGGfbULcJCfhobmHwbFkxcE5SXy
X-Google-Smtp-Source: ABdhPJw0pZRyFZqyZLwYoU3BbiWLCNBW8yUPpqDvFEJL3crxbkwUvM+aBet+ZQwvFZysHyu1DiADZg==
X-Received: by 2002:a05:6830:1af9:: with SMTP id
 c25mr21811602otd.271.1595892210560; 
 Mon, 27 Jul 2020 16:23:30 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id i1sm2351630oib.6.2020.07.27.16.23.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 16:23:29 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 0/2] qemu-ga patch queue for hard-freeze
Date: Mon, 27 Jul 2020 18:22:35 -0500
Message-Id: <20200727232237.31024-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9303ecb658a0194560d1eecde165a1511223c2d8:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200727' into staging (2020-07-27 17:25:06 +0100)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-07-27-tag

for you to fetch changes up to ba620541d0db7e3433babbd97c0413a371e6fb4a:

  qga/qapi-schema: Document -1 for invalid PCI address fields (2020-07-27 18:03:55 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* document use of -1 when pci_controller field can't be retrieved for
  guest-get-fsinfo
* fix incorrect filesystem type reporting on w32 for guest-get-fsinfo
  when a volume is not mounted

----------------------------------------------------------------
Basil Salman (1):
      qga-win: fix "guest-get-fsinfo" wrong filesystem type

Thomas Huth (1):
      qga/qapi-schema: Document -1 for invalid PCI address fields

 qga/commands-win32.c | 29 +++++++++++++++++++++++------
 qga/qapi-schema.json |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)



