Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD58C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6978120719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWTjBrMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6978120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5C3-00042W-H2
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5At-0002OT-H5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5As-00009d-6E
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5As-00006p-2k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDZFlDrNrmcbhjI7o8eIbQ/9N5xBzcJuGAS0NyZhRws=;
 b=dWTjBrMxd+zaLcUksrehwwwG/9d8+Wm+enU7xOl1KFA/jSbll0SQ0v9bkbgpGRMZ8eFYkj
 hgx65IYkyi/qqNehrPx1Tnd7bxaFdBxi6zAcNdllPA3P45C3SRr2+i3HOF6FFUkTydUoKm
 4kHHPNueUtiszHMop2jQh8ENBUhoVZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-oWo5Buj6NVOuA7UQhV2YLA-1; Thu, 02 Apr 2020 15:06:42 -0400
X-MC-Unique: oWo5Buj6NVOuA7UQhV2YLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B185013FD
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADAB50BEE
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] Misc patches for 5.0-rc2
Date: Thu,  2 Apr 2020 15:06:25 -0400
Message-Id: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e=
:

  Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0dc0389fa5455bb264866701892ed06bc3eb06e4:

  xen: fixup RAM memory region initialization (2020-04-02 14:56:29 -0400)

----------------------------------------------------------------
Bugfixes for 5.0-rc2.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      serial: Fix double migration data

Elazar Leibovich (1):
      hw/scsi/vmw_pvscsi: Remove assertion for kick after reset

Igor Mammedov (2):
      vl: fix broken IPA range for ARM -M virt with KVM enabled
      xen: fixup RAM memory region initialization

Marc-Andr=C3=A9 Lureau (3):
      softmmu: fix crash with invalid -M memory-backend=3D
      migration: fix cleanup_bh leak on resume
      qmp: fix leak on callbacks that return both value and error

Paolo Bonzini (2):
      virtio-iommu: depend on PCI
      object-add: don't create return value if failed

Philippe Mathieu-Daud=C3=A9 (1):
      hw/isa/superio: Correct the license text

Robert Hoo (2):
      util/bufferiszero: assign length_to_accel value for each accelerator =
case
      util/bufferiszero: improve avx2 accelerator

Roman Bolshakov (2):
      MAINTAINERS: Add an entry for the HVF accelerator
      i386: hvf: Reset IRQ inhibition after moving RIP

Vitaly Kuznetsov (1):
      target/i386: do not set unsupported VMX secondary execution controls

 MAINTAINERS                |  7 +++++++
 hw/char/serial.c           | 12 +++++++++++-
 hw/isa/isa-superio.c       |  2 +-
 hw/isa/smc37c669-superio.c |  2 +-
 hw/scsi/vmw_pvscsi.c       |  5 ++++-
 hw/virtio/Kconfig          |  2 +-
 hw/xen/xen-common.c        |  7 +++++++
 include/hw/isa/superio.h   |  2 +-
 migration/migration.c      |  7 ++++++-
 qapi/qmp-dispatch.c        |  2 ++
 qom/qom-qmp-cmds.c         |  5 +----
 softmmu/vl.c               | 12 ++++++++----
 target/i386/hvf/vmx.h      |  3 +++
 target/i386/kvm.c          | 41 ++++++++++++++++++++++++++---------------
 util/bufferiszero.c        | 27 +++++++++++----------------
 15 files changed, 90 insertions(+), 46 deletions(-)
--=20
2.18.2


