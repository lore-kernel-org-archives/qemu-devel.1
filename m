Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10B32065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbH4X7ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10B32065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvoOJ-0007Xb-S5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 16:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNM-0006jj-2K
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:36 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:43757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNJ-0007Yh-AU
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:35 -0400
Received: by mail-pg1-x531.google.com with SMTP id w2so3678864pgg.10
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8YG7sNe1WZD8WXiuBEhD8a7IbM25Es/A8eo5RXuxdNo=;
 b=QbH4X7ckC0Wdb9nJHSHLI5mUrSt7SHUzmjDUUqGNXFAMYi8ABwY6k0YcTbb+ynfLMe
 cmu+pxO5gsGsVEDGEJCV7qyczeoD8rKcfa76jjVaRpGWuvIxY6WFwjTU4EWdg+Wu5H54
 69m2IYFW1stR3TU/7MDFFEKVhFMyEejYYD8IZH+D1dgJ9JWFUsYbvVixlc0rnsznSNfB
 lI65fPF13UyytLZrt8NO8E0QaSOWxKP64c0z/oEYcQ1zv+DOVgUKK8ht1qbNx4tTGRV1
 zuj1P+pDUByqYyBIYhqUgTTKOMs+Gqmt8JLbOOaFgJ1dOhD4o00M1diHHQNqqMlUuT4N
 OeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8YG7sNe1WZD8WXiuBEhD8a7IbM25Es/A8eo5RXuxdNo=;
 b=JfwR+I1PGcnktGHmD5qPm7L2G3ddPpiJrj87OULOdr0viJeODVRJ9PYCf5plW+HztB
 egAoba7dYjPjmkUnTqq7fvEW/bt88+7d/Ao1u5cGbAEdNQOWpcQtUacYZWcQ1oos1ccv
 5z5DMsFIg8r+waNMO6IJw/MqT8xfSXQK+KTuH/4xCb360xpmPz9I8EDjbF9VXiKc7GA+
 MU5QHzJS94crw0V2hY6sBu+ZFXpUqBaBH+0h9Oq42XHe/61lDS6VPS4vjTJmwOGx+7Nr
 lQTxsb7HBGHRbWdtvurdLh4b6Ls4kkXS7ZYmGaiJ8TLS/fWibo8TztXYpKc6u72rXvEl
 iSbw==
X-Gm-Message-State: AOAM532b+EDrOq6FczSRtLJryw9UX/nNMeoA8bkIZa2c0NCfmwJQzbEV
 S5Ew4ZwWgn6++LuamVPbJRAFDd4DEC97xg==
X-Google-Smtp-Source: ABdhPJwL25qw6J5FV6yNrPuXp1P7yw95FXJt6MCT3YXHNoUxyZKEOB5Gdh9xeci1FhzUqC2oCYJ5og==
X-Received: by 2002:a63:371d:: with SMTP id e29mr1333401pga.153.1594846286584; 
 Wed, 15 Jul 2020 13:51:26 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id 66sm2687690pfg.63.2020.07.15.13.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 13:51:25 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] python/qemu: follow-up changes for ConsoleSocket
Date: Wed, 15 Jul 2020 16:48:12 -0400
Message-Id: <20200715204814.2630-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, jsnow@redhat.com, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces a few follow-up changes after the introduction of 
ConsoleSocket.

The first patch introduces cleanup changes for pylint and flake8.

The second patch allows machine.py to use a single type for the console_socket,
a ConsoleSocket.
Since machine.py will use ConsoleSocket for both the draining and non-draining
cases, we changed ConsoleSocket to handle the case where it does not drain the
socket at all and essentially behaves like a socket.

Robert Foley (2):
  python/qemu: Cleanup changes to ConsoleSocket
  python/qemu: Change ConsoleSocket to optionally drain socket.

 python/qemu/console_socket.py | 133 +++++++++++++++++++---------------
 python/qemu/machine.py        |  14 ++--
 python/qemu/pylintrc          |   2 +-
 3 files changed, 82 insertions(+), 67 deletions(-)

-- 
2.17.1


