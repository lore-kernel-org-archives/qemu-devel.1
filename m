Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8465AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E7E20756
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E7E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRHH-00084d-M2
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ard.biesheuvel@arm.com>)
 id 1kaQmu-0003qA-9t; Wed, 04 Nov 2020 16:57:52 -0500
Received: from foss.arm.com ([217.140.110.172]:36988)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@arm.com>)
 id 1kaQmr-0000et-O7; Wed, 04 Nov 2020 16:57:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C4C14BF;
 Wed,  4 Nov 2020 13:57:43 -0800 (PST)
Received: from [192.168.1.81] (unknown [10.37.8.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6273F719;
 Wed,  4 Nov 2020 13:57:40 -0800 (PST)
Subject: Re: Question on UEFI ACPI tables setup and probing on arm64
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ying Fang <fangying1@huawei.com>
References: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
 <20201103133913.1fee3337@redhat.com>
 <a79383a6-92d4-5b10-d143-414543caab70@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <a21964bc-d603-9a3c-1012-627088688ce1@arm.com>
Date: Wed, 4 Nov 2020 22:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a79383a6-92d4-5b10-d143-414543caab70@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=ard.biesheuvel@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 16:57:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Nov 2020 17:28:39 -0500
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Drew Jones <drjones@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "wangzhigang17@huawei.com" <wangzhigang17@huawei.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 10:46 PM, Laszlo Ersek wrote:
...
> 
> (9) (Ard, please correct the below if necessary; thanks.)
> 
> The UEFI stub of the guest kernel (which is a UEFI application) uses a
> device tree as its main communication channel to the (later-started)
> kernel entry point, AIUI.
> 
> The UEFI stub basically inverts the importance of the UEFI system table
> versus the device tree -- the UEFI stub *converts* the UEFI system table
> (the multitude of UEFI config tables) into a device tree. This is my
> understanding anyway.
> 

Not entirely. The UEFI stub uses DT to communicate with the kernel 
proper, just like a non-EFI bootloader does. There are two pieces of 
information regarding EFI that the stub passes via the device tree:
- the EFI system table address
- the EFI memory map (address, size, descriptor size etc)

(Aside: unfortunately, we cannot pass the latter information via a EFI 
configuration table, given that we call SetVirtualAddressMap() in the 
stub, which causes the config_tables member of the system table to be 
converted into a virtual address. That virtual address can only be 
converted into a physical address if we have access to the EFI memory map.)

All other information passed between the EFI stub and the kernel proper 
is passed via Linux-specific EFI configuration tables.

> (9a) If ACPI was disabled on the QEMU command line, then the guest
> kernel *adopts* the device tree that was forwarded to it in (6), via the
> UEFI config table marked with DEVICE_TREE_GUID.
> 

Yes, although the EFI stub updates/augments it with the two data items 
mentioned above, as well as the kernel command line, initrd base and 
size and a KASLR seed [if enabled].

> (9b) If ACPI was enabled on the QEMU command line, then the UEFI stub
> creates a brand new (empty) device tree (AIUI).
>

... unless GRUB executed first and loaded a initrd, and passed this 
information via the device tree. In this case, GRUB creates an empty DT 
(Note that I posted the GRUB patches to implement LoadFile2 based initrd 
loading just a week or so ago)

> Either way, the UEFI system table is linked *under* the -- adopted or
> new -- device tree, through the "chosen" node. And so, if ACPI was
> enabled, the ACPI RSD PTR (coming from step (7)) becomes visible to the
> kernel proper as well, through the UEFI config table with
> ACPI_20_TABLE_GUID.
> 
> I believe this is implemented under "drivers/firmware/efi/libstub" in
> the kernel tree.
> 
> Thanks,
> Laszlo
> 


