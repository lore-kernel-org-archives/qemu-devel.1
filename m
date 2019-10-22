Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4D82184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeAR6izD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4D82184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzjV-00086M-Gj
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeh-0002QO-B8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005Kc-1o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzec-0005Bh-3g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so17248492wmi.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5n/Del3i3mT5eJ43EABNcCzBNbRxcjW2MNK6RlSEeSg=;
 b=GeAR6izDQLxCQOSpdD9GmUzDSF+M0AYCQh03uT0bDoAhGghHxgDwzKzOxGl1a6PlDY
 Dt+KSaIqmHJKCTIhTdCXZ4SRFGcyn9TsTSLpdwTM5vMZ2iQTDx9oMYr45XItjVK6fJSq
 mb2ckrvEXps0Byer7Pkb0UyFrH8O4dGv8uFbHN8FZtbXxR3Z/Z6Wnimh4NAgDwbhHAfY
 VdM+Z9/EPJCGIlFmZ92CUQIqgs+DyfYFCmVsE0eNhz1rI3FAzNhUJ5+Uf3BafR7J1FGt
 mvu+W4B3ho8kZ412BRQYPb2dBfY8G7dgQpFFPvgjQ7v9eeCTU5bLh2FDlAwCKNxGRtKy
 Hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5n/Del3i3mT5eJ43EABNcCzBNbRxcjW2MNK6RlSEeSg=;
 b=ulH7KIq7JraveIXN5iGnzcbnLrc1UysRR1qOp++Azjrw93NkI9Qu27H12VpBSaGDnq
 ibvb8BGi+HwrfKcWjYmPP7Ud4aCk5ZfvtSEn+TA01WErlFvcPorYK08E5K7U8VXlMWdX
 R/8hU1GriEHC/JbkMbzWbJuAnxyiwFgw2u/KV07HbT1TbgTltnEY2NPOeRJ/JG/ERl81
 bZRysw206utw8AdvQoxsiBHQ8sOfaP1u7X5dAS+09bSuXt2XIqzEP47UcgPODmXR78dq
 cR8d6qKdAVqxUikFZbFk3CcogDRE71hujRIafnUswCw5x9emwf8nu/p97jSOb+dkwX63
 OtQQ==
X-Gm-Message-State: APjAAAXHAOA7BpTYTYp20EPkYQYLRkt/v0qV7hJ6Zhevxq7jY/nIxa7P
 9GnycZwCfCLBM+znhV2qe0tOCQ==
X-Google-Smtp-Source: APXvYqxN+loYZvY3OCA07ZyW9dyxEkPTRcPkjEv+ncwGbPxi/uOzBA2qcv/DrkWFGIT0kS7z1D/Rwg==
X-Received: by 2002:a1c:9990:: with SMTP id b138mr4539141wme.176.1571771826616; 
 Tue, 22 Oct 2019 12:17:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm31834778wro.36.2019.10.22.12.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A80B1FF87;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 00/19] testing/next before softfreeze
Date: Tue, 22 Oct 2019 20:16:45 +0100
Message-Id: <20191022191704.6134-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current status of testing/next. I dropped the Travis arm64
build due to stability concerns. As far as I can tell Thomas' latest
iotest updates are working fine. If there are any other patches worth
considering before the softfreeze now is the time to shout.

Alex Bennée (5):
  travis.yml: reduce scope of the --enable-debug build
  cirrus.yml: reduce scope of MacOS build
  travis.yml: bump Xcode 10 to latest dot release
  cirrus.yml: add latest Xcode build target
  travis.yml: cache the clang sanitizer build

Eduardo Habkost (2):
  tests/vm: Let subclasses disable IPv6
  tests/vm/netbsd: Disable IPv6

Gerd Hoffmann (1):
  tests/vm: netbsd autoinstall, using serial console

John Snow (1):
  iotests: remove 'linux' from default supported platforms

Philippe Mathieu-Daudé (1):
  travis.yml: Test the release tarball

Thomas Huth (9):
  travis.yml: Add libvdeplug-dev to compile-test net/vde.c
  travis.yml: Use libsdl2 instead of libsdl1.2, and install
    libsdl2-image
  travis.yml: Use newer version of libgnutls and libpng
  travis.yml: Fix the ccache lines
  iotests: Test 041 only works on certain systems
  iotests: Test 183 does not work on macOS and OpenBSD
  iotests: Skip "make check-block" if QEMU does not support virtio-blk
  iotests: Enable more tests in the 'auto' group to improve test
    coverage
  iotests: Remove 130 from the "auto" group

 .cirrus.yml                   |  14 ++-
 .travis.yml                   |  46 ++++++--
 tests/check-block.sh          |  16 ++-
 tests/qemu-iotests/041        |   3 +-
 tests/qemu-iotests/183        |   1 +
 tests/qemu-iotests/group      |  18 ++--
 tests/qemu-iotests/iotests.py |  16 ++-
 tests/vm/basevm.py            |  15 ++-
 tests/vm/netbsd               | 195 ++++++++++++++++++++++++++++++++--
 9 files changed, 285 insertions(+), 39 deletions(-)

-- 
2.20.1


