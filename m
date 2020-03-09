Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E2C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEB72465A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQuKtjPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEB72465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBO8g-00039T-6L
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBO70-0001wq-OM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBO6z-0006Vd-2y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:30:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBO6y-0006U9-TQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583782248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgSJZz+7N/XmtB00LpHxgmUeu7UHgxPmmEpXRLIPeGI=;
 b=WQuKtjPCKQ/IVko2BCpKD2S9mrhybssIfkmVWMmvX+o/tINA5TtjhrgtYmiutClIJ+2UL5
 LGr2inlTs3btXDvlRMtkHegyXg61FIQwNz9uKHLqcG4OARoxc5lYdUml69wGG7zjRaldtN
 gcTOWyqfGPqnaVT1+BDJPIp8/zM9NZY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-spkxaVqVOF2G50y2dCaLPA-1; Mon, 09 Mar 2020 15:30:46 -0400
X-MC-Unique: spkxaVqVOF2G50y2dCaLPA-1
Received: by mail-ed1-f71.google.com with SMTP id v17so5521128eds.18
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 12:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U5+hxV+pTb4wFwWjLPVekY2Ubg939vPBJHcCEcGKxmE=;
 b=paH0aGuSo9QnN23tdcoHDqWxolzIJMenelVu46tuduD39SKA43JjNPKc/efnoaoK9J
 c9SOfcUVFHUM2SQVZSsleol19Wo0OsWV3GTy7KaSoli751uFfubCAJTWCY0q95qz5L+K
 G478GR+S4xH3TIWZeJ/fD6oX4xl7g7KW3g9XwvZkKnuS+R25+ObnA+lsl3NFy4O2JUFw
 o/zN2/VdoRj2G4GC7VZ7VaTtq4fvgbjoPca9o9jW+FwevrqZRpuwNUMKOxmzY7EK2Tpe
 avCuwkfMZHFf+XPg+ILYzCBeEZkPJaGU6S1ovSNR4cW/CY2bsq0HiQMdKHkaJvPnN9Jx
 PJ0w==
X-Gm-Message-State: ANhLgQ3qthoyCSXwTMS1YghnjuGoYk1EblAEWfUEB2GltBgT81/imqMx
 34V3YD/DQkE8sxeGnnfuS3JZmzdVQ+FAV0koDiStXDGqbwdpJddzTWy7GTata+nGOp0SnEXvVAl
 tnl6ufExTTMjrOjk=
X-Received: by 2002:a05:6402:b71:: with SMTP id
 cb17mr2188462edb.190.1583782245387; 
 Mon, 09 Mar 2020 12:30:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQIU11aTSIxU6QqYJC4x0VEsBlbRUF6QtQdM9MSXMeSgCMJFCEH/tgIoL0OKmlv/FLuzmNvw==
X-Received: by 2002:a05:6402:b71:: with SMTP id
 cb17mr2188423edb.190.1583782245110; 
 Mon, 09 Mar 2020 12:30:45 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h17sm1137078ejc.11.2020.03.09.12.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 12:30:44 -0700 (PDT)
Subject: Re: [PULL 00/33] Trivial branch patches
To: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier
 <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
Date: Mon, 9 Mar 2020 20:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309151621-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
>> The following changes since commit 7a5853cec479a448edae0fb2aaf4e2f78c9c7=
74d:
>>
>>    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into sta=
ging (2020-03-09 10:32:53 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>
>> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636bb:
>>
>>    monitor/hmp-cmds: Remove redundant statement in hmp_rocker_of_dpa_gro=
ups() (2020-03-09 15:59:31 +0100)
>=20
>=20
> Could you avoid CC everyone involved on the whole PULL req?
> I was involved in a patch or two and don't really need to see
> the whole series. Just the cover and the relevant patches
> would be enough - if I do want it there's always lore.

I suppose Laurent used git-publish, which has this limitation.

>=20
>> ----------------------------------------------------------------
>> - includes cleanup
>> - reduce .data footprint
>> - fix warnings reported by Clang static code analyzer
>> - fix dp8393x part lost in merge
>> - update git.orderfile and rules.mak
>>
>> ----------------------------------------------------------------
>>
>> Chen Qun (7):
>>    block/stream: Remove redundant statement in stream_run()
>>    block/file-posix: Remove redundant statement in raw_handle_perm_lock(=
)
>>    dma/xlnx-zdma: Remove redundant statement in zdma_write_dst()
>>    scsi/scsi-disk: Remove redundant statement in
>>      scsi_disk_emulate_command()
>>    display/pxa2xx_lcd: Remove redundant statement in
>>      pxa2xx_palette_parse()
>>    display/exynos4210_fimd: Remove redundant statement in
>>      exynos4210_fimd_update()
>>    monitor/hmp-cmds: Remove redundant statement in
>>      hmp_rocker_of_dpa_groups()
>>
>> Eric Blake (1):
>>    maint: Include top-level *.rst files early in git diff
>>
>> Finn Thain (1):
>>    dp8393x: Mask EOL bit from descriptor addresses, take 2
>>
>> Pan Nengyuan (1):
>>    core/qdev: fix memleak in qdev_get_gpio_out_connector()
>>
>> Philippe Mathieu-Daud=C3=A9 (23):
>>    build-sys: Move the print-variable rule to rules.mak
>>    hw/audio/fmopl: Fix a typo twice
>>    hw/net/e1000: Add readops/writeops typedefs
>>    hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>>    virtfs-proxy-helper: Make the helper_opts[] array const
>>    vl: Add missing "hw/boards.h" include
>>    hw/southbridge/ich9: Removed unused headers
>>    hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
>>    hw/timer: Remove unused "ui/console.h" header
>>    hw/usb/dev-storage: Remove unused "ui/console.h" header
>>    hw/i386/intel_iommu: Remove unused includes
>>    hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
>>    hw/alpha/dp264: Include "net/net.h"
>>    hw/hppa/machine: Include "net/net.h"
>>    hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
>>    hw/timer/hpet: Include "exec/address-spaces.h"
>>    hw/pci-host/q35: Include "qemu/range.h"
>>    hw/i2c/smbus_ich9: Include "qemu/range.h"
>>    hw/pci-host/piix: Include "qemu/range.h"
>>    hw/acpi: Include "hw/mem/nvdimm.h"
>>    hw/i386: Include "hw/mem/nvdimm.h"
>>    hw/pci-host/q35: Remove unused includes
>>    hw/i386/pc: Clean up includes
>>
>>   Makefile                          |  3 ---
>>   block/file-posix.c                |  1 -
>>   block/stream.c                    |  3 +--
>>   fsdev/virtfs-proxy-helper.c       |  2 +-
>>   hw/acpi/cpu_hotplug.c             |  1 +
>>   hw/acpi/ich9.c                    |  2 +-
>>   hw/acpi/piix4.c                   |  1 +
>>   hw/alpha/alpha_sys.h              |  1 -
>>   hw/alpha/dp264.c                  |  1 +
>>   hw/audio/fmopl.c                  |  4 ++--
>>   hw/core/qdev.c                    |  2 +-
>>   hw/display/exynos4210_fimd.c      |  1 -
>>   hw/display/pxa2xx_lcd.c           |  1 -
>>   hw/dma/xlnx-zdma.c                | 10 +++++-----
>>   hw/hppa/machine.c                 |  1 +
>>   hw/i2c/smbus_ich9.c               |  1 +
>>   hw/i386/acpi-build.c              |  1 +
>>   hw/i386/pc.c                      |  1 +
>>   hw/i386/pc_piix.c                 |  1 +
>>   hw/i386/pc_q35.c                  |  1 +
>>   hw/isa/lpc_ich9.c                 |  1 -
>>   hw/net/dp8393x.c                  |  4 ++--
>>   hw/net/e1000.c                    |  6 ++++--
>>   hw/net/e1000e_core.c              |  6 ++++--
>>   hw/pci-host/i440fx.c              |  1 +
>>   hw/pci-host/q35.c                 |  1 +
>>   hw/rtc/twl92230.c                 |  1 -
>>   hw/scsi/scsi-disk.c               |  1 -
>>   hw/timer/hpet.c                   |  2 +-
>>   hw/usb/dev-storage.c              |  1 -
>>   include/hw/i386/ich9.h            |  1 -
>>   include/hw/i386/intel_iommu.h     |  4 ----
>>   include/hw/i386/ioapic_internal.h |  1 -
>>   include/hw/i386/pc.h              | 11 +++--------
>>   include/hw/pci-host/q35.h         |  8 +-------
>>   monitor/hmp-cmds.c                |  5 +----
>>   rules.mak                         |  3 +++
>>   scripts/git.orderfile             |  1 +
>>   softmmu/vl.c                      |  1 +
>>   39 files changed, 43 insertions(+), 55 deletions(-)
>>
>> --=20
>> 2.24.1
>=20


