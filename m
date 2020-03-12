Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD39FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7855C20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Koxv45o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7855C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMHA-00055d-KZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG6-0003RJ-Ra
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG5-0001zD-5X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG4-0001y9-UJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l18so6980991wru.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ktwBlGPnJjETlEEbOT+skykkPPBSlbE51IVXCS/jbrw=;
 b=Koxv45o3VmRxkxi4aHsc/d12o0BjiuCjIHQOT88cGFJ8GMkFlrl2WTSpPcGdTBDbhE
 ydqcaLT7WhjYD6HIqERgzbI0Al9c47yjHD4snUfVcI6xTmYq3OLl+uU51JeDR6kkgJ4W
 pfpzBclSHZz/XvF8hDRjXUxms+yz7DVKubwjPXY5NjwxyLFtUAPV6nKuhZmxZWDSfsqE
 AkU3/bH+T7xK5F6pcpio5WlWNgBsSieEC6g93EId6Lvw8fawMKJJzoboWW7mwWemnPuC
 lyXbzuEztIhWMjCTMlpkaLhg8FxD/+wu7vPk8RXd7z0SztgimDxe7crnAX4WL08Ea+mQ
 qLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ktwBlGPnJjETlEEbOT+skykkPPBSlbE51IVXCS/jbrw=;
 b=SjEtAuGeQKpBzuylJU5j9Hjml/sOZC0ZWZoC6okX4CYfcLaIjd3ceDOcPu14oOuDYN
 Dg7hoDkO72vwS+cRtuXZbEFzGF0i9Fgag5DdIp4cNEmstAUpuBYGLcXb2MV003Y+n7JS
 NRyhC9hC7NBo1Ecx5afYG9LT7Eb4k+s4e1qAJovHnpWyRS5PAbIiWeDzIeHNIV6fgfgv
 VgCCgiZPqSYA4+epxoSKJYhtiOdABWXgXHZZVrVIl0qo7/oWPYVCLrbbvzjX8s1rHKg4
 I5OjTDTBziwhNuzUwm8Fomf36fAGcW5zieKUfNYIWs4nYBMMluXuLPezL0wCEdHPz0QX
 u2JQ==
X-Gm-Message-State: ANhLgQ1NL2IX2pldAOS+DJDEmqN3KNyy3IPuxItgapDCnHrGLfUXUxe9
 xAhntsGqCwJj4s/HWm7T4zCnEREGBohgBA==
X-Google-Smtp-Source: ADFU+vvIZCsIJ6VvuKKX4/3PdoG4dLQ3AkQ0Y41hXs7nTjJhu8pGbQPNaZrCu4z60Be1oMXEC3Vd3w==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr11080625wrv.164.1584013451359; 
 Thu, 12 Mar 2020 04:44:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] docs queue
Date: Thu, 12 Mar 2020 11:43:56 +0000
Message-Id: <20200312114408.16891-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some documentation-related updates now that the main
qemu-doc conversion is in master. Includes the splitting
out of arm-specific info into subpages.

thanks
-- PMM

The following changes since commit 5931ed5641ca6c4a237e82e4e5d2a08639865ce7:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-03-11' into staging (2020-03-11 17:06:40 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200312

for you to fetch changes up to 6fe6d6c9a953901251e1a85088f0a61ff5caf648:

  docs: Be consistent about capitalization of 'Arm' (2020-03-12 11:20:20 +0000)

----------------------------------------------------------------
docs queue:
 * Remove some no longer needed texinfo infrastructure
 * Reorder the top level index docs to put most useful manuals first
 * Split the Arm target-specific info into sub-pages
 * Improve the Arm documentation a bit with info previously
   only on the wiki page

----------------------------------------------------------------
Peter Maydell (12):
      Makefile: Remove redundant Texinfo related code
      Update comments in .hx files that mention Texinfo
      hxtool: Remove Texinfo generation support
      docs/sphinx/hxtool.py: Remove STEXI/ETEXI support
      Makefile: Make all Sphinx documentation depend on the extensions
      docs/index.rst, docs/index.html.in: Reorder manuals
      docs/qemu-option-trace.rst.inc: Remove redundant comment
      Makefile: Allow for subdirectories in Sphinx manual dependencies
      docs/system: Split target-arm.rst into sub-documents
      docs/system/target-arm.rst: Add some introductory text
      docs: Move arm-cpu-features.rst into the system manual
      docs: Be consistent about capitalization of 'Arm'

 docs/can.txt                                       |   2 +-
 docs/devel/atomics.txt                             |   2 +-
 docs/devel/multi-thread-tcg.txt                    |   8 +-
 docs/replay.txt                                    |   2 +-
 docs/specs/fw_cfg.txt                              |   2 +-
 Makefile                                           |  16 +-
 MAINTAINERS                                        |   9 +
 docs/devel/kconfig.rst                             |   2 +-
 docs/devel/loads-stores.rst                        |   2 +-
 docs/devel/tcg.rst                                 |   2 +-
 docs/index.html.in                                 |  10 +-
 docs/index.rst                                     |   8 +-
 docs/qemu-option-trace.rst.inc                     |   4 -
 docs/specs/tpm.rst                                 |   6 +-
 docs/sphinx/hxtool.py                              |  28 +-
 .../arm/cpu-features.rst}                          |  12 +-
 docs/system/arm/integratorcp.rst                   |  16 ++
 docs/system/arm/musicpal.rst                       |  19 ++
 docs/system/arm/nseries.rst                        |  33 +++
 docs/system/arm/palm.rst                           |  23 ++
 docs/system/arm/realview.rst                       |  34 +++
 docs/system/arm/stellaris.rst                      |  26 ++
 docs/system/arm/sx1.rst                            |  18 ++
 docs/system/arm/versatile.rst                      |  29 ++
 docs/system/arm/xscale.rst                         |  29 ++
 docs/system/target-arm.rst                         | 295 ++++++---------------
 docs/user/main.rst                                 |   8 +-
 hmp-commands-info.hx                               |   8 +-
 hmp-commands.hx                                    |   8 +-
 qemu-options.hx                                    |   8 +-
 scripts/hxtool                                     |  78 +-----
 31 files changed, 369 insertions(+), 378 deletions(-)
 rename docs/{arm-cpu-features.rst => system/arm/cpu-features.rst} (98%)
 create mode 100644 docs/system/arm/integratorcp.rst
 create mode 100644 docs/system/arm/musicpal.rst
 create mode 100644 docs/system/arm/nseries.rst
 create mode 100644 docs/system/arm/palm.rst
 create mode 100644 docs/system/arm/realview.rst
 create mode 100644 docs/system/arm/stellaris.rst
 create mode 100644 docs/system/arm/sx1.rst
 create mode 100644 docs/system/arm/versatile.rst
 create mode 100644 docs/system/arm/xscale.rst

