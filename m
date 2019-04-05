Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF1C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A2B2175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A2B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY2L-0004Xy-HF
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:14:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0p-0003Xb-Ob
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0n-0003Sn-Qa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0n-0003Gj-Fg
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so9398603qtm.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=3dnkoVUDhzmj6V+sRTqhPfd8LX8au6zOhjXDFviKoPk=;
	b=QSxm7HE+FeK+CctxJ17s0VxCv8v8gi/MOOpZlYBfGGwSEnVf2UsWZCXaM7waKm8EUR
	igL4kYKLRNQx2a1BHPPD/J9BR3xFzENrobAs9JooCCPyekhHISogA4UXp0GiwthqtCl0
	8cEMCRebDIZVdTquxA5tBf7lsxWHMmTChPxDkhEdbo6qQObxIYXtoVvdrSIyX1Z4G23M
	8YIM+fw5k5QCzwDsDjWtFkP3GzjcEWceTMxFFHFeTtCuZmIuVfnrgGZ3I0qlDozOFbMD
	bZf97EECaa4yCALXLDkjzeK7NbUONsKMZFkW5MurP8PlgEF8aql5OCJkC1UfB+VNNDyi
	wodA==
X-Gm-Message-State: APjAAAVVZgX2NAGJMQWZHLCYZ66vWKHBa2oNMEPiiF2GpLZnUS3tzh9w
	YIcRn7UfeZcA8etELWs9iSVmn/YUnwk=
X-Google-Smtp-Source: APXvYqypKdr70+INNmhq3573CODXy+0sYa1EMQp2YXDGth9B5wYHl0joIhSvI5IjMyhyu3QKnOLVNQ==
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr12900578qto.349.1554505958986; 
	Fri, 05 Apr 2019 16:12:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	k3sm15870041qtf.28.2019.04.05.16.12.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:38 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PULL 0/5] pci, pc, virtio: fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231236.onTf6aC-XA1Pdjm8OzK4BReObPKNNZNP-THdTgHQcMI@z>

The following changes since commit 436960c95946007aca713330e7a488a6f2e0696f:

  Merge remote-tracking branch 'remotes/berrange/tags/filemon-next-pull-request' into staging (2019-04-02 14:52:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 81fb1e646e4da29f8e1639022241323b956b67e4:

  intel_iommu: Drop extended root field (2019-04-02 11:49:14 -0400)

----------------------------------------------------------------
pci, pc, virtio: fixes

intel-iommu fixes
virtio typo fixes
linker: a couple of asserts for consistency/security

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Williamson (1):
      intel_iommu: Correct caching-mode error message

Liam Merwick (1):
      acpi: verify file entries in bios_linker_loader_add_pointer()

Peter Xu (2):
      intel_iommu: Fix root_scalable migration breakage
      intel_iommu: Drop extended root field

Yuval Shaia (1):
      virtio-net: Fix typo in comment

 hw/i386/intel_iommu_internal.h |  1 -
 include/hw/i386/intel_iommu.h  |  1 -
 hw/acpi/bios-linker-loader.c   |  2 ++
 hw/i386/intel_iommu.c          | 32 +++++++++++++++++++++++---------
 hw/net/virtio-net.c            |  2 +-
 hw/i386/trace-events           |  2 +-
 6 files changed, 27 insertions(+), 13 deletions(-)


