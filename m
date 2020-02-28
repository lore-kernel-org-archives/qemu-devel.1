Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D748246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYTOh34J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D748246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mqX-0004SC-Is
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7moE-0000xh-5E
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7moD-0005Ed-6Z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7moD-0005ED-2z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lAgDS5CAvN/e7pjN7y1OL5IZkHDnpKNePlJa0kW0eHc=;
 b=YYTOh34JnbyQwoswlp7i8UUFnI92Cba2fzClY0hKVTr4XDODUXGQzirfUyXcb+c7fDYXC+
 eB9Qpa8eFM6dD9LdOg95N55UpcAZm3ciMhlR0LbcEBViI9Kq/5ye2wxJhtrA62A8ZXpjtl
 29WOIfn3MmJ91MJ/PxDrspbk3dMLl6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-JSDS3FacMwS5KKcyoO2JGA-1; Fri, 28 Feb 2020 16:04:29 -0500
X-MC-Unique: JSDS3FacMwS5KKcyoO2JGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA02A1937FC3;
 Fri, 28 Feb 2020 21:04:28 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8173892D07;
 Fri, 28 Feb 2020 21:04:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Machine queue, 2020-02-28
Date: Fri, 28 Feb 2020 16:04:23 -0500
Message-Id: <20200228210427.474606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
228' into staging (2020-02-28 16:39:27 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 6db1857ec9960c63024f4ce6329d947f727bad39:

  vl: Abort if multiple machines are registered as default (2020-02-28 14:5=
7:19 -0500)

----------------------------------------------------------------
Machine queue, 2020-02-28

Cleanups:
* Fix NMI() macro (Philippe Mathieu-Daud=C3=A9)
* Make MachineClass::is_default boolean, refuse multiple
  default machines (Philippe Mathieu-Daud=C3=A9)

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (4):
  hw/nmi: Fix the NMI() macro, based on INTERFACE_CHECK()
  hw: Do not initialize MachineClass::is_default to 0
  hw: Make MachineClass::is_default a boolean type
  vl: Abort if multiple machines are registered as default

 hw/alpha/dp264.c                         |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/hppa/machine.c                        |  2 +-
 hw/i386/pc_piix.c                        | 10 +++++-----
 hw/lm32/lm32_boards.c                    |  3 +--
 hw/lm32/milkymist.c                      |  1 -
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/q800.c                           |  1 -
 hw/microblaze/petalogix_ml605_mmu.c      |  1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/mips_malta.c                     |  2 +-
 hw/moxie/moxiesim.c                      |  2 +-
 hw/nios2/10m50_devboard.c                |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/riscv/spike.c                         |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  2 +-
 hw/sh4/shix.c                            |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/sun4u.c                       |  2 +-
 hw/tricore/tricore_testboard.c           |  1 -
 hw/unicore32/puv3.c                      |  2 +-
 include/hw/boards.h                      |  4 +++-
 include/hw/nmi.h                         |  2 +-
 softmmu/vl.c                             |  6 ++++--
 26 files changed, 31 insertions(+), 32 deletions(-)

--=20
2.24.1


