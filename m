Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE96C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9378023977
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urnlPCbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378023977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRuw-00056H-A2
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRtv-0004Kt-PT
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:38231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRtu-0005Kh-4y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id c3so1700233plz.5
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/nYQ+8zkCgUp5MR/ASiOY6mLhsrMuES3KlMH28cwivA=;
 b=urnlPCbexh/zAue8y9VHKC2FrFJDVhohzi/QB1jiNlAgMLOjsdu8xztX5Ng/DtY9eI
 AlrvEgBlVMstYMsaW3KUnhvhjt9RB6UdWojcqwzTnNmWl5I6jx+DfQakuQ6JeeQUDS8N
 4vxI5gkyY7o8vmTOTs6Wr86MpUU9gHAsxAKTG88gFsS/v0BTCwzQsi6lzluLI1V8uAX8
 HKhrCEmOGi9TWtGoAWo9OUHm1wgNc4WKLQkKPB+J18agIET9BJ728JsbMCYyni3E3NgA
 A5RQJJtgkmBZ5jNmdn+H1lEYKmM30/xxvErUvRQ++ghw+oY/ZeADjtg0J2E709mYRZaa
 NXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/nYQ+8zkCgUp5MR/ASiOY6mLhsrMuES3KlMH28cwivA=;
 b=i02vwzxfqKTLNJy9vbU5O6+czwWS0aLxbhIVazL+y0A7E4EQl9fpQtxI4DreEc9Ihn
 gVNlYgOrEEnUOOwhUUxNcIPgHCVHMlKPzuvKGh+YsIv3Av4YGdENtrRGJAQ2Sx8DyEKO
 z5Z9ZCFRIcTtuwsnHmh7XFs+RLalCQDWYAF5d9oU+0i+zr41ZcbqA7WQP51AHtC4p/wU
 VKJRktidgt6o+DmLvtZDO/zzTuyHBmkuN6L6FN0vlENgeCk0tx9ZQJ+/SE9cVig+/sMy
 zuStvanehEIc+8TjIaI7gD9S2UDm7HBYLfkpDTxeUVlZtc/pd4lYmsuVRJ919D/jh4ps
 nrrQ==
X-Gm-Message-State: AOAM530CzZff5RvkcJVa/RLOXzVcJZPO2o11Ohy9KUD+UguPhwmUm81m
 yMF/Ow/eAW77zkrfY9kJTsk3vSyL43mSa8gS
X-Google-Smtp-Source: ABdhPJxHQKwZPw+k6SHS7cWnoHkS5QFSh7ID8V+5S8bCSYLv5BVfCLvnCG4DUDBK4LokG/Jmq3HFDQ==
X-Received: by 2002:a17:902:7c0e:b029:d0:89f3:28d4 with SMTP id
 x14-20020a1709027c0eb02900d089f328d4mr6603500pll.16.1601194755688; 
 Sun, 27 Sep 2020 01:19:15 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id z22sm3317693pjq.2.2020.09.27.01.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 01:19:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Enable plugin support on msys2/mingw
Date: Sun, 27 Sep 2020 16:18:57 +0800
Message-Id: <20200927081901.771-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62f.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=E8=8C=85e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Yonggang Luo (4):=0D
  plugins: Fixes a issue when dlsym failed, the handle not closed=0D
  plugin: Fixes compiling errors on msys2/mingw=0D
  cirrus: Enable plugin in cirrus for windows=0D
  Getting qemu-plugin works under win32.=0D
=0D
 .cirrus.yml                  |   3 +-=0D
 Makefile                     |   1 -=0D
 configure                    |  71 -------------=0D
 contrib/plugins/hotblocks.c  |   3 +-=0D
 contrib/plugins/hotpages.c   |   1 +=0D
 contrib/plugins/howvec.c     |   1 +=0D
 contrib/plugins/lockstep.c   |   1 +=0D
 include/qemu/qemu-plugin.h   | 197 +++++++++++++++++++++++++++--------=0D
 meson.build                  |   6 +-=0D
 plugins/api.c                |  65 ++++++------=0D
 plugins/core.c               |   7 +-=0D
 plugins/loader.c             |  51 ++++++++-=0D
 plugins/meson.build          |  10 +-=0D
 plugins/plugin.h             |   1 +=0D
 plugins/qemu-plugins.symbols |  40 -------=0D
 tests/plugin/bb.c            |   5 +-=0D
 tests/plugin/empty.c         |   1 +=0D
 tests/plugin/insn.c          |   1 +=0D
 tests/plugin/mem.c           |   1 +=0D
 19 files changed, 258 insertions(+), 208 deletions(-)=0D
 delete mode 100644 plugins/qemu-plugins.symbols=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

