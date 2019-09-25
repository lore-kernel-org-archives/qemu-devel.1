Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF9FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B435E21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435E21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8sQ-0005Pc-84
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD8na-0000Z3-JX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD8nV-0004XU-UQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD8nV-0004Wc-9O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8BD7A44ADD;
 Wed, 25 Sep 2019 15:01:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D94845C21F;
 Wed, 25 Sep 2019 15:01:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, richardw.yang@linux.intel.com,
 alex.benee@linaro.org
Subject: [PULL 0/9] migration queue
Date: Wed, 25 Sep 2019 16:01:21 +0100
Message-Id: <20190925150130.12303-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 25 Sep 2019 15:01:38 +0000 (UTC)
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00=
bc:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' i=
nto staging (2019-09-24 15:36:31 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190925a

for you to fetch changes up to 3748fef9b95a9bc1602f3c4ed2a329d8ef47e63c:

  migration/postcopy: Recognise the recovery states as 'in_postcopy' (201=
9-09-25 15:51:19 +0100)

----------------------------------------------------------------
Migration pull 2019-09-25

  me: test fixes from (should stop hangs in postcopy tests).
  me: An RDMA cleanup hang fix
  Wei: Tidy ups around postcopy
  Marc-Andre: mem leak fix

----------------------------------------------------------------
Dr. David Alan Gilbert (5):
      migration/rdma: Don't moan about disconnects at the end
      migration/rdma.c: Swap synchronize_rcu for call_rcu
      tests/migration: Fail on unexpected migration states
      tests/migration/postcopy: trim migration bandwidth
      migration/postcopy: Recognise the recovery states as 'in_postcopy'

Marc-Andr=C3=A9 Lureau (1):
      migration: fix vmdesc leak on vmstate_save() error

Wei Yang (3):
      migration/postcopy: not necessary to do discard when canonicalizing=
 bitmap
      migration/postcopy: unsentmap is not necessary for postcopy
      migration: remove sent parameter in get_queued_page_not_dirty

 include/exec/ram_addr.h |  6 ----
 migration/migration.c   |  9 ++++-
 migration/qjson.h       |  2 ++
 migration/ram.c         | 94 ++++++++-----------------------------------=
------
 migration/rdma.c        | 51 ++++++++++++++++++---------
 migration/savevm.c      |  3 +-
 migration/trace-events  |  2 +-
 tests/migration-test.c  | 25 +++++++++----
 8 files changed, 80 insertions(+), 112 deletions(-)

