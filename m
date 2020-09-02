Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B091C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C443B20786
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImpUIA9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C443B20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRLR-0003hH-Pc
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKX-0001y8-B9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKU-0006ta-3B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yG4X45JO3JiE1s0/++vJZOI1+/XAh0WXPisd9toCcn0=;
 b=ImpUIA9GE7H0mzD1I83g/RhRxiG+wJ7CkB5rAgdfjjGQmegguUy6hopp3FKDTOWrK2QNjV
 LiN0B9Wk1xVrJYxwJmP78JHu4rlHH2RJIf459lFS0VZ6+W1DGfQhoiBB4lI+de3K7HTraB
 kE3SN+bSUVnXVMDAAqQBOchiiiZHr/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-EvRjLFY4NGK8kQKZLxr-rw-1; Wed, 02 Sep 2020 07:53:27 -0400
X-MC-Unique: EvRjLFY4NGK8kQKZLxr-rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2269C1DE10;
 Wed,  2 Sep 2020 11:53:26 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBD187E581;
 Wed,  2 Sep 2020 11:53:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/20] x86 and machine queue, 2020-09-02
Date: Wed,  2 Sep 2020 07:53:03 -0400
Message-Id: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
901' into staging (2020-09-01 16:51:37 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to efacd5b89643ea98c9377630f9054de8b380008b:=0D
=0D
  target/i386/sev: Plug memleak in sev_read_file_base64 (2020-09-02 07:30:2=
6 -0400)=0D
=0D
----------------------------------------------------------------=0D
x86 and machine queue, 2020-09-02=0D
=0D
Bug fixes:=0D
* Revert EPYC topology patches that caused regressions=0D
  (Babu Moger)=0D
* Memory leak fixes (Pan Nengyuan)=0D
=0D
QOM Cleanups:=0D
* Fix typo in AARCH64_CPU_GET_CLASS=0D
* Rename QOM macros for consistency and/or to avoid=0D
  conflicts with other symbols=0D
* Move typedefs to header files=0D
* Correct instance/class sizes=0D
=0D
----------------------------------------------------------------=0D
=0D
Babu Moger (8):=0D
  Revert "i386: Fix pkg_id offset for EPYC cpu models"=0D
  Revert "target/i386: Enable new apic id encoding for EPYC based cpus=0D
    models"=0D
  Revert "hw/i386: Move arch_id decode inside x86_cpus_init"=0D
  Revert "i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition"=0D
  Revert "hw/i386: Introduce apicid functions inside X86MachineState"=0D
  Revert "target/i386: Cleanup and use the EPYC mode topology functions"=0D
  Revert "hw/386: Add EPYC mode topology decoding functions"=0D
  Revert "hw/i386: Update structures to save the number of nodes per=0D
    package"=0D
=0D
Cornelia Huck (1):=0D
  virtio: add Virtio*BusClass sizes=0D
=0D
Eduardo Habkost (9):=0D
  imx_ccm: Rename IMX_GET_CLASS macro=0D
  mos6522: Rename QOM macros=0D
  x86-iommu: Rename QOM type macros=0D
  rdma: Rename INTERFACE_RDMA_PROVIDER_CLASS macro=0D
  arm: Fix typo in AARCH64_CPU_GET_CLASS definition=0D
  rx: Rename QOM type check macros=0D
  rx: Move typedef RXCPU to cpu-qom.h=0D
  hda-audio: Set instance_size at base class=0D
  tls-cipher-suites: Correct instance_size=0D
=0D
Pan Nengyuan (2):=0D
  target/i386/cpu: Fix memleak in x86_cpu_class_check_missing_features=0D
  target/i386/sev: Plug memleak in sev_read_file_base64=0D
=0D
 include/hw/i386/topology.h  | 101 -------------------=0D
 include/hw/i386/x86-iommu.h |   4 +-=0D
 include/hw/i386/x86.h       |   9 --=0D
 include/hw/misc/imx_ccm.h   |   2 +-=0D
 include/hw/misc/mos6522.h   |   4 +-=0D
 include/hw/rdma/rdma.h      |   2 +-=0D
 target/arm/cpu-qom.h        |   2 +-=0D
 target/i386/cpu.h           |   3 -=0D
 target/rx/cpu-qom.h         |   7 +-=0D
 target/rx/cpu.h             |   1 -=0D
 crypto/tls-cipher-suites.c  |   2 +-=0D
 hw/audio/hda-codec.c        |   4 +-=0D
 hw/i386/amd_iommu.c         |   2 +-=0D
 hw/i386/intel_iommu.c       |   2 +-=0D
 hw/i386/pc.c                |   8 +-=0D
 hw/i386/x86-iommu.c         |   2 +-=0D
 hw/i386/x86.c               |  43 ++------=0D
 hw/misc/imx_ccm.c           |   2 +-=0D
 hw/misc/mac_via.c           |  14 +--=0D
 hw/misc/macio/cuda.c        |   6 +-=0D
 hw/misc/macio/pmu.c         |   6 +-=0D
 hw/misc/mos6522.c           |   8 +-=0D
 hw/rdma/vmw/pvrdma_main.c   |   2 +-=0D
 hw/rx/rx-gdbsim.c           |   4 +-=0D
 hw/s390x/virtio-ccw.c       |   1 +=0D
 hw/virtio/virtio-pci.c      |   1 +=0D
 target/i386/cpu.c           | 190 +++++++++++++++++++++++++-----------=0D
 target/i386/kvm.c           |   2 +-=0D
 target/i386/sev.c           |   1 +=0D
 target/rx/cpu.c             |  14 +--=0D
 target/rx/gdbstub.c         |   4 +-=0D
 target/rx/helper.c          |   4 +-=0D
 target/rx/translate.c       |   2 +-=0D
 tests/test-x86-cpuid.c      |  40 ++++----=0D
 34 files changed, 215 insertions(+), 284 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


