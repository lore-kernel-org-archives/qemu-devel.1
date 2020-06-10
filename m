Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED12C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97339206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZtv3TBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97339206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj35k-0005TU-OT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34W-0003by-Rx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40890)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34V-000593-Ec
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so2863400wrc.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cof85NCDQM5Jrdy1rTaMA6BE1i32JRnFUrNPOPsWXUg=;
 b=vZtv3TBjdK3+Dpnwp6FZEPsOS+YmNmmnszpm9vcjJY3ZYaUwTUvqMAeOzwTFYhO4eu
 UNh7vzJf6kLPUO5COOhfEAy3GDdq5KKm7tMEVO5Lqh7pJE6+hvETIKwEBoHOZdtC9Tdp
 Hu0DCecbTRyRJ7tfLcoyFbkGaENkwCqRg8XP8kK9qN20AMKYTitYIwl29PczOKv+DBGG
 Tqdi1f/+h3kwuUib4EUpX1+8vIXxi8qB5tJyJ8YAaMwP4fbtIP0v5yPZH9u0msSQ3vXz
 azabCDmfLcH9XhZUBLNEFKBJ/f7lkcXWfNucsuuDXQJS3T2/yFH3fhRyoDJ58KktCUZD
 rouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cof85NCDQM5Jrdy1rTaMA6BE1i32JRnFUrNPOPsWXUg=;
 b=CpMMeIgj4SmlUWxvVwrrmQdCQ0YkMqpj0GZWeLwdaJcDFU0J/1T5QY0ln6Er7TW/s7
 E1ja171Rax3HQza6PGMxe1TjdLmY/ONCueRbRW4pzFOvnVz9Nu483CGvcHoB2OJdQ1xD
 35ltiqrY1t2TwCX+ThTx6mxtqFg1UkESPwjhc+mVH1T70RH2B+EJaGedPwLZntVvEz76
 qkWaPV7USx+OTeoBbWH9xj2F6/dSgdfh7sNLq7l6KuijYwpGV1DUBrULGduRBOUg2dyU
 2VUeaAF/Df2tlwmIWWyPIlpdAb6qTENMz2SeQb11WkCsZ53pO+q65aiCprvvADAnle4Z
 Vm/g==
X-Gm-Message-State: AOAM531SPwuKE8j4yWJX4oLDvuVpyTpOfr+w47kF9/YeumbhiExwckSK
 BQxu+dFRswxvipFSI8KpkZ0V6Q==
X-Google-Smtp-Source: ABdhPJyij8IeOtFTHL2nzGuxZEdh+TdxXEh6JqgtOlgtmLd/k1ZNvyNjs05R1mWtjlXkIfknZGbqcA==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr4435021wrm.258.1591804512674; 
 Wed, 10 Jun 2020 08:55:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a126sm156142wme.28.2020.06.10.08.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:55:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E1E001FF7E;
 Wed, 10 Jun 2020 16:55:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/6] plugins/next (lockstep, api, hwprofile)
Date: Wed, 10 Jun 2020 16:55:03 +0100
Message-Id: <20200610155509.12850-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current plugins/next queue. The main changes are:

  - cputlb corruption workaround now just saves data ahead of io_writex
  - tweak to format of virtio-pci naming
  - the hwaddr device name now returns a g_intern_string()
  - bunch of extra features to hwprofile

The question of if we should expose mr->name is still an open one. My
alternate suggestion of sticking to explicitly -device with id=
entries met with crickets so I would welcome other thoughts.

The following are still missing reviews:

 - cputlb: ensure we save the IOTLB data in case of reset
 - plugins: new lockstep plugin for debugging TCG changes

Alex Bennée (5):
  plugins: new lockstep plugin for debugging TCG changes
  cputlb: ensure we save the IOTLB data in case of reset
  hw/virtio/pci: include vdev name in registered PCI sections
  plugins: add API to return a name for a IO device
  plugins: new hwprofile plugin

Vladimir Sementsov-Ogievskiy (1):
  iotests: 194: wait migration completion on target too

 include/qemu/qemu-plugin.h |   6 +
 accel/tcg/cputlb.c         |  63 ++++++-
 hw/virtio/virtio-pci.c     |  22 ++-
 plugins/api.c              |  20 +++
 tests/plugin/hwprofile.c   | 305 +++++++++++++++++++++++++++++++++
 tests/plugin/lockstep.c    | 340 +++++++++++++++++++++++++++++++++++++
 tests/plugin/Makefile      |   2 +
 tests/qemu-iotests/194     |  10 ++
 tests/qemu-iotests/194.out |   5 +
 tests/tcg/Makefile.target  |   9 +-
 10 files changed, 771 insertions(+), 11 deletions(-)
 create mode 100644 tests/plugin/hwprofile.c
 create mode 100644 tests/plugin/lockstep.c

-- 
2.20.1


