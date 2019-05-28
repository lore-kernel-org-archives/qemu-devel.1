Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6BFC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7C720989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LWUuqt78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7C720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYFw-0007ff-NJ
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:18:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVYE0-0006g0-9A
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVYDz-00010F-6v
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:16:52 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hVYDy-0000yb-Oe
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:16:51 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A77B42E15F4;
	Tue, 28 May 2019 12:16:46 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	Ip42aDmYjE-GjTq3eA8; Tue, 28 May 2019 12:16:46 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1559035006; bh=ukN/2hgiYj3H9CcC/Vd+QyBMcG3ANH1yXIw3t9pAMNg=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=LWUuqt78d1IBrSJCmihQvoDKxXEVMzWnNKTQVy5GrZey36R8gjqOgfjEAy3lKDN04
	QWofgg3QcJL5x/LEXPd4JVUDmpZxcI64yoRY9fG5DYE/V6LjiGz+yr8sSDq5pOoxlo
	Letg1vdnFpwZ99/3YveczPNz/OTTAxsVZx1nlaZk=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:5d26:9eea:30af:86bd])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	JeN6ka38JZ-GjlmrOTd; Tue, 28 May 2019 12:16:45 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2019 12:16:31 +0300
Message-Id: <20190528091633.12246-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH v2 0/2] Deferred incoming migration through fd
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

Hi,

V2:
* Revert odd changes in migrate()
* Add short description for socket_send_fds()
  and remove ifdef WIN32 as it's not needed

This series is a continuation of the previous two:
* migration: Fix handling fd protocol
* Add 'inline-fd:' protocol for migration

It's about such use case:
1. Target VM: exec ...,-incoming defer
2. Target VM: getfd("fd-mig")
3. Target VM: migrate-incoming("fd:"fd-mig")
4. Source VM: getfd("fd-mig")
5. Source VM: migrate("fd-mig")

Currently, it's not possible to do the step 3, because for incoming migra=
tion
"fd:" protocol expects an integer, not the name of fd.

Yury Kotov (2):
  migration: Fix fd protocol for incoming defer
  migration-test: Add a test for fd protocol

 migration/fd.c         |   8 ++--
 migration/fd.h         |   2 +-
 tests/libqtest.c       |  80 ++++++++++++++++++++++++++++++--
 tests/libqtest.h       |  51 ++++++++++++++++++++-
 tests/migration-test.c | 101 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 233 insertions(+), 9 deletions(-)

--=20
2.21.0


