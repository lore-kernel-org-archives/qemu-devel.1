Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C27C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940C420818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiLvFa19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940C420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcXx-0004VV-V7
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:53:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hQcSV-0001Aq-88
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hQcST-0002lD-R5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:47:27 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hQcSR-0002dj-3w; Tue, 14 May 2019 14:47:23 -0400
Received: by mail-qt1-x843.google.com with SMTP id t1so201354qtc.12;
	Tue, 14 May 2019 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=orTAG3ogiPRikRYcOz7KM100wsVa7mme0Gv9/jTbCvM=;
	b=NiLvFa19VOvbcKPigDx+JDmbmXIda3L8MfxwXmrOp/mbwHMasQJeHUqy9fBHk0w9JE
	vYIsFjxIdmjytqtwqU9w8HBSfyYrXrRHk6nwj5kFA8uGwSeiJuktPUJX5y5yEqGlyaRv
	37Vd46/Sgxn42EbaiWwjxa2B5LUGsPZKIdRm5q1yLPZhHTPwIqQjaEZk1AtSaXDsxX5f
	37iwhtS5ZTI2aUnKrdWamGJTpL9hmgZPDYVnpXkSLrJtiKwLoGrETJ2cUQNq2qh2EWCV
	DGA4qyABHRFiWnXJBjR86Gf13VwmK45Zk2cl8O75XtrbTFhrw2CgKML+HvthDCUBnRLk
	zMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=orTAG3ogiPRikRYcOz7KM100wsVa7mme0Gv9/jTbCvM=;
	b=LlK9UnKeFyCIcHMFqFsckIw6sOdovK90JZCRoAreaMXMWR/0+51PAsMGWQYW2znMcv
	4GlRf2anveVcLUDkJ4sfRgQ3khEipEcg4wE7dRi+zZ0gE29+XXx7mvxuOSvEquH0AYty
	HomvDHhXPHg7qo4Unztqq4TCu3MLHr/hRDhVjSli/5QAw4Bf7tV4F1r9idcKagpilbH+
	wUJWncf5QfgJ28H4uQqkIYdn3WBJU0HfVDaR7KpQ85tBik0gS3Ua3YKQ+sNjQeskAo+e
	C6qf3e+/Btlb+Dwf5r0SFx0HLKYO6i6YhgUBsoWbWZLr1mxkNfj7kU8AAJL77yk0Rj0Y
	UI9Q==
X-Gm-Message-State: APjAAAViuKwLNNODxHOQQAdC4YJqywdqgrCubbi3QFeY7k9QHZDJW3KS
	JW61RHOL3eaBL4ZquFGyLfBFRh/t
X-Google-Smtp-Source: APXvYqzs9bwm4goH5PmIy8XDniY2KIftxY9LyakhUoDGDWzb5Kwyj5VXn7BBjoAY7iqGsJk8gMx1uA==
X-Received: by 2002:ac8:fa9:: with SMTP id b38mr27533505qtk.22.1557859641024; 
	Tue, 14 May 2019 11:47:21 -0700 (PDT)
Received: from [9.18.235.64] ([32.104.18.203])
	by smtp.gmail.com with ESMTPSA id
	t30sm7987902qtc.80.2019.05.14.11.47.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 11:47:20 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <155713017771.272495.17615824973869586988.stgit@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <3b7a8207-6b72-5c10-bb94-3ed4cf85bc91@gmail.com>
Date: Tue, 14 May 2019 15:47:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155713017771.272495.17615824973869586988.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Allow machine to dump
 dtb after SLOF update
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/6/19 5:09 AM, Greg Kurz wrote:
> Now that SLOF can update QEMU's device tree at runtime, it makes sense
> to be able to dump the resulting dtb, pretty much like it is already
> possible to dump the initial dtb with the dumpdtb machine option.
>
> Add a new dumpdtb-slof property to the pseries machine with the same
> semantics as dumpdtb, except that the dtb is dumped at the first call
> to h_update_dt() and QEMU exits right after that.
>
> The dtb size sanity check is skipped on purpose so that one has a chance
> to peek into the dump file and see what's wrong. If the size is big enough
> to cause g_malloc0() to fail then QEMU will abort though. This is likely
> not ever to happen, and anyway, we don't really care because dumpdtb-slof
> is for developpers, not production, and they should try to debug at the

typo: developers


> SLOF level in this case.
>
> Even if 3.1 and older machine types don't support device tree updates, it
> doesn't hurt to let them dump the dtb and exit anyway, and it seems better
> to ensure a consistent behaviour for this feature.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

LGTM

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   hw/ppc/spapr.c         |   19 +++++++++++++++++++
>   hw/ppc/spapr_hcall.c   |   22 ++++++++++++++--------
>   include/hw/ppc/spapr.h |    1 +
>   3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ce84806ee3d5..18de51d03bd1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3322,6 +3322,19 @@ static void spapr_set_host_serial(Object *obj, const char *value, Error **errp)
>       spapr->host_serial = g_strdup(value);
>   }
>   
> +static char *spapr_get_dumpdtb_slof(Object *obj, Error **errp)
> +{
> +    return g_strdup(SPAPR_MACHINE(obj)->dumpdtb_slof);
> +}
> +
> +static void spapr_set_dumpdtb_slof(Object *obj, const char *value, Error **errp)
> +{
> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
> +
> +    g_free(spapr->dumpdtb_slof);
> +    spapr->dumpdtb_slof = g_strdup(value);
> +}
> +
>   static void spapr_instance_init(Object *obj)
>   {
>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
> @@ -3378,6 +3391,12 @@ static void spapr_instance_init(Object *obj)
>           &error_abort);
>       object_property_set_description(obj, "host-serial",
>           "Host serial number to advertise in guest device tree", &error_abort);
> +
> +    object_property_add_str(obj, "dumpdtb-slof", spapr_get_dumpdtb_slof,
> +                            spapr_set_dumpdtb_slof, &error_abort);
> +    object_property_set_description(obj, "dumpdtb-slof",
> +                                    "Dump SLOF dtb to a file and quit",
> +                                    &error_abort);
>   }
>   
>   static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6c16d2b12040..30a3880cf1d6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1766,20 +1766,26 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
>       cb = fdt32_to_cpu(hdr.totalsize);
>   
> -    if (!smc->update_dt_enabled) {
> -        return H_SUCCESS;
> -    }
> +    if (!spapr->dumpdtb_slof) {
> +        if (!smc->update_dt_enabled) {
> +            return H_SUCCESS;
> +        }
>   
> -    /* Check that the fdt did not grow out of proportion */
> -    if (cb > spapr->fdt_initial_size * 2) {
> -        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
> -                                          fdt32_to_cpu(hdr.magic));
> -        return H_PARAMETER;
> +        /* Check that the fdt did not grow out of proportion */
> +        if (cb > spapr->fdt_initial_size * 2) {
> +            trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
> +                                              fdt32_to_cpu(hdr.magic));
> +            return H_PARAMETER;
> +        }
>       }
>   
>       fdt = g_malloc0(cb);
>       cpu_physical_memory_read(dt, fdt, cb);
>   
> +    if (spapr->dumpdtb_slof) {
> +        exit(g_file_set_contents(spapr->dumpdtb_slof, fdt, cb, NULL) ? 0 : 1);
> +    }
> +
>       /* Check the fdt consistency */
>       if (fdt_check_full(fdt, cb)) {
>           trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 7e32f309c2be..72a5ff7bfee9 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -191,6 +191,7 @@ struct SpaprMachineState {
>       char *kvm_type;
>       char *host_model;
>       char *host_serial;
> +    char *dumpdtb_slof;
>   
>       int32_t irq_map_nr;
>       unsigned long *irq_map;
>
>


