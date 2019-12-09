Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B654620637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxdAu3bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iePwM-0001mo-PS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 15:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iePvc-0001NT-OQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iePva-0008GG-7c
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:46:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iePvZ-0008Fl-KB
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575924404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/0Y9FLgiKnD4NnOmgIKfAruN6baA0eABW4zYQhHYWw=;
 b=LxdAu3bSqVl19bwcvlluMS20BTsEyFYdQvnorwqAA3kQJwTq7tUI9t+uj9l14SYCi1/qO6
 ST6WCyfNoNW4L8LZPLPty7qTxG5ENGCy4Ck0JggWoQpVsX6TXMridRryT+Bz9Dc6jSj4DD
 WxswSdKPS5sQfhodZPmL9ByDkJqVU9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-ezfBepjVNT6RgQaJh30KPA-1; Mon, 09 Dec 2019 15:46:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30386800EB7
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 20:46:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 709826055E;
 Mon,  9 Dec 2019 20:46:35 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 9/9] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD
 command
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
 <1575896942-331151-10-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3bf8e847-2190-8fe9-6637-5d1834fc9244@redhat.com>
Date: Mon, 9 Dec 2019 21:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575896942-331151-10-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ezfBepjVNT6RgQaJh30KPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 14:09, Igor Mammedov wrote:
> Firmware can enumerate present at boot APs by broadcasting wakeup IPI,
> so that woken up secondary CPUs could register them-selves.
> However in CPU hotplug case, it would need to know architecture
> specific CPU IDs for possible and hotplugged CPUs so it could
> prepare environment for and wake hotplugged AP.
> 
> Reuse and extend existing CPU hotplug interface to return architecture
> specific ID for currently selected CPU in 2 registers:
>  - lower 32 bits in ACPI_CPU_CMD_DATA_OFFSET_RW
>  - upper 32 bits in ACPI_CPU_CMD_DATA2_OFFSET_R
> 
> On x86, firmware will use CPHP_GET_CPU_ID_CMD for fetching the APIC ID
> when handling hotplug SMI.
> 
> Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
> which serves the similar to APIC ID purpose.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v1:
>  - s/ACPI_CPU_CMD_DATA2_OFFSET_RW/ACPI_CPU_CMD_DATA2_OFFSET_R/.
> v2:
>  - ACPI_CPU_CMD_DATA2_OFFSET_R moved into separate patch
>    that adds 'Command data 2' field separately
>  - ammend commit message
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 3 +++
>  hw/acpi/cpu.c                   | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index cb99cf3..a8ce5e7 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -47,6 +47,7 @@ read access:
>      [0x0-0x3] Command data 2: (DWORD access)
>                if value last stored in 'Command field':
>                  0: reads as 0x0
> +                3: upper 32 bits of architecture specific CPU ID value
>                  other values: reserved
>      [0x4] CPU device status fields: (1 byte access)
>          bits:
> @@ -61,6 +62,8 @@ read access:
>      [0x8] Command data: (DWORD access)
>            contains 0 unless value last stored in 'Command field' is one of:
>                0: contains 'CPU selector' value of a CPU with pending event[s]
> +              3: lower 32 bits of architecture specific CPU ID value
> +                 (in x86 case: APIC ID)
>  
>  write access:
>      offset:
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index d475c06..e2c957c 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -18,6 +18,7 @@ enum {
>      CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
>      CPHP_OST_EVENT_CMD = 1,
>      CPHP_OST_STATUS_CMD = 2,
> +    CPHP_GET_CPU_ID_CMD = 3,
>      CPHP_CMD_MAX
>  };
>  
> @@ -75,6 +76,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>          case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
>             val = cpu_st->selector;
>             break;
> +        case CPHP_GET_CPU_ID_CMD:
> +           val = cdev->arch_id & 0xFFFFFFFF;
> +           break;
>          default:
>             break;
>          }
> @@ -85,6 +89,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>          case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
>             val = 0;
>             break;
> +        case CPHP_GET_CPU_ID_CMD:
> +           val = cdev->arch_id >> 32;
> +           break;
>          default:
>             break;
>          }
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


