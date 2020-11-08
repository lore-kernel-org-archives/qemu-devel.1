Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC762C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6270D206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYKqpL5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6270D206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbubn-00035N-9o
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 19:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuae-0002IP-S4
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuad-0003k3-2b
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id c9so6447554wml.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=789PFm8J90WkO5RJPK4P7q80GNT2jwQoQ0M3AJMcIGA=;
 b=GYKqpL5pfk66p5Z77zaKBF3KVr9kje2/BRfxZENKhifncRE8ZyC3HUiAIBP7Gg73XR
 5tXoCocSgoVigwGSn2Dk6IKYgZg0v7519/1dwYXnkwIQLgJTJ5kS3ERHhjthbiLwBzSD
 i5lNbtZ1fM+oFtS2HeKLUk2jvM0aHoxObwR2tcMp6hNrEWefEs1hiofJGbNXGn0n2BJ4
 woWJZAgQReR2MoHY+jgCXlTQqxTZURBsFSAyInbvbewbiBWdy2GGUe0dZ/Ot+FwF2IN2
 nfL53bDqqzSX+AeZWNg+u1VKk6yAAKnFQzqOXQQVJimpf2CkQP7N41bZU2ju+2uMj5kW
 97Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=789PFm8J90WkO5RJPK4P7q80GNT2jwQoQ0M3AJMcIGA=;
 b=F3WrKHu8l+XsX6jxMWbVDw6959v5fGU5JIUQhZVWym79xYWyu9JN2gsJW83ulUlMCv
 xtIxjrKU2ualpSndtsKysXZNyeqGGcoIW4HCOoL6oYZuLjpftO93c+oXlCjzmv4v84jd
 /hZIJYXzyU8uKgfCfifA+EBU77IVbxTJ8W1r1mLnodlh1B1B54OYbSOwl9sQw5JpULKd
 Pr8IYBexsYWC+a6Xh85u2qvbqdcKHh4ic/A86UnQwFtK5oT1AVy8X6qmphovtaJBZD+c
 1z6hKnCM8RkQIzCQMSHvp6dMUaN8X6mdRiB+9D23yvX3rSk7SmudBOlVnHhEnH4g0y9Z
 3KYw==
X-Gm-Message-State: AOAM532Quu8AN/S31ccPRZDQhVhnltpriVOYaN+10AUqK3pbrSFR/sUW
 6gvM03Zma3K8+EsMBiPoyWhEjk4RUTM=
X-Google-Smtp-Source: ABdhPJxhGowO7W2OgHxFnPoA+yOmqQ+kRxaR6fvybpI8MKGSIZgwo2Hmm2T7pXTPYxNcyOI5whrQOw==
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr11492762wmc.103.1604879957283; 
 Sun, 08 Nov 2020 15:59:17 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y20sm10620118wma.15.2020.11.08.15.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:59:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Renesas patches for 5.2-rc1
Date: Mon,  9 Nov 2020 00:59:13 +0100
Message-Id: <20201108235915.2396150-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e2156=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into st=
aging (2020-11-06 13:43:28 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/renesas-fixes-20201109=0D
=0D
for you to fetch changes up to 60f6de8fbafa5dc57af63792e3ba1a910239d195:=0D
=0D
  hw/rx/rx-gdbsim: Fix memory leak (CID 1432307) (2020-11-09 00:53:07 +0100=
)=0D
=0D
----------------------------------------------------------------=0D
Renesas patches queue=0D
=0D
- Demote target & hardware sections to 'Odd Fixes'=0D
- Fix memory leak (CID 1432307)=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/5340929353580544=0D
. https://gitlab.com/philmd/qemu/-/pipelines/213407241=0D
. https://travis-ci.org/github/philmd/qemu/builds/742315021=0D
----------------------------------------------------------------=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  MAINTAINERS: Demote Renesas target & hardware to 'Odd Fixes'=0D
  hw/rx/rx-gdbsim: Fix memory leak (CID 1432307)=0D
=0D
 hw/rx/rx-gdbsim.c |  3 +--=0D
 MAINTAINERS       | 10 +++++-----=0D
 2 files changed, 6 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

