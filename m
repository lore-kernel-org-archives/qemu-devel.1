Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3887C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0D20828
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhAv2-0006lE-Nb
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 06:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhAss-0006FW-Td
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhAsr-0008S9-KY
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:47:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhAsq-0008QV-70
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:47:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so8793174wrs.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 03:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9L2jyaDQHoLbfx2IW1q+3nL2Jjvofyz4fXZp9aVMGNg=;
 b=QKOBb6KCnlbEwg+SiZ6WBiy89LD8AWVceErd4lxV8v5G6MSnk4iAkhnrBF0RJWRo7F
 CodWCTdTfPGpPbn0Zd/58OgKXv+Th58rp1aeMBMfRYo6yhxZ6gdoEg1gc+oWShimD+ca
 VWnab9X/rHRDf/Yfd4jgEZp7bQWmgN1SwmknYOQEfe8HLqIfqJZ2AMbuF8wayTpGE1wh
 FWyhtCVu3KZlPPs5pgB2PO+oNZIWE5aKT8qyx1zEt0POdh+c8tgoppltI0iQxf5COhAd
 GBZ7US/geQedzKlizQIQhbGmCRiiPqbUmIJPVql75tALwbIYeQiKKqCXzs26pwmF0Jtg
 5GIw==
X-Gm-Message-State: APjAAAVQV50k/+XlliqrZfVfp/ziHfbLXMbDONkqe8YldBLqNqAlmSDT
 nS+RyxVYHyTEwodSyejFAJyAMg==
X-Google-Smtp-Source: APXvYqzqDUvcHV02wphMFTSGjKvIjx5cQr19UmjD/BLDMAWRBKuTeVNiLIOQD9BQahtyHw7QZLxpPQ==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr12199533wrm.117.1561805221564; 
 Sat, 29 Jun 2019 03:47:01 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id n2sm1453113wmi.38.2019.06.29.03.47.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 03:47:00 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190628200227.1053-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d48b0ed-07fd-282a-fae7-b9ae87de66e3@redhat.com>
Date: Sat, 29 Jun 2019 12:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628200227.1053-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] pc: Move compat_apic_id_mode variable to
 PCMachineClass
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Samuel Ortiz <sameo@linux.intel.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 10:02 PM, Eduardo Habkost wrote:
> Replace the static variable with a PCMachineClass field.  This
> will help us eventually get rid of the pc_compat_*() init
> functions.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/i386/pc.h |  3 +++
>  hw/i386/pc.c         | 22 +++++++++-------------
>  hw/i386/pc_piix.c    |  3 ++-
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c54cc54a47..853502f277 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -134,6 +134,9 @@ typedef struct PCMachineClass {
>  
>      /* use PVH to load kernels that support this feature */
>      bool pvh_enabled;
> +
> +    /* Enables contiguous-apic-ID mode */
> +    bool compat_apic_id_mode;
>  } PCMachineClass;
>  
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e96360b47a..3983621f1c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -913,14 +913,6 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
>      return false;
>  }
>  
> -/* Enables contiguous-apic-ID mode, for compatibility */
> -static bool compat_apic_id_mode;
> -
> -void enable_compat_apic_id_mode(void)
> -{
> -    compat_apic_id_mode = true;
> -}
> -
>  /* Calculates initial APIC ID for a specific CPU index
>   *
>   * Currently we need to be able to calculate the APIC ID from the CPU index
> @@ -928,13 +920,15 @@ void enable_compat_apic_id_mode(void)
>   * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
>   * all CPUs up to max_cpus.
>   */
> -static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
> +static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
> +                                           unsigned int cpu_index)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      uint32_t correct_id;
>      static bool warned;
>  
>      correct_id = x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_index);
> -    if (compat_apic_id_mode) {
> +    if (pcmc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
>                           "CPU topology won't match the configuration");
> @@ -1533,7 +1527,8 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
>  void pc_hot_add_cpu(const int64_t id, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> -    int64_t apic_id = x86_cpu_apic_id_from_index(id);
> +    PCMachineState *pcms = PC_MACHINE(ms);
> +    int64_t apic_id = x86_cpu_apic_id_from_index(pcms, id);
>      Error *local_err = NULL;
>  
>      if (id < 0) {
> @@ -1569,7 +1564,7 @@ void pc_cpus_init(PCMachineState *pcms)
>       *
>       * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
>       */
> -    pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
> +    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms, max_cpus - 1) + 1;
>      possible_cpus = mc->possible_cpu_arch_ids(ms);
>      for (i = 0; i < smp_cpus; i++) {
>          pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
> @@ -2660,6 +2655,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>  
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  {
> +    PCMachineState *pcms = PC_MACHINE(ms);
>      int i;
>  
>      if (ms->possible_cpus) {
> @@ -2679,7 +2675,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
> +        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                   smp_cores, smp_threads, &topo);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c07c4a5b38..f29de58636 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -358,7 +358,6 @@ static void pc_compat_1_4_fn(MachineState *machine)
>  static void pc_compat_1_3(MachineState *machine)
>  {
>      pc_compat_1_4_fn(machine);
> -    enable_compat_apic_id_mode();
>  }
>  
>  /* PC compat function for pc-0.14 to pc-1.2 */
> @@ -708,6 +707,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
>  
>  static void pc_i440fx_1_3_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      static GlobalProperty compat[] = {
>          PC_CPU_MODEL_IDS("1.3.0")
>          { "usb-tablet", "usb_version", "1" },
> @@ -718,6 +718,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
>  
>      pc_i440fx_1_4_machine_options(m);
>      m->hw_version = "1.3.0";
> +    pcmc->compat_apic_id_mode = true;
>      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

