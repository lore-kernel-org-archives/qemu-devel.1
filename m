Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EABC3A59B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6249C2063F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6249C2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKaR-000558-2N
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKWL-0002bP-Pv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKWI-0001Bf-GL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hyKWI-0001B4-BE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E89AB89C35
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 18:30:40 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1AF312A6A
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 18:30:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:30 -0500
Message-Id: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 15 Aug 2019 18:30:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/9] First batch of 4.2 NBD patches
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

The following changes since commit 9e06029aea3b2eca1d5261352e695edc1e7d7b=
8b:

  Update version for v4.1.0 release (2019-08-15 13:03:37 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-08-15

for you to fetch changes up to 8f071c9db506e03abcb1b76ec6d3d2f9488cc3b3:

  block/nbd: refactor nbd connection parameters (2019-08-15 13:22:14 -050=
0)

----------------------------------------------------------------
nbd patches for 2019-08-15

- Addition of InetSocketAddress keep-alive
- Addition of BDRV_REQ_PREFETCH for more efficient copy-on-read
- Initial refactoring in preparation of NBD reconnect

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (9):
      qapi: Add InetSocketAddress member keep-alive
      block: implement BDRV_REQ_PREFETCH
      block/stream: use BDRV_REQ_PREFETCH
      nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH
      block/nbd: split connection_co start out of nbd_client_connect
      block/nbd: use non-blocking io channel for nbd negotiation
      block/nbd: move from quit to state
      block/nbd: add cmdline and qapi parameter reconnect-delay
      block/nbd: refactor nbd connection parameters

 qapi/block-core.json  |  11 ++-
 qapi/sockets.json     |   6 +-
 include/block/block.h |   8 ++-
 include/block/nbd.h   |   3 +-
 block/io.c            |  18 +++--
 block/nbd.c           | 195 +++++++++++++++++++++++++++++---------------=
------
 block/stream.c        |  24 +++----
 nbd/client.c          |  16 +++--
 nbd/server.c          |  43 ++++++++---
 qemu-nbd.c            |   2 +-
 util/qemu-sockets.c   |  28 ++++++++
 11 files changed, 233 insertions(+), 121 deletions(-)

Vladimir Sementsov-Ogievskiy (9):
  qapi: Add InetSocketAddress member keep-alive
  block: implement BDRV_REQ_PREFETCH
  block/stream: use BDRV_REQ_PREFETCH
  nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH
  block/nbd: split connection_co start out of nbd_client_connect
  block/nbd: use non-blocking io channel for nbd negotiation
  block/nbd: move from quit to state
  block/nbd: add cmdline and qapi parameter reconnect-delay
  block/nbd: refactor nbd connection parameters

 qapi/block-core.json  |  11 ++-
 qapi/sockets.json     |   6 +-
 include/block/block.h |   8 +-
 include/block/nbd.h   |   3 +-
 block/io.c            |  18 ++--
 block/nbd.c           | 195 ++++++++++++++++++++++++------------------
 block/stream.c        |  24 ++----
 nbd/client.c          |  16 ++--
 nbd/server.c          |  43 ++++++++--
 qemu-nbd.c            |   2 +-
 util/qemu-sockets.c   |  28 ++++++
 11 files changed, 233 insertions(+), 121 deletions(-)

--=20
2.20.1


