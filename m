Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83A020BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Emsfafvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83A020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOQV-0004sw-RT
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPF-0003NG-Fr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPD-0007zM-QH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QV3et4pxrPms5Mgj3RYGRReNRB1ZFp8NwU8uR8anWtw=;
 b=EmsfafvjNO2AZIbXZQ/hzP9Hr7BfmFAqRrsQYvr5VWxexHldUYedcrZH5jrO6a/Re3yVnC
 2iJHn5cuBf3IElfzeJ7VkdYhoBUtOcp4ykjaaK4QCZqltT3CAXNjR+PqkOQgLzyTmkT5It
 tDXtz75pFSmsvh9r7VUQFv9gpAQfdc8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528--RDCUJbtNTyk1A8tJduGOg-1; Thu, 10 Sep 2020 11:22:29 -0400
X-MC-Unique: -RDCUJbtNTyk1A8tJduGOg-1
Received: by mail-wm1-f71.google.com with SMTP id 23so118233wmk.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QV3et4pxrPms5Mgj3RYGRReNRB1ZFp8NwU8uR8anWtw=;
 b=cV0e8ICCEq0r4Jz0AEURLqyUJOOzvb8bZ61HF6yhoFxD0sAXhEvAk4I9x/GmnXh245
 lV0gw7ohbcF5LMd5SPa5vsaycoRlv5j1qZvp/wrOMXhG1AaFu9Z+jt8HOy31r5ggXzTp
 JiAYnnxtfADWLRXf1kcQWla535G9gzgocZ7qjbjQ2rt8kqy3pgY2ihMP6/siK03yBXet
 k6zgUDmgH5/CYNdBcWLXLmYKak6kMav3l1Co4QuGdiQw8i3EcCNxMtpUQZeZkWSWawlG
 WUQyfO3jUSZfDDwhj767qJBVVLzVJZNfsNaK+C129x2zzK5hsAYcac2RxhPNTd4uwF2m
 GWCw==
X-Gm-Message-State: AOAM531XfBk69zTQaNgWmY8hA0fVUKmjDMgtrZZNia/UA7moUhz2pj8e
 OisdYdN/QLBifcaVViSn5zwIqHgtYV4/aUaiu+A/cKeS9hOtTEMnjC/ad2YB1AiBxCXh3/ETfPw
 DJq7Tpdu1TbJ2QFo=
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr490671wmb.71.1599751347962;
 Thu, 10 Sep 2020 08:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpz37bbNm2S6MjBDHbkaAad37RLohg4pnr8X9uyZrY8+J/MRRkKqgGAYqqLDCf4HjSgHrpOw==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr490626wmb.71.1599751347660;
 Thu, 10 Sep 2020 08:22:27 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b11sm9594926wrt.38.2020.09.10.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:22:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
Date: Thu, 10 Sep 2020 17:22:16 +0200
Message-Id: <20200910152225.524322-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 2:
- Extract code not related to user-mode from qapi/misc.json

Since v3:
- Rebased (Meson)
- Addressed Markus comments:
  - Use g_assert_not_reached() in stub
  - Add commit descriptions
  - Extract ACPI / PCI
  - MEMORY not extracted as no feedback from Igor/MST

Since v2:
- Addressed Igor review comments (move query-uuid to machine)
- Addressed David review comments (fix balloon documentation)

Since v1:
- Do not extract the 'add_client' command (elmarco)

CI:
https://gitlab.com/philmd/qemu/-/pipelines/188367944

Philippe Mathieu-Daudé (9):
  target/i386: Restrict X86CPUFeatureWord to X86 targets
  qapi: Restrict LostTickPolicy enum to machine code
  qapi: Correct balloon documentation
  qapi: Restrict balloon-related commands to machine code
  qapi: Restrict query-vm-generation-id command to machine code
  qapi: Restrict query-uuid command to machine code
  qapi: Restrict device memory commands to machine code
  qapi: Extract ACPI commands to 'acpi.json'
  qapi: Extract PCI commands to 'pci.json'

 qapi/acpi.json                       | 141 +++++
 qapi/machine-target.json             |  45 ++
 qapi/machine.json                    | 430 ++++++++++++--
 qapi/misc.json                       | 820 ---------------------------
 qapi/pci.json                        | 316 +++++++++++
 qapi/qapi-schema.json                |   2 +
 include/hw/acpi/acpi_dev_interface.h |   2 +-
 include/hw/mem/memory-device.h       |   2 +-
 include/hw/rtc/mc146818rtc.h         |   2 +-
 include/hw/virtio/virtio-pmem.h      |   2 +-
 include/sysemu/balloon.h             |   2 +-
 block/iscsi.c                        |   2 +-
 hw/acpi/core.c                       |   2 +-
 hw/acpi/cpu.c                        |   2 +-
 hw/acpi/memory_hotplug.c             |   3 +-
 hw/acpi/vmgenid.c                    |   2 +-
 hw/core/qdev-properties.c            |   1 +
 hw/i386/kvm/i8254.c                  |   2 +-
 hw/pci/pci-stub.c                    |   2 +-
 hw/pci/pci.c                         |   2 +-
 hw/virtio/virtio-balloon.c           |   2 +-
 hw/virtio/virtio-mem-pci.c           |   1 +
 monitor/hmp-cmds.c                   |   2 +
 monitor/qmp-cmds.c                   |   1 +
 softmmu/balloon.c                    |   2 +-
 stubs/uuid.c                         |   2 +-
 stubs/vmgenid.c                      |   2 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/machine-stub.c           |  23 +
 MAINTAINERS                          |   2 +
 qapi/meson.build                     |   2 +
 target/i386/meson.build              |   1 +
 32 files changed, 944 insertions(+), 880 deletions(-)
 create mode 100644 qapi/acpi.json
 create mode 100644 qapi/pci.json
 create mode 100644 target/i386/machine-stub.c

-- 
2.26.2


