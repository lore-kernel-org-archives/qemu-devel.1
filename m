Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BEC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50A221D81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50A221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7eA-0006y3-KK
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iD7UK-0003Wu-1U
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iD7UH-00061c-GE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iD7UH-000618-2K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52FE910A8126
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:37:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FBB519C7F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:37:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/5] NBD patches for 2019-09-24
Date: Wed, 25 Sep 2019 08:37:35 -0500
Message-Id: <20190925133740.30401-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 25 Sep 2019 13:37:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd9856=
3a:

  Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg-2=
019-09-23' into staging (2019-09-23 15:44:52 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-09-24-v2

for you to fetch changes up to da5e1169183ca6eb6fb470dc32ed1bfc24d1d406:

  util/qemu-sockets: fix keep_alive handling in inet_connect_saddr (2019-=
09-25 08:15:44 -0500)

For v2 - add one more patch

----------------------------------------------------------------
nbd patches for 2019-09-24

- Improved error message for plaintext client of encrypted server
- Fix various assertions when -object iothread is in use
- Silence a Coverity error for use-after-free on error path

----------------------------------------------------------------
Eric Blake (3):
      nbd/client: Add hint when TLS is missing
      nbd: Grab aio context lock in more places
      tests: Use iothreads during iotest 223

Sergio Lopez (1):
      nbd/server: attach client channel to the export's AioContext

Vladimir Sementsov-Ogievskiy (1):
      util/qemu-sockets: fix keep_alive handling in inet_connect_saddr

 include/block/nbd.h        |  1 +
 blockdev-nbd.c             | 14 ++++++++++++--
 nbd/client.c               |  1 +
 nbd/server.c               | 27 +++++++++++++++++++++++----
 util/qemu-sockets.c        |  5 +++--
 tests/qemu-iotests/223     |  6 ++++--
 tests/qemu-iotests/223.out |  1 +
 tests/qemu-iotests/233.out |  2 ++
 8 files changed, 47 insertions(+), 10 deletions(-)

--=20
2.21.0


