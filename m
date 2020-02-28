Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4AB246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6Sdax1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4AB246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e80-0000ma-Ar
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e6i-0007LS-Dp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e6h-00019T-4f
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e6h-00019C-1G
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AmxNuFC3e6lYnUMNlpXbB6JPWDYdS6Xlgt71LjznSWc=;
 b=Q6Sdax1gTQLMrLKAqtMPx9548N4gUBcL83pDB83OXNCdLoVFiqU6RigunAmQQk03j9fQ7T
 qEeHjvC9jhMu+6w/3lsOBejvfbvqzRF1MqbJl54ASLovbd5sFdjDXNFpo2o6FtNAvSq7qm
 wSnpfCDS5zsNE480TGSAr++GBr/TNS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-DG6ji7B3O8Gmg5mLMD9_GA-1; Fri, 28 Feb 2020 06:46:55 -0500
X-MC-Unique: DG6ji7B3O8Gmg5mLMD9_GA-1
Received: by mail-wr1-f69.google.com with SMTP id m13so1231912wrw.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yuQOAGBwnnozKVeLt+LTAi2McDFqWK9ifpJf4wdoSwk=;
 b=bUyVYUL0EyO9nZ6/fxKtMlvKiSWR98VdFs4qA32mOaceD+kqwkUHytNPV6K2xhxtVV
 CzLSRTEBMYZtqhxaq0nqlMD5LgFOrQMEp1HmYlFFRVa3TZEM6mq7uoDB5WctLHVKiw6f
 m3efIcAIjfhcRhq58tLp7gyObYFIzJOpKIO3tb8Dz3JvI+fsmJKadLtbRHe9ksIAlqub
 4nrGk0sCFCrBAFIP22VnTFuNnx5g7HNodA7bitYnBzSsnBdDwweDMzawYxny/3IOoY0w
 pDDg8XtPt4pHPS7qe936215g93Rs5XeijZrXisZjVqUKxQ5txQmY6YcCWgsh0J/f6U7Z
 7q7g==
X-Gm-Message-State: APjAAAXdYiM0OGKe9pqEqd8tEu6ZDEUEAREMXu9BP9M9gTvrK1rSLaeT
 F7MczdzK1rtbJAKDhuwfxOhgzAj6SqK0bHvhnkI++UX60gWl9OO1iagejTEp5+xH2W8R81jzZQh
 EusT48xsz6wAYaRs=
X-Received: by 2002:adf:d4d2:: with SMTP id w18mr4808763wrk.180.1582890413536; 
 Fri, 28 Feb 2020 03:46:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN6gIsA/l0Pj7FF9JVSiXFX66nvRoBFxr3C1FT2WelKnn338ckD0zAyyRGpALF7mj+t2NkNg==
X-Received: by 2002:adf:d4d2:: with SMTP id w18mr4808748wrk.180.1582890413322; 
 Fri, 28 Feb 2020 03:46:53 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q138sm1127219wme.41.2020.02.28.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:46:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] hw: Clean up hw/i386 headers (and few alpha/hppa)
Date: Fri, 28 Feb 2020 12:46:31 +0100
Message-Id: <20200228114649.12818-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Rebased since v1]:
https://www.mail-archive.com/qemu-block@nongnu.org/msg57485.html

This is a follow-up of Markus's cleanup series:
Tame a few "touch this, recompile the world"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg635748.html

This part is mostly restricted to X86, but since some file from the
Alpha/PA-RISC machines include "hw/i386/pc.h" I had to fix them
too.

Eventually I'll succeed at removing hw/i386/ dependency on non-X86
platforms (Quest I started 2 years ago...).

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (18):
  vl: Add missing "hw/boards.h" include
  hw/southbridge/ich9: Removed unused headers
  hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
  hw/timer: Remove unused "ui/console.h" header
  hw/usb/dev-storage: Remove unused "ui/console.h" header
  hw/i386/intel_iommu: Remove unused includes
  hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
  hw/alpha/dp264: Include "net/net.h"
  hw/hppa/machine: Include "net/net.h"
  hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
  hw/timer/hpet: Include "exec/address-spaces.h"
  hw/pci-host/q35: Include "qemu/range.h"
  hw/i2c/smbus_ich9: Include "qemu/range.h"
  hw/pci-host/piix: Include "qemu/range.h"
  hw/acpi: Include "hw/mem/nvdimm.h"
  hw/i386: Include "hw/mem/nvdimm.h"
  hw/pci-host/q35: Remove unused includes
  hw/i386/pc: Clean up includes

 hw/alpha/alpha_sys.h              |  1 -
 include/hw/i386/ich9.h            |  1 -
 include/hw/i386/intel_iommu.h     |  4 ----
 include/hw/i386/ioapic_internal.h |  1 -
 include/hw/i386/pc.h              | 11 +++--------
 include/hw/pci-host/q35.h         |  8 +-------
 hw/acpi/cpu_hotplug.c             |  1 +
 hw/acpi/ich9.c                    |  2 +-
 hw/acpi/piix4.c                   |  1 +
 hw/alpha/dp264.c                  |  1 +
 hw/hppa/machine.c                 |  1 +
 hw/i2c/smbus_ich9.c               |  1 +
 hw/i386/acpi-build.c              |  1 +
 hw/i386/pc.c                      |  1 +
 hw/i386/pc_piix.c                 |  1 +
 hw/i386/pc_q35.c                  |  1 +
 hw/isa/lpc_ich9.c                 |  1 -
 hw/pci-host/i440fx.c              |  1 +
 hw/pci-host/q35.c                 |  1 +
 hw/rtc/twl92230.c                 |  1 -
 hw/timer/hpet.c                   |  2 +-
 hw/usb/dev-storage.c              |  1 -
 softmmu/vl.c                      |  1 +
 23 files changed, 18 insertions(+), 27 deletions(-)

--=20
2.21.1


