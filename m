Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95FC2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BB420772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtOVOPBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BB420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZzc-0005op-6N
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyf-0004BI-Ah
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyd-00028o-TC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyd-00027m-JC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id w10so29836201wrm.4
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YOymoiYKg8zfvksmzTC/HgGcGdDABmXsN+Kp7tifL6w=;
 b=FtOVOPBLifclokzug9eZWlA7I8vUXEu0GO/6wq1Wkzsj0LnB0LkXklXipGXvYHGigB
 bgtFtpOH6nzPogVGPniygEBhqLE1jacUMLARDf+0LgNHbDvYRiZ4eOhNVpn6j1KkBcPw
 VU0rIzN4oyHqbXFAhm9uWFxTrMTMQGzkgl7BzlkghK4OsidcZImE3LOgp4oaoXi0zaWP
 LxNv1GCajZJjvRhBlt53VbiI90TUmI9o7r3CCVrMZHf8ws24yBaJt5UZY7gePGxIajR2
 K5ilSJQFuTtpaNSAS4sP9dh+YP0jZBsdnoMajD2esUkBjUsJUHTiJtOvWMVw3CR5cN0+
 CSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YOymoiYKg8zfvksmzTC/HgGcGdDABmXsN+Kp7tifL6w=;
 b=eMrfa45DTktEn85bzbHsSzb14RT1mRSLJtYvQJt4M05+59zc3yZmT63da0RA0kqKyA
 kIOCG2LyRQ3zmgTEGCoetIdTo2VTU82JRDoDuHL62NH4LZdyMwSDfwTbv7MXd6fVTLij
 vJCsHMOHuMbuTTgN5hvUUiRSyI5ANTCjMN39iSl0+KpLqMYKbqLCw48pMEWfeYX+T16y
 I1gkPgclCBHXTK40KD6wpBZaR87qmbgSBA9xdLFj9wMEESXXcA/4PDWkNxDLrZea2T24
 /FtJZbYMiYJG4Io55dDx/pBgWg+zFsso4brP0yKqDKNYRgO4KEeOhvVfcL25TZiMLW0X
 7CYw==
X-Gm-Message-State: ANhLgQ1bwuo4waiq3/epuHQyTA23x615oICTysXyJ8E1m+qASnvtPg33
 BejOASCgQ5pcjn1yvndQgGhX0A==
X-Google-Smtp-Source: ADFU+vszlWhIczifDKlQDKLfNkPIWMtIjl13zaA9Adw0lgIsc6YA1D8e+cAzjFlIBQKW6H8t7YDooQ==
X-Received: by 2002:adf:e942:: with SMTP id m2mr24772950wrn.364.1585734481991; 
 Wed, 01 Apr 2020 02:48:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z129sm1973940wmb.7.2020.04.01.02.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1FC61FF7E;
 Wed,  1 Apr 2020 10:47:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.0 v2 00/10] A selection of sanitiser fixes
Date: Wed,  1 Apr 2020 10:47:49 +0100
Message-Id: <20200401094759.5835-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Here is version 2 of my random fixes series. I've swapped out my fix
to softfloat for Richard's better targeted fix. I also did a re-factor
to init_guest_space so we can use the sanitizer builds on more of the
guests. Initial testing is showing up a few more issues but I didn't
want to hold up review of the changes to date so I can put them in a
PR this week.

The following need review:

 - linux-user: completely re-write init_guest_space
 - linux-user: clean-up padding on /proc/self/maps
 - linux-user: factor out reading of /proc/self/maps
 - target/xtensa: add FIXME for translation memory leak

Alex Bennée (8):
  elf-ops: bail out if we have no function symbols
  linux-user: protect fcntl64 with an #ifdef
  tests/tcg: remove extraneous pasting macros
  linux-user: more debug for init_guest_space
  target/xtensa: add FIXME for translation memory leak
  linux-user: factor out reading of /proc/self/maps
  linux-user: clean-up padding on /proc/self/maps
  linux-user: completely re-write init_guest_space

Denis Plotnikov (1):
  gdbstub: fix compiler complaining

Richard Henderson (1):
  softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal

 include/hw/elf_ops.h           |   7 +-
 include/qemu/selfmap.h         |  44 ++++++
 fpu/softfloat.c                |   3 +
 gdbstub.c                      |   4 +-
 linux-user/elfload.c           | 273 +++++++++++++++------------------
 linux-user/syscall.c           |  80 +++++-----
 target/xtensa/translate.c      |   5 +
 util/selfmap.c                 |  74 +++++++++
 tests/tcg/x86_64/system/boot.S |   5 +-
 util/Makefile.objs             |   1 +
 10 files changed, 303 insertions(+), 193 deletions(-)
 create mode 100644 include/qemu/selfmap.h
 create mode 100644 util/selfmap.c

-- 
2.20.1


