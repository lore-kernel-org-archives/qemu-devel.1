Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42981C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0197208B3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrqItiii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0197208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqKH-0006Z6-RH
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4f-0000Zs-JX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4d-0000Ct-Rw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so402118wmb.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pIFi3DUdOFHRulPhCVcNI2925WgOpymqf78dNvyw1VU=;
 b=NrqItiii49Rwz10vAj8AyZ0Wp377UD+0rdDfeX13SX6s6TIjyML9zmW7aSUeYFJx+V
 p2xWaAy9jgSd1meWEukf/u7JRT6xDzrRnXANYxXZDOUro92sYToeCIBQhONRX1juTUv7
 QkPpbass2wHwohno2hJodtn6NH61dR8H9lnjuamofRpk5lB1aYgwXMYHeRLvEHwP+QmU
 HXfPK5sr+a7VSQFvBnED2l7JkIRv8RwGoOHcMlbgkJtHy0Zmx59ZRNDR1fCzKd6801Z5
 xfyk/zeHVtBDyWodoxRMSDMtMNJgGNKoXDIkdcZqmqWHMHnAWtwnp3rHxv/Z1BdHeoVQ
 T2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pIFi3DUdOFHRulPhCVcNI2925WgOpymqf78dNvyw1VU=;
 b=H5Q68LtWQS0/TqhX077kGToaz/PRCV9CLFvfcZ0df2dkR0Zxad/9529JgqYxexDD7+
 qqVHt4UM/M6DMDtVPaqrJ9R86BDqD+XC0lc+nnSviWet6PYQ/jOzW8hsdqH+OesqC8j0
 tW0IBGPj4PEVqXh3TB+dtJcPf4e6hV+WEh2y8K55/J1nq7iQhSWxmBGh9avMS89CsFmH
 9pPGAv6FIPUjCvpb8CBpNJfSalQHsIoexRwUY9dzIMhc2cD+wzA/F0teciz5SGIF5mpd
 msO0vr82uByU2yt1GnALQUo9jNqdFWzO0jqy9lHyQ/rZHBWydKCyKRnLjzLnek9jjomC
 8fDg==
X-Gm-Message-State: AOAM532r2mivk5PDlPj5A/riGlsEDhygF25sr1nCXhNLtVNcpErr8jtJ
 zQcKUoJrUkHuSiFzu5fQ/FDA6A==
X-Google-Smtp-Source: ABdhPJwXEglZoZegQy2UB9OO6Q263Im3aUhvBOWjWAwV/36s3Ws/BlZ4rffZVEPBGvhuNhFtE39DFg==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr14556507wmk.29.1600096038520; 
 Mon, 14 Sep 2020 08:07:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm24755521wra.36.2020.09.14.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF5AC1FF7E;
 Mon, 14 Sep 2020 16:07:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/6] deprecation and linux-user tweaks (+test fix)
Date: Mon, 14 Sep 2020 16:07:10 +0100
Message-Id: <20200914150716.10501-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
with weird mmap semantics as well as some tweaks to configure as
suggested in a late review of my last PR. It includes tilegx in the
modified configure logic for handling deprecated fixes. There is also
a fix from Max for iotests although I suspect there will be a v2 of
the patch soon.

Most need review:
 - gitlab: create a build-deprecated target
 - configure: include tilegx-linux-user in the auto-exclude logic
 - configure: also skip deprecated targets with target-list-exclude
 - configure: use add_to for tweaking deprecated_features
 - linux-user: test, don't assert addr != test in pgb_reserved_va

Alex Bennée (5):
  linux-user: test, don't assert addr != test in pgb_reserved_va
  configure: use add_to for tweaking deprecated_features
  configure: also skip deprecated targets with target-list-exclude
  configure: include tilegx-linux-user in the auto-exclude logic
  gitlab: create a build-deprecated target

Max Reitz (1):
  iotests: Work around failing readlink -f

 configure                | 15 +++++++++++----
 linux-user/elfload.c     |  9 ++++-----
 .gitlab-ci.yml           | 10 ++++++++++
 .travis.yml              |  3 +--
 tests/qemu-iotests/check |  4 ++++
 5 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.20.1


