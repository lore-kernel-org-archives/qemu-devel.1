Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E545C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA120730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSccltEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCA120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqWl-00056o-GY
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVc-0003QP-QG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVb-0004KC-Lt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVb-0004JX-Fs
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id t203so2239758wmt.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ErBqsEg90J/rMI3zUeIrTPRPG0UcgfPkvLOHEBfuAjA=;
 b=WSccltEYHqOkVcmXduMu7OKxsoBtnVbSHcZFgq1vn6Pg9FRuoqZKsyKlMYZCp1H355
 QfBIfeftvr3m1AIm3tZkV3BWA7A3xy9DHV4NsreVcLxVSlTwc0bHbV0m/+3sAJ1gudd0
 3StuOktSoNrx9ZTe8t5yXJDJQnJ32DI2gpm418TPJ6pIG12pJ2SpU1go1u09muYqr0XY
 5TJdD2DZzjAFfc/pHxQ+JIse6Afc93yc5OVqB+ALTR8P4ccJUggihDxbiOsEStpXVbaD
 /46MSUHuMk/Uv5BzAUjKUAj3BjjUoXcvJSuA0eT4mXNKqpV6DluaN4oOYe7NTuvXp4eL
 dOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ErBqsEg90J/rMI3zUeIrTPRPG0UcgfPkvLOHEBfuAjA=;
 b=eKSwHPXslDnCD4TcfavpTskWYyAj/FOIfcmCpXw4gQA0TtxEfrf7RnLthEIgomsRFc
 LmVuqxm3+OPZmHySQXVObXXrS51BDoUjcMZN/H2ebO3sbxHZ931Da+hzp154lGS7Eb3S
 qsL4gaLdrUwbcCnXk62vlYy34AW6ZXiPla6IVqz690BsM24JX4iuh8skUpqd6KjtCw5i
 BRkB86TAzBKj+xsu7m5cHxZSi+nk9g3GL5TaznXxOZgKYFt/8wFdrD+3qgkYMmb0EOAc
 PYPGFc7edB9XbbmCKefqxuWImGbrO2gAp1cowwtjNFNu5CiF+cSRYyO/09ks41irFrtG
 tHfw==
X-Gm-Message-State: AGi0PuZfbaOfKHS+rKOFpIGX+gWocHtWIbdn2mjRCPS9bEUrakaqOe5U
 tonHivBaPc+ZgJmRqE//neXNIw==
X-Google-Smtp-Source: APiQypIHP5RY8sRN5fpQ5RsPBrAUyCRHss5lxfoXqGWIiyBmPrzTp5hQeeuSueJk5yKihSFeyNBw4A==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr3016808wml.138.1586274686414; 
 Tue, 07 Apr 2020 08:51:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p22sm2849589wmc.42.2020.04.07.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43C851FF7E;
 Tue,  7 Apr 2020 16:51:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL for 5.0-rc2 00/13] various fixes
Date: Tue,  7 Apr 2020 16:51:05 +0100
Message-Id: <20200407155118.20139-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-misc-fixes-070420-1

for you to fetch changes up to cce743abbf398a324879039cd582349b36da0ea6:

  tcg/i386: Fix %r12 guest_base initialization (2020-04-07 16:19:49 +0100)

----------------------------------------------------------------
Various fixes:

  - add .github repo lockdown config
  - better handle missing symbols in elf-ops
  - protect fcntl64 with #ifdef
  - remove unused macros from test
  - fix handling of /proc/self/maps
  - avoid BAD_SHIFT in x80 softfloat
  - properly terminate on .hex EOF
  - fix configure probe on windows cross build
  - fix %r12 guest_base initialization

----------------------------------------------------------------
Alex Bennée (8):
      elf-ops: bail out if we have no function symbols
      linux-user: protect fcntl64 with an #ifdef
      tests/tcg: remove extraneous pasting macros
      linux-user: more debug for init_guest_space
      target/xtensa: add FIXME for translation memory leak
      linux-user: factor out reading of /proc/self/maps
      linux-user: clean-up padding on /proc/self/maps
      hw/core: properly terminate loading .hex on EOF record

Denis Plotnikov (1):
      gdbstub: fix compiler complaining

Philippe Mathieu-Daudé (1):
      .github: Enable repo-lockdown bot to refuse GitHub pull requests

Richard Henderson (3):
      softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal
      configure: Add -Werror to PIE probe
      tcg/i386: Fix %r12 guest_base initialization

 configure                      |  4 +--
 include/hw/elf_ops.h           | 48 +++++++++++++------------
 include/qemu/selfmap.h         | 44 +++++++++++++++++++++++
 fpu/softfloat.c                |  3 ++
 gdbstub.c                      |  4 +--
 hw/core/loader.c               |  5 ++-
 linux-user/elfload.c           |  8 ++++-
 linux-user/syscall.c           | 80 ++++++++++++++++++++++--------------------
 target/xtensa/translate.c      |  5 +++
 tcg/i386/tcg-target.inc.c      |  2 +-
 util/selfmap.c                 | 78 ++++++++++++++++++++++++++++++++++++++++
 .github/lockdown.yml           | 34 ++++++++++++++++++
 MAINTAINERS                    |  1 +
 tests/tcg/x86_64/system/boot.S |  5 +--
 util/Makefile.objs             |  1 +
 15 files changed, 250 insertions(+), 72 deletions(-)
 create mode 100644 include/qemu/selfmap.h
 create mode 100644 util/selfmap.c
 create mode 100644 .github/lockdown.yml

-- 
2.20.1


