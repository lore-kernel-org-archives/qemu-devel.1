Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D4C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C6E205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqS2wNuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdts-0004Uj-C1
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdEf-0005TS-Gk
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdEd-0000Ry-B3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29915
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdEd-0000DH-7L
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DEx1DBsAUoNULRC5d5g69zDoidZfdJm/4hPW7FcSvm0=;
 b=FqS2wNuq8NjhohNB6KiB55/Y0w8ZJd21wAPT6tatBbi1MSe9jmc+Q6/4xqHAsxLaU/QYML
 Ok/k49Ihvc3SFRHLkELrs3g+4fkdazEVc4v1LCal+5eHntoxN+ap3LvD+ySWf077yPh7qe
 OCNI1qns2hZFQBJOsdAPJbHGP16lRq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-a-caHGIrOq-ewv0urf2fmg-1; Sun, 15 Mar 2020 20:03:53 -0400
X-MC-Unique: a-caHGIrOq-ewv0urf2fmg-1
Received: by mail-wm1-f71.google.com with SMTP id i24so3059253wml.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p3U6+/FO9XXtk26KgyHPnHFo878eVON0VEI6XyYlJKc=;
 b=pH41VFmeNIRAbURpZ71/xb21oRQ1gOjWjL9FDtYfQtZjiIS3IhFVEr3BKimM889SHe
 Xny5tI40MmF77dVT5Q5Kv9FlOnAqOXEDbS/PxQh+sh+l+MU5XFSoc0rN5trGYNBcTGML
 G1p6PQXkkTWxDIJoFy9fARB9L4tqcRTUbLhtqzxyP3iNzc3IZJAqLz1jRWeL6hz+jrsH
 XYKE9Xhu5lINkPY/MPUXoO13Xn1Pqdoo0QKPleZ633/AAO9FMkIbmUcO6RZZhmE+CmBX
 mIPaicB0TKeVtl5xARQFpwvNypwVluUMCwMx/KPVOZZ9rFIe8e2QLqm5Tuu0NdwfZD37
 vwcA==
X-Gm-Message-State: ANhLgQ2zxOlqYLtwtCbV6YDSWu6WqZ20UqFIf/Bo39IJCojtcYkSDkcX
 eNlSCqi4ueLEWLWz/snYCK8zCsUhHEQRZzYk2GrQHY8NiPGRZCdivgPSazgusZ02fwSXiJM4lgi
 qagRyeB82ucdzxf8=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr30641280wrn.88.1584317032135; 
 Sun, 15 Mar 2020 17:03:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuTmu0zTz1TQ9HCY7uymerom7g90h3XVP9GyCle39u1kugpqGCO9Ps/l6jlmOLfSD0b2lrOBA==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr30641250wrn.88.1584317031908; 
 Sun, 15 Mar 2020 17:03:51 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id r18sm4620088wro.13.2020.03.15.17.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:03:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] user-mode: Prune build dependencies (part 2)
Date: Mon, 16 Mar 2020 01:03:40 +0100
Message-Id: <20200316000348.29692-1-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the second part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 2:
- Extract code not related to user-mode from qapi/misc.json

Since v1:
- Do not extract the 'add_client' command (elmarco)

v1: https://www.mail-archive.com/qemu-block@nongnu.org/msg63284.html

Based-on: <i20200315235716.28448-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (8):
  target/i386: Restrict X86CPUFeatureWord to X86 targets
  qapi/misc: Restrict LostTickPolicy enum to machine code
  qapi/misc: Restrict balloon-related commands to machine code
  qapi/misc: Move query-uuid command with block code
  qapi/misc: Restrict query-vm-generation-id command to machine code
  qapi/misc: Restrict ACPI commands to machine code
  qapi/misc: Restrict PCI commands to machine code
  qapi/misc: Restrict device memory commands to machine code

 qapi/block-core.json                 |  30 ++
 qapi/machine-target.json             |  45 ++
 qapi/machine.json                    | 766 +++++++++++++++++++++++++--
 qapi/misc.json                       | 756 --------------------------
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
 26 files changed, 843 insertions(+), 816 deletions(-)
 create mode 100644 target/i386/machine-stub.c

--=20
2.21.1


