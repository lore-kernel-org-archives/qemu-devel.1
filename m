Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCDEC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736F021726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736F021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kjb-000117-F0
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kiI-0007cb-En
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kiH-0003xE-1v
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0kiG-0003wR-Qi
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D552E3082E57
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:53:03 +0000 (UTC)
Received: from dhcp-16-132.lcy.redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 485ED600CD;
 Thu, 22 Aug 2019 10:53:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:52:59 +0100
Message-Id: <20190822105302.26823-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 10:53:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/3] crypto: autofree patches
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

The following changes since commit fe066b4848bab4f9365a419f3c8ba59ccecf67=
c0:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-08-21 16:59:22 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/autofree-pull-request

for you to fetch changes up to 57b9f113fce2a2231a47e9295c1d461e9ff7f0f7:

  crypto: use auto cleanup for many stack variables (2019-08-22 10:56:57 =
+0100)

----------------------------------------------------------------
require newer glib2 to enable autofree'ing of stack variables exiting sco=
pe

* Bump minium glib2 version to 2.48
* Convert much of the crypto code to use automatic memory free functions

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  glib: bump min required glib library version to 2.48
  crypto: define cleanup functions for use with g_autoptr
  crypto: use auto cleanup for many stack variables

 configure                   |  2 +-
 crypto/afsplit.c            | 28 ++++----------
 crypto/block-luks.c         | 74 +++++++++++--------------------------
 crypto/block.c              | 15 +++-----
 crypto/hmac-glib.c          |  5 ---
 crypto/pbkdf.c              |  5 +--
 crypto/secret.c             | 39 ++++++++-----------
 crypto/tlscredsanon.c       | 16 +++-----
 crypto/tlscredspsk.c        |  5 +--
 crypto/tlscredsx509.c       | 16 +++-----
 include/crypto/block.h      |  2 +
 include/crypto/cipher.h     |  2 +
 include/crypto/hmac.h       |  2 +
 include/crypto/ivgen.h      |  2 +
 include/crypto/tlssession.h |  2 +
 include/glib-compat.h       | 42 +--------------------
 16 files changed, 78 insertions(+), 179 deletions(-)

--=20
2.21.0


