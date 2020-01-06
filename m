Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F9C32767
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ECD21734
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 06:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bO/ccTwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ECD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioLtn-0007RW-Fg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 01:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ioLsy-0006tJ-GP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ioLss-0005Oo-Sh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:29:07 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ioLss-0005Ky-5s
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 01:29:02 -0500
Received: by mail-pj1-x1042.google.com with SMTP id bg7so7348185pjb.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 22:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aCC+WxXr9SC5nDftkSUVGudEGpl8YIu91R7swz3BZLk=;
 b=bO/ccTwTD3PBhpsuXb2WXaNFiiHtLTJ2xRYSNQhsi6ZB7U0QOM4yDXROIqZXmjsr9O
 XYwtdlPPuJFFOydlJEhEHLjYrqQFYtAwF0OWjIDWRAvi2DQ/bVqHxMygukld2XOYW6yI
 Jp7P34iUJGdlOqWb4GIYNIEQZCvt8C2JKzRM3zCBHiEf3HjglfvbLrnVyPHX2MwQ3qrR
 Y5se+wTRRkewDE3F5vFd2rM8xy2s4zF6OyFZ0xWIb/grWqXpg1zqhBfMsI966QuQsUFA
 yzBKdr229pNb8V8EP1zha/X/xUmOQzrj5Mn5NErOQZug+EljagmBIknjnUIf/DtM9w5y
 nH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aCC+WxXr9SC5nDftkSUVGudEGpl8YIu91R7swz3BZLk=;
 b=bCPukLyac9+GdEWsx06Piki/lkitg+axnJ2Mnf9DC2a1mql7w0hd2MRRWM5ceHFvvm
 /KTP3KRxlY/pkyj80ydAfgoYPlYRt8CGpbkmUq6RZ/zzjJbCA8LOBGp00xtxIA6711n1
 Fw1MEr0jfYytL+cBMcxY+VTLiHxqwKFirKJI1V2XwyPo3eBq5PL6iHETts0R0fRrtbSQ
 3sDo/Cyw9AJN/Fqj4nnavjFebCmhn7DrMmFzB0QlsdRJ6SEqIsdIVSWradn10bJNZ1Y0
 49mKHPdEPKoVj+15fcw/WE9xoeX4lv9+FcRiaFyT57ZPML3VEVU7Ybeg4hrzIoDIqU/3
 LvjQ==
X-Gm-Message-State: APjAAAUBzPha5ZjHiHi3OhIwt5e6YT8lw16G1PacZm/L3SEt0wyuwfk8
 IGpd3LsdEotv6e7dmiaF8CZ7lXeXa38=
X-Google-Smtp-Source: APXvYqxqip1iKnbrhtqUs1tBwB2DMHcEiS7ogrE/0ieLEghiTEWJeydMAyt510gkFNF4BHoD56+A+w==
X-Received: by 2002:a17:90a:35e6:: with SMTP id
 r93mr41521924pjb.44.1578292139234; 
 Sun, 05 Jan 2020 22:28:59 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f9sm74397490pfd.141.2020.01.05.22.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2020 22:28:58 -0800 (PST)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
Date: Mon, 6 Jan 2020 17:28:55 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200106041940.GV2098@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/01/2020 15:19, David Gibson wrote:
> On Mon, Jan 06, 2020 at 10:42:42AM +1100, Alexey Kardashevskiy wrote:
>> The Petitboot bootloader is way more advanced than SLOF is ever going to
>> be as Petitboot comes with the full-featured Linux kernel with all
>> the drivers, and initramdisk with quite user friendly interface.
>> The problem with ditching SLOF is that an unmodified pseries kernel can
>> either start via:
>> 1. kexec, this requires presence of RTAS and skips
>> ibm,client-architecture-support entirely;
>> 2. normal boot, this heavily relies on the OF1275 client interface to
>> fetch the device tree and do early setup (claim memory).
>>
>> This adds a new bios-less mode to the pseries machine: "bios=on|off".
>> When enabled, QEMU does not load SLOF and jumps to the kernel from
>> "-kernel".
>>
>> The client interface is implemented exactly as RTAS - a 20 bytes blob,
>> right next after the RTAS blob. The entry point is passed to the kernel
>> via GPR5.
>>
>> This implements a handful of client interface methods just to get going.
>> In particular, this implements the device tree fetching,
>> ibm,client-architecture-support and instantiate-rtas.
>>
>> This implements changing FDT properties only for "linux,rtas-base" and
>> "linux,rtas-entry", just to get early boot going.
>>
>> This assigns "phandles" to device tree nodes as there is no more SLOF
>> and OF nodes addresses of which served as phandle values.
>> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
>> phandles are regenerated at every FDT rebuild.
>>
>> When bios=off, this adds "/chosen" every time QEMU builds a tree.
>>
>> This implements "claim" which the client (Linux) uses for memory
>> allocation; this is also  used by QEMU for claiming kernel/initrd images,
>> client interface entry point, RTAS and the initial stack.
>>
>> While at this, add a "kernel-addr" machine parameter to allow moving
>> the kernel in memory. This is useful for debugging if the kernel is
>> loaded at @0, although not necessary.
>>
>> This does not implement instances properly but in order to boot a VM,
>> we only really need a stdout instance and the "/" instance for
>> "call-method", we fake these.
> 
> As we've discussed, I really like the idea of this.  It think the
> basic approach looks good too.
> 
> As you probably realize, there are quite a lot of things to be
> polished though.  Comments below.
> 
>>
>> The test command line:
>>
>> qemu-system-ppc64 \
>> -nodefaults \
>> -chardev stdio,id=STDIO0,signal=off,mux=on \
>> -device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
>> -mon id=MON0,chardev=STDIO0,mode=readline \
>> -nographic \
>> -vga none \
>> -kernel vmldbg \
>> -machine pseries,bios=off \
>> -m 4G \
>> -enable-kvm \
>> -initrd pb/rootfs.cpio.xz \
>> img/u1804-64le.qcow2 \
>> -snapshot \
>> -smp 8,threads=8 \
>> -L /home/aik/t/qemu-ppc64-bios/ \
>> -trace events=qemu_trace_events \
>> -d guest_errors \
>> -chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh37874 \
>> -mon chardev=SOCKET0,mode=control
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * fixed claim()
>> * added "setprop"
>> * cleaner client interface and RTAS blobs management
>> * boots to petitboot and further to the target system
>> * more trace points
>> ---
>>  hw/ppc/Makefile.objs   |   1 +
>>  include/hw/loader.h    |   1 +
>>  include/hw/ppc/spapr.h |  25 ++-
>>  hw/ppc/spapr.c         | 231 ++++++++++++++++++--
>>  hw/ppc/spapr_client.c  | 464 +++++++++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_hcall.c   |  49 +++--
>>  hw/ppc/trace-events    |   9 +
>>  7 files changed, 743 insertions(+), 37 deletions(-)
>>  create mode 100644 hw/ppc/spapr_client.c
>>
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 101e9fc59185..ce31c0acd2fb 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>>  obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
>>  obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>>  obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
>> +obj-$(CONFIG_PSERIES) += spapr_client.o
> 
> This applies in a bunch of places here.  Just calling things "client"
> is clear enough if you're already thinking about Open Firmware.  But
> this appears in a bunch of places where you might come across it
> without that context, in which case it could be kind of confusing.  So
> I'd suggest using "of_client" or "of_client_interface" in most places
> you're using "client".
> 
>>  obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
>>  # IBM PowerNV
>>  obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>> index 48a96cd55904..a2f58077a47e 100644
>> --- a/include/hw/loader.h
>> +++ b/include/hw/loader.h
>> @@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>>  int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
>>                          size_t datasize, size_t romsize, hwaddr addr,
>>                          AddressSpace *as);
>> +bool rom_intersect(uint64_t start, uint64_t size);
> 
> I don't see this called, so I'm guessing it's a stray chunk leftover.
> 
>>  int rom_check_and_register_reset(void);
>>  void rom_set_fw(FWCfgState *f);
>>  void rom_set_order_override(int order);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 61f005c6f686..876879d12029 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -105,6 +105,11 @@ struct SpaprCapabilities {
>>      uint8_t caps[SPAPR_CAP_NUM];
>>  };
>>  
>> +typedef struct {
>> +    uint64_t start;
>> +    uint64_t size;
>> +} spapr_of_claimed;
> 
> Please use the qemu convention of StudlyCaps for types.
> 
>>  /**
>>   * SpaprMachineClass:
>>   */
>> @@ -158,8 +163,13 @@ struct SpaprMachineState {
>>      uint32_t fdt_size;
>>      uint32_t fdt_initial_size;
>>      void *fdt_blob;
>> +    uint32_t rtas_base;
>>      long kernel_size;
>>      bool kernel_le;
>> +    uint64_t kernel_addr;
> 
> This would intersect with your other patch to allow changing the
> kernel load address, yes?


This includes kernel_addr, it is a single patch now. More about this below.


> 
>> +    bool bios_enabled;
>> +    GArray *claimed; /* array of spapr_of_claimed */
>> +    uint64_t claimed_base;
> 
> I'd suggest moving all the client interface related fields to a
> visually separated chunk in the structure definition.
> 
>>      uint32_t initrd_base;
>>      long initrd_size;
>>      uint64_t rtc_offset; /* Now used only during incoming migration */
>> @@ -510,7 +520,8 @@ struct SpaprMachineState {
>>  /* Client Architecture support */
>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>> +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
>>  
>>  /*
>>   * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
>> @@ -538,6 +549,12 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
>>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>                               target_ulong *args);
>>  
>> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>> +                                            SpaprMachineState *spapr,
>> +                                            target_ulong addr,
>> +                                            target_ulong fdt_buf,
>> +                                            target_ulong fdt_bufsize);
>> +
>>  /* Virtual Processor Area structure constants */
>>  #define VPA_MIN_SIZE           640
>>  #define VPA_SIZE_OFFSET        0x4
>> @@ -769,6 +786,9 @@ struct SpaprEventLogEntry {
>>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
>>  void spapr_events_init(SpaprMachineState *sm);
>>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
>> +uint64_t spapr_do_client_claim(SpaprMachineState *sm, uint64_t virt,
>> +                               uint64_t size, uint64_t align);
>> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args);
>>  void close_htab_fd(SpaprMachineState *spapr);
>>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>>  void spapr_free_hpt(SpaprMachineState *spapr);
>> @@ -891,4 +911,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>  
>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>> +
>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
>> +
>>  #endif /* HW_SPAPR_H */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index e62c89b3dd40..1c97534a0aea 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -896,6 +896,51 @@ out:
>>      return ret;
>>  }
>>  
>> +/*
>> + * Below is a compiled version of RTAS blob and OF client interface entry point.
>> + *
>> + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
>> + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
>> + *
>> + *   .globl  _start
>> + *   _start:
>> + *           mr      4,3
>> + *           lis     3,KVMPPC_H_RTAS@h
>> + *           ori     3,3,KVMPPC_H_RTAS@l
>> + *           sc      1
>> + *           blr
>> + *           mr      4,3
>> + *           lis     3,KVMPPC_H_CLIENT@h
>> + *           ori     3,3,KVMPPC_H_CLIENT@l
>> + *           sc      1
>> + *           blr
>> + */
>> +static struct {
>> +    uint8_t rtas[20], client[20];
>> +} QEMU_PACKED rtas_client_blob = {
>> +    .rtas = {
>> +        0x7c, 0x64, 0x1b, 0x78,
>> +        0x3c, 0x60, 0x00, 0x00,
>> +        0x60, 0x63, 0xf0, 0x00,
>> +        0x44, 0x00, 0x00, 0x22,
>> +        0x4e, 0x80, 0x00, 0x20
>> +    },
>> +    .client = {
>> +        0x7c, 0x64, 0x1b, 0x78,
>> +        0x3c, 0x60, 0x00, 0x00,
>> +        0x60, 0x63, 0xf0, 0x05,
>> +        0x44, 0x00, 0x00, 0x22,
>> +        0x4e, 0x80, 0x00, 0x20
>> +    }
>> +};
> 
> I'd really prefer to read this in from a file (or files) which we
> assemble (as with the existing spapr-rtas.img), rather than having a
> magic array in qemu.

Two considerations here:
1. This blob is not going to change (at least often)
2. A new file which needs to be packaged/signed/copied.



>> +
>> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
>> +{
>> +    spapr->rtas_base = base;
>> +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
>> +                              sizeof(rtas_client_blob.rtas));
>> +}
>> +
>>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>  {
>>      MachineState *ms = MACHINE(spapr);
>> @@ -980,6 +1025,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>>                       lrdr_capacity, sizeof(lrdr_capacity)));
>>  
>> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->rtas_base));
>> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->rtas_base));
> 
> IIUC, we shouldn't need to add these in bios=off mode, yes?  Instead
> the client must instantiate-rtas before attempting to use it.


Well. Here is what happens:

1. spapr machine reset creates FDT, lets say without rtas-entry
2. linux calls ibm,client-interface-support
3. the QEMU handler rebuilds the FDT
4. linux calls "instantiate-rtas"
5. linux stores "linux,rtas-base" and "linux,rtas-entry" in the FDT
using "setprop" client call
6. linux fetches the tree by traversing it and packs it into FDT blob itself
7. linux calls quiesce
8. linux uses "linux,rtas-entry" from FDT to call RTAS.

Because in 5) I only allow in-place property update and only for
"linux,rtas-base" and "linux,rtas-entry", these do not make to the tree
and there is no "linux,rtas-entry" in the FDT.

There are choices:

1. I can extend "setprop" (tricky as FDT is flattened by then?)
2. simply store rtas base in spapr->rtas_base and do complete FDT rebuild
3. (currently) I basically have 2 placeholders for these
"linux,rtas-base" and "linux,rtas-entry".


Or we can avoid flattening FDT at all for bios=off (as nobody wants
flattened device tree, my "fetch-fdt" never made it to upstream Linux),
then 1) is easy (if it is a problem to begin with).



>> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
>> +                          sizeof(rtas_client_blob.rtas)));
>> +    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base,
>> +                         sizeof(rtas_client_blob.rtas)));
> 
> Nor should we need the mem_rsv with bios=off.

True. If not the "setprop" limitation from above, I would only need
"rtas-size" here.


> 
>> +
>>      spapr_dt_rtas_tokens(fdt, rtas);
>>  }
>>  
>> @@ -1057,7 +1109,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>      }
>>  
>>      if (spapr->kernel_size) {
>> -        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
>> +        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
>>                                cpu_to_be64(spapr->kernel_size) };
>>  
>>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
>> @@ -1104,6 +1156,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>          _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>>      }
>>  
>> +    if (!spapr->bios_enabled) {
>> +        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));
> 
> What is this for?

Looks like a leftover, I did this for prom_find_boot_cpu() but after
double checking and trying it looks like it can proceed without this chunk.


> 
>> +    }
>>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>  
>>      g_free(stdout_path);
>> @@ -1133,6 +1188,28 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>>      }
>>  }
>>  
>> +static void spapr_fdt_add_phandles(void *fdt, int parent, uint32_t *phandle)
>> +{
>> +    int proplen = 0, node;
>> +    const void *prop;
>> +    char tmp[256] = "BAAD";
>> +
>> +    fdt_get_path(fdt, parent, tmp, sizeof(tmp));
> 
> You don't actually appear to use tmp.  Is this a debugging leftover?

Yes it is.


> 
>> +    prop = fdt_getprop_namelen(fdt, parent, "phandle", 7, &proplen);
>> +    if (!prop) {
>> +        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
>> +        while (1) {
>> +            ++*phandle;
>> +            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
>> +                break;
>> +            }
>> +        }
>> +    }
>> +    fdt_for_each_subnode(node, fdt, parent) {
>> +        spapr_fdt_add_phandles(fdt, node, phandle);
>> +    }
> 
> Oof, this is pretty inefficient, since fdt_node_offset_by_phandle()
> will have to scan the whole tree, and you do it on every node.


Inefficient indeed but for a VM with ~30 devices it is not that bad :)


> Obviously, a "live" tree structure rather than fdt would be better
> suited for this.  I'd like to move to that at some point, but it will
> be a while before we're ready.

I could have a cache/hashmap of phandles...


> I guess this is fine for a PoC, but I think we can do a bit better
> without too much extra complexity:
>   * Rather than scanning for an existing node with the handle on each
>     iteration, you can use fdt_find_max_phandle() once beforehand,
>     and start your counter from there, being assured that it won't hit
>     any existing phandles

I'd like to avoid that as NPU/GPU phandles are quite huge and we will
have huge gaps between phandles numbers which is not so much of a big
deal but annoying to debug.


>   * The phandles are arbitrary, so you don't actually care about the
>     tree structure here.  So instead of recursively descending the
>     tree, you can just alter each node in the order they appear in the
>     blob.  fdt_next_node() will let you do that, simply by ignoring
>     the 'depth' parameter.  [In fact the structure ensures that will
>     be a depth first traversal of the tree, just like you have here,
>     not that it matters].

... but this one is better.

Unlike many others, fdt_next_node() does not have a comment in
dtc/libfdt/libfdt.h so I was not sure about what *depth is for and I
basically ignored fdt_next_node().


>   * You should check for overflows of your phandle counter, though
>     it's fine to treat that as a fatal error.

Ok.


>> +}
>> +
>>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>  {
>>      MachineState *machine = MACHINE(spapr);
>> @@ -1245,7 +1322,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>      /* Build memory reserve map */
>>      if (reset) {
>>          if (spapr->kernel_size) {
>> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
>> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
>> +                                  spapr->kernel_size)));
>>          }
>>          if (spapr->initrd_size) {
>>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
>> @@ -1268,12 +1346,19 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>>          }
>>      }
>>  
>> +    if (!spapr->bios_enabled) {
>> +        uint32_t phandle = 1;
>> +
>> +        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &phandle);
>> +    }
>> +
>>      return fdt;
>>  }
>>  
>>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>  {
>> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>> +    SpaprMachineState *spapr = opaque;
>> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>>  }
>>  
>>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
>> @@ -1660,6 +1745,60 @@ static void spapr_machine_reset(MachineState *machine)
>>       */
>>      fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
>>  
>> +    /* Set up the entry state */
>> +    if (!spapr->bios_enabled) {
>> +        if (spapr->claimed) {
>> +            g_array_unref(spapr->claimed);
>> +        }
>> +        spapr->claimed = g_array_new(false, false, sizeof(spapr_of_claimed));
>> +        spapr->claimed_base = 0x10000; /* Avoid using the first system page */
>> +
>> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt_addr);
>> +
>> +        if (spapr_do_client_claim(spapr, spapr->kernel_addr,
>> +                                  spapr->kernel_size, 0) == -1) {
>> +            error_report("Memory for kernel is in use");
>> +            exit(1);
>> +        }
>> +        if (spapr_do_client_claim(spapr, spapr->initrd_base,
>> +                                  spapr->initrd_size, 0) == -1) {
>> +            error_report("Memory for initramdisk is in use");
>> +            exit(1);
>> +        }
>> +        first_ppc_cpu->env.gpr[1] = spapr_do_client_claim(spapr, 0, 0x40000,
>> +                                                          0x10000);
>> +        if (first_ppc_cpu->env.gpr[1] == -1) {
>> +            error_report("Memory for stack is in use");
>> +            exit(1);
>> +        }
>> +
>> +        first_ppc_cpu->env.gpr[5] =
>> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.client),
>> +                                  sizeof(rtas_client_blob.client));
>> +        if (first_ppc_cpu->env.gpr[5] == -1) {
>> +            error_report("Memory for OF client is in use");
>> +            exit(1);
>> +        }
>> +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
>> +                                  rtas_client_blob.client,
>> +                                  sizeof(rtas_client_blob.client));
>> +
>> +        /* Allocate space for RTAS here so spapr_build_fdt() below picks it */
>> +        spapr->rtas_base =
>> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.rtas),
>> +                                  0x100);
>> +        if (spapr->rtas_base == -1) {
>> +            error_report("Memory for RTAS is in use");
>> +            exit(1);
>> +        }
>> +        cpu_physical_memory_write(spapr->rtas_base,
>> +                                  rtas_client_blob.rtas,
>> +                                  sizeof(rtas_client_blob.rtas));
> 
> The above is complex enough it might be worth having bios and nobios
> variants of spapr_cpu_set_entry_state().


Probably yes, when it settles. I'd rather prefer having kernel/initrd
claiming code where we load them but these are Roms and when we "load"
them, they are not loaded, they are loaded from a machine reset handler but:

may be we could add a hook to Roms to be called every time an image is
actually written to the guest memory and

this is when I would "claim" these chunks and

this would make the chunk above shorter and we won't need a separate
spapr_cpu_set_entry_state().


>> +    } else {
>> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>> +        first_ppc_cpu->env.gpr[5] = 0; /* 0 = kexec !0 = prom_init */
>> +    }
>> +
>>      fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
>>  
>>      rc = fdt_pack(fdt);
>> @@ -1675,10 +1814,14 @@ static void spapr_machine_reset(MachineState *machine)
>>      spapr->fdt_initial_size = spapr->fdt_size;
>>      spapr->fdt_blob = fdt;
>>  
>> -    /* Set up the entry state */
>> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>> -    first_ppc_cpu->env.gpr[5] = 0;
>> -
>> +    if (!spapr->bios_enabled) {
>> +        /*
>> +         * Claim FDT space so initramdisk/zImage are not unpacked over it.
>> +         * In practice Linux claim additional memory for FDT and fetches it
>> +         * using client interface's "getprop" call.
>> +         */
> 
> IIUC, it shouldn't actually be necessary to put the fdt into guest
> memory in nobios mode - it will be retrieved piecemeal via the client
> interface instead, won't it?

Huh. I was under the impression that we pass the FDT to a VM via GPR3
and it is safer to avoid "claim" from claiming this memory (even though
Linux is not using it).

Now I realize that this GPR3 is QEMU<->SLOF convention (or some OFW
binding - what is it exactly?) and Linux rather expects initramdisk
start/size in GPR3/4 and this did not hit me just because GPR4 is always
0 so Linux falls back to the device tree for initramdisk location.




> 
>> +        spapr_do_client_claim(spapr, fdt_addr, fdt_totalsize(fdt), 0);
>> +    }
>>      spapr->cas_reboot = false;
>>  }
>>  
>> @@ -2897,12 +3040,12 @@ static void spapr_machine_init(MachineState *machine)
>>          uint64_t lowaddr = 0;
>>  
>>          spapr->kernel_size = load_elf(kernel_filename, NULL,
>> -                                      translate_kernel_address, NULL,
>> +                                      translate_kernel_address, spapr,
>>                                        NULL, &lowaddr, NULL, 1,
>>                                        PPC_ELF_MACHINE, 0, 0);
>>          if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>>              spapr->kernel_size = load_elf(kernel_filename, NULL,
>> -                                          translate_kernel_address, NULL, NULL,
>> +                                          translate_kernel_address, spapr, NULL,
>>                                            &lowaddr, NULL, 0, PPC_ELF_MACHINE,
>>                                            0, 0);
>>              spapr->kernel_le = spapr->kernel_size > 0;
>> @@ -2918,7 +3061,7 @@ static void spapr_machine_init(MachineState *machine)
>>              /* Try to locate the initrd in the gap between the kernel
>>               * and the firmware. Add a bit of space just in case
>>               */
>> -            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
>> +            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
>>                                    + 0x1ffff) & ~0xffff;
>>              spapr->initrd_size = load_image_targphys(initrd_filename,
>>                                                       spapr->initrd_base,
>> @@ -2932,20 +3075,22 @@ static void spapr_machine_init(MachineState *machine)
>>          }
>>      }
>>  
>> -    if (bios_name == NULL) {
>> -        bios_name = FW_FILE_NAME;
>> +    if (spapr->bios_enabled) {
>> +        if (bios_name == NULL) {
>> +            bios_name = FW_FILE_NAME;
>> +        }
>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> +        if (!filename) {
>> +            error_report("Could not find LPAR firmware '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +        fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>> +        if (fw_size <= 0) {
>> +            error_report("Could not load LPAR firmware '%s'", filename);
>> +            exit(1);
>> +        }
>> +        g_free(filename);
>>      }
>> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> -    if (!filename) {
>> -        error_report("Could not find LPAR firmware '%s'", bios_name);
>> -        exit(1);
>> -    }
>> -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>> -    if (fw_size <= 0) {
>> -        error_report("Could not load LPAR firmware '%s'", filename);
>> -        exit(1);
>> -    }
>> -    g_free(filename);
>>  
>>      /* FIXME: Should register things through the MachineState's qdev
>>       * interface, this is a legacy from the sPAPREnvironment structure
>> @@ -3162,6 +3307,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>  }
>>  
>> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
>> +                                  void *opaque, Error **errp)
>> +{
>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>> +}
>> +
>> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
>> +                                  void *opaque, Error **errp)
>> +{
>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>> +}
> 
> Might be clearer to split the adjustable kernel addr stuff out into a
> separate patch - in fact, didn't you have such a patch before?


I did but it was not useful on its own and the whole "bios=off" feature
does not need to be "series" at this stage. Also having it separate
(before or after "kill slof") means changing same lines in 2 patches of
the same patchset which is never really good.


>> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> +
>> +    return spapr->bios_enabled;
>> +}
>> +
>> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> +
>> +    spapr->bios_enabled = value;
>> +}
>> +
>>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> @@ -3267,6 +3438,20 @@ static void spapr_instance_init(Object *obj)
>>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>>                               spapr_get_msix_emulation, NULL, NULL);
>>  
>> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
>> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
>> +                        &error_abort);
>> +    object_property_set_description(obj, "kernel-addr",
>> +                                    stringify(KERNEL_LOAD_ADDR)
>> +                                    " for -kernel is the default",
>> +                                    NULL);
>> +    spapr->kernel_addr = KERNEL_LOAD_ADDR;
>> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
>> +                            spapr_set_bios_enabled, NULL);
>> +    object_property_set_description(obj, "bios", "Conrols whether to load bios",
>> +                                    NULL);
>> +    spapr->bios_enabled = true;
>> +
>>      /* The machine class defines the default interrupt controller mode */
>>      spapr->irq = smc->irq;
>>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>> diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
>> new file mode 100644
>> index 000000000000..a318eaae3c40
>> --- /dev/null
>> +++ b/hw/ppc/spapr_client.c
>> @@ -0,0 +1,464 @@
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qapi/error.h"
>> +#include "exec/memory.h"
>> +#include "hw/ppc/spapr.h"
>> +#include "hw/ppc/spapr_vio.h"
>> +#include "trace.h"
>> +
>> +struct prom_args {
> 
> StudlyCaps and typedef, please..
> 
>> +        __be32 service;
>> +        __be32 nargs;
>> +        __be32 nret;
>> +        __be32 args[10];


btw we do not generally have __be32 (and x86 build fails), I am
replacing these with uint32_t.



>> +};
>> +
>> +#define CLI_PH_MASK     0x0FFFFFFF
>> +#define CLI_INST_PREFIX 0x20000000
>> +
>> +#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), sizeof(buf))
> 
> I'd prefer "readbuf" or something, since this isn't actually looking
> at any string structure.
> 
>> +#define readuint32(pa) ({ \
>> +    uint32_t __tmp__; \
>> +    cpu_physical_memory_read((pa), &__tmp__, sizeof(__tmp__)); \
>> +    be32_to_cpu(__tmp__); })
> 
> You can simplify this with ldl_be_phys().  In fact, then you probably
> don't need any wrapper at all.

Ah right. There are too many of these, was quicker to type this :)


>> +
>> +static bool _cmpservice(const char *s, size_t len,
>> +                        unsigned nargs, unsigned nret,
>> +                        const char *s1, size_t len1,
>> +                        unsigned nargscheck, unsigned nretcheck)
>> +{
>> +    if (strncmp(s, s1, MAX(len, len1))) {
>> +        return false;
>> +    }
>> +    if (nargscheck == 0 && nretcheck == 0) {
>> +        return true;
>> +    }
>> +    if (nargs != nargscheck || nret != nretcheck) {
>> +        trace_spapr_client_error_param(s, nargscheck, nretcheck, nargs, nret);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static uint32_t client_finddevice(const void *fdt, uint32_t nodeaddr)
>> +{
>> +    char node[256];
>> +    int ret;
>> +
>> +    readstr(nodeaddr, node);
>> +    ret = fdt_path_offset(fdt, node);
>> +    if (ret >= 0) {
>> +        ret = fdt_get_phandle(fdt, ret);
>> +    }
>> +
>> +    return (uint32_t) ret;
>> +}
>> +
>> +static uint32_t client_getprop(const void *fdt, uint32_t nodeph, uint32_t pname,
>> +            uint32_t valaddr, uint32_t vallen)
>> +{
>> +    char propname[64];
>> +    uint32_t ret = 0;
>> +    int proplen = 0;
>> +    const void *prop;
>> +
>> +    readstr(pname, propname);
>> +
>> +    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
>> +                               propname, strlen(propname), &proplen);
> 
> You can just use fdt_getprop().  By definition it's equivalent to
> fdt_getprop_namelen(.., propname, strlen(propname), ...)
> 
>> +    if (prop) {
>> +        int cb = MIN(proplen, vallen);
>> +
>> +        cpu_physical_memory_write(valaddr, prop, cb);
>> +        ret = cb;
>> +    } else if (strncmp(propname, "stdout", 6) == 0 && vallen == sizeof(ret)) {
>> +        ret = cpu_to_be32(1);
>> +        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, sizeof(ret)));
> 
> I'm guessing the special casing of stdout is to fake the OF instancing
> stuff, which I don't really understand.  Some comments to explain
> what's going on here would be good.


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/prom_init.c#n2219

This thing wants ihandle which is stored as /chosen/stdout and which we
do not have as there are no instances.

If this property is not there, prom_panic() happens.

I could implement some primitive intances, I'll look into this.

> 
>> +    } else {
>> +        ret = -1;
>> +    }
>> +    trace_spapr_client_getprop(nodeph, propname, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_setprop(SpaprMachineState *sm,
>> +                               uint32_t nodeph, uint32_t pname,
>> +                               uint32_t valaddr, uint32_t vallen)
>> +{
>> +    char propname[64];
>> +    uint32_t ret = -1;
>> +    int proplen = 0;
>> +    const void *prop;
>> +
>> +    readstr(pname, propname);
>> +    if (vallen == sizeof(uint32_t) &&
>> +        ((strncmp(propname, "linux,rtas-base", 15) == 0) ||
>> +         (strncmp(propname, "linux,rtas-entry", 16) == 0))) {
>> +
>> +        sm->rtas_base = readuint32(valaddr);
>> +        prop = fdt_getprop_namelen(sm->fdt_blob,
>> +                                   fdt_node_offset_by_phandle(sm->fdt_blob,
>> +                                                              nodeph),
>> +                                   propname, strlen(propname), &proplen);
>> +        if (proplen == vallen) {
>> +            *(uint32_t *) prop = cpu_to_be32(sm->rtas_base);
>> +            ret = proplen;
>> +        }
> 
> Is there a particular reason to restrict this to the rtas properties,
> rather than just allowing the guest to fdt_setprop() something
> arbitrary?

The FDT is flatten and I am not quite sure if libfdt can handle updating
properties if the length has changed.

Also, more importantly, potentially property changes like this may have
to be reflected in the QEMU device tree so I allowed only the properties
which I know how to deal with.


> 
>> +    }
>> +    trace_spapr_client_setprop(nodeph, propname, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_getproplen(const void *fdt, uint32_t nodeph,
>> +                                  uint32_t pname)
>> +{
>> +    char propname[64];
>> +    uint32_t ret = 0;
>> +    int proplen = 0;
>> +    const void *prop;
>> +
>> +    readstr(pname, propname);
>> +
>> +    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
>> +                               propname, strlen(propname), &proplen);
>> +    if (prop) {
>> +        ret = proplen;
>> +    } else if (strncmp(propname, "stdout", 6) == 0) {
>> +        ret = 4;
>> +    } else {
>> +        ret = -1;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_peer(const void *fdt, uint32_t phandle)
>> +{
>> +    int ret;
>> +
>> +    if (phandle == 0) {
>> +        ret = fdt_path_offset(fdt, "/");
>> +    } else {
>> +        ret = fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>> +    }
>> +
>> +    if (ret < 0) {
>> +        ret = 0;
>> +    } else {
>> +        ret = fdt_get_phandle(fdt, ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_child(const void *fdt, uint32_t phandle)
>> +{
>> +    int ret = fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>> +
>> +    if (ret < 0) {
>> +        ret = 0;
>> +    } else {
>> +        ret = fdt_get_phandle(fdt, ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_parent(const void *fdt, uint32_t phandle)
>> +{
>> +    int ret = fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt, phandle));
>> +
>> +    if (ret < 0) {
>> +        ret = 0;
>> +    } else {
>> +        ret = fdt_get_phandle(fdt, ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_open(uint32_t phandle)
>> +{
>> +    uint32_t ret = (phandle & CLI_PH_MASK) | CLI_INST_PREFIX;
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_instance_to_path(SpaprMachineState *sm,
>> +                                        uint32_t instance, uint32_t buf,
>> +                                        uint32_t len)
>> +{
>> +    uint32_t ph = instance & CLI_PH_MASK;
>> +    char *stdout_path = spapr_vio_stdout_path(sm->vio_bus);
>> +    int stdout_ph = fdt_path_offset(sm->fdt_blob, stdout_path);
>> +
>> +    if (ph == stdout_ph) {
>> +        len = MIN(len, strlen(stdout_path));
>> +        cpu_physical_memory_write(buf, stdout_path, len);
>> +    } else  {
>> +        len = 0;
>> +    }
>> +    g_free(stdout_path);
>> +
>> +    return len;
>> +}
>> +
>> +static uint32_t client_package_to_path(const void *fdt, uint32_t phandle,
>> +                                       uint32_t buf, uint32_t len)
>> +{
>> +    char tmp[256];
> 
> Fixed sized buffers are icky.  You could either dynamically allocate
> this based on the size the client gives, or you could use
> memory_region_get_ram_ptr() to read the data from the tree directly
> into guest memory.

True, will fix.


>> +    if (0 == fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle), tmp,
>> +                          sizeof(tmp))) {
>> +        tmp[sizeof(tmp) - 1] = 0;
>> +        cpu_physical_memory_write(buf, tmp, MIN(len, strlen(tmp)));
>> +    }
>> +    return len;
>> +}
>> +
>> +static uint32_t client_write(uint32_t instance, uint32_t buf, uint32_t len)
>> +{
>> +    char tmp[len + 1]; /* TODO: do a loop as len might be enourmous*/
>> +
>> +    readstr(buf, tmp);
>> +    tmp[len] = 0;
>> +    printf("%s", tmp);
> 
> I'm guessing this is what's used for console output via OF.  This is
> enough for a debugging PoC, but for real we'll need to have this
> actually go via the appropriate qemu chardev.

Yes, this is for PoC. instance need to be tracked back to the actual
device and I just do not have instances now.


>> +
>> +    return len;
>> +}
>> +
>> +static bool client_claim_avail(SpaprMachineState *sm, uint64_t virt,
>> +                               uint64_t size)
>> +{
>> +    int i;
>> +    spapr_of_claimed *c;
>> +
>> +    for (i = 0; i < sm->claimed->len; ++i) {
>> +        c = &g_array_index(sm->claimed, spapr_of_claimed, i);
>> +        if ((c->start <= virt && virt < c->start + c->size) ||
>> +            (virt <= c->start && c->start < virt + size)) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +uint64_t spapr_do_client_claim(SpaprMachineState *sm,
> 
> SpaprMachineState * are usually called 'spapr', not 'sm'.

Ok I'll fix but include/hw/ppc/spapr.h disagrees with you, this was the
place where I added the very first function prototype which started all
this :)


> 
>> uint64_t virt,
>> +                               uint64_t size, uint64_t align)
>> +{
>> +    uint32_t ret;
>> +    spapr_of_claimed newclaim;
>> +
>> +    if (align == 0) {
>> +        if (!client_claim_avail(sm, virt, size)) {
>> +            return -1;
>> +        }
>> +        ret = virt;
>> +    } else {
>> +        align = pow2ceil(align);
>> +        sm->claimed_base = (sm->claimed_base + align - 1) & ~(align - 1);
>> +        while (1) {
>> +            if (sm->claimed_base >= sm->rma_size) {
>> +                perror("Out of memory");
> 
> This should be an error_report() rather than a perror().
> 
>> +                return -1;
>> +            }
>> +            if (client_claim_avail(sm, sm->claimed_base, size)) {
>> +                break;
>> +            }
>> +            sm->claimed_base += size;
>> +        }
>> +        ret = sm->claimed_base;
>> +    }
>> +
>> +    sm->claimed_base = MAX(sm->claimed_base, ret) + size;
> 
> I understand the logic with claimed_base.  It looks like you're
> implementing a bump allocator, but isn't the the client passing in the
> address to claim anyway, so why do you need an allocator?


The client passes 3 numbers - address, size, align, the address is only
used when align==0. So it is either allocating or claiming. I was not
quite sure if address==0 mode is (not) used, especially for zImage.

Having said that, I noticed that Linux always calls "claim" with
non-zero address and increments it until it succeeded so I can ignore
allocating case when called by Linux. I still need some
allocator/claimer for myself though.


> 
>> +    newclaim.start = virt;
>> +    newclaim.size = size;
>> +    g_array_append_val(sm->claimed, newclaim);
>> +    trace_spapr_client_claim(virt, size, align, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static uint32_t client_claim(SpaprMachineState *sm, uint32_t virt,
>> +                             uint32_t size, uint32_t align)
>> +{
>> +    return spapr_do_client_claim(sm, virt, size, align);
> 
> Um.. why this wrapper?


It grew to this. And I may add separate claim() and alloc() and only
call claim() from here.

> 
>> +}
>> +
>> +static uint32_t client_nextprop(const void *fdt, uint32_t phandle,
>> +                                uint32_t prevaddr, uint32_t nameaddr)
>> +{
>> +    int namelen = 0;
>> +    int offset = fdt_node_offset_by_phandle(fdt, phandle);
>> +    char prev[256];
> 
> Ew, fixed sized buffer.
> 
>> +    const struct fdt_property *prop;
>> +    const char *tmp;
>> +
>> +    readstr(prevaddr, prev);
>> +    for (offset = fdt_first_property_offset(fdt, offset);
>> +         (offset >= 0);
>> +         (offset = fdt_next_property_offset(fdt, offset))) {
>> +
>> +        prop = fdt_get_property_by_offset(fdt, offset, &namelen);
> 
> fdt_getprop_by_offset() also returns the property's name without
> having to dick around with fdt_get_string() manually.


Ah you're right.


> 
>> +        if (!prop) {
>> +            return 0;
>> +        }
>> +
>> +        tmp = fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namelen);
>> +        if (prev[0] == 0 ||
> 
> == '\0' please.
> 
>> +            strncmp(prev, tmp, MAX(namelen, strlen(prev))) == 0) {
> 
> This will break very badly if the client passed a name larger than
> sizeof(prev), since readstr() won't \0 terminate in that case IIUC.
> 
>> +            if (prev[0]) {
>> +                offset = fdt_next_property_offset(fdt, offset);
>> +                if (offset < 0) {
>> +                    return 0;
>> +                }
>> +            }
>> +            prop = fdt_get_property_by_offset(fdt, offset, &namelen);
>> +            if (!prop) {
>> +                return 0;
>> +            }
>> +
>> +            tmp = fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namelen);
>> +            cpu_physical_memory_write(nameaddr, tmp, namelen + 1);
>> +            return 1;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static uint32_t client_call_method(SpaprMachineState *sm, uint32_t methodaddr,
>> +                                   uint32_t param1, uint32_t param2,
>> +                                   uint32_t *ret2)
>> +{
>> +    uint32_t ret = 0;
>> +    char method[256];
> 
> More fixed sized buffers.
> 
>> +    readstr(methodaddr, method);
>> +    if (strncmp(method, "ibm,client-architecture-support", 31) == 0) {
>> +
>> +#define FDT_MAX_SIZE            0x100000
>> +        ret = do_client_architecture_support(POWERPC_CPU(first_cpu), sm, param2,
>> +                                             0, FDT_MAX_SIZE);
>> +        *ret2 = 0;
>> +    } else if (strncmp(method, "instantiate-rtas", 16) == 0) {
>> +        uint32_t rtasbase = param2;
>> +
>> +        spapr_instantiate_rtas(sm, rtasbase);
>> +        *ret2 = rtasbase;
> 
> In both these cases you ignore param1.  I'm guessing it has the handle
> of the node on which you're calling the method?  In which case you
> really should validate it.

It is an ihandle which I do not do now.


> 
>> +    } else {
>> +        trace_spapr_client_error_unknown_method(method);
>> +        return -1;
>> +    }
>> +
>> +    trace_spapr_client_method(method, param1, param2, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static void client_quiesce(SpaprMachineState *sm)
>> +{
> 
> Possibly want a flush of stdout here.
> 
>> +}
>> +
>> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args)
>> +{
>> +    struct prom_args args = { 0 };
>> +    char service[64];
> 
> More fixed sized buffers.
> 
>> +    unsigned nargs, nret;
>> +    int i, servicelen;
>> +
>> +    cpu_physical_memory_read(client_args, &args, sizeof(args));
>> +    nargs = be32_to_cpu(args.nargs);
>> +    nret = be32_to_cpu(args.nret);
>> +    readstr(be32_to_cpu(args.service), service);
>> +    servicelen = strlen(service);
>> +
>> +#define cmpservice(s, a, r) \
>> +        _cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a), (r))
>> +
>> +    if (cmpservice("finddevice", 1, 1)) {
> 
> Hrm.  Rather than this giant chain of if(cmp) checks, I'd prefer to
> have a table of services as a data structure, which the code would
> scan through.  That does mean you'd have to give the functions
> implementing each service a common signature, so they'd need to parse
> out their own parameters, but I still think it's the better option.
> It also makes it closer to how we implement RTAS call dispatch.


I seriously doubt it will make the code simpler/shorter/easier; and it
will move certain checks from compile time to run time. Dispatch tables
make sense for "call-method" but for the others not so much. Thanks,


>> +        args.args[nargs] = client_finddevice(sm->fdt_blob,
>> +                                             be32_to_cpu(args.args[0]));
>> +    } else if (cmpservice("getprop", 4, 1)) {
>> +        args.args[nargs] = client_getprop(sm->fdt_blob,
>> +                                          be32_to_cpu(args.args[0]),
>> +                                          be32_to_cpu(args.args[1]),
>> +                                          be32_to_cpu(args.args[2]),
>> +                                          be32_to_cpu(args.args[3]));
>> +    } else if (cmpservice("getproplen", 2, 1)) {
>> +        args.args[nargs] = client_getproplen(sm->fdt_blob,
>> +                                             be32_to_cpu(args.args[0]),
>> +                                             be32_to_cpu(args.args[1]));
>> +    } else if (cmpservice("setprop", 4, 1)) {
>> +        args.args[nargs] = client_setprop(sm,
>> +                                          be32_to_cpu(args.args[0]),
>> +                                          be32_to_cpu(args.args[1]),
>> +                                          be32_to_cpu(args.args[2]),
>> +                                          be32_to_cpu(args.args[3]));
>> +    } else if (cmpservice("instance-to-path", 3, 1)) {
>> +        args.args[nargs] = client_instance_to_path(sm,
>> +                                                   be32_to_cpu(args.args[0]),
>> +                                                   be32_to_cpu(args.args[1]),
>> +                                                   be32_to_cpu(args.args[2]));
>> +    } else if (cmpservice("package-to-path", 3, 1)) {
>> +        args.args[nargs] = client_package_to_path(sm->fdt_blob,
>> +                                                  be32_to_cpu(args.args[0]),
>> +                                                  be32_to_cpu(args.args[1]),
>> +                                                  be32_to_cpu(args.args[2]));
>> +    } else if (cmpservice("write", 3, 1)) {
>> +        args.args[nargs] = client_write(be32_to_cpu(args.args[0]),
>> +                                        be32_to_cpu(args.args[1]),
>> +                                        be32_to_cpu(args.args[2]));
>> +    } else if (cmpservice("peer", 1, 1)) {
>> +        args.args[nargs] = client_peer(sm->fdt_blob,
>> +                                       be32_to_cpu(args.args[0]));
>> +    } else if (cmpservice("child", 1, 1)) {
>> +        args.args[nargs] = client_child(sm->fdt_blob,
>> +                                        be32_to_cpu(args.args[0]));
>> +    } else if (cmpservice("parent", 1, 1)) {
>> +        args.args[nargs] = client_parent(sm->fdt_blob,
>> +                                         be32_to_cpu(args.args[0]));
>> +    } else if (cmpservice("open", 1, 1)) {
>> +        args.args[nargs] = client_open(be32_to_cpu(args.args[0]));
>> +    } else if (cmpservice("call-method", 3, 2)) {
>> +        uint32_t ret2 = 0;
>> +
>> +        args.args[nargs] = client_call_method(sm,
>> +                                              be32_to_cpu(args.args[0]),
>> +                                              be32_to_cpu(args.args[1]),
>> +                                              be32_to_cpu(args.args[2]),
>> +                                              &ret2);
>> +        args.args[nargs + 1] = ret2;
>> +    } else if (cmpservice("claim", 3, 1)) {
>> +        args.args[nargs] = client_claim(sm,
>> +                                        be32_to_cpu(args.args[0]),
>> +                                        be32_to_cpu(args.args[1]),
>> +                                        be32_to_cpu(args.args[2]));
>> +    } else if (cmpservice("nextprop", 3, 1)) {
>> +        args.args[nargs] = client_nextprop(sm->fdt_blob,
>> +                                           be32_to_cpu(args.args[0]),
>> +                                           be32_to_cpu(args.args[1]),
>> +                                           be32_to_cpu(args.args[2]));
>> +    } else if (cmpservice("quiesce", 0, 0)) {
>> +        client_quiesce(sm);
>> +    } else if (cmpservice("exit", 0, 0)) {
>> +        error_report("Stopped as the VM requested \"exit\"");
>> +        vm_stop(RUN_STATE_PAUSED);
>> +    } else {
>> +        trace_spapr_client_error_unknown_service(service, nargs, nret);
>> +        args.args[nargs] = -1;
>> +    }
>> +
>> +    for (i = 0; i < nret; ++i) {
>> +        args.args[nargs + i] = be32_to_cpu(args.args[nargs + i]);
>> +    }
>> +    cpu_physical_memory_write(client_args, &args, sizeof(args));
>> +
>> +    return H_SUCCESS;
>> +}
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index f1799b1b707d..76f93ec37959 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1660,15 +1660,12 @@ static bool spapr_hotplugged_dev_before_cas(void)
>>      return false;
>>  }
>>  
>> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>> -                                                  SpaprMachineState *spapr,
>> -                                                  target_ulong opcode,
>> -                                                  target_ulong *args)
>> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>> +                                            SpaprMachineState *spapr,
>> +                                            target_ulong addr,
>> +                                            target_ulong fdt_buf,
>> +                                            target_ulong fdt_bufsize)
>>  {
>> -    /* Working address in data buffer */
>> -    target_ulong addr = ppc64_phys_to_real(args[0]);
>> -    target_ulong fdt_buf = args[1];
>> -    target_ulong fdt_bufsize = args[2];
>>      target_ulong ov_table;
>>      uint32_t cas_pvr;
>>      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
>> @@ -1833,13 +1830,15 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>  
>>          fdt_bufsize -= sizeof(hdr);
>>  
>> -        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
>> +        fdt = spapr_build_fdt(spapr, !spapr->bios_enabled, fdt_bufsize);
>>          _FDT((fdt_pack(fdt)));
>>  
>> -        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
>> -        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
>> -                                  fdt_totalsize(fdt));
>> -        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
>> +        if (spapr->bios_enabled) {
>> +            cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
>> +            cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
>> +                                      fdt_totalsize(fdt));
>> +            trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
>> +        }
>>  
>>          g_free(spapr->fdt_blob);
>>          spapr->fdt_size = fdt_totalsize(fdt);
>> @@ -1854,6 +1853,20 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>      return H_SUCCESS;
>>  }
>>  
>> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>> +                                                  SpaprMachineState *spapr,
>> +                                                  target_ulong opcode,
>> +                                                  target_ulong *args)
>> +{
>> +    /* Working address in data buffer */
>> +    target_ulong addr = ppc64_phys_to_real(args[0]);
>> +    target_ulong fdt_buf = args[1];
>> +    target_ulong fdt_bufsize = args[2];
>> +
>> +    return do_client_architecture_support(cpu, spapr, addr, fdt_buf,
>> +                                          fdt_bufsize);
>> +}
>> +
>>  static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>>                                                SpaprMachineState *spapr,
>>                                                target_ulong opcode,
>> @@ -1998,6 +2011,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>      return H_SUCCESS;
>>  }
>>  
>> +static target_ulong h_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                             target_ulong opcode, target_ulong *args)
>> +{
>> +    target_ulong client_args = ppc64_phys_to_real(args[0]);
>> +
>> +    return spapr_h_client(spapr, client_args);
>> +}
>> +
>>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
>>  static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BASE) / 4 + 1];
>> @@ -2121,6 +2142,8 @@ static void hypercall_register_types(void)
>>  
>>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>>  
>> +    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
>> +
>>      /* Virtual Processor Home Node */
>>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
>>                               h_home_node_associativity);
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index 9ea620f23c85..92bce3e44693 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -21,6 +21,15 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
>>  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>>  
>> +# spapr_client.c
>> +spapr_client_error_param(const char *method, int nargscheck, int nretcheck, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
>> +spapr_client_error_unknown_service(const char *service, int nargs, int nret) "%s args=%d rets=%d"
>> +spapr_client_error_unknown_method(const char *method) "%s"
>> +spapr_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) "virt=0x%x size=0x%x align=0x%x => 0x%x"
>> +spapr_client_method(const char *method, uint32_t param1, uint32_t param2, uint32_t ret) "%s(0x%x, 0x%x) => 0x%x"
>> +spapr_client_getprop(uint32_t ph, const char *prop, uint32_t ret) "phandle=0x%x \"%s\" => 0x%x"
>> +spapr_client_setprop(uint32_t ph, const char *prop, uint32_t ret) "phandle=0x%x \"%s\" => 0x%x"
>> +
>>  # spapr_hcall_tpm.c
>>  spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
>>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
> 

-- 
Alexey

