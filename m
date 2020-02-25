Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF42C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992EF20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJZ1xWY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992EF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Y4c-0002TN-QH
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Y3v-0001wJ-9G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Y3t-0005HL-Pd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:07:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Y3t-0005Gv-M0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582628856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kmaxn9tD99SPW9GVCRpwuVuFeo57vUGK4iIG7MBPuP4=;
 b=SJZ1xWY9FMTjJ1Z1RJyGDAMswLZKX/qEGXGFM7YzNhHOBiEsjUA6z5PqGxJ30vi0smHQRb
 zQmO5HwtOHeTXXklpf7hh8TmpNZiwwS6nM69vGwIuUUMFOPEiD2+m9+FavNgT06/27SFJT
 WFXrffgx7n1njt4RFJbFUrkitoQpxeo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-vnJvWyiiNoioe14mvZHTyQ-1; Tue, 25 Feb 2020 06:07:33 -0500
X-MC-Unique: vnJvWyiiNoioe14mvZHTyQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so5358669wrp.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kmaxn9tD99SPW9GVCRpwuVuFeo57vUGK4iIG7MBPuP4=;
 b=fpPp+w1OHvVXIFCpopZEE5B79B8ctiGKamYZpfOMX7wU9VAENGApcRlxjSIM1iOcnT
 Jx2ds2k7xDMhEKKztmgf+bE19t2oURQjEG2k/uMDrIDccbgf3vUSZTJRR6A3sbbYJf5J
 8T9MDv0QdIkl+Xodb0jF1FlKJDYve44oLQAJ9GrDWHyEPoZakSndw7kyBXIpyZj6g6P1
 bA6KoVm55V8yT9lxk6iL1EFoWDnSHvYBiCMzCJDrt2zHP95IHY51pG26CLCB384Xbh7L
 U0F/9NXkmRRbS/BQzWXJAEmDsX/Itm1wRc8Qk6/G19NSlpFNWrhWKNn9e80SESSD0NgW
 w7mw==
X-Gm-Message-State: APjAAAVf7AQ/kPwJ61zZFCKcIBeQ6PY8eQNR8eu2RwmtFO9FSBmFPCDt
 uijWZy5NrVFHtmXcsSmshdzSRIhi2jBCcKTubAic6ROH3IqP9VGZ323oXLEbwW7BPhgMVfFjjiU
 MhIhOEhv2Z1sGNXg=
X-Received: by 2002:adf:eac1:: with SMTP id o1mr10036496wrn.234.1582628852095; 
 Tue, 25 Feb 2020 03:07:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4RMsqO03flA2eTlFQsDxzjUX9LC46Cn6QrYlUPPJ8a5TCncwN52KIW6qs1FL2cyIyETeyQw==
X-Received: by 2002:adf:eac1:: with SMTP id o1mr10036463wrn.234.1582628851782; 
 Tue, 25 Feb 2020 03:07:31 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n2sm1229981wro.96.2020.02.25.03.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:07:31 -0800 (PST)
Subject: Re: [PATCH v6 17/18] spapr: Clean up RMA size calculation
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-18-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd9b356a-1b13-c322-33ec-49c31d1dd2e7@redhat.com>
Date: Tue, 25 Feb 2020 12:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224233724.46415-18-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 12:37 AM, David Gibson wrote:
> Move the calculation of the Real Mode Area (RMA) size into a helper
> function.  While we're there clean it up and correct it in a few ways:
>    * Add comments making it clearer where the various constraints come from
>    * Remove a pointless check that the RMA fits within Node 0 (we've just
>      clamped it so that it does)
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr.c | 59 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6e9f15f64d..f0354b699d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2648,6 +2648,40 @@ static PCIHostState *spapr_create_default_phb(void)
>       return PCI_HOST_BRIDGE(dev);
>   }
>   
> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine = MACHINE(spapr);
> +    hwaddr rma_size = machine->ram_size;
> +    hwaddr node0_size = spapr_node0_size(machine);
> +
> +    /* RMA has to fit in the first NUMA node */
> +    rma_size = MIN(rma_size, node0_size);
> +
> +    /*
> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> +     * never exceed that
> +     */
> +    rma_size = MIN(rma_size, TiB);

Can you use '1 * TiB'? It makes review obvious.

> +
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
> +     */
> +    if (smc->rma_limit) {
> +        spapr->rma_size = MIN(spapr->rma_size, smc->rma_limit);
> +    }
> +
> +    if (rma_size < (MIN_RMA_SLOF * MiB)) {

This looks old copy/paste before the change "spapr: Don't use weird 
units for MIN_RMA_SLOF".

> +        error_setg(errp,
> +"pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area)",
> +                   MIN_RMA_SLOF);

Similarly, "MIN_RMA_SLOF / MiB"?

> +        return -1;

Maybe return 0 in case this function is called with errp != &error_fatal.

> +    }
> +
> +    return rma_size;
> +}
> +
>   /* pSeries LPAR / sPAPR hardware init */
>   static void spapr_machine_init(MachineState *machine)
>   {
> @@ -2660,7 +2694,6 @@ static void spapr_machine_init(MachineState *machine)
>       int i;
>       MemoryRegion *sysmem = get_system_memory();
>       MemoryRegion *ram = g_new(MemoryRegion, 1);
> -    hwaddr node0_size = spapr_node0_size(machine);
>       long load_limit, fw_size;
>       char *filename;
>       Error *resize_hpt_err = NULL;
> @@ -2700,22 +2733,7 @@ static void spapr_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    spapr->rma_size = node0_size;
> -
> -    /*
> -     * Clamp the RMA size based on machine type.  This is for
> -     * migration compatibility with older qemu versions, which limited
> -     * the RMA size for complicated and mostly bad reasons.
> -     */
> -    if (smc->rma_limit) {
> -        spapr->rma_size = MIN(spapr->rma_size, smc->rma_limit);
> -    }
> -
> -    if (spapr->rma_size > node0_size) {
> -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
> -                     spapr->rma_size);
> -        exit(1);
> -    }
> +    spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
>   
>       /* Setup a load limit for the ramdisk leaving room for SLOF and FDT */
>       load_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> @@ -2954,13 +2972,6 @@ static void spapr_machine_init(MachineState *machine)
>           }
>       }
>   
> -    if (spapr->rma_size < MIN_RMA_SLOF) {
> -        error_report(
> -            "pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area memory)",
> -            MIN_RMA_SLOF / MiB);
> -        exit(1);
> -    }
> -
>       if (kernel_filename) {
>           uint64_t lowaddr = 0;
>   
> 


