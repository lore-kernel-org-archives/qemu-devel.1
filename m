Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C95CC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE09206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE09206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCsr-0000Bh-NC
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htCq2-0004yy-2p
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htCq1-0000al-4g
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htCpy-0000Z6-8g; Thu, 01 Aug 2019 11:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B49430C75CF;
 Thu,  1 Aug 2019 15:17:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB1F61F27;
 Thu,  1 Aug 2019 15:17:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  1 Aug 2019 17:17:41 +0200
Message-Id: <20190801151744.798-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 01 Aug 2019 15:17:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] iotests: Test migration with filter nodes
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the testcase for the copy-on-read fix I merged in a hurry for
4.1.0-rc3.

Kevin Wolf (3):
  iotests: Move migration helpers to iotests.py
  iotests: Enable -d for Python non-unittest tests
  iotests: Test migration with all kinds of filter nodes

 tests/qemu-iotests/194        |  1 +
 tests/qemu-iotests/202        |  1 +
 tests/qemu-iotests/203        |  2 +
 tests/qemu-iotests/206        |  1 +
 tests/qemu-iotests/207        |  1 +
 tests/qemu-iotests/208        |  1 +
 tests/qemu-iotests/210        |  1 +
 tests/qemu-iotests/211        |  1 +
 tests/qemu-iotests/212        |  1 +
 tests/qemu-iotests/213        |  1 +
 tests/qemu-iotests/216        |  2 +
 tests/qemu-iotests/218        |  1 +
 tests/qemu-iotests/219        |  1 +
 tests/qemu-iotests/222        |  1 +
 tests/qemu-iotests/224        |  2 +
 tests/qemu-iotests/228        |  2 +
 tests/qemu-iotests/234        | 30 ++++---------
 tests/qemu-iotests/236        |  1 +
 tests/qemu-iotests/237        |  1 +
 tests/qemu-iotests/246        |  1 +
 tests/qemu-iotests/255        |  1 +
 tests/qemu-iotests/256        |  1 +
 tests/qemu-iotests/262        | 84 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/262.out    | 17 +++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 39 ++++++++++++----
 26 files changed, 166 insertions(+), 30 deletions(-)
 create mode 100755 tests/qemu-iotests/262
 create mode 100644 tests/qemu-iotests/262.out

--=20
2.20.1


