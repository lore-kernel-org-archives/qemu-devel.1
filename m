Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7DC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6145221D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d03bjRr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6145221D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY5O-0005Cm-HA
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4V-00042W-MZ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4T-0002EU-7B
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=70Am46u+VNNVmqkgIMfKXZnlGCMmOoH7G/p5iB4dISI=;
 b=d03bjRr/C3TZymD+DKaFPebFTjLIYjqkjlp9FZQWNPCZxgOP2sPeN5qIHhuxiNYtgltXin
 Awre5mX4AeSuXzZ6ETB4AoSytVvD0ZDdmffpabuKAYOKcsr383aKNSE86UX3y8KATEEJ0Z
 67WlUi63Bc9qX9GOS9HYX1xgXqZuPto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6a6tqmdHMu2Ro7mXtF3O9g-1; Sun, 13 Sep 2020 15:53:53 -0400
X-MC-Unique: 6a6tqmdHMu2Ro7mXtF3O9g-1
Received: by mail-wr1-f72.google.com with SMTP id 33so5940505wre.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=70Am46u+VNNVmqkgIMfKXZnlGCMmOoH7G/p5iB4dISI=;
 b=GiHA2dTLhzaneZyKQRwxfa96SFjfe6XYeFb+1psfKmvxv7sYU79k8Tly+xI41VjccS
 xCru+BI2+zuMwiwRSvwAb0teKv7GlMV95edS432//Q/I7w9BMqKV8IoEmWb96aHXhRsx
 ZWJKlYGziariot0cvp6aEyvyjdtHOPTyAVSXwY8hZ8cJ6yVtB2C3aiIbxFqchn1BTB4B
 zHUGq5JipZhtNCIvJhkJI1Lz03dguBWgG7JHGePnbe24syohPxkr9AzOGxsd5KrVsB/o
 rjhSW/mlcp2/HQPRTLi1e6GCS+qZXus8u1NPEMtgmyO9fMn9NPqC3XOR5UgrV3GJihOq
 dsug==
X-Gm-Message-State: AOAM531UxNfxoUkuQdQOyBjU3Jvu/6+bOmZOjPaeHsXb3xSMobmUKmmS
 tmGCfIHv8q/EtUk2VaTObkzAuk5zyD6SgXv4TIc0WkBPta+uwFUwu1kMBtCYkOmhzgn+2ISUX+q
 LTkQM8RI70wB90Xc=
X-Received: by 2002:adf:f701:: with SMTP id r1mr12582074wrp.341.1600026832140; 
 Sun, 13 Sep 2020 12:53:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTPvKoXfNDABFkg03p04sK+hG8TMh7CuHVNDRHygH/dXv4/pDFrdz+rY0TVV+hUDrFRv4yuw==
X-Received: by 2002:adf:f701:: with SMTP id r1mr12582059wrp.341.1600026831943; 
 Sun, 13 Sep 2020 12:53:51 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i3sm16934006wrs.4.2020.09.13.12.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 0/8] user-mode: Prune build dependencies (part 2)
Date: Sun, 13 Sep 2020 21:53:40 +0200
Message-Id: <20200913195348.1064154-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 15:53:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Series is fully Acked.

Part 2:
- Extract code not related to user-mode from qapi/misc.json

Since v4:
- Rebased on "QOM boilerplate cleanup"
- Dropped patch #1 "target/i386: Restrict X86CPUFeatureWord"
- Added Paolo's A-b tag

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
https://gitlab.com/philmd/qemu/-/pipelines/189374631

Philippe Mathieu-Daudé (8):
  qapi: Restrict LostTickPolicy enum to machine code
  qapi: Correct balloon documentation
  qapi: Restrict balloon-related commands to machine code
  qapi: Restrict query-vm-generation-id command to machine code
  qapi: Restrict query-uuid command to machine code
  qapi: Restrict device memory commands to machine code
  qapi: Extract ACPI commands to 'acpi.json'
  qapi: Extract PCI commands to 'pci.json'

 qapi/acpi.json                       | 141 +++++
 qapi/machine.json                    | 388 +++++++++++++
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
 MAINTAINERS                          |   2 +
 qapi/meson.build                     |   2 +
 28 files changed, 874 insertions(+), 837 deletions(-)
 create mode 100644 qapi/acpi.json
 create mode 100644 qapi/pci.json

-- 
2.26.2


