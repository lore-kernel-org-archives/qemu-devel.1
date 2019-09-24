Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB6520872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB6520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCu2q-0006Jy-Cs
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iCtol-0004gG-CW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iCtok-0000Xr-B6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iCtod-0000Tn-TH; Tue, 24 Sep 2019 19:01:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 767B93090FDA;
 Tue, 24 Sep 2019 23:01:49 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17FE360852;
 Tue, 24 Sep 2019 23:01:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] dirty-bitmaps: remove deprecated autoload parameter
Date: Tue, 24 Sep 2019 19:01:42 -0400
Message-Id: <20190924230143.22551-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 24 Sep 2019 23:01:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm going to be honest, here. There's actually no real reason to remove
this now, but we could, so I'm going to.

Also, in terms of the API serving as documentation, it's nicer to not
pretend this is an option that does anything, so out it goes.

This will serve as a little smoke test to see what happens if we
actually stop dropping features we claimed were deprecated.

John Snow (1):
  dirty-bitmaps: remove deprecated autoload parameter

 qemu-deprecated.texi | 20 +++++++++++++++-----
 qapi/block-core.json |  6 +-----
 blockdev.c           |  6 ------
 3 files changed, 16 insertions(+), 16 deletions(-)

--=20
2.21.0


