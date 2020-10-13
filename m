Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39837C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970DC21655
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ2RdRMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970DC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8D5-0000v4-7w
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8Az-0007rF-Sb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:25 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:45155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8Ay-0004mT-7n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:25 -0400
Received: by mail-pg1-x52f.google.com with SMTP id y14so16107219pgf.12
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zEKfNIeymcKPsazgVsI+BouUpU8RF746p2+yCwWSEXg=;
 b=KQ2RdRMrYsh6GOoShET0iRiz98tfZVxWp37i0REPXHO6NARYLcNsw4Wc9R7nh3WC1h
 BrU/Zl9wYiMyKJTjyf5NXb67921ylOS1SayG0gWBRKAKYA78N2rZknBvaYFgNCYVxAls
 76Yb0qy22N34e39aNLLi1R3Fv0j62GRPBQgR8jJC2wlAQRxWMPOT2tMTEUoqMOz3hPSI
 puYQzifmQMQXjk2wi3GUsRpk24cNjuD67BoZmOUulb5uaCkf4xGf5xZS1RkK6XgQEEFH
 6umZUKsHEJwqNady+gPenQ1OixHsmg8SqQxQ6kQ9iMtGP32U83dKTo/XrVGo7XHAtcPB
 qN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zEKfNIeymcKPsazgVsI+BouUpU8RF746p2+yCwWSEXg=;
 b=QC2YSjvAcvXJkLCIZ8ZxPuSIgN5yRcXd9GtCcEg/sAKwuVhaxkYmCcpoeyA0OPgCTg
 Aa/R03c9heZd+RZ58J0x1cDvU5tuYtDQGb7k+J4anDl6wBctCUsazSUgPoHYRHdTHxvD
 kNq+WaK/QYry9ULe/qShnB9ocje0srsGrntJEOrALSGLy5o3ndDxTAehrYqfTiKnpbbB
 yGJSVwYntLfErJsHtzMTZjdKDg5qERU+36SAswuJZx9Yusme7R6BUoXlxvxAB4TEWysb
 6Mi3RoLPlVzBQPsZUBTW3XLEf3eimEq/T0qMuVE5um0JNLbRzsi27sCFHvBet4ELn4Ac
 l88Q==
X-Gm-Message-State: AOAM531rPINbPqFdFwTrg52k2SS8PlldIobMSTgQrS248ftW6WsnZ3EP
 KASnW4tdYcEUpW4nvHcmqjzluGkoISca5Q==
X-Google-Smtp-Source: ABdhPJwJV7iSGkurUd6SPHe4Zk0tj63x25wp6R3J4ji7jniNlAfs93iQANLBOhJg9zUJtAF8GsIabg==
X-Received: by 2002:a17:90b:30d2:: with SMTP id
 hi18mr23247720pjb.86.1602548902208; 
 Mon, 12 Oct 2020 17:28:22 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id y5sm22565925pge.62.2020.10.12.17.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:28:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/5] Enable plugin support on msys2/mingw
Date: Tue, 13 Oct 2020 08:28:01 +0800
Message-Id: <20201013002806.1447-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52f.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V5-V6=0D
Skip merged patches=0D
=0D
V3-V4=0D
Split  plugin: Fixes typo in qemu-plugin.h out=0D
Trying to explain the design of=0D
plugin: Getting qemu-plugin works under win32.=0D
=0D
V1-V2=0D
1. Fixes review comments=0D
2. Increase QEMU_PLUGIN_VERSION to 1 for compat  QEMU_PLUGIN_VERSION 0=0D
3. Revise the loader to support for version 0 and 1=0D
4. By export function qemu_plugin_initialize in plugin, and call it in load=
er=3D=0D
, so=0D
  we have no need call it in every plugin. And also provide a standard impl=
em=3D=0D
entation,=0D
  anyway, use can also override it.=0D
=0D
Add this feature on msys2/mingw by using glib provided cross-platform dlsym=
 f=3D=0D
unctional.=0D
=0D
Yonggang Luo (5):=0D
  plugins: getting qemu_plugin_get_hwaddr only expose one function=0D
    prototype=0D
  plugins: Fixes typo in qemu-plugin.h=0D
  plugins: Getting qemu-plugin works under win32.=0D
  plugins: Getting qemu-plugin.h can be included in multiple source file=0D
  cirrus: Enable plugins in cirrus for windows=0D
=0D
 .cirrus.yml                  |   1 +=0D
 Makefile                     |   1 -=0D
 configure                    |  71 ------------=0D
 contrib/plugins/hotblocks.c  |   1 +=0D
 contrib/plugins/hotpages.c   |   1 +=0D
 contrib/plugins/howvec.c     |   1 +=0D
 contrib/plugins/lockstep.c   |   1 +=0D
 include/qemu/qemu-plugin.h   | 208 +++++++++++++++++++++++++++--------=0D
 meson.build                  |   6 +-=0D
 plugins/api.c                | 113 ++++++++++---------=0D
 plugins/core.c               |  16 ++-=0D
 plugins/loader.c             |  50 ++++++++-=0D
 plugins/meson.build          |  10 +-=0D
 plugins/plugin.h             |   1 +=0D
 plugins/qemu-plugins.symbols |  40 -------=0D
 tests/plugin/bb.c            |   1 +=0D
 tests/plugin/empty.c         |   1 +=0D
 tests/plugin/insn.c          |   1 +=0D
 tests/plugin/mem.c           |   1 +=0D
 19 files changed, 298 insertions(+), 227 deletions(-)=0D
 delete mode 100644 plugins/qemu-plugins.symbols=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

