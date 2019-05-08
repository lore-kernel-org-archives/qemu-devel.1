Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB85AC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD8E214C6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD8E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOISJ-0003TE-St
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:01:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINk-0007UC-6k
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINi-0002vm-U0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOINh-0002nw-T1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90D7C806DF;
	Wed,  8 May 2019 08:56:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F086260C61;
	Wed,  8 May 2019 08:56:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AF4B011AAF; Wed,  8 May 2019 10:56:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 10:56:32 +0200
Message-Id: <20190508085645.11595-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 08 May 2019 08:56:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/13] tests/vm: serial console autoinstall,
 misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series changes the way virtual machines for test builds are
managed.  They are created locally on the developer machine now.  The
installer is booted on the serial console and the scripts walks through
the dialogs to install and configure the guest.

That takes the download.patchew.org server out of the loop and makes it
alot easier to tweak the guest images (adding build dependencies for
example).

The install scripts take care to apply host proxy settings (from *_proxy
environment variables) to the guest, so any package downloads will be
routed through the proxy and can be cached that way.  This also makes
them work behind strict firewalls.

There are also a bunch of smaller tweaks for tests/vm to fix issues I
was struggling with.  See commit messages of individual patches for
details.

Known issue:  NetBSD package install is not working for me right now.
It did work a while ago.  Not sure what is going on here.

Do we have accelerator support for the BSDs?  A "make check" for a full
build takes ages, and I suspect tcg being used is part of the problem.
I did my tests using "TARGET_LIST=x86_64-softmmu" because of that.

Gerd Hoffmann (13):
  scripts: use git archive in archive-source
  tests/vm: send proxy environment variables over ssh
  tests/vm: send locale environment variables over ssh
  tests/vm: use ssh with pty unconditionally
  tests/vm: run test builds on snapshot
  tests/vm: add vm-boot-{ssh,serial}-<guest> targets
  tests/vm: add DEBUG=1 to help text
  tests/vm: serial console support helpers
  tests/vm: openbsd autoinstall, using serial console
  tests/vm: freebsd autoinstall, using serial console
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: fedora autoinstall, using serial console
  tests/vm: ubuntu.i386: apt proxy setup

 tests/vm/basevm.py        | 125 ++++++++++++++++++++++---
 scripts/archive-source.sh |  72 +++++++--------
 tests/vm/Makefile.include |  25 ++++-
 tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          | 172 +++++++++++++++++++++++++++++++++--
 tests/vm/netbsd           | 178 ++++++++++++++++++++++++++++++++++--
 tests/vm/openbsd          | 150 +++++++++++++++++++++++++++---
 tests/vm/ubuntu.i386      |   4 +
 8 files changed, 830 insertions(+), 83 deletions(-)
 create mode 100755 tests/vm/fedora

-- 
2.18.1


