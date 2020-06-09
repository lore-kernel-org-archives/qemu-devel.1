Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB22C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25363206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/AJIMjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25363206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihNe-0003mt-9P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihGj-00028P-Gt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:38:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihGh-0002px-N3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmQS4Awqs0tpfZnB1AcZyyXTBW2D7QIAYMLz9e7B0j4=;
 b=X/AJIMjdgHMFMsdJTb0yQ5Fo2nTlivxWkT1JHIDlXoa8emcUlROmXIqisHBhQOX1OXuU7K
 XA9SQto+Oia0YaB7aedpDu9mq/fQ8+Guoa0MOkbN8Ox9yXZTw9+++1tDke0S4lI654R/fl
 w4KRwrjthQHe4Vzo5STZNkhOzy802Lk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-iltg3GG3P2C83l49cM93Pw-1; Tue, 09 Jun 2020 12:38:13 -0400
X-MC-Unique: iltg3GG3P2C83l49cM93Pw-1
Received: by mail-wr1-f70.google.com with SMTP id l18so8879585wrm.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jmQS4Awqs0tpfZnB1AcZyyXTBW2D7QIAYMLz9e7B0j4=;
 b=QaMFXGQvsyWwfrRuiyYOimosa5wXCa9/VJDIw0KuXTNhwotJVMk6hb4q2VyX7Xgkr/
 fpACbbfjTD+EgiGhEBNErG3f2X7oag4DrJy7ctjemOYePS3/0tlxFrZdPHCUoELlREnz
 AtuwvW1FsGq45gAt/M8kiQqkyOGx8m76OypGPoUTqf9oxM2F56BO1XFEX5QrCzoN+XmI
 6e/C9gqMs8hNK+E24hRPhjdt+WJ2SuSjPBcf12WYJsSaSV0DgTaZNBzfH1vu2vGgtpP/
 oAay8ocpK1ljLoovEtNKLMoqp+X9CFX/18L02158Wb05z4bVYyeKVJAAc/y1rnxjc2Ir
 cByQ==
X-Gm-Message-State: AOAM533o9/uBfrc15AchEQ4YOvB1jyjOxG4Fs/jMEhq2kHuuPuE1uQbn
 PVt6Ez9OAZPoNxMFhUEoYTqIfmOoJ6ulXGWZSekfqRFOGPqrIEzRngwuvpxus8lZTHAZQTw5qLx
 9kOrHwka0BKJ3XjA=
X-Received: by 2002:adf:fd49:: with SMTP id h9mr5569335wrs.67.1591720691813;
 Tue, 09 Jun 2020 09:38:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzha9qxqaFWvIZgLeU/9K9aUIsuXvB892m5yR+CrHTdBrxARxcqvhq3PQtmRkOXrdofzzPQBA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr5569254wrs.67.1591720690651;
 Tue, 09 Jun 2020 09:38:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id o8sm3561448wmb.20.2020.06.09.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:38:10 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:38:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [PATCH v7 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
Message-ID: <20200609123738-mutt-send-email-mst@kernel.org>
References: <20200520093629.1495-1-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200520093629.1495-1-miaoyubo@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 05:36:21PM +0800, Yubo Miao wrote:
> Changes with v6
> v6->v7:
> Refactor fw_cfg_write_extra_pci_roots
> Add API PCI_GET_PCIE_HOST_STATE
> Fix typos
> 
> I have one question for patch
> [PATCH v7 8/8] unit-test: Add the binary file and clear diff.
> 
> I followed instructions in tests/qtest/bios-tables-test.c
> to updated golden master binaries and empty
> tests/qtest/bios-tables-test-allowed-diff.h.
> 
> However, checkpatch.pl would report the error
> ERROR: Do not add expected files together with tests.
> 
> Does the error matters?

It doesn't - should be fixed on master.
But I see other checkpatch errors.
Can you address them and repost pls?

> Changes with v5
> v5->v6: stat crs_range_insert in aml_build.h
> 
> Changes with v4
> v4->v5: Not using specific resources for PXB.
> Instead, the resources for pxb are composed of the bar space of the
> pci-bridge/pcie-root-port behined it and the config space of devices
> behind it.
> 
> Only if the bios(uefi for arm) support multiple roots,
> configure space of devices behind pxbs could be obtained.
> The uefi work is updated for discussion by the following link:
> https://edk2.groups.io/g/devel/message/56901?p=,,,20,0,0,0::Created,,add+extra+roots+for+Arm,20,2,0,72723351
> [PATCH] ArmVirtPkg/FdtPciHostBridgeLib: add extra roots for Arm.
> 
> Currently pxb-pcie is not supported by arm,
> the reason for it is pxb-pcie is not described in DSDT table
> and only one main host bridge is described in acpi tables,
> which means it is not impossible to present different io numas
> for different devices.
> 
> This series of patches make arm to support PXB-PCIE.
> 
> Users can configure pxb-pcie with certain numa, Example command
> is:
> 
>    -device pxb-pcie,id=pci.7,bus_nr=128,numa_node=0,bus=pcie.0,addr=0x9
> 
> Yubo Miao (8):
>   acpi: Extract two APIs from acpi_dsdt_add_pci
>   fw_cfg: Write the extra roots into the fw_cfg
>   acpi: Extract crs build form acpi_build.c
>   acpi: Refactor the source of host bridge and build tables for pxb
>   acpi: Align the size to 128k
>   unit-test: The files changed.
>   unit-test: Add testcase for pxb
>   unit-test: Add the binary file and clear diff.h
> 
>  hw/acpi/aml-build.c            | 275 +++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c       | 249 +++++++++++++++++++++-------
>  hw/arm/virt.c                  |   8 +
>  hw/i386/acpi-build.c           | 285 ---------------------------------
>  hw/i386/pc.c                   |  18 +--
>  hw/nvram/fw_cfg.c              |  20 +++
>  include/hw/acpi/aml-build.h    |  25 +++
>  include/hw/nvram/fw_cfg.h      |   2 +
>  include/hw/pci/pcie_host.h     |   4 +
>  tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 7802 bytes
>  tests/qtest/bios-tables-test.c |  58 ++++++-
>  11 files changed, 579 insertions(+), 365 deletions(-)
>  create mode 100644 tests/data/acpi/virt/DSDT.pxb
> 
> -- 
> 2.19.1
> 


