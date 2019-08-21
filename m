Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB53C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB53C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uap-000564-8o
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPL-0006IS-Cm
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPK-00051H-1M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPJ-00050e-SL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEFAB191C68A
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:24 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3481560F88
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:08 +0200
Message-Id: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 21 Aug 2019 17:28:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/13] Misc patches for 2019-08-21
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

The following changes since commit e65472c7bc413d79faa61eb1d05c540b039458=
94:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20190821=
' into staging (2019-08-21 14:04:17 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 78d01598aea85841f0e4f8baf62c42b76230a81c:

  char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout() (=
2019-08-21 16:31:59 +0200)

----------------------------------------------------------------
* Longstanding chardev race condition fix (Berto)
* Cleanups and tests from the Meson POC (Marc-Andr=C3=A9, myself)
* Coalesced range cleanup (Peter)

----------------------------------------------------------------
Alberto Garcia (2):
      main-loop: Fix GSource leak in qio_task_thread_worker()
      char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout=
()

Marc-Andr=C3=A9 Lureau (5):
      module: use g_hash_table_add()
      module: return success on module load
      tests: add module loading test
      configure: remove AUTOCONF_HOST
      minikconf: don't print CONFIG_FOO=3Dn lines

Paolo Bonzini (2):
      qemu-ga: clean up TOOLS variable
      configure: define CONFIG_TOOLS here

Peter Xu (4):
      memory: Refactor memory_region_clear_coalescing
      memory: Split zones when do coalesced_io_del()
      memory: Remove has_coalesced_range counter
      memory: Fix up memory_region_{add|del}_coalescing

 Makefile               |  9 ++---
 chardev/char-socket.c  | 16 ++++++--
 configure              | 10 ++---
 include/qemu/module.h  |  2 +-
 io/task.c              |  1 +
 memory.c               | 99 ++++++++++++++++++++++++++------------------=
------
 qtest.c                |  9 +++++
 scripts/minikconf.py   |  4 +-
 tests/Makefile.include |  1 +
 tests/libqtest.c       |  6 +++
 tests/libqtest.h       |  2 +
 tests/modules-test.c   | 71 ++++++++++++++++++++++++++++++++++++
 util/module.c          | 17 ++++++---
 13 files changed, 178 insertions(+), 69 deletions(-)
 create mode 100644 tests/modules-test.c
--=20
1.8.3.1


