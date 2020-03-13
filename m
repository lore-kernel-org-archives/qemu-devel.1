Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E26C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040E820658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZFGSYEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpPP-0000HX-52
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpFz-0000sb-Fs
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpFy-00055T-BZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpFy-00055B-8X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qTJWLuPvDtPVlT+0gmAc/Ch34jN4Re0x/yogrlHnxD4=;
 b=XZFGSYEpPk+QV1kLwWA5g/bXmvgoxIGN6bMIiWhYTlqRklZE1yvDaZ8DnYLA/RLti7XFcR
 LgEuZkoebNeRY4dVZ7aR+LCEcXRhD5Mr+zJ3fHXYhGutvzJUw6rHF/NPEnqgGHYAwo6mOI
 vDMqYJw6IHKspbZ28OTlnsSntxIKkL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-opIrMOY4PQuqrqI7uvPJlg-1; Fri, 13 Mar 2020 14:41:56 -0400
X-MC-Unique: opIrMOY4PQuqrqI7uvPJlg-1
Received: by mail-wr1-f69.google.com with SMTP id p2so2188437wrw.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9wmwK7XBEa9KVBRzHAi0ocsEP1vfCuqCnlmQIUqq3Zk=;
 b=XG1ISdgf3M81C9JKZaWxLNWrkTSE8gSkHF+iGjO06/Vk5mt88kXNUZ3fn2q38bAM5T
 GxxYFOkP2vkAExSKTpM8J82pOXCUYnZiW+TcT00v8rF4UP7SdiawgP0aD0mGnmY8GoYr
 1GVRMSMspC0iqilkiKg2+Wc4tLvIZ9WwwweqWs/9IoTkOT5igjnX/fpJW+6XWAaWOjBc
 CBiCDZgN/8xmM57NG/IIcLQm6tJOwIDJUkkBcTAt3vHLBPF6Z5dvA2mgnE/djIaLyVWk
 Ea+oTE9EXQlQ+i8MHMFaV/jfWw8SGR1czSE8tj7+dOYFv3cYrkVEpLY8fP8O9Yp+AIxE
 JtsQ==
X-Gm-Message-State: ANhLgQ1TLioCG0iicEwrvX+e0iQ49LKAXzgtVVaB3vrUKBA5XhXWAqpX
 yBe8M8fiA8vkwNhmtPeyAEafOXKe61YzmoWpypYpVayaAA8fJUef7X8JYyt5Uy7Du39SYAvl8Go
 Lq8D36+QyuWKZmfo=
X-Received: by 2002:adf:ec88:: with SMTP id z8mr3578732wrn.61.1584124915226;
 Fri, 13 Mar 2020 11:41:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7pFHf5AdpsKedlzL6DqJNE3CPV+5w77ZSUkvrl6LrSA/u1d3ihAukt+FGJzU196kdaVvQ/A==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr3578701wrn.61.1584124915016;
 Fri, 13 Mar 2020 11:41:55 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a199sm9047221wme.29.2020.03.13.11.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:41:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] user-mode: Prune build dependencies (part 2)
Date: Fri, 13 Mar 2020 19:41:44 +0100
Message-Id: <20200313184153.11275-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 2:
- Extract code not related to user-mode from qapi/misc.json

Based-on: <20200313183652.10258-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (9):
  target/i386: Restrict X86CPUFeatureWord to X86 targets
  qapi/misc: Move add_client command with chardev code
  qapi/misc: Restrict LostTickPolicy enum to machine code
  qapi/misc: Restrict balloon-related commands to machine code
  qapi/misc: Move query-uuid command with block code
  qapi/misc: Restrict query-vm-generation-id command to machine code
  qapi/misc: Restrict ACPI commands to machine code
  qapi/misc: Restrict PCI commands to machine code
  qapi/misc: Restrict device memory commands to machine code

 qapi/block-core.json                 |  30 +
 qapi/char.json                       |  32 ++
 qapi/machine-target.json             |  45 ++
 qapi/machine.json                    | 766 ++++++++++++++++++++++++--
 qapi/misc.json                       | 788 ---------------------------
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
 monitor/qmp-cmds.c                   |   1 +
 stubs/uuid.c                         |   2 +-
 stubs/vmgenid.c                      |   2 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/machine-stub.c           |  22 +
 target/i386/Makefile.objs            |   3 +-
 28 files changed, 876 insertions(+), 848 deletions(-)
 create mode 100644 target/i386/machine-stub.c

--=20
2.21.1


