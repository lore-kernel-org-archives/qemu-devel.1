Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE3C31E53
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85326205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85326205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcjVy-0006ql-Pp
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:45:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hcjQE-0001Oz-FJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hcjQC-0005rc-3t
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hcjQB-0005oZ-Dd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15066C00732A;
 Mon, 17 Jun 2019 04:39:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C01DD2CFD6;
 Mon, 17 Jun 2019 04:38:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA8EF16E08; Mon, 17 Jun 2019 06:38:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 06:38:47 +0200
Message-Id: <20190617043858.8290-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 17 Jun 2019 04:39:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 00/11] tests/vm: serial console autoinstall,
 misc fixes.
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

v4:
 - rebase, drop patches merged.
 - use in-tree seabios binary, for serial console support.
 - some minor tweaks.
v3:
 - python3 fixes.
 - openbsd: configure memory limits.
 - freebsd: configure autoboot delay.

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

 tests/vm/basevm.py        | 135 +++++++++++++++++++++++----
 tests/vm/Makefile.include |  23 ++++-
 tests/vm/fedora           | 189 ++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          | 180 ++++++++++++++++++++++++++++++++++--
 tests/vm/netbsd           | 187 +++++++++++++++++++++++++++++++++++--
 tests/vm/openbsd          | 159 +++++++++++++++++++++++++++++---
 tests/vm/ubuntu.i386      |   4 +
 7 files changed, 825 insertions(+), 52 deletions(-)
 create mode 100755 tests/vm/fedora

--=20
2.18.1


