Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F25C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF77E2173B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rZC6wBOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF77E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVC34-0006RS-NJ
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:36:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVC1G-0005IB-39
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVC1F-0004JQ-7o
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:14 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hVC1E-0004Et-KM
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:13 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1294D2E1581;
	Mon, 27 May 2019 12:34:07 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	dln55jqjxT-Y65iWD5X; Mon, 27 May 2019 12:34:06 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558949646; bh=4Zis7gtJsn4p7S1M83CyODJOC++oJLL9aiQIVu/iSB4=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=rZC6wBOWw1UojVAyTTNoOiMP3nOPt/80Dv1xZTS/JxSzy0XFqNaNHNPQh+fdGoPkW
	12dOAWdMoi/zWCMYjhHvhJcT4PKg63Erl6pZYKZ0jdyICfS3NN8IGfnDPAf/UuNBoC
	HQ7NUpO3N+pn/HY6nJWtU9ZWEN9chI1ECB+RGcSY=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:c428:a8c1:9de0:d2bf])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	ZkWW82ke0f-Y6lmGZ3A; Mon, 27 May 2019 12:34:06 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 May 2019 12:33:48 +0300
Message-Id: <20190527093350.28567-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH 0/2] Deferred incoming migration through fd
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

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

 migration/fd.c         |   8 +--
 migration/fd.h         |   2 +-
 tests/libqtest.c       |  83 ++++++++++++++++++++++++++++++--
 tests/libqtest.h       |  51 +++++++++++++++++++-
 tests/migration-test.c | 107 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 239 insertions(+), 12 deletions(-)

--=20
2.21.0


