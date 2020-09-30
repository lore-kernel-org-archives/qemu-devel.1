Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA4C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86D720706
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwPlw7cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86D720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgIj-0002wy-QB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNgEG-0005GR-5a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNgEA-0004jb-Vw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601488158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RZzbHjTI6ieygQu4OMX2702kE0ErYNGEsTPgyQ1acUc=;
 b=BwPlw7cgVOMSYsFWbwmIlDYX+ZwttWBlu+14OiolUam5cPQDRuh8Ty4ZE7Fh4L2H+8Gyv8
 wFcLMO+UY1RUaSGCRmghnmFwncvnE+tPbOx4obRhFOg2jlPpUUBow3RvGHPh24NT/5IFjS
 3oyxpDDv8tauUZl82qdUN/8BFzBE/oA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-WzKQYrjEPsioPxF6v8OM3A-1; Wed, 30 Sep 2020 13:49:11 -0400
X-MC-Unique: WzKQYrjEPsioPxF6v8OM3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393D2802B7C;
 Wed, 30 Sep 2020 17:49:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1C47880B;
 Wed, 30 Sep 2020 17:48:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0624A9CBC; Wed, 30 Sep 2020 19:48:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Microvm 20200930 patches
Date: Wed, 30 Sep 2020 19:48:43 +0200
Message-Id: <20200930174856.11296-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9=
:=0D
=0D
  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2020-09-29 13:18:54 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/microvm-20200930-pull-request=0D
=0D
for you to fetch changes up to 7f6c3d1a574bddcda6931eb00287089998725f71:=0D
=0D
  tests/acpi: update expected data files (2020-09-30 11:29:56 +0200)=0D
=0D
----------------------------------------------------------------=0D
microvm: add pcie support.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (12):=0D
  move MemMapEntry=0D
  acpi: add acpi_dsdt_add_gpex=0D
  arm: use acpi_dsdt_add_gpex=0D
  microvm: add irq table=0D
  microvm: add pcie support=0D
  microvm/pcie: add 64bit mmio window=0D
  tests/acpi: allow updates for expected data files=0D
  tests/acpi: add empty tests/data/acpi/microvm/DSDT.pcie file=0D
  tests/acpi: factor out common microvm test setup=0D
  tests/acpi: add microvm pcie test=0D
  acpi/gpex: no reason to use a method for _CRS=0D
  tests/acpi: update expected data files=0D
=0D
 include/exec/hwaddr.h             |   5 +=0D
 include/hw/arm/virt.h             |   5 -=0D
 include/hw/i386/microvm.h         |  32 ++++++=0D
 include/hw/pci-host/gpex.h        |  11 ++=0D
 hw/arm/sbsa-ref.c                 |   5 -=0D
 hw/arm/virt-acpi-build.c          | 175 ++---------------------------=0D
 hw/i386/acpi-microvm.c            |  12 ++=0D
 hw/i386/microvm.c                 |  93 ++++++++++++++++=0D
 hw/pci-host/gpex-acpi.c           | 177 ++++++++++++++++++++++++++++++=0D
 tests/qtest/bios-tables-test.c    |  30 ++++-=0D
 hw/i386/Kconfig                   |   1 +=0D
 hw/pci-host/meson.build           |   1 +=0D
 tests/data/acpi/microvm/DSDT.pcie | Bin 0 -> 3023 bytes=0D
 tests/data/acpi/virt/DSDT         | Bin 5200 -> 5196 bytes=0D
 tests/data/acpi/virt/DSDT.memhp   | Bin 6561 -> 6557 bytes=0D
 tests/data/acpi/virt/DSDT.numamem | Bin 5200 -> 5196 bytes=0D
 16 files changed, 366 insertions(+), 181 deletions(-)=0D
 create mode 100644 hw/pci-host/gpex-acpi.c=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.pcie=0D
=0D
--=20=0D
2.27.0=0D
=0D


