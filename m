Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1851620717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWTO52OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7Po-0004km-F6
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iP7Gs-0002tO-77
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iP7Go-0000yR-Bg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24933
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iP7Go-0000xS-6R
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572277764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LYyFgvbIyV2bgI5AwnVSyRwn5Dl1RQToy+rVHgO0MZc=;
 b=MWTO52OYYhS3LW+xdieHK7wSBp/a7te5E7iWY900JtAXwTxezIcU0s95nzq9IyM2n+BxYd
 HQn+ZrdbRB8yLroVaXIAi0rQgN6f7v62eMrU8PHrz/boGP4+GO7oP/+guJR++eNCF0Hdn4
 xtcmKyggWeWCZ9pWo2vyVQjQMP2MTSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-8pEEe0NtNC-5sQ6m6K6RzQ-1; Mon, 28 Oct 2019 11:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56F3E85B6EF
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 15:49:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-24.ams2.redhat.com
 [10.36.112.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0B85D9C5;
 Mon, 28 Oct 2019 15:49:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Crypto luks patches
Date: Mon, 28 Oct 2019 16:49:10 +0100
Message-Id: <20191028154914.84821-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8pEEe0NtNC-5sQ6m6K6RzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-2510=
19-3' into staging (2019-10-26 10:13:48 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/crypto-luks-pull-request

for you to fetch changes up to dc2207af2de162005f7e9e534850d07232290cee:

  crypto: add support for nettle's native XTS impl (2019-10-28 16:45:07 +01=
00)

----------------------------------------------------------------
crypto: improve performance of ciphers in XTS mode

Currently QEMU uses its own XTS cipher mode, however, this has
relatively poor performance.

Gcrypt now includes its own XTS cipher which is at least x2 faster than
what we get with QEMU's on Fedora/RHEL hosts. With gcrypt git master, a
further x5-6 speed up is seen.

This is essential for QEMU's LUKS performance to be viable.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  tests: allow filtering crypto cipher benchmark tests
  tests: benchmark crypto with fixed data size, not time period
  crypto: add support for gcrypt's native XTS impl
  crypto: add support for nettle's native XTS impl

 configure                       | 40 ++++++++++++++
 crypto/Makefile.objs            |  2 +-
 crypto/cipher-gcrypt.c          | 97 ++++++++++++++++++++++-----------
 crypto/cipher-nettle.c          | 18 ++++++
 tests/Makefile.include          |  2 +-
 tests/benchmark-crypto-cipher.c | 39 ++++++++-----
 tests/benchmark-crypto-hash.c   | 17 +++---
 7 files changed, 159 insertions(+), 56 deletions(-)

--=20
2.23.0


