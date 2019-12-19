Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16896C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D832E206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggo/qAL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D832E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtm5-0000E2-RJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtYc-0006X0-V2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtYX-0007xz-KL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtYX-0007ur-DN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+iI+yTIHoswKNRLQylDMklwGHzsDkc4EzVyDczCsXEI=;
 b=Ggo/qAL+Sz29KsKONNI0LuxY72ybAdZPA6x/KN5y/m1qoZHanUqQmt7u+repHxglVK5mYo
 +N6S+bFTur5mSwkjqFexZNQEKh2VWukUmxbvW0Y30b19Vwwy0d2/XFIMniZHKElx28sj+f
 8FC0STjcTIE+U3fAr+8odtAGwaSHAVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-zNTuvbRAMcaDDESRHnpICQ-1; Thu, 19 Dec 2019 06:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB46C1005502;
 Thu, 19 Dec 2019 11:01:16 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D4C763B8A;
 Thu, 19 Dec 2019 11:01:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] more s390x patches
Date: Thu, 19 Dec 2019 12:01:06 +0100
Message-Id: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zNTuvbRAMcaDDESRHnpICQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-=
12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20191219

for you to fetch changes up to 104130cb7c106378dab944397c6a455c4a6d552f:

  s390x: Properly fetch and test the short psw on diag308 subc 0/1 (2019-12=
-18 15:54:24 +0100)

----------------------------------------------------------------
More s390x patches:
- tcg: implement LOAD/STORE TO REAL ADDRESS inline
- fixes in tests, the bios, and diag308 handling

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390: Update firmware images

Janosch Frank (2):
  pc-bios/s390x: Fix reset psw mask
  s390x: Properly fetch and test the short psw on diag308 subc 0/1

Richard Henderson (2):
  target/s390x: Split out helper_per_store_real
  target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline

Thomas Huth (1):
  tests/boot-sector: Fix the bad s390x assembler code

 pc-bios/s390-ccw.img        | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/jump2ipl.c |  12 +++++++-----
 pc-bios/s390-netboot.img    | Bin 67232 -> 67232 bytes
 target/s390x/cpu.c          |  12 ++++++++++--
 target/s390x/cpu.h          |   1 +
 target/s390x/helper.h       |   5 +----
 target/s390x/insn-data.def  |   8 ++++----
 target/s390x/mem_helper.c   |  38 ------------------------------------
 target/s390x/misc_helper.c  |  10 ++++++++++
 target/s390x/translate.c    |  21 ++++++++------------
 tests/boot-sector.c         |   4 ++--
 11 files changed, 43 insertions(+), 68 deletions(-)

--=20
2.21.0


