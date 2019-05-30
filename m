Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3BC28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C264256ED
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fucstIkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C264256ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWI8n-0003sH-JH
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:18:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6S-0002Xe-TT
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6R-0006Qy-Mn
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6R-0006Pt-GP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id f10so3599049wmb.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qQVT5XursvXqJ6jlV6iBVIi+y/aPi9jAtcAQjVjmzpI=;
	b=fucstIkOo6/s/tUoiZq0GGcaPr748jDMTwsJG/A3K3pj7dq8i/KAk74tt+AqWOspTz
	vPpT2Sezv6n8gcoxRldB6lsqI1DNH18cfjV9rX6sxvXa+QBVEqrNiGOSfAhtqejjvwla
	X4cx06SE9h33X2NoWEJLMBwG1l6XLjTQXSFxSB0pojUeX66yw4UlKw+BSlxPMtLzxQzH
	m3x54vVRhlzRhyoH5OmBqEGsWb82GYw8yai/21OiVorqBc+gjWVskPQdCDajG2nhk4Lu
	2OpBwSNIPg5gioXyPhdkDiihz0bMByBnwx4ACNNvbs6hs2JI+1m0oBESvTy7sZ1d5YGh
	3Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qQVT5XursvXqJ6jlV6iBVIi+y/aPi9jAtcAQjVjmzpI=;
	b=iRRFgp/d6GE8dfqpBXcoMKxfEh6Sr1CofJVrSaMSQ3B4zQN8JVcMpWTT4YbbRup1oo
	m2LbkkhHbF6jFl1bj9r4gyHygmqRrnzZ+BrEhMD9ORZuszcquaUAft2C3kUVSLl39yvl
	UdD2mN8tuz/QDxtKJIA5ZuTUvm4hAxhUjyCh+5JHkQnBQA7wq2wNFN6fMxCQ4BpjgjzA
	PzAVWoJCSfbCc/Tx9P5tnNeKd0VDhInAprfrIxKaGLnVniLTJ9H/KbxndyqeWlhSBiKO
	HHB9mN+y14cNxOX8BEWmqrn99Uen48FgtKHkU5Mpi43GV/tTgbruSKJfMtTFJVAB+zfL
	Vn8A==
X-Gm-Message-State: APjAAAVsIUHDkEo6Kh4uRfhaT4s3cXpD7vryTZqQh11vm0tx/NxcqPJf
	Dfjrg7nQA3PTukXES7UIUVh2aw==
X-Google-Smtp-Source: APXvYqxaYqKDBe3E/IOGqtJIV0e26mGZNNRITSJIT6x1Et6fvBngr2RhpGRiXv1xX5aMAcLoXHItoQ==
X-Received: by 2002:a1c:d10e:: with SMTP id i14mr1852584wmg.161.1559211365630; 
	Thu, 30 May 2019 03:16:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id r9sm2338180wrq.0.2019.05.30.03.16.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:04 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 097FD1FF87;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:37 +0100
Message-Id: <20190530101603.22254-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 00/26] testing/next queue (iotests, docker,
 tests/vm)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

I've been playing catch-up with the testing patches so here is the
next set of patches for testing/next. It includes the enabling of
check-block which I dropped from my last PR due to a last minute div0
found by Peter during merging. I've added a clang undefined
behaviour job to Travis to catch this in future as well as bumped the
GCC TSan build to gcc-9. This still has stringop truncation turned
off as we still have build failures. I've updated the Ubuntu image to
the latest ubuntu for those that want to build with the latest
compilers to fix all this.

The bulk of the series includes Wainer's tests/vm clean-ups and Gerd's
work on autoinstall for the BSD's so we no longer have to rely on
magic images stored in our "infrastructure". I did drop the
caching/checksum patch as it clashed with the new approach Gerd has
taken.

I've not got Philippe's work on enabling caching to speed up Travis
but I'm looking forward to it because it looks like it makes a fair
difference.

The following patches need review
 patch 0001/editorconfig add setting for shell scripts.patch
 patch 0002/qemu io cmds use clock_gettime for benchmarking.patch
 patch 0005/tests docker Update the Fedora cross compile imag.patch
 patch 0006/tests docker Update the Ubuntu image to 19.04.patch
 patch 0007/.travis.yml bump gcc sanitiser job to gcc 9.patch
 patch 0008/.travis.yml add clang ubsan job.patch

Alex Bennée (6):
  editorconfig: add setting for shell scripts
  qemu-io-cmds: use clock_gettime for benchmarking
  tests/docker: Update the Fedora cross compile images to 30
  tests/docker: Update the Ubuntu image to 19.04
  .travis.yml: bump gcc sanitiser job to gcc-9
  .travis.yml: add clang ubsan job

Gerd Hoffmann (14):
  scripts: use git archive in archive-source
  tests/vm: python3 fixes
  tests/vm: send proxy environment variables over ssh
  tests/vm: use ssh with pty unconditionally
  tests/vm: run test builds on snapshot
  tests/vm: proper guest shutdown
  tests/vm: add vm-boot-{ssh,serial}-<guest> targets
  tests/vm: add DEBUG=1 to help text
  tests/vm: serial console support helpers
  tests/vm: openbsd autoinstall, using serial console
  tests/vm: freebsd autoinstall, using serial console
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: fedora autoinstall, using serial console
  tests/vm: ubuntu.i386: apt proxy setup

Philippe Mathieu-Daudé (1):
  tests/docker: Update the Fedora image to Fedora 30

Thomas Huth (1):
  tests: Run the iotests during "make check" again

Wainer dos Santos Moschetta (4):
  tests/vm: Use python configured on build
  tests/vm: Port basevm to Python 3
  tests/vm: Fix build-centos docker-based tests run
  tests/vm: Add missing variables on help

 .editorconfig                                 |   4 +
 .travis.yml                                   |  17 +-
 qemu-io-cmds.c                                |  69 +++----
 scripts/archive-source.sh                     |  72 +++----
 tests/Makefile.include                        |   8 +-
 tests/check-block.sh                          |  44 ++++-
 .../dockerfiles/fedora-cris-cross.docker      |   2 +-
 .../dockerfiles/fedora-i386-cross.docker      |   2 +-
 tests/docker/dockerfiles/fedora.docker        |   2 +-
 tests/docker/dockerfiles/ubuntu.docker        |  19 +-
 tests/qemu-iotests-quick.sh                   |   8 -
 tests/vm/Makefile.include                     |  37 +++-
 tests/vm/basevm.py                            | 147 +++++++++++---
 tests/vm/centos                               |   6 +-
 tests/vm/fedora                               | 187 ++++++++++++++++++
 tests/vm/freebsd                              | 179 ++++++++++++++++-
 tests/vm/netbsd                               | 187 +++++++++++++++++-
 tests/vm/openbsd                              | 158 +++++++++++++--
 tests/vm/ubuntu.i386                          |   4 +
 19 files changed, 977 insertions(+), 175 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh
 create mode 100755 tests/vm/fedora

-- 
2.20.1


