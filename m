Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D0C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB302070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB302070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wPl-00085i-5z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wO3-0006Wa-Np
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wO1-0005pZ-4G
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5wO0-0005kf-VI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E6BCC055673
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 18:21:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5BC5D6A3
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 18:21:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:23 -0500
Message-Id: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 05 Sep 2019 18:21:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/9] NBD patches through 2019-09-05
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

The following changes since commit eac2f39602e0423adf56be410c9a22c31fec9a=
81:

  target/arm: Inline gen_bx_im into callers (2019-09-05 13:23:04 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-09-05

for you to fetch changes up to 73bddca33cb1749ddcbcc1e9972a77d93000553b:

  nbd: Implement server use of NBD FAST_ZERO (2019-09-05 10:48:46 -0500)

----------------------------------------------------------------
nbd patches for 2019-09-05

- Advertise NBD_FLAG_CAN_MULTI_CONN on readonly images
- Tolerate larger set of server error responses during handshake
- More precision on handling fallocate() failures due to alignment
- Better documentation of NBD connection URIs
- Implement new extension NBD_CMD_FLAG_FAST_ZERO to benefit qemu-img conv=
ert

----------------------------------------------------------------
Andrey Shinkevich (1):
      block: workaround for unaligned byte range in fallocate()

Eric Blake (8):
      nbd: Advertise multi-conn for shared read-only connections
      nbd: Use g_autofree in a few places
      nbd: Tolerate more errors to structured reply request
      docs: Update preferred NBD device syntax
      nbd: Improve per-export flag handling in server
      nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
      nbd: Implement client use of NBD FAST_ZERO
      nbd: Implement server use of NBD FAST_ZERO

 docs/interop/nbd.txt |  2 ++
 qemu-doc.texi        | 11 +++++--
 include/block/nbd.h  |  6 +++-
 block/io.c           |  2 +-
 block/file-posix.c   |  7 +++++
 block/nbd.c          | 18 ++++++-----
 blockdev-nbd.c       |  3 +-
 nbd/client.c         | 85 +++++++++++++++++++++++++---------------------=
------
 nbd/common.c         |  5 ++++
 nbd/server.c         | 83 ++++++++++++++++++++++++++++------------------=
----
 qemu-nbd.c           |  7 +++--
 nbd/trace-events     |  2 +-
 12 files changed, 134 insertions(+), 97 deletions(-)

--=20
2.21.0


