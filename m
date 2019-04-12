Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52299C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BACD20818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rfrB4rGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BACD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvFP-0001HQ-9d
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:25:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAv-000694-Sv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAr-00070C-Pv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:57 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34508)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAr-0006yy-7Z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:53 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id BEA302E1443;
	Fri, 12 Apr 2019 15:20:50 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
	[2a02:6b8:0:1472:2741:0:8b6:10])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	huEYPqifM2-KoeCH6uD; Fri, 12 Apr 2019 15:20:50 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555071650; bh=3T9khVU7szn5g8uyFhS4GSIxV4aHd8JjAMmP6K3BMvM=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=rfrB4rGUvlyMnuY6SRgj5EBeZFwmvwW+dzSD8B7BrL7iblOqW5Rr3fBl2E6sqxFyp
	I/QDTsZ7ScJSvuXmz0+KIL0069VYK0RYEtthjEXtQHpT4IXecY2bL84zFLG2at6+aU
	qgnDHWiXLvQ2y6s5hMbJzpT5WmKVDmYXXAJaCURU=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:3404:6cb5:5ab:ed68])
	by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	m4LakqlT7Q-Ko0WxZsE; Fri, 12 Apr 2019 15:20:50 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2019 15:20:25 +0300
Message-Id: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
	yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122025.fsn2lx61cWnGCsfLvPktNa6nzt03cw_SM3CotyvdE34@z>

Hi,

I've added 'inline-fd:' proto to simplify migration to/from fd.
I thought about modifying the existing 'fd:' proto but I'm not sure it's =
a
good idea to change it's contract.

Existing 'fd:' proto works with previously added fd by getfd or add-fd co=
mmands.
If client doesn't want to work with this fd before or after migration the=
n it's
easier to send an fd with the migrate-* command. Also, client shouldn't m=
aintain
this fd.

Usage:
{ 'execute': 'migrate', 'arguments': { 'uri': 'inline-fd:' } }
{ 'execute': 'migrate-incoming', 'arguments': { 'uri': 'inline-fd:' } }

Regards,
Yury

Yury Kotov (3):
  monitor: Add monitor_recv_fd function to work with sent fds
  migration: Add inline-fd protocol
  migration-test: Add a test for inline_fd protocol

 include/monitor/monitor.h          |   1 +
 migration/Makefile.objs            |   2 +-
 migration/inline-fd.c              |  89 ++++++++++++++++++++++
 migration/inline-fd.h              |  22 ++++++
 migration/migration.c              |  15 ++++
 migration/trace-events             |   4 +
 monitor.c                          |  15 +++-
 tests/libqtest.c                   |  83 +++++++++++++++++++-
 tests/libqtest.h                   |  51 ++++++++++++-
 tests/migration-test.c             | 117 ++++++++++++++++++++++++++---
 tests/qemu-seccomp                 | Bin 0 -> 1266168 bytes
 tests/test-query-device-blockstats | Bin 0 -> 1272608 bytes
 12 files changed, 379 insertions(+), 20 deletions(-)
 create mode 100644 migration/inline-fd.c
 create mode 100644 migration/inline-fd.h
 create mode 100755 tests/qemu-seccomp
 create mode 100755 tests/test-query-device-blockstats

--=20
2.21.0


