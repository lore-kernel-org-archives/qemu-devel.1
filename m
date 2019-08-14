Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF72206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF72206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsEw-0001vT-Bn
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsC1-0000Ac-UX
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsBz-0001et-On
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hxsBm-0001bQ-W4; Wed, 14 Aug 2019 08:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44226308FEDF;
 Wed, 14 Aug 2019 12:15:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 274A01B2F5;
 Wed, 14 Aug 2019 12:15:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 14:15:23 +0200
Message-Id: <20190814121527.17876-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 14 Aug 2019 12:15:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] configure: Fix libssh on Ubuntu 18.04
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since a long time occured between libssh 0.7 and libssh 0.8,
distributions went cherry-picking improvments from the trunk
branch into their 0.7 branch, leading to packages versioned
as 0.7 but having 0.8 features.

This series fixes the oddest combination found so far, packaged
with Ubuntu 18.04.

This fixes https://bugs.launchpad.net/qemu/+bug/1838763

Philippe Mathieu-Daud=C3=A9 (4):
  RFC configure: Improve libssh check
  configure: Avoid using libssh deprecated API
  configure: Improve checking libssh version is 0.8
  configure: Log the libssh version detected

 block/ssh.c |  2 +-
 configure   | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

--=20
2.20.1


