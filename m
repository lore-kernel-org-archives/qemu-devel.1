Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AB4206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB4206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dLL-0004LJ-3r
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1i2cwU-0003UM-OB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1i2cwR-0003qO-Tq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1i2cwP-0003Yi-3Q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:26 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C83F32A09D3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 14:58:58 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m26so1153042wmc.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 07:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=AczsstH8QJNbtrRDmgZq9nyXUy9ZzeqTwm1Sa/Pzim0=;
 b=pIy5ZWnh8DI/yUeK3bGzptyVUDbyLhPfhYPmmN6R4tCtImaU00jcGz75osFJ9u1f0L
 J3ZXuFi1C0x8ZoZHoU8BeaO8mq65jjwvnTq1I612GUTXXnWdPH1W8pCWj01CsJvekgfG
 rkCm6VD0W7ka2Yjxp//4VxFPGSD05qe+3a1AGfDJEXlR0t4dUNHCh5MzkQj6IG6OJEMk
 fWMrbCiQTdSdQeadeJtwHWNxiE/TUAOiRdJMSt6Jl14S3qTe9wcKCKmX732ocrExFPeb
 FXygbcOvmekCqjUM5Nf3zuXgxMwxxj39nDLueFMVCW31xbdYVHzg0I1XRSnOcXujgfVy
 xeZw==
X-Gm-Message-State: APjAAAXfI7aGqjo0nd5lq0QAHmL+YbZqagPqkTXwFTm430IHIZJmDi7e
 N/4pavPG94t4VG2jtbkEGUsDUYRk6ezPgRJy+tEOjOKPvZsbngnkEZB0GCBa00j0WNAUjILqHTI
 ehBiXIKxLDUpgx0o=
X-Received: by 2002:a5d:404d:: with SMTP id w13mr29934573wrp.253.1566917937586; 
 Tue, 27 Aug 2019 07:58:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCQSdYQA/1m07wx/MfwWwqI9xwggDS36ZL50CRXAqLq5MM6VZGY7GiT8M7zLP1pS7goKVWow==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr29934558wrp.253.1566917937345; 
 Tue, 27 Aug 2019 07:58:57 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id z1sm19534398wrp.51.2019.08.27.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 07:58:56 -0700 (PDT)
Message-ID: <c87583f3e8487100fdb8196ad45e6375cc877e3b.camel@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 16:58:56 +0200
In-Reply-To: <0dc1a87882d78b071134dba7787d4459b48ed096.camel@gmail.com>
References: <0dc1a87882d78b071134dba7787d4459b48ed096.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v5 0/6] pci_expander_brdige: support separate
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2018-09-17 at 22:57 +0800, Zihan Yang wrote:
> Hi all
> 
> Here is a minimal working version of supporting multiple pci domains.

Hi Zihan,
Do you plan to continue working on this project?

I am interested in it, and if you do not mind I would like to finish
the project, retaining your authorship. I am going to take care
of this patch set, and the one in SeaBios too.
How does it sound to you?

Any tips and clues are welcomed.

Best regards, Julia Suvorova.

> The next a few paragraphs will illustrate the purpose and use
> example.
> Current issue and limitations will be in last 2 paragraphs, followed
> by the changelog of each verison.
> 
> Currently only q35 host bridge is allocated an item in MCFG table,
> all
> pxb-pcie host bridges stay within pci domain 0. This series of
> patches
> allow each pxb-pcie to be put in separate pci domain, allocating a
> new
> MCFG table item for it.
> 
> Users can configure whether to put pxb host bridge into separate
> domain
> by specifying property 'domain_nr' of pxb-pcie device. 'bus_nr'
> property
> indicates the Base Bus Number(BBN) of the pxb-pcie host bridge.
> Another
> property max_bus specifies the maximum desired bus numbers to reduce
> MCFG space cost. Example command is
> 
>     -device pxb-pcie,id=bridge3,bus="pcie.0",domain_nr=1,max_bus=15
> 
> Then this pxb-pcie host bridge is placed at pci domain 1, and only 
> reserve
> (15+1)=16 buses, which is much smaller than the default 256 buses.
> 
> Compared with previous version, this version is much simpler because
> mcfg of extra domain now has a relatively fixed address, as suggested
> by Marcel and Gerd. Putting extra mmconfig above 4G and let seabios
> leave them for guest os will be expected in next version. The range
> is
> [0x80000000, 0xb0000000), which allows us to hold 4x busses compared
> with before.
> 
> A complete command line for test is follows, you need to replace 
> GUEST_IMAGE,
> DATA_IMAGE and SEABIOS_BIN with proper environment variable
> 
> ./x86_64-softmmu/qemu-system-x86_64 \
>     -machine q35,accel=kvm -smp 2 -m 2048 \
>     -drive file=${GUEST_IMAGE}  -netdev user,id=realnet0 \
>     -device e1000e,netdev=realnet0,mac=52:54:00:12:34:56 \
>     -device pxb-pcie,id=bridge3,bus="pcie.0",domain_nr=1 \
>     -device pcie-root-
> port,id=rp1,bus=bridge3,addr=1c.0,port=8,chassis=8 
> \
>     -drive if=none,id=drive0,file=${DATA_IMAGE} \
>     -device virtio-scsi-pci,id=scsi,bus=rp1,addr=00.0 \
>     -bios ${SEABIOS_BIN}
> 
> There are a few limitations, though
> 1. Legacy interrupt routing is not dealt with yet. There is only
> support 
> for
>    devices using MSI/MSIX
> 2. Only 4x devices is supported, you need to be careful not to
> overuse
> 3. I have not fully tested the functionality of devices under
> separate 
> domain
>    yet, but Linux can recognize then when typing `lspci`
> 
> Current issue:
> * SCSI storage device will be recognized twice, one in domain 0 as 
> 0000:01.0,
>   the other in domain 1 as 0001:01.0. I will try to fix it in next 
> version
> 
> v5 <- v4:
> - Refactor the design and place pxb-pcie's mcfg in [0x80000000, 
> 0xb0000000)
> - QEMU only decides the desired mcfg_size and leaves mcfg_base for 
> seabios
> - Does not connect PXBDev and PXBPCIEHost with link property
> anymore, 
> but
>   with the pcibus under them, which makes code simpler.
> 
> v4 <- v3:
> - Fix bug in setting mcfg table
> - bus_nr is not used when pxb-pcie is in a new pci domain
> 
> v3 <- v2:
> - Replace duplicate properties in pxb pcie host with link property
> to 
> PXBDev
> - Allow seabios to access config space and data space of expander
> bridge
>   through a different ioport, because 0xcf8 is attached only to
> sysbus.
> - Add a new property start_bus to indicate the BBN of pxb host
> bridge. 
> The
>   bus_nr property is used as the bus number of pxb-pcie device on
> pcie.0 
> bus
> 
> v2 <- v1:
> - Allow user to configure whether to put pxb-pcie into seperate
> domain
> - Add AML description part of each host bridge
> - Modify the location of MCFG space to between RAM hotplug and pci 
> hole64
> 
> Many thanks to 
> Please let me know if you have any suggestions.
> 
> Zihan Yang (6):
>   pci_expander_bridge: add type TYPE_PXB_PCIE_HOST
>   pci_expander_bridge: add domain_nr and max_bus property for pxb-
> pcie
>   acpi-build: allocate mcfg for pxb-pcie host bridges
>   i386/acpi-build: describe new pci domain in AML
>   pci_expander_bridge: add config_write callback for pxb-pcie
>   pci_expander_bridge: inform seabios of desired mcfg size via hidden
>     bar
> 
>  hw/i386/acpi-build.c                        | 162 
> ++++++++++++++++++--------
>  hw/pci-bridge/pci_expander_bridge.c         | 172 
> +++++++++++++++++++++++++++-
>  hw/pci/pci.c                                |  30 ++++-
>  include/hw/pci-bridge/pci_expander_bridge.h |  25 ++++
>  include/hw/pci/pci.h                        |   2 +
>  include/hw/pci/pci_bus.h                    |   2 +
>  include/hw/pci/pci_host.h                   |   2 +-
>  7 files changed, 336 insertions(+), 59 deletions(-)
>  create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
> 


