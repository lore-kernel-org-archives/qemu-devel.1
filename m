Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081EDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C809120674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKkXwEG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C809120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4he-00011X-1I
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gX-0007uG-SM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gV-0006Fz-Rx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id f7so18154578wrw.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bgIm0ZKsheAhSoe+ZwgMoK/8D+7oAiV57M87gUrDop4=;
 b=PKkXwEG1du4WDisI2sFj+DyEN1441motwlMsgncKMT9foFnQjzZMtQp+GU05BUCWiC
 Hjynz26dsuggfi4mWiqaIk6ZbDVNn0dHf+nw1Fk4eWNuSodBSkN88wvy8tIE27TaYATt
 Uj1+3U7VzL5WlaPED5AYaISTQvnBx8n+ddm1vssGiXApmWHI5JqbGcXM6WILF8QfbuLF
 4o3trWfZ+k+Vyt74WjaUfMmcLmxzT7y43jb/RvLUhGAufKJrZ/tf6FdDuFoWMr+TKyZ4
 g8dS2H+yZpON2eEDbff5OO1GPUQOvkbFF5Mm0M0+fItg4Q+qNvGbZM0iSdGjhYZt+HMF
 ZLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bgIm0ZKsheAhSoe+ZwgMoK/8D+7oAiV57M87gUrDop4=;
 b=C0z/B9O66GT4RiTCrWoESoeVHhqGI+lbQifBWS2xzMGCy4kTyigjUy/x43BuOho545
 UIEPbWs+FC9dDoKnbRaaTSnKFzQy1rK/E8aMJ325ZT6o4cyZhFStcQShysg+rzu3JnOq
 zQajp+2tY/I6nyHCJSx4MMcXFylMp6X5lV2rBQDI3C2/Drj1LnacCjD4Plv4nvlnKeSa
 abCIS6JRl1REAuYIsE08Enql0Wnpkyy2bZwBHBEBb3w8oJK+4q7H8pgPheSG3mhhZTQF
 QRPzPBPXSQeGjcN4tSSoIaO8NutauAI9GEoBw+YnSB7ybOFpAkUskjyPo+l8cuzO/E6J
 weFg==
X-Gm-Message-State: AOAM533OK6wHh0BoPHKt0ePu+9zfygmYKy97ya5whHGHYuR6wV35IOuR
 hUTXHgKHEkI877FMnjOFPPyGKA==
X-Google-Smtp-Source: ABdhPJzvpiy3Xn6Z5orZs6lEYWO1avMUN7i+TVxE3Af4sDRirrCu4wKJb5AuksVxqxPo9BAqnCdeqQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr1181836wro.214.1594670658231; 
 Mon, 13 Jul 2020 13:04:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm786906wmc.26.2020.07.13.13.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96FC21FF7E;
 Mon, 13 Jul 2020 21:04:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/11] misc fixes for rc0 (docker, plugins, softfloat)
Date: Mon, 13 Jul 2020 21:04:04 +0100
Message-Id: <20200713200415.26214-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These are some candidate patches for rc0 along with a few plugin
patches that haven't yet gotten review. The new functionality won't
get added to the PR but I'd like to get the cputlb fix in. I've also
had another run at fixing the -Wpsabi problem.

The following still need review:

 - docs/devel: fix grammar in multi-thread-tcg
 - tests/plugins: don't unconditionally add -Wpsabi
 - cputlb: ensure we save the IOTLB data in case of reset

Alex Bennée (9):
  configure: remove all dependencies on a (re)configure
  docker.py: fix fetching of FROM layers
  tests/plugins: don't unconditionally add -Wpsabi
  cputlb: ensure we save the IOTLB data in case of reset
  plugins: expand the bb plugin to be thread safe and track per-cpu
  docs/devel: fix grammar in multi-thread-tcg
  hw/virtio/pci: include vdev name in registered PCI sections
  plugins: add API to return a name for a IO device
  plugins: new hwprofile plugin

LIU Zhiwei (1):
  fpu/softfloat: fix up float16 nan recognition

Thomas Huth (1):
  tests/docker: Remove the libssh workaround from the ubuntu 20.04 image

 docs/devel/multi-thread-tcg.rst            |   2 +-
 configure                                  |  18 +-
 include/hw/core/cpu.h                      |  16 ++
 include/qemu/qemu-plugin.h                 |   6 +
 include/qemu/typedefs.h                    |   1 +
 accel/tcg/cputlb.c                         |  38 ++-
 fpu/softfloat-specialize.inc.c             |   4 +-
 hw/virtio/virtio-pci.c                     |  22 +-
 plugins/api.c                              |  20 ++
 tests/plugin/bb.c                          |  97 ++++++-
 tests/plugin/hwprofile.c                   | 305 +++++++++++++++++++++
 tests/docker/docker.py                     |  16 +-
 tests/docker/dockerfiles/ubuntu2004.docker |   3 -
 tests/plugin/Makefile                      |  23 +-
 tests/tcg/Makefile.target                  |  12 +-
 15 files changed, 533 insertions(+), 50 deletions(-)
 create mode 100644 tests/plugin/hwprofile.c

-- 
2.20.1


