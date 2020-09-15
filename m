Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFAEC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E424E21655
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHXRpHZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E424E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBJx-0006y1-1V
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEy-0000YI-8E
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEw-00047A-HT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so3422207wrm.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lYY3EJUKyqIcqNqVTB5o4eci52O5NxI+Yh0+mjHclVs=;
 b=CHXRpHZBGI2aUYeW3CrK3p27xvUvEjQ5NLRVZTkP6P2B22IXmUS6EFEt79JwipYgyV
 A/naXgjVH7Clc+c1u9XXHzRrCxYvqSk/jrf2O9yM/jiK75HAUqdlgB/34xl1yVP3rdRy
 p4VpbPqy8RDDHJGHTPN92n/CD89fEccIknkCyNIMcSmSe8Q+u88s7caDFzwEyutP44yW
 y0FZOdhaLfJp6REW8va7RJk5oJdCKIzF9Pvgs4c46AfXkf/QwUvCWCT5p9zqAyk3cIqP
 QaxrDDiDvJuC8PirW9DXmBm661UU6Dr71mce9/Lfyvdur3NsZmDQGKnQ/UFa20ICMY4b
 IA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lYY3EJUKyqIcqNqVTB5o4eci52O5NxI+Yh0+mjHclVs=;
 b=Wn3f8uGVzmxi8Y5L8+2+oSY9quodjobJgv7iW1pkZoTFxsCIQa2JPMakc/KOMFdOjz
 DAJISxsy0ISsfhNbD1sNkiDSUgySA95xVitG8fN68wBIXahTWSwySPSfzy9HrbdYN36d
 3eMVSUfM9nitbB8yTzBKKKhL8RMaqz48ogghotXkrkW5SHEKGSSrRoUoH7+VT/v4uUo8
 6rCOBYo8mx8+yTnHzLfjEEYB4N+OmlQNKQtaII5GXuDH79i1sP4YHf/ULjzKQsEiIW1z
 oWPD7WmnAjHKilJJQ8KjyUCa5s3eU9WsPBerKr1eW9G7HshLn50S0flDKyT4ZFPkPXeR
 4ncA==
X-Gm-Message-State: AOAM533J4/QYDsnF23Eatq/1xDUWzRvmACi5znZB0uxTlXqnZiOWA6Km
 Dkizyj5sD8WyUOhEpXxLgh/dHQ==
X-Google-Smtp-Source: ABdhPJzxKaazaD6h4rXH/ZCEJLcnZnejo1nxoWxxsM07w1DQptsbM9/c8+WT2nNKALa2W98BXJB7mg==
X-Received: by 2002:a5d:4d8a:: with SMTP id b10mr21319644wru.82.1600177398943; 
 Tue, 15 Sep 2020 06:43:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a83sm25100723wmh.48.2020.09.15.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28C6D1FF7E;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/8] configure deprecation, linux-user and iotest fixes
Date: Tue, 15 Sep 2020 14:43:09 +0100
Message-Id: <20200915134317.11110-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series contains the previously posted linux-user fix for dealing
with weird mmap semantics as well as some tweaks to configure. Since
last version I've included Max's latest iotest update as well as
re-factored the configure logic. I've also added a patch for to
deprecate lm32 and unicore32 from configure.

Most need review:
 - configure: add [lm32|unicore32]-softmmu to deprecation logic
 - configure: include tilegx-linux-user in the deprecation logic
 - configure: clean-up the target-list-exclude logic
 - configure: also skip deprecated targets with target-list-exclude
 - configure: move deprecated feature processing to supported_target
 - linux-user: test, don't assert addr != test in pgb_reserved_va

Alex Bennée (7):
  linux-user: test, don't assert addr != test in pgb_reserved_va
  configure: move deprecated feature processing to supported_target
  configure: also skip deprecated targets with target-list-exclude
  configure: clean-up the target-list-exclude logic
  configure: include tilegx-linux-user in the deprecation logic
  gitlab: create a build-deprecated target
  configure: add [lm32|unicore32]-softmmu to deprecation logic

Max Reitz (1):
  iotests: Drop readlink -f

 configure                | 33 ++++++++++++++++++---------------
 linux-user/elfload.c     |  9 ++++-----
 .gitlab-ci.yml           | 15 +++++++++++++--
 .shippable.yml           |  2 +-
 .travis.yml              |  3 +--
 tests/qemu-iotests/check |  2 +-
 6 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.20.1


