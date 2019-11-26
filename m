Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561AC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F23020727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZuC2j0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F23020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaw0-0005DZ-3h
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZauZ-000493-Io
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZauX-0000u3-CZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZauX-0000tH-9c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574774984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7/Gw/qa1pTOOCjh+qq97MuMh4QnvJkRlCTPGtBj2Z0=;
 b=dZuC2j0uOQ7MwYXV4GUtS8H81JB3eVhB4BqSjojRs7Rq9EHtw8G0sInsLBx5ANatiDkYPf
 oQPtpQI8TyTcU+DI/TwzoNXfCgsPtjKrpks05LD/x3M/c5Dryr3tYcnHktUQudF8qm3BwU
 P8+c5fy5dMXbzFVnqRCeMQfwVVD/img=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-qoUZuiNVNkOasbLWuxk2hQ-1; Tue, 26 Nov 2019 08:29:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB8CF132910;
 Tue, 26 Nov 2019 13:29:38 +0000 (UTC)
Received: from localhost (ovpn-204-240.brq.redhat.com [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68FB5196AE;
 Tue, 26 Nov 2019 13:29:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/2] Block patches for 4.2.0-rc3
Date: Tue, 26 Nov 2019 14:29:34 +0100
Message-Id: <20191126132936.1141588-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qoUZuiNVNkOasbLWuxk2hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4ecc984210ca1bf508a96a550ec8a93a5f833f6c=
:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.2-rc=
3' into staging (2019-11-26 12:36:40 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-11-26

for you to fetch changes up to d8130f4c420acafbf15a59436fa47199b82dc00e:

  iotests: add new test cases to bitmap migration (2019-11-26 14:18:01 +010=
0)

----------------------------------------------------------------
Block patches for 4.2.0-rc3:
- Fix for shared storage migration with persistent dirty bitmaps

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (2):
  block/qcow2-bitmap: fix bitmap migration
  iotests: add new test cases to bitmap migration

 block/qcow2-bitmap.c       | 21 ++++++++++++++++++++-
 tests/qemu-iotests/169     | 22 +++++++++++++++-------
 tests/qemu-iotests/169.out |  4 ++--
 3 files changed, 37 insertions(+), 10 deletions(-)

--=20
2.23.0


