Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1ABC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3342C206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3342C206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsrq-0001hF-67
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:18:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQspq-0000AG-64
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQspo-0002US-8g
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hQspm-0002MF-6x
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C4453022E53
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-37.ams2.redhat.com
	[10.36.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8BF5C1A3;
	Wed, 15 May 2019 12:16:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:15:36 +0200
Message-Id: <20190515121544.4597-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 15 May 2019 12:16:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/8] WIP: Multifd compression support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
- improve the code
- address David and Markus comments
- make compression code into methods
  so we can add any other method ading just three functions

Please review, as far as I know everything is ok now.

Todo: Add zstd support

v2:
- improve the code left and right
- Split better the zlib code
- rename everything to v4.1
- Add tests for multifd-compress zlib
- Parameter is now an enum (soon will see sztd)

ToDo:
- Make operations for diferent methods:
  * multifd_prepare_send_none/zlib
  * multifd_send_none/zlib
  * multifd_recv_none/zlib
- Use the MULTIFD_FLAG_ZLIB (it is unused so far).

Please review and comment.

v1:

This series create compression code on top of multifd.  It is still
WIP, but it is already:
- faster that current compression code
- it does the minimum amount of copies possible
- we allow support for other compression codes
- it pass the multifd test sent in my previous series

Test for existing code didn't work because code is too slow, I need to
make downtime 10 times bigger to make it to converge on my test
machine.  This code works with same limits that multifd no-

ToDo:
- move printf's  to traces
- move code to a struct instead of if (zlib) inside the main threads.
- improve error handling.

Please, review and coment.

Juan Quintela (8):
  migration: fix multifd_recv event typo
  migration-test: rename parameter to parameter_int
  tests: Add migration multifd test
  migration-test: introduce functions to handle string parameters
  migration: Add multifd-compress parameter
  migration: Make none operations into its own structure
  multifd: Add zlib compression support
  multifd: rest of zlib compression

 hmp.c                        |  17 +++
 hw/core/qdev-properties.c    |  13 +++
 include/hw/qdev-properties.h |   1 +
 migration/migration.c        |  25 +++++
 migration/migration.h        |   1 +
 migration/ram.c              | 203 ++++++++++++++++++++++++++++++++++-
 migration/trace-events       |   2 +-
 qapi/migration.json          |  30 +++++-
 tests/migration-test.c       | 147 ++++++++++++++++++++-----
 9 files changed, 406 insertions(+), 33 deletions(-)

--=20
2.21.0


