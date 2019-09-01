Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E0C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 11:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043E222CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 11:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043E222CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4NwR-0005Ot-7O
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 07:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i4Nu6-0003mh-MA
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i4Nu5-0003Oe-Gy
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i4Nu1-0003J7-UY; Sun, 01 Sep 2019 07:20:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23E71307D88D;
 Sun,  1 Sep 2019 11:20:13 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0488C600C8;
 Sun,  1 Sep 2019 11:20:09 +0000 (UTC)
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
 <20190813210539.31164-11-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c9d0a573-dde9-569f-7168-abc4260c237f@redhat.com>
Date: Sun, 1 Sep 2019 13:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190813210539.31164-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sun, 01 Sep 2019 11:20:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v9 10/12] docs/specs: Add ACPI GED
 documentation
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,
On 8/13/19 11:05 PM, Shameer Kolothum wrote:
> Documents basic concepts of ACPI Generic Event device(GED)
> and interface between QEMU and the ACPI BIOS.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  docs/specs/acpi_hw_reduced_hotplug.txt | 60 ++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 docs/specs/acpi_hw_reduced_hotplug.txt
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.txt b/docs/specs/acpi_hw_reduced_hotplug.txt
> new file mode 100644
> index 0000000000..46839be5ff
> --- /dev/null
> +++ b/docs/specs/acpi_hw_reduced_hotplug.txt
> @@ -0,0 +1,60 @@
> +QEMU<->ACPI BIOS Generic Event Device interface
> +
> +The ACPI Generic Event Device (GED) is a HW reduced platform
> +specific device introduced in ACPI v6.1 that handles all platform
> +events, including the hotplug ones. GED is modelled as a device
> +in the namespace with a _HID defined to be ACPI0013. This document
> +describes the interface between QEMU and the ACPI BIOS.
> +
> +GED allows HW reduced platforms to handle interrupts in ACPI ASL
> +statements. It follows a very similar approach like the _EVT method
> +from GPIO events. All interrupts are listed in  _CRS and the handler
> +is written in _EVT method. However, Qemu implementation uses a single
> +interrupt for the GED device, relying on IO memory region to communicate
> +the type of device affected by the interrupt. This way, we can support
> +up to 32 events with a unique interrupt.
> +
> +Here is an example.
> +
> +Device (\_SB.GED)
> +{
> +    Name (_HID, "ACPI0013")
> +    Name (_UID, Zero)
> +    Name (_CRS, ResourceTemplate ()
> +    {
> +        Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
> +        {
> +            0x00000029,
> +        }
> +    })
> +    OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
> +    Field (EREG, DWordAcc, NoLock, WriteAsZeros)
> +    {
> +        ESEL,   32
> +    }
> +    Method (_EVT, 1, Serialized)
> +    {
> +        Local0 = ESEL // ESEL = IO memory region which specifies the
> +                      // device type.
> +        If (((Local0 & One) == One))
> +        {
> +            MethodEvent1()
> +        }
> +        If ((Local0 & 0x2) == 0x2)
> +        {
> +            MethodEvent2()
> +        }
> +        ...
> +    }
> +}
> +
> +GED IO interface (4 byte access):
> +read access:
> +    [0x0-0x3] Event selector bit field(32 bit) set by Qemu.
> +    bits:
> +        1:  Memory hotplug event
> +        2:  System power down event
> +     3-31:  Reserved
> +
> +write_access:
> +    Nothing is expected to be written into GED IO memory
> 

