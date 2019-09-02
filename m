Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC14C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08439217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUct8k5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08439217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jYe-0000ow-OZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSh-0004dI-54
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSf-0004FI-U1
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSf-0004Es-Me
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id q19so5132290wmc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBLLvltDhED+jd/bHDb3y9MsQHiUdeO1F4Z0MYK9IEU=;
 b=DUct8k5TmT3mX1J4giqFg50y5PT53wGVs2oFheun7t/xI8+epshTMfl4pysClgqhLj
 eGbirDvSYiEIlHqkTD/lu9FdNg4pp+I+nA9gOJ8h1AMpiF2vP112YN228w5NHK/QANZ8
 B9oQKBq46Icq7sfkZNhEXHiDwbKBH2pi/QBziFOHMFU1OROm7N5Mr6EfuK64KIzdvwhy
 YdPYZy8KVn6lvMt9tVTY/kJIA0FUJNkkAHgSDUs2StNwcU3Vv64z1urefY8+Z1Pd9kIi
 WaP01x7GWcUds8Q7BDMSV+KFFUDAgckc3aQmtzjOVhfbbcz5ilz2gCSVospMV6WkswzS
 fMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBLLvltDhED+jd/bHDb3y9MsQHiUdeO1F4Z0MYK9IEU=;
 b=DVBStpcHgnh0yFCePHGLzyWwldWOZw6pdXQhd9ayl/2IxIi0rA0JgbFHFBw+/9uaTz
 oAMvqDAumNBY1ij5f/NmfDarU/B1X1eWfhWjVCNftloZuUbph8wCSUL+EYHJ43Gz0Jw5
 Uft6VG1MsylH6WJOkrdOrnFw+mBkGbG54qDnEM7xVK7Y1NerucU0L+rsMBuc7+fz8XsG
 +7Q1M9tnhLeHgyd17Dfd1mdGjioDO2LawyyEXe2ZNgAfCHOmX1gCqQrtFBa0J31Ujohi
 iEpcqHOgeXwTkVaXBikbWbJKux6FUAqV3VOrAH5VNPacsALQDnixU+zBAuXe9ejgSqer
 gj9w==
X-Gm-Message-State: APjAAAVsaoTfxiDOCIt+Es9cbTXoN68aIH9xLsKXxo5+fW+xuAMllhIf
 RmfJDOm1C/ErMceGmoEvk6KpOdnsAqM=
X-Google-Smtp-Source: APXvYqyFvLSyMyQKsj5CMMGTs+HNKI97sQN9dq7THEf4y82fOo/Huvw1pivo+1QRzYBrlkg8QR9fhQ==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr2186069wma.10.1567419683962; 
 Mon, 02 Sep 2019 03:21:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d78sm5952269wmd.47.2019.09.02.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C5DC1FF87;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:10 +0100
Message-Id: <20190902102122.1128-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 00/12] fixes for gdbstub, gitdm and testing
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

The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024f4:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' into staging (2019-08-27 15:52:36 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-gdbstub-gitdm-testing-020919-1

for you to fetch changes up to 4112aff7cdd932f273e920911a45a5d5a2d5d299:

  tests/docker: upgrade docker.py to python3 (2019-09-02 10:52:22 +0100)

----------------------------------------------------------------
Various maintainer updates

   - fixes for gdbstub regressions
   - bunch of gitdm/mailmap updates
   - module fixes for Travis
   - docker fixes for shippable

----------------------------------------------------------------
Alex Bennée (2):
      .mailmap/aliases: add some further commentary
      tests/docker: upgrade docker.py to python3

Marc-André Lureau (2):
      build-sys: build ui-spice-app as a module
      tests: fix modules-test with no default machine

Markus Armbruster (2):
      contrib/gitdm: filetype interface is not in order, fix
      contrib/gitdm: Add armbru@pond.sub.org to group-map-redhat

Philippe Mathieu-Daudé (4):
      mailmap: Reorder by sections
      mailmap: Update philmd email address
      mailmap: Add many entries to improve 'git shortlog' statistics
      contrib/gitdm: Add RT-RK to the domain-map

Ramiro Polla (1):
      gdbstub: Fix handling of '!' packet with new infra

Sandra Loosemore (1):
      gdbstub: Fix handler for 'F' packet

 .mailmap                            | 137 +++++++++++++++++++++++++++++++++---
 contrib/gitdm/aliases               |  20 +++++-
 contrib/gitdm/domain-map            |   1 +
 contrib/gitdm/filetypes.txt         |   2 +-
 contrib/gitdm/group-map-individuals |   3 +-
 contrib/gitdm/group-map-redhat      |   1 +
 gdbstub.c                           |  12 +++-
 tests/docker/docker.py              |  27 +++----
 tests/modules-test.c                |   7 +-
 ui/Makefile.objs                    |   4 +-
 10 files changed, 184 insertions(+), 30 deletions(-)

-- 
2.20.1


