Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D2CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC24220731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0rwvBar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC24220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYag3-0001aZ-Ts
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaeU-00008m-EJ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:18 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:45332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaeT-0001lh-5Q
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:17 -0400
Received: by mail-qv1-xf42.google.com with SMTP id z9so4914356qvi.12
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7CaZpTWka1C8MJsj1GeNh6KCoNtsbN5Y01Jpprc1T4w=;
 b=S0rwvBarPnNDzRix+kua2HM1NFKmJhogx0BjZTo5SqKTmJQUgaM15fx+SY67/6loDF
 nWyw0kdjwrAmfE+HVDGEpt7caxC2F8SkuJriPfoWjcqxkY9YuZ8e+fgsgT2M9OOUuBJr
 SbgnkChqhk1grRgtOh1I8vfGBeX5p0KaG21BvvF/oiI8xtVY8BX+DRpke2JJGoJllrb9
 G5XMAU2IZ1GbebnRu9PUN7arhdXCg31Zn9w6RZRCB1pV0LE2KTeQn3Cibsa++vx5M1mY
 HqyDNrhIuuKyBzv9KqmDYNiZ/j/MuH44+X89XtjVy9GRl9+U72dUVh5sfL5ZxBxB504k
 t8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7CaZpTWka1C8MJsj1GeNh6KCoNtsbN5Y01Jpprc1T4w=;
 b=PEPgzhS8rCUlZK9PyaqFu815WfvgeMt58RgopZPlHQCayOrRwN8KBwD8e4Qm0MsRMw
 trN7hJgNL4Ysy695FPvMthd+hJfRVquWsU6xObV5E4hx8LHhTZ/OqOcM9V4luUbw15wE
 LKE2P0LUjz20lpegTjMeQoAQsg8bZ/9dPdk0KHtOy+GmvxV8jPuUEcPcla8eV8Iy971x
 8IllyEPQR1UGdARCZ0FHfscX1TnGXnSMeXBMKlpEqYXw0y1sviOe0ucof6l67QMP38+y
 FtOMJlow6RgZfIATblFrkiqqHGbmXruNuW5k+LEFO7UwAw5ag6D2IrYfF1xj0nG/vwvq
 K5cQ==
X-Gm-Message-State: AGi0Pubp79SSJ5ox8ND8ZTIq582EP4zp9dFeTbVqbpDal0fXHUthCJA8
 t9+824shshpTJ/PkA57zgo3RaKAQ4Y89hg==
X-Google-Smtp-Source: APiQypIXaZfPqs6F+LsmZYTlZDczUlWjVsBM9GlPcAmJorO56zqBA+sEa0boRSajGeeLNX+aAiSJ+A==
X-Received: by 2002:a0c:ef05:: with SMTP id t5mr21451189qvr.113.1589311995399; 
 Tue, 12 May 2020 12:33:15 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:d31:9f53:b3eb:9b53])
 by smtp.gmail.com with ESMTPSA id j45sm2100998qtk.14.2020.05.12.12.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:33:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/9] tests/vm: Add support for aarch64 VMs
Date: Tue, 12 May 2020 15:33:31 -0400
Message-Id: <20200512193340.265-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is version 6 of the patch series to
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

v5: https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg05692.html

Changes in v6
- Removed the use of the BOOT_CONSOLE option.  We were thinking about moving
  this under the DEBUG=1 option, but decided to remove this since
  we already have support for logging to a file, which can be used instead.
- Went back to Ubuntu 18.04.  Still working on 20.04 issues and will plan on
  a later patch to enable 20.04.

Robert Foley (9):
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Pass --debug through for vm-boot-ssh.
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  tests/vm: Add workaround to consume console

 configure                         |  25 +++
 python/qemu/console_socket.py     | 162 ++++++++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  24 +++
 tests/vm/aarch64vm.py             | 105 ++++++++++++
 tests/vm/basevm.py                | 276 ++++++++++++++++++++++++------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 227 ++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 +++++++++++++
 15 files changed, 1089 insertions(+), 91 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

--
2.17.1

