Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0080C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEB420706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdPOp5MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEB420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idElj-0000eF-3w
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1idEOI-0001Pz-Pt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1idEOH-0001U4-61
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1idEOH-0001Sn-1u
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bf/sq2X8LvwM7XPzmbbgVK4hHmEwYBU4eGspdFx65Yg=;
 b=OdPOp5MF3ev/G/fHW49dCXcGOWFOXJihRKJNUyVFSiglT7ir4BUSZ8n9Itr0fydm3wFiPS
 S2OC2LCQfGWD8/I9m60DcLXRO2LOO/9eyJ0KdKhdmbNkK2a+jr2PfedCV4zLdzbXVXod77
 h+ohOyOBACElN5oTBc9/1/8+VqC2Heg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-utEINZruNCSvTvHzwpFR_g-1; Fri, 06 Dec 2019 09:00:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 867AF801E7A;
 Fri,  6 Dec 2019 14:00:16 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4D4E60E3E;
 Fri,  6 Dec 2019 14:00:12 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tests/acceptance: Add boot vmlinux test
Date: Fri,  6 Dec 2019 09:00:10 -0500
Message-Id: <20191206140012.15517-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: utEINZruNCSvTvHzwpFR_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, alex.bennee@linaro.org, wrampazz@redhat.com,
 crosa@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series add a new acceptance test: boot an uncompressed
Linux kernel built with CONFIG_PVH, so checking the PVH
capability introduced in QEMU 4.0 works.

The test implementation depends on [1] which is likely released
on next Avocado. So that will need a version 2 of this
series to bump Avocado version.

Also I want to use this as an example of a scenario that test
assets could be better managed. As you see on patch 01 the
kernel is built at test time on localhost. While Avocado provides
an API to easily fetch and build it, the whole process takes
reasonable time - besides the fact that localhost must have
all build dependencies installed. How could it be done better?

Nonetheless I argue in favor of merging this as is, and
gradually implement corrections to improve the tests assets
management. Also if eventually the test is proven to unacceptable
slow down the Travis CI then I can add a guard to skip it.

[1] https://github.com/avocado-framework/avocado/pull/3389

Wainer dos Santos Moschetta (2):
  tests/acceptance: Add PVH boot test
  .travis.yml: Add kernel build deps for acceptance tests

 .travis.yml             |  2 ++
 tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/acceptance/pvh.py

--=20
2.21.0


