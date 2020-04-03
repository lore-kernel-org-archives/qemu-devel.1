Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D4C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509D020721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQBNslx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509D020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIbf-0005yS-DG
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jKIaT-0004mY-Lt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jKIaS-0006SZ-Jt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jKIaS-0006Rb-GF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585905964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qvqyeRXMpDzFuUpyWKrlPNncj2W/te4Wbwchvr7WR4s=;
 b=NQBNslx4F9LP6Kafnl7uvIpEHOfq1uAovY5XCIVZbSo15qBcnZhlPSH3koAHpyYBCN/N1C
 PG4tyhQIv3eb840/OMrFH14wWJwjVSi1UQ1Y9zCJEThiLy/0XoG2IRv5ustXUpIoKO2ku6
 WdbwewzI1L9DhnTT+JNndNjqQAUE1yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-T1YsEoY2MHO4aattDr4EFA-1; Fri, 03 Apr 2020 05:26:00 -0400
X-MC-Unique: T1YsEoY2MHO4aattDr4EFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5860477;
 Fri,  3 Apr 2020 09:25:59 +0000 (UTC)
Received: from localhost (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4875A9A245;
 Fri,  3 Apr 2020 09:25:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 0/2] s390x fixes for -rc2
Date: Fri,  3 Apr 2020 11:25:51 +0200
Message-Id: <20200403092553.25803-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e=
:

  Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200403

for you to fetch changes up to 5c30ef937f522a65df78dd9f496483fe4fc44d5e:

  vl/s390x: fixup ram sizes for compat machines (2020-04-02 17:10:09 +0200)

----------------------------------------------------------------
- fix cpu number reporting in the stsi 3.2.2 block for kvm
- fix migration for old machines with odd ram sizes

----------------------------------------------------------------

Christian Borntraeger (1):
  vl/s390x: fixup ram sizes for compat machines

Janosch Frank (1):
  s390x: kvm: Fix number of cpu reports for stsi 3.2.2

 hw/s390x/s390-skeys.c        |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  4 ++--
 hw/s390x/s390-virtio-ccw.c   | 22 ++++++++++++++++++++++
 hw/s390x/sclp.c              | 17 +++++------------
 include/hw/boards.h          |  7 +++++++
 softmmu/vl.c                 |  3 +++
 target/s390x/kvm.c           | 17 ++++++++++++++++-
 7 files changed, 56 insertions(+), 16 deletions(-)

--=20
2.21.1


