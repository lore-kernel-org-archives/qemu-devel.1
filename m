Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0EC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983CC214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIcWnkm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983CC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgTZ-0007p4-M4
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRV-0005ys-BW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRU-0008Ra-7E
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRT-0008Qi-Tc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id r16so459032wrl.11
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEp1SSgo0ytv7hyYNYxrIJVJbY4Oc223+ftTbWURO6A=;
 b=oIcWnkm+q+s6YPzVqYrZX6hrw0I0YRq+p3oMLJO3AtzKI8JviQdm32mM52GXIp44TT
 hXlmpelyOZ90zG/pBTFsMCkLXihAkY5RR9igT9bc7ab6VhdhIHdlOOaDhb0hyZsOuxVP
 e5CjpJuM+cu/PaZkCpKjP52bMqeeMxIty58/7w+ZSIcevVjxdVCm+2ialAlqWEQMQxdc
 Y8zXYsu8hAeI0/iF3g1sb6nvGeX+IGOxC2hdlopG/pL0aL2zyOXK1WE3olIQBun6g0GV
 CFeCCt5tg3WuIahiRwSrufURUkSo6ReSNMdICxmwP1ZwybES9DxiCDlYYINqtOZ+BAgM
 HH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEp1SSgo0ytv7hyYNYxrIJVJbY4Oc223+ftTbWURO6A=;
 b=lPGWoKXPI2axoATjpeYk4auToQh0x7fpX8Xa0MWa8sOqEZFR92d01gFSqdTX2rh/Gq
 82Dv23NYOO8Zn9vKE2mUkDIoHOrFHTYTj3zefLkpx/K7GY5QXdBz3o4tfUc9tFFynltq
 vl68574N5nkmtYYelfHDbwcpbZi5e89faqDsxFRKp0SlnKmAOivKXhNxQ0IKpJsUrcbM
 JslrAkcAw0owjajDlWEKDGb6pUGLZnTTfFl0YRogAeuxe8zQ9lxVwzGjs1UbOEQQRfV5
 klrGf/iDkBlRwvkLFZIgZl3Q6vgYmTDe1KdBp7Y8dMXrcXRDZc9Fj5R69gc+44aoI1cW
 0ulA==
X-Gm-Message-State: APjAAAXY9JiUZ8i+rgv/x9usLd3KY8J+Ij0kw4gZXhcmoPAUjDNV4OVf
 gTo/dGL7c0ikEH1bPNsggUCZxw==
X-Google-Smtp-Source: APXvYqwE1wkztCLBnYZcX+WsX8/fM8dU4394tp1sN5p+aLoo1Upgn/cuVhy0mPokMz6JltzdNLdhbw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr70983275wrm.68.1560973222513; 
 Wed, 19 Jun 2019 12:40:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h23sm1592640wmb.46.2019.06.19.12.40.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74D291FF87;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:04 +0100
Message-Id: <20190619194021.8240-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PATCH  v1 00/17] testing/next (Travis fixes,
 more tests/vm)
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

This is the current state of testing/next which has fixes for the
MacOS Travis failures. We also have the return of the bsd-over-serial
autosetup patches which I've tested on the previously failing
platform. The one thing I've not included is adding check-block to the
default set of check tests. The blocker for that is it still bails on
some iotests when the source tree filesystem (e.g. ZFS) doesn't
support features it needs for some tests. It seems that they should
skip a bit more gracefully:

  Not run: 045 059 064 070 075 077 078 081 084 088 092 094 101 106 113 116 119 123 128 131 146 148 160 162 171 175 211 212 213 221 225 231 233 237 239 241 253
  Some cases not run in: 139
  Failures: 102 243 250
  Failed 3 of 138 tests

I'll try and send the PR for this out by the end of the week.

The following patches need review
 patch 0014/tests vm fedora autoinstall using serial console.patch
 patch 0016/.travis.yml default the disable system build to s.patch
 patch 0017/.travis.yml force a brew update for MacOS builds.patch

Alex Bennée (2):
  .travis.yml: default the --disable-system build to --static
  .travis.yml: force a brew update for MacOS builds

Cleber Rosa (4):
  tests/vm: avoid extra compressed image copy
  tests/vm: avoid image presence check and removal
  tests/vm: pin ubuntu.i386 image
  tests/vm: add source repos on ubuntu.i386

Gerd Hoffmann (11):
  tests/vm: send proxy environment variables over ssh
  tests/vm: use ssh with pty unconditionally
  tests/vm: run test builds on snapshot
  tests/vm: proper guest shutdown
  tests/vm: add vm-boot-{ssh,serial}-<guest> targets
  tests/vm: serial console support helpers
  tests/vm: openbsd autoinstall, using serial console
  tests/vm: freebsd autoinstall, using serial console
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: fedora autoinstall, using serial console
  tests/vm: ubuntu.i386: apt proxy setup

 .travis.yml               |   3 +-
 tests/vm/Makefile.include |  23 ++++-
 tests/vm/basevm.py        | 135 +++++++++++++++++++++++----
 tests/vm/centos           |   6 +-
 tests/vm/fedora           | 189 ++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          | 180 ++++++++++++++++++++++++++++++++++--
 tests/vm/netbsd           | 187 +++++++++++++++++++++++++++++++++++--
 tests/vm/openbsd          | 159 +++++++++++++++++++++++++++++---
 tests/vm/ubuntu.i386      |  11 ++-
 9 files changed, 833 insertions(+), 60 deletions(-)
 create mode 100755 tests/vm/fedora

-- 
2.20.1


