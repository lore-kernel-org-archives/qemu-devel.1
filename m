Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B4C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344332080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344332080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0tt-00005J-FY
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0nx-0003Eh-OZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0nu-0002ny-JA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0np-0002jT-6g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:48:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 003C0308330B;
 Wed, 12 Jun 2019 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B84202719D;
 Wed, 12 Jun 2019 10:48:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:48:00 +0200
Message-Id: <20190612104808.6398-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 10:48:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 219dca61ebf41625831d4f96a720852baf44b7=
62:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2019-06-11 16:02:07 +0100)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/migration-pull-request

for you to fetch changes up to 87fa344f0684d7c62b0859632de4b6c28e32f2c7:

  migratioin/ram.c: reset complete_round when we gets a queued page (2019=
-06-12 12:38:12 +0200)

----------------------------------------------------------------
Migration pull request

* misc fixes from wei
* Fixes for the multifd compression tree (juan)

Please apply

----------------------------------------------------------------

Juan Quintela (3):
  migration: fix multifd_recv event typo
  migration-test: rename parameter to parameter_int
  migration-test: Add migration multifd test

Wei Yang (5):
  migration/multifd: call multifd_send_sync_main when sending
    RAM_SAVE_FLAG_EOS
  migration/xbzrle: update cache and current_data in one place
  cutils: remove one unnecessary pointer operation
  migration/multifd: sync packet_num after all thread are done
  migratioin/ram.c: reset complete_round when we gets a queued page

 migration/ram.c        |  41 ++++++++++------
 migration/trace-events |   2 +-
 tests/migration-test.c | 103 ++++++++++++++++++++++++++++++-----------
 util/cutils.c          |   8 ++--
 4 files changed, 107 insertions(+), 47 deletions(-)

--=20
2.21.0


