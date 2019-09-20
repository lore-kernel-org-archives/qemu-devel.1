Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CABAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE47207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE47207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHLB-0005fY-6c
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBHK7-0005Cz-4q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBHK5-0006y3-Qo
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBHK5-0006xn-KU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:43:37 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6935536955
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 11:43:36 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f63so914608wma.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 04:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UOeyCixWlVKBny8saakoSeNBzdnd2BLTsaQUVYjlXn0=;
 b=C8oHhYtBygfb9lYo4jpT+BnIUA9xR+TeBDGEchCdFupJauMVfL5dPr7aKqmjt9MlK8
 Sn5+67W6vrRWH+tvmObX5XPmpGv4IFQWtqZereqMTd024OdObyxFnQEoOrDExDYnqbF/
 BQlravYws9ejoaY6pxGHSSy6mSEJrPLksbljBxxGN4bt3cQjrhj3Ew/7uvBNinm7oOEW
 8Lb/GK9+DRODolOUA1kyfBZgNTIRJWXia+MGbEncpk+c/F3RK3U8QXkbwb8LJjNd8biW
 1HUz5p0hXbHHuBzqTdsQkUM719I2BYwqvScgKhluWEHHxUm01NAmiGv6Zxd/Tn+473gJ
 +hkg==
X-Gm-Message-State: APjAAAUGBhj0D75yK+d4mbznGofl9ZeDmju9G7gbVMWlNKWdBpVvXWbQ
 8NOo/1OTekANnOc3z+ePAFN5qh9RnBT65SHp4L6A14bsIM/hDWasS0koVn1YpQbSrasv+ZgX3eJ
 gR5eDKOUfFYlmYto=
X-Received: by 2002:adf:ec86:: with SMTP id z6mr11877942wrn.231.1568979814984; 
 Fri, 20 Sep 2019 04:43:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD6RMjBqp+sq4u+BiqD/R7f/wT0p4gLeYkkcsVJoWCn/MieYiGnjCHdHN2MESqjsVihU6zJg==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr11877917wrn.231.1568979814669; 
 Fri, 20 Sep 2019 04:43:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id g11sm1878208wmh.45.2019.09.20.04.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 04:43:33 -0700 (PDT)
Subject: Re: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2e9b4b2e-ac56-6039-a800-fbdc48ca1958@redhat.com>
Date: Fri, 20 Sep 2019 13:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 23:39, minyard@acm.org wrote:
> I haven't gotten a lot of commentary on this, but I assume that means
> that everything is ok.  It's been posted a few times and the last time
> I received no issues, just a couple of reviews.  I would like more
> review.  But I'm not quite sure what to do about that, I've been
> hanging on to these changes far too long.

It's just that not many people here are IPMI-savvy.  I took a quick look
at patches 5 and 15, and they look fine.

Paolo

> The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-19
> 
> for you to fetch changes up to d9b74295c6528fd68cebdea116b283e46543b2a2:
> 
>   pc: Add an SMB0 ACPI device to q35 (2019-09-19 14:41:58 -0500)
> 
> ----------------------------------------------------------------
> ipmi: Some bug fixes and new interfaces
> 
> Some bug fixes for the watchdog and hopeful the BT tests.
> 
> Change the IPMI UUID handling to give the user the ability to set it or
> not have it.
> 
> Add a PCI interface.
> 
> Add an SMBus interfaces.
> 
> -corey
> 
> ----------------------------------------------------------------
> Corey Minyard (15):
>       ipmi: Fix watchdog NMI handling
>       ipmi: Fix the get watchdog command
>       ipmi: Generate an interrupt on watchdog pretimeout expiry
>       tests:ipmi: Fix IPMI BT tests
>       qdev: Add a no default uuid property
>       ipmi: Add a UUID device property
>       ipmi: Split out KCS-specific code from ISA KCS code
>       ipmi: Split out BT-specific code from ISA BT code
>       ipmi: Allow a size value to be passed for I/O space
>       smbios:ipmi: Ignore IPMI devices with no fwinfo function
>       ipmi: Add PCI IPMI interfaces
>       ipmi: Add an SMBus IPMI interface
>       acpi: Add i2c serial bus CRS handling
>       ipmi: Fix SSIF ACPI handling to use the right CRS
>       pc: Add an SMB0 ACPI device to q35
> 
>  default-configs/i386-softmmu.mak |   3 +
>  hw/acpi/aml-build.c              |  40 ++++
>  hw/acpi/ipmi-stub.c              |   2 +-
>  hw/acpi/ipmi.c                   |  13 +-
>  hw/i386/Kconfig                  |   3 +
>  hw/i386/acpi-build.c             |  17 +-
>  hw/i386/pc_piix.c                |  12 +-
>  hw/i386/pc_q35.c                 |   9 +-
>  hw/ipmi/Kconfig                  |  15 ++
>  hw/ipmi/Makefile.objs            |   5 +-
>  hw/ipmi/ipmi.c                   |   6 +-
>  hw/ipmi/ipmi_bmc_sim.c           |  30 ++-
>  hw/ipmi/ipmi_bt.c                | 437 ++++++++++++++++++++++++++++++++++++++
>  hw/ipmi/ipmi_kcs.c               | 423 +++++++++++++++++++++++++++++++++++++
>  hw/ipmi/isa_ipmi_bt.c            | 443 ++-------------------------------------
>  hw/ipmi/isa_ipmi_kcs.c           | 419 ++----------------------------------
>  hw/ipmi/pci_ipmi_bt.c            | 146 +++++++++++++
>  hw/ipmi/pci_ipmi_kcs.c           | 146 +++++++++++++
>  hw/ipmi/smbus_ipmi.c             | 384 +++++++++++++++++++++++++++++++++
>  hw/smbios/smbios_type_38.c       |   3 +
>  include/hw/acpi/aml-build.h      |  18 ++
>  include/hw/acpi/ipmi.h           |   2 +-
>  include/hw/i386/pc.h             |   2 +
>  include/hw/ipmi/ipmi.h           |   7 +-
>  include/hw/ipmi/ipmi_bt.h        |  73 +++++++
>  include/hw/ipmi/ipmi_kcs.h       |  76 +++++++
>  include/hw/pci/pci.h             |   1 +
>  include/hw/qdev-properties.h     |   7 +
>  qemu-options.hx                  |  10 +-
>  tests/Makefile.include           |   3 +-
>  tests/data/acpi/q35/DSDT         | Bin 7841 -> 7879 bytes
>  tests/data/acpi/q35/DSDT.bridge  | Bin 7858 -> 7896 bytes
>  tests/data/acpi/q35/DSDT.cphp    | Bin 8304 -> 8342 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm | Bin 9494 -> 9532 bytes
>  tests/data/acpi/q35/DSDT.ipmibt  | Bin 7916 -> 7954 bytes
>  tests/data/acpi/q35/DSDT.memhp   | Bin 9200 -> 9238 bytes
>  tests/data/acpi/q35/DSDT.mmio64  | Bin 8971 -> 9009 bytes
>  tests/data/acpi/q35/DSDT.numamem | Bin 7847 -> 7885 bytes
>  tests/ipmi-bt-test.c             |   6 +-
>  39 files changed, 1902 insertions(+), 859 deletions(-)
>  create mode 100644 hw/ipmi/ipmi_bt.c
>  create mode 100644 hw/ipmi/ipmi_kcs.c
>  create mode 100644 hw/ipmi/pci_ipmi_bt.c
>  create mode 100644 hw/ipmi/pci_ipmi_kcs.c
>  create mode 100644 hw/ipmi/smbus_ipmi.c
>  create mode 100644 include/hw/ipmi/ipmi_bt.h
>  create mode 100644 include/hw/ipmi/ipmi_kcs.h
> 
> 
> 


