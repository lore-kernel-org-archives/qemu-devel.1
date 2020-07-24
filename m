Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5971C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908542070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3tC+Xrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908542070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrTs-0005kC-SB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSF-00040C-OK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSD-0000Du-Kl
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id q5so7250056wru.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VAi8k5Zol/wiE3ERKKx5W1VAkElXOLsOF468dnZNkJU=;
 b=e3tC+XrtW/b7mySKTX2+JH/Ih4Ex9znfGvCcXz2JAqRYj2s3A2skCQbmhu1+mKp58L
 zxE6H2zDjsnQYlEePdhcS1JSiFBEHn/8asSDGsaBkTam0JaquvJ+jjgj5uxe6a5eSqER
 35LcyWCUBzCBz0deKHQYLSa1uPKffE8m2iFPkLuOcRo05kloksXPN6VGraE/VuBfXnfI
 7QFaFk5PqmM3kE9Cm7wfRoOQh9giDN3Wn34LhfoZHe9GzxTN5mOEwUYsdfJBE0nd1WFP
 aQvPzcCzp2/I4pZ1pEOBc660504MpBtZHj+pVB+3dZklm56JbXwxoBjEyBPLwNp/LDg4
 Fi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VAi8k5Zol/wiE3ERKKx5W1VAkElXOLsOF468dnZNkJU=;
 b=q7TmXU8tmlYaIjSVu1KM8imTD7wUOQMOE6h9t1o81OHaBea18Rqe/TPcxRzREiRmZO
 cZix9OMjTa84SUW+srd+Izen5ztHrYRzQCH2DSXHevgl421OYszkKjTqbN5jgbyLJ91i
 oLNBwuN8VrLGJrc6U/arFJ5RKbNxYOP36WmpQxsO4UxtfoW/W2aJCP5aoBLAaWUhNMVp
 iRzj7UKwMRVtqcSah3SbzDXiMEZI6Swj+0OmzWZuZtzkV3m4nzPAiyXBxotDnp3p043c
 yRNblBaufWXCJEp1vYcoC0hnetB9PqaVMZ6Div8wcA9koHEa79NuhKzTBsvhN1B7OvS0
 T8DA==
X-Gm-Message-State: AOAM532xnCVEbpFoj6wj7uk/31Oa+vzUf/WWFZsuZVKFoWrX81zXcM5H
 9Er9U0iAi1hbyz4I9LtdMeQWTw==
X-Google-Smtp-Source: ABdhPJyGT8QsBjy9LwZnCvP5Bz5kf6Kv4P5fWtsi9SrcH95kYMYPgptRFUwW+YSynUm1fb33sEF3jA==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr7537417wrs.187.1595573111320; 
 Thu, 23 Jul 2020 23:45:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k10sm130745wrm.74.2020.07.23.23.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 363761FF7E;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 00/16] candidate fixes for 5.1-rc1 (testing, semihosting,
 OOM tcg, x86 fpu)
Date: Fri, 24 Jul 2020 07:44:53 +0100
Message-Id: <20200724064509.331-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my candidate fixes for 5.1. Apart from
the revisions following reviews for v2:
  
  https://patchew.org/QEMU/20200722062902.24509-1-alex.bennee@linaro.org/

this includes a new version of Laurent's nanosleep fix and some
clean-ups to the python console drain code which should sort out some
of the 100% cpu spins Peter was seeing.

Other minor tweaks noted bellow -- in the patches themselves. The
following are still un-reviewed:

 - tests/docker: fix update command due to python3 str/bytes distinction
 - accel/tcg: better handle memory constrained systems
 - util/oslib-win32: add qemu_get_host_physmem implementation

Alex Bennée (8):
  shippable: add one more qemu to registry url
  util: add qemu_get_host_physmem utility function
  util/oslib-win32: add qemu_get_host_physmem implementation
  accel/tcg: better handle memory constrained systems
  linux-user: don't use MAP_FIXED in pgd_find_hole_fallback
  tests/docker: fix update command due to python3 str/bytes distinction
  tests/docker: fix binfmt_misc image building
  tests/docker: add support for DEB_KEYRING

KONRAD Frederic (2):
  semihosting: defer connect_chardevs a little more to use serialx
  semihosting: don't send the trailing '\0'

Laszlo Ersek (1):
  target/i386: floatx80: avoid compound literals in static initializers

Laurent Vivier (2):
  linux-user: fix clock_nanosleep()
  linux-user,ppc: fix clock_nanosleep() for linux-user-ppc

Robert Foley (3):
  python/qemu: Cleanup changes to ConsoleSocket
  python/qemu: Change ConsoleSocket to optionally drain socket.
  tests/vm: add shutdown timeout in basevm.py

 include/fpu/softfloat.h                       |   1 +
 include/qemu/osdep.h                          |  15 +
 accel/tcg/translate-all.c                     |   7 +-
 hw/semihosting/console.c                      |   4 +-
 linux-user/elfload.c                          |  10 +-
 linux-user/syscall.c                          |  15 +-
 softmmu/vl.c                                  |   5 +-
 target/i386/fpu_helper.c                      | 426 +++++++++---------
 util/oslib-posix.c                            |  15 +
 util/oslib-win32.c                            |  11 +
 .shippable.yml                                |   2 +-
 python/qemu/console_socket.py                 | 137 +++---
 python/qemu/machine.py                        |  14 +-
 python/qemu/pylintrc                          |   2 +-
 tests/docker/Makefile.include                 |   2 +-
 tests/docker/docker.py                        |  13 +-
 tests/docker/dockerfiles/debian-bootstrap.pre |   7 +
 tests/vm/basevm.py                            |  15 +-
 18 files changed, 390 insertions(+), 311 deletions(-)

-- 
2.20.1


