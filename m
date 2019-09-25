Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD322054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD322054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD967-0001f9-41
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iD8w9-0001dZ-6g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iD8w7-0007JT-0w
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iD8w4-0007Fr-8A; Wed, 25 Sep 2019 11:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 608E8315C037;
 Wed, 25 Sep 2019 15:10:30 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D503D10027B8;
 Wed, 25 Sep 2019 15:10:02 +0000 (UTC)
Date: Wed, 25 Sep 2019 17:09:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v11 09/11] docs/specs: Add ACPI GED
 documentation
Message-ID: <20190925170959.399b7302@Igors-MacBook-Pro>
In-Reply-To: <20190918130633.4872-10-shameerali.kolothum.thodi@huawei.com>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
 <20190918130633.4872-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 25 Sep 2019 15:10:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Sep 2019 14:06:31 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Documents basic concepts of ACPI Generic Event device(GED)
> and interface between QEMU and the ACPI BIOS.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Addressed Peter's comments,
>  -changed to rst format.
>  -typo/grammer corrections.
> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst | 70 ++++++++++++++++++++++++++
>  docs/specs/index.rst                   |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 docs/specs/acpi_hw_reduced_hotplug.rst
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> new file mode 100644
> index 0000000000..911a98255b
> --- /dev/null
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -0,0 +1,70 @@
> +==================================================
> +QEMU and ACPI BIOS Generic Event Device interface
> +==================================================
> +
> +The ACPI *Generic Event Device* (GED) is a HW reduced platform
> +specific device introduced in ACPI v6.1 that handles all platform
> +events, including the hotplug ones. GED is modelled as a device
> +in the namespace with a _HID defined to be ACPI0013. This document
> +describes the interface between QEMU and the ACPI BIOS.
> +
> +GED allows HW reduced platforms to handle interrupts in ACPI ASL
> +statements. It follows a very similar approach to the _EVT method
> +from GPIO events. All interrupts are listed in  _CRS and the handler
> +is written in _EVT method. However, the QEMU implementation uses a
> +single interrupt for the GED device, relying on an IO memory region
> +to communicate the type of device affected by the interrupt. This way,
> +we can support up to 32 events with a unique interrupt.
> +
> +**Here is an example,**
> +
> +::
> +
> +   Device (\_SB.GED)
> +   {
> +       Name (_HID, "ACPI0013")
> +       Name (_UID, Zero)
> +       Name (_CRS, ResourceTemplate ()
> +       {
> +           Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
> +           {
> +               0x00000029,
> +           }
> +       })
> +       OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
> +       Field (EREG, DWordAcc, NoLock, WriteAsZeros)
> +       {
> +           ESEL,   32
> +       }
> +       Method (_EVT, 1, Serialized)
> +       {
> +           Local0 = ESEL // ESEL = IO memory region which specifies the
> +                         // device type.
> +           If (((Local0 & One) == One))
> +           {
> +               MethodEvent1()
> +           }
> +           If ((Local0 & 0x2) == 0x2)
> +           {
> +               MethodEvent2()
> +           }
> +           ...
> +       }
> +   }
> +
> +GED IO interface (4 byte access)
> +--------------------------------
> +**read access:**
> +
> +::
> +
> +   [0x0-0x3] Event selector bit field (32 bit) set by QEMU.
> +
> +    bits:
> +       0: Memory hotplug event
> +       1: System power down event
> +    2-31: Reserved
> +
> +**write_access:**
> +
> +Nothing is expected to be written into GED IO memory
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 40adb97c5e..984ba44029 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -12,3 +12,4 @@ Contents:
>  
>     ppc-xive
>     ppc-spapr-xive
> +   acpi_hw_reduced_hotplug


