Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F98C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D582073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuiH4hSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D582073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEiL-0006UR-Fk
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgm-00054x-BK
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:06:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgk-0006dZ-L9
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uUUhEVsZA8ApsKvIkOz+zp8cHKf2RmvS+SISjPwHIak=;
 b=CuiH4hSu+/i65O8Imr7gczrZTQulNemgvVF1WlBAWtF7SdIZL9gYCL1jmR/qy1cELg8Bn+
 z+XKqZB1Oda+gYalU3YLk6bJg40BLygdQ2FdGnYvLrm5diDNOYXXtd6mM87aWBPX6YgWt1
 NGPYdHRFNk258SQYQwpmY3zDXsXvCZ0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-IfsTokUMNIiaXNud1JhZyg-1; Mon, 25 May 2020 11:06:45 -0400
X-MC-Unique: IfsTokUMNIiaXNud1JhZyg-1
Received: by mail-ed1-f72.google.com with SMTP id bo26so7548690edb.22
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uUUhEVsZA8ApsKvIkOz+zp8cHKf2RmvS+SISjPwHIak=;
 b=MDct3avkLDd8xXjo3052Yo6Llui0/haB0oL5m4r1uySCBeC1eg3xTDU0ZSawk2vy6f
 hPVAvB9qtDjHvQitAwgPjAWAbRdW1sB3v79z/p3GmwJ1xyg1dxuLJwsa7Dgn/jF8BHWa
 P3+VelI8pdoUooKgGUeSjRH86FfHDkJhsFt+rkHajuKhfqhilQoxDa8GlInPhfeZZP7O
 MbY8uA+043oHcy699d8fCztGmTSwqOlIUNzy3D5gAUNYxndbGoLtVtTp3FdE9G8mYmxF
 Zd64JipfBFNrEt5oNzJke33BPy/RrHBzSNZRfe+7KFFkkTG6CPyoxo+gkoCEjDX9h6iP
 yQ4g==
X-Gm-Message-State: AOAM533XuP4eGh1NC45jpDCS8VDoxxbuVHPg792i5qXRCMc+JLiiPXhs
 TKwCYSm8IudrJbASCYpJbLXPOmnSTgNTCCi9zrsvkb2ti1lRi6FczxpQSxyCsrgvgtfCCtHXQgG
 tipjl6I22SHvpcls=
X-Received: by 2002:a05:6402:c0f:: with SMTP id
 co15mr15228063edb.286.1590419204160; 
 Mon, 25 May 2020 08:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXDuYBjwts5Oak7YG5sKKGRvEk5y89ZJNDT54sGarZyB2TlcoBuz5H/ICJ52o62bVxKlN74Q==
X-Received: by 2002:a05:6402:c0f:: with SMTP id
 co15mr15228030edb.286.1590419203904; 
 Mon, 25 May 2020 08:06:43 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c12sm15706712ejm.36.2020.05.25.08.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:06:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] user-mode: Prune build dependencies (part 2)
Date: Mon, 25 May 2020 17:06:31 +0200
Message-Id: <20200525150640.30879-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing review:
- #2 restrict LostTickPolicy to x86
- #3 correct balloon documentation (new)
- #4 restrict balloon to machine
- #6 move query-uuid to machine
- #8 restrict PCI commands

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 2:
- Extract code not related to user-mode from qapi/misc.json

Since v2:
- Addressed Igor review comments (move query-uuid to machine)
- Addressed David review comments (fix balloon documentation)

Since v1:
- Do not extract the 'add_client' command (elmarco)

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[----] [--] 'target/i386: Restrict X86CPUFeatureWord to X86 targets'
002/9:[----] [--] 'qapi/misc: Restrict LostTickPolicy enum to machine code'
003/9:[down] 'qapi/misc.json: Correct balloon documentation'
004/9:[0026] [FC] 'qapi/misc: Restrict balloon-related commands to machine code'
005/9:[----] [--] 'qapi/misc: Restrict query-vm-generation-id command to machine code'
006/9:[down] 'qapi/misc: Move query-uuid command to machine code'
007/9:[----] [--] 'qapi/misc: Restrict ACPI commands to machine code'
008/9:[----] [--] 'qapi/misc: Restrict PCI commands to machine code'
009/9:[----] [--] 'qapi/misc: Restrict device memory commands to machine code'

Philippe Mathieu-Daudé (9):
  target/i386: Restrict X86CPUFeatureWord to X86 targets
  qapi/misc: Restrict LostTickPolicy enum to machine code
  qapi/misc.json: Correct balloon documentation
  qapi/misc: Restrict balloon-related commands to machine code
  qapi/misc: Restrict query-vm-generation-id command to machine code
  qapi/misc: Move query-uuid command to machine code
  qapi/misc: Restrict ACPI commands to machine code
  qapi/misc: Restrict PCI commands to machine code
  qapi/misc: Restrict device memory commands to machine code

 qapi/machine-target.json             |  45 ++
 qapi/machine.json                    | 803 +++++++++++++++++++++++++--
 qapi/misc.json                       | 756 -------------------------
 include/hw/acpi/acpi_dev_interface.h |   2 +-
 include/hw/mem/memory-device.h       |   1 +
 include/hw/rtc/mc146818rtc.h         |   2 +-
 include/hw/virtio/virtio-pmem.h      |   2 +-
 include/sysemu/balloon.h             |   2 +-
 balloon.c                            |   2 +-
 block/iscsi.c                        |   2 +-
 hw/acpi/core.c                       |   2 +-
 hw/acpi/cpu.c                        |   2 +-
 hw/acpi/memory_hotplug.c             |   2 +-
 hw/acpi/vmgenid.c                    |   2 +-
 hw/core/qdev-properties.c            |   1 +
 hw/i386/kvm/i8254.c                  |   2 +-
 hw/pci/pci-stub.c                    |   2 +-
 hw/pci/pci.c                         |   2 +-
 hw/virtio/virtio-balloon.c           |   2 +-
 monitor/hmp-cmds.c                   |   1 +
 stubs/uuid.c                         |   2 +-
 stubs/vmgenid.c                      |   2 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/machine-stub.c           |  22 +
 target/i386/Makefile.objs            |   3 +-
 25 files changed, 850 insertions(+), 816 deletions(-)
 create mode 100644 target/i386/machine-stub.c

-- 
2.21.3


