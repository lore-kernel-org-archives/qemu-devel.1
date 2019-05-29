Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3F5C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4267E24257
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4267E24257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33379 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW6fM-0003Xo-C9
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 18:03:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW6eJ-00030U-1m
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW6eH-0003IG-LH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:02:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW6eG-0003GF-5n
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:02:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so4626505qtf.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 15:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=mrv9r7Syv0tTJaqEsFyMFQe8Ib2tnQobfxmhabffb+s=;
	b=bUjLfVfQu05/Z+vTB5Na6N36sBNiLYVXaSzqHh+lIq3366EeK3PYdbNq9E1AYQI+CC
	U4C/7iCAQPM/LuYrb1X9yQ4sLvIKfL+IpzONQ9G+aAjVOB/4EsMJIK2c2BQJqqxkSnUA
	/s92OgFvf5KlhJLEMhAV8MNH3XrGtvfKPgSxh+aI/Q9Qu+nRdaJ9V+60mQ5aZdZ7vs15
	SEa7UJZWWzl947zx8FZonlCA8NKslt3j78AENoWDd8+bz6C2cIL5RfI3fTO7LjpmKsxh
	KQGNErgQ5rMqW5oXD4o9C+LN7n37ZjkYTvfhUPS2UVwwU74/BWOlLwBTjHx95QK/bzmb
	qynA==
X-Gm-Message-State: APjAAAWQmHfmUnHh46dWhk7IPDzd+/JoIc8CfJu0lt5oxe1P7x62M62u
	X4QnpYQ2I/g0NDpff/h7oa368wfMdio=
X-Google-Smtp-Source: APXvYqy5iAWwJfJi80ii2mFF+S/nSAlg6DbQs3hn3tZaS06SZEgvnowIj5WO4utr27OvrZ4T5t4Pfg==
X-Received: by 2002:a0c:a902:: with SMTP id y2mr304049qva.42.1559167332908;
	Wed, 29 May 2019 15:02:12 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id p64sm464375qkf.60.2019.05.29.15.02.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 15:02:11 -0700 (PDT)
Date: Wed, 29 May 2019 18:02:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190529180143-mutt-send-email-mst@kernel.org>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PULL 00/10] virtio, pci, pc: cleanups
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

On Wed, May 29, 2019 at 12:37:07PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
> 
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 8828a019eec52858140c7368494fb1523971cd5f:


Minor fixup: new commit ab50f22309a17c772c51931940596e707c200739

>   vhost: fix memory leak in vhost_user_scsi_realize (2019-05-29 12:34:45 -0400)
> 
> ----------------------------------------------------------------
> virtio, pci, pc: cleanups
> 
> not a lot going on, just some cleanups all over the place
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> David Gibson (3):
>       pcie: Simplify pci_adjust_config_limit()
>       pci: Make is_bridge a bool
>       pci: Fold pci_get_bus_devfn() into its sole caller
> 
> Igor Mammedov (1):
>       docs: smbios: remove family=x from type2 entry description
> 
> Jie Wang (3):
>       vhost: remove the dead code
>       vhost: fix incorrect print type
>       vhost: fix memory leak in vhost_user_scsi_realize
> 
> Michael S. Tsirkin (1):
>       bios-tables-test: add diff allowed list
> 
> Wei Yang (2):
>       hw/acpi: Consolidate build_mcfg to pci.c
>       acpi: pci: use build_append_foo() API to construct MCFG
> 
>  default-configs/i386-softmmu.mak      |   1 +
>  include/hw/acpi/acpi-defs.h           |  18 ------
>  include/hw/acpi/pci.h                 |   1 +
>  include/hw/pci/pci.h                  |   3 +-
>  include/hw/pci/pci_bus.h              |   8 ++-
>  tests/bios-tables-test-allowed-diff.h |   1 +
>  hw/acpi/pci.c                         |  61 ++++++++++++++++++++
>  hw/arm/virt-acpi-build.c              |  17 ------
>  hw/i386/acpi-build.c                  |  18 +-----
>  hw/pci-bridge/dec.c                   |   4 +-
>  hw/pci-bridge/i82801b11.c             |   2 +-
>  hw/pci-bridge/pci_bridge_dev.c        |   2 +-
>  hw/pci-bridge/pcie_pci_bridge.c       |   2 +-
>  hw/pci-bridge/pcie_root_port.c        |   2 +-
>  hw/pci-bridge/simba.c                 |   2 +-
>  hw/pci-bridge/xio3130_downstream.c    |   2 +-
>  hw/pci-bridge/xio3130_upstream.c      |   2 +-
>  hw/pci/pci.c                          | 101 +++++++++++++++++-----------------
>  hw/pci/pci_host.c                     |  13 +----
>  hw/ppc/spapr_pci.c                    |  34 ++++--------
>  hw/scsi/vhost-user-scsi.c             |   3 +
>  hw/virtio/vhost.c                     |   3 +-
>  tests/bios-tables-test.c              |  20 ++++++-
>  hw/acpi/Kconfig                       |   4 ++
>  hw/acpi/Makefile.objs                 |   1 +
>  hw/arm/Kconfig                        |   1 +
>  qemu-options.hx                       |   2 +-
>  27 files changed, 176 insertions(+), 152 deletions(-)
>  create mode 100644 tests/bios-tables-test-allowed-diff.h
>  create mode 100644 hw/acpi/pci.c
> 

