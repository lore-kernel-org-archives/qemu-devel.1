Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A97C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC842054F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC842054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShk4-0003my-FR
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:50:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhi-0002Tz-3A
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhg-0006Dh-AG
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hShhf-0005vu-V8
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D9BA8763B;
	Mon, 20 May 2019 12:47:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC4E4145;
	Mon, 20 May 2019 12:47:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E780411AA3; Mon, 20 May 2019 14:47:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 14:47:02 +0200
Message-Id: <20190520124716.30472-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 20 May 2019 12:47:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console autoinstall,
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

v3:
 - python3 fixes.
 - openbsd: configure memory limits.
 - freebsd: configure autoboot delay.

Gerd Hoffmann (14):
  scripts: use git archive in archive-source
  tests/vm: python3 fixes
  tests/vm: send proxy environment variables over ssh
  tests/vm: use ssh with pty unconditionally
  tests/vm: run test builds on snapshot
  tests/vm: proper guest shutdown
  tests/vm: add vm-boot-{ssh,serial}-<guest> targets
  tests/vm: add DEBUG=3D1 to help text
  tests/vm: serial console support helpers
  tests/vm: openbsd autoinstall, using serial console
  tests/vm: freebsd autoinstall, using serial console
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: fedora autoinstall, using serial console
  tests/vm: ubuntu.i386: apt proxy setup

 tests/vm/basevm.py        | 144 ++++++++++++++++++++++++-----
 scripts/archive-source.sh |  72 +++++++--------
 tests/vm/Makefile.include |  25 ++++-
 tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          | 179 ++++++++++++++++++++++++++++++++++--
 tests/vm/netbsd           | 187 ++++++++++++++++++++++++++++++++++++--
 tests/vm/openbsd          | 158 +++++++++++++++++++++++++++++---
 tests/vm/ubuntu.i386      |   4 +
 8 files changed, 858 insertions(+), 98 deletions(-)
 create mode 100755 tests/vm/fedora

--=20
2.18.1


