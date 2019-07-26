Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA29C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90122173B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90122173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2Vb-00061u-T6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2VO-0005RJ-20
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2VL-0003SQ-Ei
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:51:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2VL-0003Lb-7c
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:51:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so5031127wrr.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fIUW90DC95Wb2trh0I5RWsRGh95tgdG5rbZPcFizH+A=;
 b=XOk5TlegJ9nStNkb8+7wOrCzm3Rx1Xlm165LHjOe1N11vW9Fnf3Bq6Wy4SmLGII2UF
 JyGCPsGJovnK1LGAwglcUD4QHUvkSLRRKYfHqD5F6TWfzj25SxBuiak4TIaUINkF3x79
 KL/l+2Eiu2h7bPeeHPr76BCSRy1FvRIzwu3zZi2/3kHiSqZ5Bs3IwAF81DY5tS3UYwoK
 2Qza48kiZdFf0X2gEQOpv159jg1j8S8vv4pwUFEqUOzURHnpr+3Hwr1zNLuCgfK+hc5C
 fwReiUImC7pLRqXkFXqqb5d2rpqNG2kwpZqzu7HzrM7WcgtI0Ewcpz+0L+o2ZZGf7SHf
 xuaA==
X-Gm-Message-State: APjAAAWiLTVCfuJk6Y4ZY75lW5rh3a8gNuFGmacfYywIwZoC6AG4bGbl
 tcKcM2BRFnAI7/3VM5xTfp0XH3H7ydI=
X-Google-Smtp-Source: APXvYqzyeC0X3STWSHaO7ioZ2do529WT0toY/H6Hmla4Dd69s5MXNMLtGF45JV4AgBruzGuM09FGeg==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr8638960wrt.106.1564156292828; 
 Fri, 26 Jul 2019 08:51:32 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id k17sm60973622wrq.83.2019.07.26.08.51.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 08:51:32 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f764e590-e2a4-12d1-d8ef-e09f5f57d699@redhat.com>
Date: Fri, 26 Jul 2019 17:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 14/28] migration: Move the
 VMStateDescription typedef to typedefs.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> We declare incomplete struct VMStateDescription in a couple of places
> so we don't have to include migration/vmstate.h for the typedef.
> That's fine with me.  However, the next commit will drop
> migration/vmstate.h from a massive number of compiles.  Move the
> typedef to qemu/typedefs.h now, so I don't have to insert struct in
> front of VMStateDescription all over the place then.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/qdev-core.h      | 6 ++----
>  include/migration/vmstate.h | 1 -
>  include/qemu/typedefs.h     | 1 +
>  include/qom/cpu.h           | 4 ++--
>  target/alpha/cpu.h          | 2 +-
>  target/arm/cpu.h            | 2 +-
>  target/cris/cpu.h           | 2 +-
>  target/hppa/cpu.h           | 2 +-
>  target/i386/cpu.h           | 2 +-
>  target/lm32/cpu.h           | 2 +-
>  target/mips/internal.h      | 2 +-
>  target/openrisc/cpu.h       | 2 +-
>  target/ppc/cpu-qom.h        | 2 +-
>  target/ppc/cpu.h            | 2 +-
>  target/s390x/cpu.h          | 2 +-
>  target/sparc/cpu.h          | 2 +-
>  16 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b0c1d0e410..80fdb38d94 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -35,8 +35,6 @@ typedef void (*DeviceReset)(DeviceState *dev);
>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>  typedef void (*BusUnrealize)(BusState *bus, Error **errp);
>  
> -struct VMStateDescription;
> -
>  /**
>   * DeviceClass:
>   * @props: Properties accessing state fields.
> @@ -112,7 +110,7 @@ typedef struct DeviceClass {
>      DeviceUnrealize unrealize;
>  
>      /* device state */
> -    const struct VMStateDescription *vmsd;
> +    const VMStateDescription *vmsd;
>  
>      /* Private to qdev / bus.  */
>      const char *bus_type;
> @@ -422,7 +420,7 @@ void device_class_set_parent_unrealize(DeviceClass *dc,
>                                         DeviceUnrealize dev_unrealize,
>                                         DeviceUnrealize *parent_unrealize);
>  
> -const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
> +const VMStateDescription *qdev_get_vmsd(DeviceState *dev);
>  
>  const char *qdev_fw_name(DeviceState *dev);
>  
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index ca68584eba..a547517dc7 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -28,7 +28,6 @@
>  #define QEMU_VMSTATE_H
>  
>  typedef struct VMStateInfo VMStateInfo;
> -typedef struct VMStateDescription VMStateDescription;
>  typedef struct VMStateField VMStateField;
>  
>  /* VMStateInfo allows customized migration of objects that don't fit in
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index c32efb5b18..9e1283aacf 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -101,6 +101,7 @@ typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
> +typedef struct VMStateDescription VMStateDescription;
>  
>  /*
>   * Pointer types
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 5ee0046b62..ddb91bbaff 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -215,7 +215,7 @@ typedef struct CPUClass {
>      int (*write_elf32_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
>                                  void *opaque);
>  
> -    const struct VMStateDescription *vmsd;
> +    const VMStateDescription *vmsd;
>      const char *gdb_core_xml_file;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
>      const char * (*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlname);
> @@ -1108,7 +1108,7 @@ bool target_words_bigendian(void);
>  #ifdef NEED_CPU_H
>  
>  #ifdef CONFIG_SOFTMMU
> -extern const struct VMStateDescription vmstate_cpu_common;
> +extern const VMStateDescription vmstate_cpu_common;
>  #else
>  #define vmstate_cpu_common vmstate_dummy
>  #endif
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index b3e8a823e1..4619530660 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -277,7 +277,7 @@ struct AlphaCPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_alpha_cpu;
> +extern const VMStateDescription vmstate_alpha_cpu;
>  #endif
>  
>  void alpha_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 94c990cddb..2cdde6c4bc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -922,7 +922,7 @@ void arm_cpu_post_init(Object *obj);
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_arm_cpu;
> +extern const VMStateDescription vmstate_arm_cpu;
>  #endif
>  
>  void arm_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index fb14ad51f1..aba0a66474 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -183,7 +183,7 @@ struct CRISCPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_cris_cpu;
> +extern const VMStateDescription vmstate_cris_cpu;
>  #endif
>  
>  void cris_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index e9fba96be9..4b816cc13a 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -334,7 +334,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
>                                int type, hwaddr *pphys, int *pprot);
>  extern const MemoryRegionOps hppa_io_eir_ops;
> -extern const struct VMStateDescription vmstate_hppa_cpu;
> +extern const VMStateDescription vmstate_hppa_cpu;
>  void hppa_cpu_alarm_timer(void *);
>  int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
>  #endif
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 05393cf9d1..fdf25df25c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1516,7 +1516,7 @@ struct X86CPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern struct VMStateDescription vmstate_x86_cpu;
> +extern VMStateDescription vmstate_x86_cpu;
>  #endif
>  
>  /**
> diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
> index c2bbfa2780..064c6b1267 100644
> --- a/target/lm32/cpu.h
> +++ b/target/lm32/cpu.h
> @@ -195,7 +195,7 @@ struct LM32CPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_lm32_cpu;
> +extern const VMStateDescription vmstate_lm32_cpu;
>  #endif
>  
>  void lm32_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index b2b41a51ab..d5aa5490d3 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -148,7 +148,7 @@ hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
>  #define cpu_signal_handler cpu_mips_signal_handler
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_mips_cpu;
> +extern const VMStateDescription vmstate_mips_cpu;
>  #endif
>  
>  static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index f23b25262d..61ade1d4f0 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -333,7 +333,7 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
>  #define cpu_signal_handler cpu_openrisc_signal_handler
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_openrisc_cpu;
> +extern const VMStateDescription vmstate_openrisc_cpu;
>  
>  /* hw/openrisc_pic.c */
>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index be9b4c30c3..a2f202f021 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -203,7 +203,7 @@ typedef struct PPCTimebase {
>      int64_t time_of_the_day_ns;
>  } PPCTimebase;
>  
> -extern const struct VMStateDescription vmstate_ppc_timebase;
> +extern const VMStateDescription vmstate_ppc_timebase;
>  
>  #define VMSTATE_PPC_TIMEBASE_V(_field, _state, _version) {            \
>      .name       = (stringify(_field)),                                \
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..4ea33cf696 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1255,7 +1255,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
>  void ppc_cpu_do_system_reset(CPUState *cs);
> -extern const struct VMStateDescription vmstate_ppc_cpu;
> +extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
>  
>  /*****************************************************************************/
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index a606547b4d..3d9de25f7c 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -163,7 +163,7 @@ struct S390CPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_s390_cpu;
> +extern const VMStateDescription vmstate_s390_cpu;
>  #endif
>  
>  /* distinguish between 24 bit and 31 bit addressing */
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 8ed2250cd0..0d5b01efe5 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -532,7 +532,7 @@ struct SPARCCPU {
>  
>  
>  #ifndef CONFIG_USER_ONLY
> -extern const struct VMStateDescription vmstate_sparc_cpu;
> +extern const VMStateDescription vmstate_sparc_cpu;
>  #endif
>  
>  void sparc_cpu_do_interrupt(CPUState *cpu);
> 

