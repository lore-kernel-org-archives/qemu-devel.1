Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD6C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C24A20880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C24A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3Dx-0007J4-OA
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:08:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3D1-0006wO-Ix
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG3D0-0007WM-Em
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG3D0-0007W6-71
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:07:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so22448306wrp.2
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ztRdxCjBCaIy4lZ+ehqib0tzAEfz06/vFiOBZddFlI8=;
	b=As8RwRWebMLhejnW3HcLRK1L5mOn5+mmzVop+6euttjsjjDzIbt3WStiQTal+OKy/u
	CY+NV85Ks/1yncpPVqqSt4s/WBGX2lZK3lh5MKvAYYedIGm5DWrQpuB0zqpMXsIsvox0
	Nrx4KMpAk/hQ00PYFdWjhrIfifeRwhDnFXf1bLe6p5DH+KGQGQSvdEWJzAtO/6W0Z93B
	OXGwim4pNG8FeLiew83G0b9vNhuccYNATWh6QL3F3/K8Ly5IrshgfdTatVmnB07ha1uV
	Q4EtoH8CU51XtJ9Sz0T5pQvlnxRgw/PzsMilBNA9Luc7rt0xO0bSTL4y3WEoVVjz8Pkz
	58Pg==
X-Gm-Message-State: APjAAAVdjAtS0G7oyK6V4dEZuwGAQW38y6lsl0G04oej/TopWT6wP8E9
	jh1um6oB3kYDT0PE/aeV2AMfaQ==
X-Google-Smtp-Source: APXvYqzonw9BVUbMjcS3n2laRjEAQEDUQmcnw5NLQHkzeOnqzty99gBPmHmuhQAI1ZrOEq048f5OSQ==
X-Received: by 2002:adf:b682:: with SMTP id j2mr14985118wre.3.1555340865235;
	Mon, 15 Apr 2019 08:07:45 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90])
	by smtp.gmail.com with ESMTPSA id b9sm26627432wmc.9.2019.04.15.08.07.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 08:07:44 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <efbf9e4e-8be1-04b4-3743-ce384de2b58d@redhat.com>
Date: Mon, 15 Apr 2019 17:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 1/5] sparc64: use
 memory_region_allocate_system_memory() only for '-m' specified RAM
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
Cc: David Hildenbrand <david@redhat.com>, Helge Deller <deller@gmx.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415150742.dn9ulCvocKI7kD8tLSnjduoe1UTkXwXs0r8deb3VpxA@z>

On 4/15/19 3:27 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() was designed to be called for
> allocating inital RAM. Using it mutiple times within one board is not
> supported and could fail if -mem-path with non hugepage path is used.
> 
> Keep using memory_region_allocate_system_memory() only for initial
> RAM and use memory_region_init_ram() for the rest fixed size regions.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/sparc64/niagara.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index f8a856f..39a4522 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -37,6 +37,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> +#include "qapi/error.h"
>  
>  
>  typedef struct NiagaraBoardState {
> @@ -108,8 +109,8 @@ static void niagara_init(MachineState *machine)
>      /* init CPUs */
>      sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
>      /* set up devices */
> -    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
> -                                         NIAGARA_HV_RAM_SIZE);
> +    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
> +                           NIAGARA_HV_RAM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
>  
>      memory_region_allocate_system_memory(&s->partition_ram, NULL,

Using the partition RAM as system memory rather than HV one seems the
correct choice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> @@ -118,17 +119,17 @@ static void niagara_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
>                                  &s->partition_ram);
>  
> -    memory_region_allocate_system_memory(&s->nvram, NULL,
> -                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE);
> +    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
> +                           &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
> -    memory_region_allocate_system_memory(&s->md_rom, NULL,
> -                                         "sun4v-md.rom", NIAGARA_MD_ROM_SIZE);
> +    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
> +                           NIAGARA_MD_ROM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
> -    memory_region_allocate_system_memory(&s->hv_rom, NULL,
> -                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SIZE);
> +    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
> +                           NIAGARA_HV_ROM_SIZE, &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
> -    memory_region_allocate_system_memory(&s->prom, NULL,
> -                                         "sun4v.prom", PROM_SIZE_MAX);
> +    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX,
> +                           &error_fatal);
>      memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
>  
>      add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
> @@ -145,8 +146,8 @@ static void niagara_init(MachineState *machine)
>          BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>          int size = blk_getlength(blk);
>          if (size > 0) {
> -            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
> -                                                 "sun4v_vdisk.ram", size);
> +            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
> +                                   &error_fatal);
>              memory_region_add_subregion(get_system_memory(),
>                                          NIAGARA_VDISK_BASE, &s->vdisk_ram);
>              dinfo->is_default = 1;
> 

