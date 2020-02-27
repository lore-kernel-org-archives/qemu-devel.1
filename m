Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5CC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0907C206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml/oqAKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0907C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HlZ-0000jJ-6A
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7HkY-0007n9-0U
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7HkW-0000rm-OQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7HkW-0000rU-Ki
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582804480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/aJMPG71UspefCp5A01IdKlr8J9qHAczpNpidnvgAfI=;
 b=Ml/oqAKVMuzPwdd2fNQYGWALcxeLh3U+zSQOMYWdRyga3KTR5xTn+ez9sD5+ek1hATYoi8
 fJ1s0g8AvTtHPmhUfyDmjBaTk41kdIWcrZvfAI+BkCT6hZ1Wm8NdY4W4zQH843E9rc8Q0P
 80ZUZFfWfuaJDYrNNv8+LscLP6wRlRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-IADh7zASPUS7etPQoSaaTw-1; Thu, 27 Feb 2020 06:54:36 -0500
X-MC-Unique: IADh7zASPUS7etPQoSaaTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0981005512;
 Thu, 27 Feb 2020 11:54:35 +0000 (UTC)
Received: from localhost (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17A2419C58;
 Thu, 27 Feb 2020 11:54:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/7] s390x updates
Date: Thu, 27 Feb 2020 12:54:24 +0100
Message-Id: <20200227115431.32364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-02-25 13:31:16 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200227

for you to fetch changes up to b6c2dbd7214b0b2396e1dcf9668c8b48ab571115:

  s390x: Rename and use constants for short PSW address and mask (2020-02-2=
7 11:10:29 +0100)

----------------------------------------------------------------
Includes a headers update against 5.6-current.
- add missing vcpu reset functionality
- rstfy some s390 documentation
- fixes and enhancements

----------------------------------------------------------------

Christian Borntraeger (1):
  s390/sclp: improve special wait psw logic

Cornelia Huck (3):
  linux-headers: update
  docs: rstfy s390 dasd ipl documentation
  docs: rstfy vfio-ap documentation

Janosch Frank (2):
  s390x: Add missing vcpu reset functions
  s390x: Rename and use constants for short PSW address and mask

Thomas Huth (1):
  target/s390x/translate: Fix RNSBG instruction

 MAINTAINERS                                   |   4 +-
 docs/devel/index.rst                          |   1 +
 .../{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst}  | 119 +--
 docs/system/index.rst                         |   1 +
 docs/{vfio-ap.txt =3D> system/vfio-ap.rst}      | 796 +++++++++---------
 hw/s390x/ipl.c                                |   2 +-
 include/standard-headers/drm/drm_fourcc.h     |  24 +
 include/standard-headers/linux/ethtool.h      |  11 +
 include/standard-headers/linux/input.h        |   1 +
 include/standard-headers/linux/pci_regs.h     |   1 +
 linux-headers/asm-arm/unistd-common.h         |   2 +
 linux-headers/asm-arm64/kvm.h                 |  12 +-
 linux-headers/asm-arm64/unistd.h              |   1 +
 linux-headers/asm-generic/mman-common.h       |   2 +
 linux-headers/asm-generic/unistd.h            |   7 +-
 linux-headers/asm-mips/unistd_n32.h           |   2 +
 linux-headers/asm-mips/unistd_n64.h           |   2 +
 linux-headers/asm-mips/unistd_o32.h           |   2 +
 linux-headers/asm-powerpc/unistd_32.h         |   2 +
 linux-headers/asm-powerpc/unistd_64.h         |   2 +
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/unistd_32.h             |   2 +
 linux-headers/asm-x86/unistd_64.h             |   2 +
 linux-headers/asm-x86/unistd_x32.h            |   2 +
 linux-headers/linux/kvm.h                     |   5 +
 target/s390x/cpu.c                            |  18 +-
 target/s390x/cpu.h                            |   3 +-
 target/s390x/helper.c                         |   2 +-
 target/s390x/kvm-stub.c                       |  10 +-
 target/s390x/kvm.c                            |  42 +-
 target/s390x/kvm_s390x.h                      |   4 +-
 target/s390x/translate.c                      |   2 +-
 33 files changed, 632 insertions(+), 458 deletions(-)
 rename docs/devel/{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst} (51%)
 rename docs/{vfio-ap.txt =3D> system/vfio-ap.rst} (55%)


base-commit: db736e0437aa6fd7c1b7e4599c17f9619ab6b837
--=20
2.21.1


