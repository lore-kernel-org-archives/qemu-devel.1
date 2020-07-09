Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF15FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C45E20772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBLAfZfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C45E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXK3-0001tg-RR
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIt-0000CK-CM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIq-0001K0-99
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id f139so1968851wmf.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OOuPlfztkt7djXH2mMYOdaRbdatzT6SNkYWnOe5/IrI=;
 b=qBLAfZfz7M74GYiMzWb5IZwT75mIUiCgpqpnR197qyOSAHQCOwDirQ0c6wvvTokPpK
 +Am/Wk3OFP1e7lv5GQOcJ7AEsNY3DWTmtTHFTMnNenl2qUt9pO9nd0b5lfay0VBwHzpe
 q/qjHPnqFZb+XfFCazNE3yFyfVJgwJvbxONx/EDkbKvg4ZDcGFDTHHsyOvvmmGxhvfLr
 00s4gPqV/Mrrg9lsYKuoKJAZUH7kEwh++Tn1Pdm3sRZnm1+wRX1J6mW+KVuL9LtZyi6b
 hKh+EpAA7KYJVoe4vKtJBp3Gvwyj/TGZEGJrQQBteeNxBOGm42KzfP8Fzw7RjHjnTlFj
 Qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OOuPlfztkt7djXH2mMYOdaRbdatzT6SNkYWnOe5/IrI=;
 b=NEVceVj7vqygnsCD129XTcKuXxXRzPa6STix2EGwcFyUFuSNavH2418juO6fD93KbC
 QsU13AGBPfDMr9pgdV4jWj2Ot2sns4rxWriO435PgL32DkSd9EQFnknGZrs938ejmbOU
 9pr2jTK0f8q4lhs1q7d0ojIL1l+Vxi6TYH/mMFKhpHJr13G8rOCmRiGEmDd10C8vtGpH
 XA0LKr/U5MnySd6rGqNyUrSi52+37vvvnrhCPJvknChySBDAwVsNILxrdMuTt0imoyvp
 SRIY2m199N0msvQZ8hFuJ+FUtKB8M1alsk5H8aD2+AtIza90qgPQKUuqybg44p0TlNvr
 XmcQ==
X-Gm-Message-State: AOAM533SByyBF1xwH88k2NjQboC+vQ0DU4FUMoE28BbYgxP6Wwl4f2cv
 avxQhyx8pdDvRe3iw3kNouving==
X-Google-Smtp-Source: ABdhPJy2j/T4cVWEY+idpHlY79RrGlAEBpyH4KRzAltqfK2tQiXzo+0zrXItDvdGWkFRXKG5ElzvLg==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr230994wmj.80.1594304009844; 
 Thu, 09 Jul 2020 07:13:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm5710380wrt.7.2020.07.09.07.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F5871FF7E;
 Thu,  9 Jul 2020 15:13:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/13] misc rc0 fixes (docs, plugins, docker)
Date: Thu,  9 Jul 2020 15:13:14 +0100
Message-Id: <20200709141327.14631-1-alex.bennee@linaro.org>
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
get added to the PR but I'd like to get the cputlb fix in.

Alongside the plugin stuff there are some documentation updates which
are worth adding and some tweaks to the docker cache handling that
I only discovered after I sent the last PR.

Based on:

  Message-Id: <20200707070858.6622-1-alex.bennee@linaro.org>
  https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-070720-1

The following need review:

 - configure: remove all dependencies on a (re)configure
 - tests/docker: fall back more gracefully when pull fails
 - tests/plugins: add -Wno-unknown-warning-option to handle -Wpsabi
 - target/sh4: revert to using cpu_lduw_code to decode gusa
 - plugins: expand the bb plugin to be thread safe and track per-cpu
 - cputlb: ensure we save the IOTLB data in case of reset

Alex Bennée (11):
  docs/devel: convert and update MTTCG design document
  docs/devel: add some notes on tcg-icount for developers
  cputlb: ensure we save the IOTLB data in case of reset
  hw/virtio/pci: include vdev name in registered PCI sections
  plugins: add API to return a name for a IO device
  plugins: new hwprofile plugin
  plugins: expand the bb plugin to be thread safe and track per-cpu
  target/sh4: revert to using cpu_lduw_code to decode gusa
  tests/plugins: add -Wno-unknown-warning-option to handle -Wpsabi
  tests/docker: fall back more gracefully when pull fails
  configure: remove all dependencies on a (re)configure

Jon Doron (1):
  docs: Add to gdbstub documentation the PhyMemMode

Max Filippov (1):
  tests/docker: update toolchain set in debian-xtensa-cross

 docs/devel/index.rst                          |   2 +
 ...ti-thread-tcg.txt => multi-thread-tcg.rst} |  52 +--
 docs/devel/tcg-icount.rst                     |  97 ++++++
 docs/system/gdb.rst                           |  20 ++
 configure                                     |  15 +-
 include/hw/core/cpu.h                         |   4 +
 include/qemu/qemu-plugin.h                    |   6 +
 include/qemu/typedefs.h                       |   1 +
 accel/tcg/cputlb.c                            |  57 +++-
 hw/virtio/virtio-pci.c                        |  22 +-
 plugins/api.c                                 |  20 ++
 target/sh4/translate.c                        |   8 +-
 tests/plugin/bb.c                             |  96 +++++-
 tests/plugin/hwprofile.c                      | 305 ++++++++++++++++++
 tests/docker/docker.py                        |  11 +-
 .../dockerfiles/debian-xtensa-cross.docker    |   6 +-
 tests/plugin/Makefile                         |   3 +-
 tests/tcg/Makefile.target                     |  12 +-
 18 files changed, 673 insertions(+), 64 deletions(-)
 rename docs/devel/{multi-thread-tcg.txt => multi-thread-tcg.rst} (90%)
 create mode 100644 docs/devel/tcg-icount.rst
 create mode 100644 tests/plugin/hwprofile.c

-- 
2.20.1


