Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBCC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93036206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5NqU2Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93036206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS47j-0000fT-Cw
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46v-0008Ir-VO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:07:58 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:39340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46u-0007q2-3B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:07:57 -0400
Received: by mail-qt1-x82d.google.com with SMTP id c13so3460680qtx.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v0Cs33Gr8ZIAyIhglkddtMKcyQqAbuNNR2DdCRh4xdo=;
 b=I5NqU2FmUWwd1I3YdYafLj6MuoLjP8vfg48bx4m87EUu2Z9j57n0IL2LEKO9zUeFPN
 yddqJSh6ZdXpGKz4oNhDbdJyLMQO9wAbrYe/k+07LrlqsItDNlE26EPfVhL4KYFkf5Th
 HK3QAXukmMHGZT71wNmI/11SnDwPxidsRANoKS94e9UWIIZSd57K1JhKPdS5RS88vGLl
 62QVH4qOoUOpKfmEDt/iJ3wXCvNQSi7PYo9fNu221qung4MlK+9gPbfxBa67CF3zL4Wm
 HO1D+I5SvUURf8TNTTl5gV0lzdEo6WTsIHOcwZFaz7ZFZCTaKQ0+0SRdBmIGorsFn0nI
 lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v0Cs33Gr8ZIAyIhglkddtMKcyQqAbuNNR2DdCRh4xdo=;
 b=WMgmq/BeDtmm+DleXaP8Wf5Ilu+H4Hy8a+p0I/VUiYyKLjFqdLtBzzy/ZXM8iph748
 OaFECbRVw6z9y7c68MAIXE+4P0E3Mgj/frE3dA+gEfLh14PL13FP2Qa+KKit4VmWT/GQ
 yS7O51fEJlCbmhcboTz8eTW1cwLVZk15vL91Oj1Ox9oTUNym7UzW/AvT8y6jUAYqr5HX
 sgLGBJrraMKV+E4pH0z8r2C8DiQoPhQuqtqycS0hTSGQfpy29gnoZZCpRN81bjHm/haD
 DaLlpQVktCKravdGy2Ykwv/S24f0+Jaq0tRA+tfjn7pYHycz9IvFvRbN0h6byaWtczld
 Xshg==
X-Gm-Message-State: AOAM531AQttKsfxeHf5qKHp4gFhWLBr3ndSVJnw5ZxTRL7MpuqMCeqot
 t+8NA+XyUbOEUxe58Cs/WqbIvwTCNoU=
X-Google-Smtp-Source: ABdhPJzLBfY+CXT7WdaA1EBpQhcIOT8q6V+A1sEJrRQx5zR8sS7e385nJtH7BRiNQ/b/X/cAnaaHGA==
X-Received: by 2002:ac8:1a6f:: with SMTP id q44mr11703130qtk.136.1602533274354; 
 Mon, 12 Oct 2020 13:07:54 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:9802:d83e:b724:7fdf])
 by smtp.gmail.com with ESMTPSA id d129sm13418350qkg.127.2020.10.12.13.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 13:07:53 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Add Xen CpusAccel
Date: Mon, 12 Oct 2020 16:07:22 -0400
Message-Id: <20201012200725.64137-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=jandryuk@gmail.com; helo=mail-qt1-x82d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jason Andryuk <jandryuk@gmail.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen was left behind when CpusAccel became mandatory and fails the assert
in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
Move the qtest cpu functions to a common location and reuse them for
Xen.

Jason Andryuk (2):
  accel: move qtest CpusAccel functions to a common location
  accel: Add xen CpusAccel using dummy-cpu

 .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
 .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
 accel/dummy/meson.build                       |  7 ++++++
 accel/meson.build                             |  1 +
 accel/qtest/meson.build                       |  1 -
 accel/qtest/qtest.c                           |  7 +++++-
 accel/xen/xen-all.c                           | 10 +++++++++
 7 files changed, 34 insertions(+), 24 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
 rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
 create mode 100644 accel/dummy/meson.build

-- 
2.25.1


