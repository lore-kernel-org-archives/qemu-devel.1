Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C16C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5F321849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoStk-0003MI-6b
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hoStX-0002wc-Cs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hoStW-0007uQ-8B
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:25:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hoStW-0007tg-0l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E3BA308FE8F
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 13:25:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-48.ams2.redhat.com
 [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59F4A5D704;
 Fri, 19 Jul 2019 13:25:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:25:44 +0100
Message-Id: <20190719132549.14726-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 13:25:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] Misc next patches
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 0274f45bdef73283f2c213610f11d4e5dcba43=
b6:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-07-19 09:44:43 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to b7cbb8741b40b7cd4de9ad6bdb69baae4d6dadcf:

  crypto: Fix LGPL information in the file headers (2019-07-19 14:21:25 +=
0100)

----------------------------------------------------------------

 * Fixes crypto function signatures to be compatible with
   both old and new versions of nettle
 * Fixes deprecation warnings on new nettle
 * Fixes GPL license header typos
 * Documents security implications of monitor usage
 * Optimize linking of capstone to avoid it in tools

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  crypto: switch to modern nettle AES APIs
  crypto: fix function signatures for nettle 2.7 vs 3
  configure: only link capstone to emulation targets
  doc: document that the monitor console is a privileged control
    interface

Thomas Huth (1):
  crypto: Fix LGPL information in the file headers

 Makefile.target               |   1 +
 configure                     |   6 +-
 crypto/block-luks.c           |   2 +-
 crypto/block-luks.h           |   2 +-
 crypto/block-qcow.c           |   2 +-
 crypto/block-qcow.h           |   2 +-
 crypto/block.c                |   2 +-
 crypto/blockpriv.h            |   2 +-
 crypto/cipher-builtin.c       |   2 +-
 crypto/cipher-gcrypt.c        |   2 +-
 crypto/cipher-nettle.c        | 220 ++++++++++++++++++++++++++++------
 crypto/cipher.c               |   2 +-
 crypto/hash-gcrypt.c          |   2 +-
 crypto/hash-glib.c            |   2 +-
 crypto/hash-nettle.c          |  14 ++-
 crypto/hash.c                 |   2 +-
 crypto/hmac-nettle.c          |  17 ++-
 crypto/init.c                 |   2 +-
 crypto/ivgen-essiv.c          |   2 +-
 crypto/ivgen-essiv.h          |   2 +-
 crypto/ivgen-plain.c          |   2 +-
 crypto/ivgen-plain.h          |   2 +-
 crypto/ivgen-plain64.c        |   2 +-
 crypto/ivgen-plain64.h        |   2 +-
 crypto/ivgen.c                |   2 +-
 crypto/ivgenpriv.h            |   2 +-
 crypto/pbkdf-gcrypt.c         |   2 +-
 crypto/pbkdf-nettle.c         |   2 +-
 crypto/pbkdf-stub.c           |   2 +-
 crypto/pbkdf.c                |   2 +-
 crypto/random-gcrypt.c        |   2 +-
 crypto/random-gnutls.c        |   2 +-
 crypto/random-platform.c      |   2 +-
 crypto/secret.c               |   2 +-
 crypto/tlscreds.c             |   2 +-
 crypto/tlscredsanon.c         |   2 +-
 crypto/tlscredspriv.h         |   2 +-
 crypto/tlscredspsk.c          |   2 +-
 crypto/tlscredsx509.c         |   2 +-
 crypto/tlssession.c           |   2 +-
 crypto/xts.c                  |   2 +-
 docs/security.texi            |  36 ++++++
 include/crypto/block.h        |   2 +-
 include/crypto/cipher.h       |   2 +-
 include/crypto/hash.h         |   2 +-
 include/crypto/init.h         |   2 +-
 include/crypto/ivgen.h        |   2 +-
 include/crypto/pbkdf.h        |   2 +-
 include/crypto/random.h       |   2 +-
 include/crypto/secret.h       |   2 +-
 include/crypto/tlscreds.h     |   2 +-
 include/crypto/tlscredsanon.h |   2 +-
 include/crypto/tlscredspsk.h  |   2 +-
 include/crypto/tlscredsx509.h |   2 +-
 include/crypto/tlssession.h   |   2 +-
 include/crypto/xts.h          |   2 +-
 56 files changed, 298 insertions(+), 96 deletions(-)

--=20
2.21.0


