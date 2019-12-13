Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE35C4741C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2243D24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBaMWV5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2243D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnqC-0006Cr-P4
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnek-0008Mj-U1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnei-0000m4-6p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifneh-0000jy-Ol
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QU6BUpybZ/7TTxuBnE3PZssAviZEtf6G2N9nLZaZTX0=;
 b=IBaMWV5kjZYoEp88b5hMLLAgBu3vn4OMe9qEKCY1+wrLRnAd2tDWYqY7UzqYWvrZJRq343
 5XPBDGiDlU8w74fwNL2ZEDHGkBcx8Djiu+1gDPlTKW9T+lu1zoc0TKwFaDNyIx9JHn1I97
 L5SMa+1O/AHLf/w/EbTqlZH0YzVNZhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-au230BRFO6i-Myf7NaOg9g-1; Fri, 13 Dec 2019 11:18:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64497107ACE4;
 Fri, 13 Dec 2019 16:18:58 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0979F5C241;
 Fri, 13 Dec 2019 16:18:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/16] first s390x update for 5.0
Date: Fri, 13 Dec 2019 17:18:35 +0100
Message-Id: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: au230BRFO6i-Myf7NaOg9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f=
:

  Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20191213

for you to fetch changes up to b147562019dd845a224cde7a37c219f9848d1b8d:

  qga: fence guest-set-time if hwclock not available (2019-12-13 12:16:50 +=
0100)

----------------------------------------------------------------
First s390x update for 5.0:
- compat machines (also for other architectures)
- cleanups and fixes in reset handling
- fence off guest-set-time, as we have no hwclock
- fix some misuses of the error API
- further cleanups

----------------------------------------------------------------

Boris Fiuczynski (1):
  vfio-ccw: Fix error message

Cornelia Huck (3):
  hw: add compat machines for 5.0
  s390x/tcg: clear local interrupts on reset normal
  qga: fence guest-set-time if hwclock not available

Janosch Frank (7):
  s390x: Don't do a normal reset on the initial cpu
  s390x: Move reset normal to shared reset handler
  s390x: Move initial reset
  s390x: Move clear reset
  s390x: Beautify diag308 handling
  s390x: kvm: Make kvm_sclp_service_call void
  s390x: Fix cpu normal reset ri clearing

Markus Armbruster (5):
  s390x/event-facility: Fix realize() error API violations
  s390x/cpumodel: Fix feature property error API violations
  s390x/cpumodel: Fix realize() error API violations
  s390x/cpumodel: Fix query-cpu-model-FOO error API violations
  s390x/cpumodel: Fix query-cpu-definitions error API violations

 hw/arm/virt.c              |   7 ++-
 hw/core/machine.c          |   3 +
 hw/i386/pc.c               |   3 +
 hw/i386/pc_piix.c          |  14 ++++-
 hw/i386/pc_q35.c           |  13 ++++-
 hw/ppc/spapr.c             |  15 ++++-
 hw/s390x/event-facility.c  |   6 +-
 hw/s390x/s390-virtio-ccw.c |  17 +++++-
 hw/vfio/ccw.c              |   2 +-
 include/hw/boards.h        |   3 +
 include/hw/i386/pc.h       |   3 +
 qga/commands-posix.c       |  13 ++++-
 target/s390x/cpu-qom.h     |   9 ++-
 target/s390x/cpu.c         | 112 +++++++++++++++----------------------
 target/s390x/cpu.h         |  19 ++++---
 target/s390x/cpu_models.c  |  98 +++++++++++++++++++-------------
 target/s390x/diag.c        |  54 ++++++++++--------
 target/s390x/kvm.c         |  12 ++--
 target/s390x/sigp.c        |   4 +-
 19 files changed, 250 insertions(+), 157 deletions(-)

--=20
2.21.0


