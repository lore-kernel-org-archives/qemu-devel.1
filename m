Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B745C73C41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769F321537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F321537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkpQw-0000Ya-1c
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 08:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hkpJS-0003Cy-UC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hkpJQ-0004u8-Fc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hkpJQ-0004jO-13; Tue, 09 Jul 2019 08:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FD17C055677;
 Tue,  9 Jul 2019 12:25:50 +0000 (UTC)
Received: from localhost (unknown [10.40.205.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 052328681C;
 Tue,  9 Jul 2019 12:25:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jul 2019 14:25:42 +0200
Message-Id: <20190709122546.12373-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 09 Jul 2019 12:25:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 0/4] s390x patches for -rc0
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3a1acf5d47295d22ffdae0982a2fd808b802a7=
da:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-07-08 09:46:19 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190709

for you to fetch changes up to 92b9afe45e10edd8eaed6329366201c2165a8065:

  s390x/tcg: move fallthrough annotation (2019-07-09 10:37:44 +0200)

----------------------------------------------------------------
Fixes in cpu models, tcg, and vfio-ccw.

----------------------------------------------------------------

Alex Williamson (1):
  vfio-ccw: Test vfio_set_irq_signaling() return value

Christian Borntraeger (1):
  s390: cpumodel: fix description for the new vector facility

Cornelia Huck (1):
  s390x/tcg: move fallthrough annotation

Pierre Morel (1):
  s390x/cpumodel: Set up CPU model for AQIC interception

 hw/vfio/ccw.c                       | 5 ++---
 target/s390x/cpu_features_def.inc.h | 3 ++-
 target/s390x/cpu_models.c           | 1 +
 target/s390x/gen-features.c         | 1 +
 target/s390x/translate_vx.inc.c     | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

--=20
2.20.1


