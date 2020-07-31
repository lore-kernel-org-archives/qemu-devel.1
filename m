Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08063C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 14:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C4B206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LO2lyY5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C4B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1WRL-0007hI-11
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 10:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1WQP-00077x-OX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 10:54:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1WQO-0001eH-2c
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 10:54:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id a65so13667434otc.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HL8rbpItYh57rQFmhUGenD+1qALQXnHJtL9E29zbp44=;
 b=LO2lyY5c5TytM2PBSAqntH4qzLGqBjLHvSomlgJF2xLaI9xKl37ZutbrHMFEdog9aH
 Jn2LWnqBS9EcNnm7ZdOLzaK1VUdY6cCWQ+Trcn3mNYRgwauMBZ+hV4kiMOFxOprFkqkb
 Pge6KlgupI+TtYxz0qj3DryaqhAJyBaG8jv1bGKQ8qN1LRv37n0qZgRHK+fVwmlVEEio
 yjPfe0cq4x+OeI5ScjTa/X4zI2yOY+nNGcuTdabKjKMjUvDl0S2KEBpOxUWQ1iAcSVi3
 N087xRg7yRoxTxhfCyfM2drlufjbGJIVFFkTe/AESVrlLnnyFI674jj+L0sKXstsGecx
 BFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HL8rbpItYh57rQFmhUGenD+1qALQXnHJtL9E29zbp44=;
 b=EBZ2dGQ+C+ZTqVkmn8+MdYcmtloriTRVQfs2EMflkCkOvIRtKVTerZffzev6UGC+wy
 Uh1/vHoGY56awPNgRB0gctT1tGtQsafd2AmBePCOnJICWgkt8GOsMAVx02NAwIJKpsEM
 LkE/w3V6hd4/hgiV87lQo978ivs6tBYWg/Yt13/0WVZNJAB2QvkRqoVxMK4xsiqJvTj9
 gkyGLUuB0KLl1l5eJwGK9+ioRcIouP8/dnlcvt/fCFl57koFcM51r0bMGXt0f2IiB4UV
 TinPkrwBXLxnaq6CAi+66ZKq9BH6Z+DuUtYJrrerduZeORHiZVhLvaegp+yDyX0g6ilB
 owEQ==
X-Gm-Message-State: AOAM533zsNIm+dxZ2OpHvZhxaWakOmNaVq6ZR21HkTc3/dPhnHKrIFs1
 /gqbOEZtsQHuSWKqE5igfH7t1MnckBczcQr1559k+w==
X-Google-Smtp-Source: ABdhPJwXZME0dZWKkYUG7ipaFiTrmrWjPnb07tnRQcddU0bgaiwM+876WjGFKI0fuEz3nW8r5Iid4nt379gwLwSKrxc=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr3087480oth.221.1596207258592; 
 Fri, 31 Jul 2020 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200711101033.47371-1-drjones@redhat.com>
 <20200711101033.47371-4-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-4-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2020 15:54:07 +0100
Message-ID: <CAFEAcA8h+6btvjvx=j5v7Gn12+bros_UgFScKHaWVxh0dmi-Qw@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm/virt: Implement kvm-steal-time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
> We add the kvm-steal-time CPU property and implement it for machvirt.
> A tiny bit of refactoring was also done to allow pmu and pvtime to
> use the same vcpu device helper functions.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Hi; I'm forwarding a couple of comments here from Beata,
(whose secondment with Linaro is coming to an end so she won't
have access to her Linaro email address to continue the conversation):


>  static void virt_cpu_post_init(VirtMachineState *vms)
>  {
> -    bool aarch64, pmu;
> +    bool aarch64, pmu, steal_time;
>      CPUState *cpu;
>
>      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
>      pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> +    steal_time = object_property_get_bool(OBJECT(first_cpu),
> +                                          "kvm-steal-time", NULL);
>
>      if (kvm_enabled()) {
> +        hwaddr pvtime_base = vms->memmap[VIRT_PVTIME].base;
> +        hwaddr pvtime_size = vms->memmap[VIRT_PVTIME].size;
> +
> +        if (steal_time) {
> +            MemoryRegion *pvtime = g_new(MemoryRegion, 1);
> +
> +            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
> +            memory_region_add_subregion(get_system_memory(), pvtime_base,
> +                                        pvtime);
> +        }

B: I'm not sure whether it wouldn't be useful to have the area
allocated with size determined by number of VCPUs instead of having
pre-defined size.

> +        if (vmc->kvm_no_steal_time &&
> +            object_property_find(cpuobj, "kvm-steal-time", NULL)) {
> +            object_property_set_bool(cpuobj, false, "kvm-steal-time", NULL);
> +        }
> +
>          if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
>              object_property_set_bool(cpuobj, "pmu", false, NULL);
>          }
> @@ -2528,6 +2558,7 @@ static void virt_machine_5_0_options(MachineClass *mc)
>      mc->numa_mem_supported = true;
>      vmc->acpi_expose_flash = true;
>      mc->auto_enable_numa_with_memdev = false;
> +    vmc->kvm_no_steal_time = true;
>  }
>  DEFINE_VIRT_MACHINE(5, 0)
>
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 54bcf17afd35..b5153afedcdf 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -80,6 +80,7 @@ enum {
>      VIRT_PCDIMM_ACPI,
>      VIRT_ACPI_GED,
>      VIRT_NVDIMM_ACPI,
> +    VIRT_PVTIME,
>      VIRT_LOWMEMMAP_LAST,
>  };
>
> @@ -126,6 +127,7 @@ typedef struct {
>      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
>      bool kvm_no_adjvtime;
>      bool acpi_expose_flash;
> +    bool kvm_no_steal_time;

B: It is slightly confusing : using kvm_no_steal_time vs kvm_steal_time

P: I have to admit I get confused about which sense this flag
should have. I think the sense of the flags in this struct is
"the false case is the one that the older virt boards had",
so original virt didn't have an ITS or a PMU and so we have
no_its and no_pmu. Similarly here old virt didn't have steal-time
and so we want a no_ flag (ie the patch is correct). Why
kvm_no_steal_time rather than no_kvm_steal_time, though ?

>  } VirtMachineClass;

> +void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_ARM_VCPU_PVTIME_CTRL,
> +        .attr = KVM_ARM_VCPU_PVTIME_IPA,
> +        .addr = (uint64_t)&ipa,
> +    };
> +
> +    if (!ARM_CPU(cs)->kvm_steal_time) {
> +        return;
> +    }
> +    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
> +        error_report("failed to init PVTIME IPA");
> +        abort();
> +    }
> +}

B: I am probably missing smth but .. there is a trigger missing to
update the stats
and write them back to pre-allocated guest memory.
Looking at the kernel code the stats are updated upon pending
VCPU request :
in arch/arm64/kvm/arm.c:
static void check_vcpu_requests(struct kvm_vcpu *vcpu) {
        ...
         if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu))
                kvm_update_stolen_time(vcpu);
}


thanks
-- PMM

