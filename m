Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C38CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996CC2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr/uA8r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996CC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN60N-00032t-8J
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5xy-00015E-T0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5xv-0008MT-Pc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5xv-0008M8-IE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571796094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DGScNX2CGxnwMpA5WapZAglgiyFQ+4WFz8xMv5vWDnQ=;
 b=Fr/uA8r0fVlmxGI2rtSBaiFGgslhE56rCfyxv7xbt0mUtwjXxqlk3ulotehVfzcTGZXIBm
 0cdfV1BfZpQNlVNhk8mkK39QNJWjA5zSgbOWvOIfU5wOMBRf0jK9OTEBHUGD70U6bXblw2
 SnNufaWGEKntww4+iydVBUnyqIFnNOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-WJULdNZQPq-0TEpz3xJwpw-1; Tue, 22 Oct 2019 22:01:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B141005500
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 02:01:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCB056012D
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 02:01:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] NBD patches for 2019-10-22
Date: Tue, 22 Oct 2019 21:01:23 -0500
Message-Id: <20191023020126.24991-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WJULdNZQPq-0TEpz3xJwpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit f9bec781379dd7ccf9d01b4b6a79a9ec82c192e5=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191022' into st=
aging (2019-10-22 13:45:09 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-10-22

for you to fetch changes up to 23ee0ec2360b51619cae452c4faa8590dea74a6e:

  iotests: test nbd reconnect (2019-10-22 20:51:31 -0500)

Several other NBD patches have appeared on list, but need respins based
on review comments, and may still be okay after soft freeze. But this one
is a feature addition, so I'm sending the PR now, rather than waiting to
bundle in a few more.

----------------------------------------------------------------
nbd patches for 2019-10-22

- add ability for NBD client reconnect

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (3):
      qemu-coroutine-sleep: introduce qemu_co_sleep_wake
      block/nbd: nbd reconnect
      iotests: test nbd reconnect

 include/qemu/coroutine.h      |  23 ++-
 block/nbd.c                   | 331 ++++++++++++++++++++++++++++++++++----=
----
 util/qemu-coroutine-sleep.c   |  51 +++++--
 tests/qemu-iotests/264        |  95 ++++++++++++
 tests/qemu-iotests/264.out    |  13 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  11 ++
 7 files changed, 447 insertions(+), 78 deletions(-)
 create mode 100755 tests/qemu-iotests/264
 create mode 100644 tests/qemu-iotests/264.out

Vladimir Sementsov-Ogievskiy (3):
  qemu-coroutine-sleep: introduce qemu_co_sleep_wake
  block/nbd: nbd reconnect
  iotests: test nbd reconnect

 include/qemu/coroutine.h      |  23 ++-
 block/nbd.c                   | 331 +++++++++++++++++++++++++++-------
 util/qemu-coroutine-sleep.c   |  51 ++++--
 tests/qemu-iotests/264        |  95 ++++++++++
 tests/qemu-iotests/264.out    |  13 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  11 ++
 7 files changed, 447 insertions(+), 78 deletions(-)
 create mode 100755 tests/qemu-iotests/264
 create mode 100644 tests/qemu-iotests/264.out

--=20
2.21.0


