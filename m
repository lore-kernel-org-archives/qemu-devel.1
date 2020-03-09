Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0345C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F49B20848
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD0HioCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F49B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNvL-0004fj-MP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBNuZ-0003it-Mk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBNuX-00063V-Ma
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:17:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBNuX-00062q-Ei
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583781476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN5Lztumt4MT507GNyJ7s1Z0S9UNEQ0wlWNZR4FSe4M=;
 b=RD0HioCPrv/LmtuaqSSqGTI9TVdpWs5TIsaa55d7+I7hby8lBW1LFvOLMBvKVQWIcgvE9x
 hR4rGEUXC6sxSHdsgV+pzLMaVPzLql3FHzdJPAn9ZLrtb7U1bJTXeTcCXMewj0eUiwG1yo
 bQkGr+4PhlNNttWziIwBgsD4Knujl2A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-iJcxtoCnMi6OGJpoIF2Z-g-1; Mon, 09 Mar 2020 15:17:54 -0400
X-MC-Unique: iJcxtoCnMi6OGJpoIF2Z-g-1
Received: by mail-qv1-f69.google.com with SMTP id o10so7442025qvn.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 12:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=duaZiTgTxNvQrcdo/ncFZBotrmtLMlOJLCKEjcPeZ+k=;
 b=UhgHjEcppmPx2wCyVwYWBXb0P6tnwwX9I3l3Eab0RmdXUgoVm4GjSyAMK0tedu/CDr
 57ctOckuKo0nUlE11qhZCFT71/oPQT6u+7HoLhIMCodttXo4KPf7DCOQXWrtwByd+Xgs
 odU8wMcJeLmxESStGR6pX+4yJfHxlUm2/dY8Io4I+WY8wOWeBdlmE+6RfJIc4QiQQQbc
 8Ya6IRou+/Aep8vpG+7dzBQLhucZm/clefCxMVOB6+sZe6bqSfKFSdnfPAKL+eUCS94h
 HxPa2UtLaAcq+8cd3/LkSwdTEroxEkyQObbH9p2LsIm9/gyx/nqV5AcB6gomo1CE5x75
 dmUg==
X-Gm-Message-State: ANhLgQ2bfqh8XidycDUkD/dEaGSeZw9tuk/Z2e4NnVRV09HIvatsO0VS
 zjHHbchh97WPjIZQ9r7XhmWfAjoIOOZK35mGM223Q7lg3Hz0a2tukNj1ormg9HAjbtkb+ruGUJn
 9k1KhO5u0MnglELQ=
X-Received: by 2002:a0c:8402:: with SMTP id l2mr15434794qva.227.1583781474274; 
 Mon, 09 Mar 2020 12:17:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsN9VaocfI8nL5avF8Uvqm1HtwNzmTswfv7fhCQ5DKa38eZtzi07ZxICBU5F9Nj7eoYfL7q4A==
X-Received: by 2002:a0c:8402:: with SMTP id l2mr15434739qva.227.1583781473955; 
 Mon, 09 Mar 2020 12:17:53 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id r46sm6835526qtb.87.2020.03.09.12.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 12:17:53 -0700 (PDT)
Date: Mon, 9 Mar 2020 15:17:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 00/33] Trivial branch patches
Message-ID: <20200309151621-mutt-send-email-mst@kernel.org>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
> The following changes since commit 7a5853cec479a448edae0fb2aaf4e2f78c9c77=
4d:
>=20
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2020-03-09 10:32:53 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>=20
> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636bb:
>=20
>   monitor/hmp-cmds: Remove redundant statement in hmp_rocker_of_dpa_group=
s() (2020-03-09 15:59:31 +0100)


Could you avoid CC everyone involved on the whole PULL req?
I was involved in a patch or two and don't really need to see
the whole series. Just the cover and the relevant patches
would be enough - if I do want it there's always lore.


> ----------------------------------------------------------------
> - includes cleanup
> - reduce .data footprint
> - fix warnings reported by Clang static code analyzer
> - fix dp8393x part lost in merge
> - update git.orderfile and rules.mak
>=20
> ----------------------------------------------------------------
>=20
> Chen Qun (7):
>   block/stream: Remove redundant statement in stream_run()
>   block/file-posix: Remove redundant statement in raw_handle_perm_lock()
>   dma/xlnx-zdma: Remove redundant statement in zdma_write_dst()
>   scsi/scsi-disk: Remove redundant statement in
>     scsi_disk_emulate_command()
>   display/pxa2xx_lcd: Remove redundant statement in
>     pxa2xx_palette_parse()
>   display/exynos4210_fimd: Remove redundant statement in
>     exynos4210_fimd_update()
>   monitor/hmp-cmds: Remove redundant statement in
>     hmp_rocker_of_dpa_groups()
>=20
> Eric Blake (1):
>   maint: Include top-level *.rst files early in git diff
>=20
> Finn Thain (1):
>   dp8393x: Mask EOL bit from descriptor addresses, take 2
>=20
> Pan Nengyuan (1):
>   core/qdev: fix memleak in qdev_get_gpio_out_connector()
>=20
> Philippe Mathieu-Daud=E9 (23):
>   build-sys: Move the print-variable rule to rules.mak
>   hw/audio/fmopl: Fix a typo twice
>   hw/net/e1000: Add readops/writeops typedefs
>   hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>   virtfs-proxy-helper: Make the helper_opts[] array const
>   vl: Add missing "hw/boards.h" include
>   hw/southbridge/ich9: Removed unused headers
>   hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
>   hw/timer: Remove unused "ui/console.h" header
>   hw/usb/dev-storage: Remove unused "ui/console.h" header
>   hw/i386/intel_iommu: Remove unused includes
>   hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
>   hw/alpha/dp264: Include "net/net.h"
>   hw/hppa/machine: Include "net/net.h"
>   hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
>   hw/timer/hpet: Include "exec/address-spaces.h"
>   hw/pci-host/q35: Include "qemu/range.h"
>   hw/i2c/smbus_ich9: Include "qemu/range.h"
>   hw/pci-host/piix: Include "qemu/range.h"
>   hw/acpi: Include "hw/mem/nvdimm.h"
>   hw/i386: Include "hw/mem/nvdimm.h"
>   hw/pci-host/q35: Remove unused includes
>   hw/i386/pc: Clean up includes
>=20
>  Makefile                          |  3 ---
>  block/file-posix.c                |  1 -
>  block/stream.c                    |  3 +--
>  fsdev/virtfs-proxy-helper.c       |  2 +-
>  hw/acpi/cpu_hotplug.c             |  1 +
>  hw/acpi/ich9.c                    |  2 +-
>  hw/acpi/piix4.c                   |  1 +
>  hw/alpha/alpha_sys.h              |  1 -
>  hw/alpha/dp264.c                  |  1 +
>  hw/audio/fmopl.c                  |  4 ++--
>  hw/core/qdev.c                    |  2 +-
>  hw/display/exynos4210_fimd.c      |  1 -
>  hw/display/pxa2xx_lcd.c           |  1 -
>  hw/dma/xlnx-zdma.c                | 10 +++++-----
>  hw/hppa/machine.c                 |  1 +
>  hw/i2c/smbus_ich9.c               |  1 +
>  hw/i386/acpi-build.c              |  1 +
>  hw/i386/pc.c                      |  1 +
>  hw/i386/pc_piix.c                 |  1 +
>  hw/i386/pc_q35.c                  |  1 +
>  hw/isa/lpc_ich9.c                 |  1 -
>  hw/net/dp8393x.c                  |  4 ++--
>  hw/net/e1000.c                    |  6 ++++--
>  hw/net/e1000e_core.c              |  6 ++++--
>  hw/pci-host/i440fx.c              |  1 +
>  hw/pci-host/q35.c                 |  1 +
>  hw/rtc/twl92230.c                 |  1 -
>  hw/scsi/scsi-disk.c               |  1 -
>  hw/timer/hpet.c                   |  2 +-
>  hw/usb/dev-storage.c              |  1 -
>  include/hw/i386/ich9.h            |  1 -
>  include/hw/i386/intel_iommu.h     |  4 ----
>  include/hw/i386/ioapic_internal.h |  1 -
>  include/hw/i386/pc.h              | 11 +++--------
>  include/hw/pci-host/q35.h         |  8 +-------
>  monitor/hmp-cmds.c                |  5 +----
>  rules.mak                         |  3 +++
>  scripts/git.orderfile             |  1 +
>  softmmu/vl.c                      |  1 +
>  39 files changed, 43 insertions(+), 55 deletions(-)
>=20
> --=20
> 2.24.1


