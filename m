Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A00217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A00217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDs5k-0008Px-Ty
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iDr43-00010y-4L
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iDr42-0003Sk-3Z
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iDr3v-0003No-QL; Fri, 27 Sep 2019 10:17:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80B5B796ED;
 Fri, 27 Sep 2019 14:17:30 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D35060BF3;
 Fri, 27 Sep 2019 14:17:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] iotests: trivial cleanups
Date: Fri, 27 Sep 2019 10:17:24 -0400
Message-Id: <20190927141728.7137-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 27 Sep 2019 14:17:30 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The most trivial set of cleanups to iotests common libraries and the
044 test.

Cleber Rosa (4):
  qemu-iotests: remove bash shebang from library files
  qemu-iotests: remove forceful execution success from library files
  qemu-iotests: 044: pass is actually a noop, so remove it
  qemu-iotests: 044: remove inaccurate docstring class description

 tests/qemu-iotests/044            | 4 ----
 tests/qemu-iotests/common.config  | 5 -----
 tests/qemu-iotests/common.filter  | 5 -----
 tests/qemu-iotests/common.nbd     | 1 -
 tests/qemu-iotests/common.pattern | 2 --
 tests/qemu-iotests/common.qemu    | 2 --
 tests/qemu-iotests/common.rc      | 5 -----
 tests/qemu-iotests/common.tls     | 2 --
 8 files changed, 26 deletions(-)

--=20
2.21.0


