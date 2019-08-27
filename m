Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756ACC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DBA20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YyaUfCtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DBA20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aDo-0003YN-Um
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2aBM-0001ud-HV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2aBI-0003Yq-H8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:37 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:57792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2aBH-0003XN-TZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:36 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 355F12E0DB5;
 Tue, 27 Aug 2019 15:02:30 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 NmRhiZyQfs-2TQeSKCt; Tue, 27 Aug 2019 15:02:30 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566907350; bh=NS0JUCER8Eq5OMNhFcW6kjklMiQ875IpultuHO6nwW0=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=YyaUfCtCQGzKZbIV1WOZNGts5zEqamoc8/LIUwWajyidmH2J5V7C0SXxLBkzXYiOB
 yZun9g3xOAH0o6bshtQGbQJcHejWrv9y7iTWyaySicp9aYmsZJdNF9x0gFt24iN4xS
 d9gqg9XQH5rs6CdG9H5KNvum6j8F3/QOuCWTPWp8=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:dc67:69ff:2705:c046])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 2qbfJ2c4Zu-2T6Kul4X; Tue, 27 Aug 2019 15:02:29 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Aug 2019 15:02:18 +0300
Message-Id: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH 0/3] UUID validation during migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series adds an UUID validation at the start of the migration
on the target side. The idea is to identify the source of migration.

Possible case of problem:
1. There are 3 servers: A, B and C
2. Server A has a VM 1, server B has a VM 2
3. VM 1 and VM 2 want to migrate to the server C
4. Target of VM 1 starts on the server C and dies too quickly for some re=
ason
5. Target of VM 2 starts just after that and listen the same tcp port X, =
which
   the target of VM 1 wanted to use
6. Source of VM 1 connects to the tcp port X, and migrates to VM 2 source
7. It's possible that migration might be successful (e.g., devices are th=
e same)
8. So, the target of VM 2 is in undefined state

The series adds a capability to prevent successful (by mistake) migration=
.

The new capability x-validate-uuid only affects the source so that it sen=
ds
its UUID to the target. The target will validate the received UUID and st=
op
the migration if UUIDs are not equal.

Regards,
Yury

Yury Kotov (3):
  migration: Add x-validate-uuid capability
  tests/libqtest: Allow to set expected exit status
  tests/migration: Add a test for x-validate-uuid capability

 migration/migration.c  |   9 +++
 migration/migration.h  |   1 +
 migration/savevm.c     |  45 +++++++++++++
 qapi/migration.json    |   5 +-
 tests/libqtest.c       |  14 ++++-
 tests/libqtest.h       |   9 +++
 tests/migration-test.c | 140 ++++++++++++++++++++++++++++++++---------
 7 files changed, 189 insertions(+), 34 deletions(-)

--=20
2.22.0


