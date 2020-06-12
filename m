Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC430C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 06:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FAA207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 06:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVtpmalH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FAA207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjcrA-0003oH-I8
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 02:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jjcqY-0003PH-Iq
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 02:07:22 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40668)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jjcqW-0001ij-Nx
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 02:07:22 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so9054949iow.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t3D9FNXPrtqJKKZIQ3ESiVhTjtn2P2k7Yn10zwoZxNM=;
 b=WVtpmalHyr3hfwV/Ky9N9MgwssvsBHRkUtHcIs+r4ygamzzlinrlbEVofRQX9lYcrw
 YbvWBRx5I2OfvJ0FHeQYoP3U+jnqvzENgS+FDnmPHpQI3h+2XDZ52P6vpRjaP4uOqTt5
 qnDu7IwSMRAIij+fET4TUB9jKbrEUU4IeWVR0pm+ryIfwaADF5mfRhIau6QzeHDJo/dl
 bvDsDp/3WV01F61fYl/KWlad5V+vEpJPvEvX1qnLYGsSWhD3kpH+DhH19ZidXWvj5/iI
 qX8Rd9idYn8mOXsGzuf8FdKC9J+PfgFEQkTc7NrVqcE95PsdoaBZuktQ1rd0yz0L/o1l
 uUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t3D9FNXPrtqJKKZIQ3ESiVhTjtn2P2k7Yn10zwoZxNM=;
 b=Htxy3RDbMXEVqluvGHvXMeUFAuBhRq5xOvolt9O1DrAcufycXnpKYJdV4lSLEiahS2
 DA50ha6JaZ5fuxb39wQ+PnaTi72I8I1mQkxWHp6GavyGd2YBmsR/iDiFTbxXx/zuAdH3
 ZZd1giXnSnvH7asqzI1YLxJkOlzrN3tUUCq4CsPK5QXvO98RJk+lbXOgTRdVlYogXucD
 EJUSlONB0BWaahGhQ9xsgV4AOgTFJpR2zFRQ5vxNM237A7yuK0uYIA/WD2k9rRgNrIY7
 eBIPXBdh1k0VkBFn/cDV5a6GHpG8n3k5cvBOnfNnez/QBsSBjHhoGY1pt+Xod0IicfbP
 HmmA==
X-Gm-Message-State: AOAM530HlWiEgOPApNduC64McvHOX/mL8niCdneQoeNUtT6VE94A0bsb
 YJpJb2LgYBny2v0Usr0HoACviLkEIv2ZgUMEOLg=
X-Google-Smtp-Source: ABdhPJyqHfF+X9NVqkAaVXJezoJqq79pRl1F0CRKwEYNWUO7p/8bCtmLMblqgPEwfiXDitWKu+7x3EFGpHh+QF40txU=
X-Received: by 2002:a5d:9dd2:: with SMTP id 18mr12093950ioo.196.1591942034451; 
 Thu, 11 Jun 2020 23:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-4-git-send-email-chenhc@lemote.com>
 <59a6cfbb-3b53-1ca0-7871-5956b4188e31@flygoat.com>
 <CAAhV-H66OdX3zNwWj5sRjAWLJWoB5GPLsj1-MnV5G8Dt0i_RmQ@mail.gmail.com>
 <3cfda172-7637-2791-cf65-0ba7a2e4c6bb@flygoat.com>
 <CAHiYmc7BoPkwDHOoOOKAWdW7gyZ5UiDAZZ0A8v8EZheP3GxhNQ@mail.gmail.com>
In-Reply-To: <CAHiYmc7BoPkwDHOoOOKAWdW7gyZ5UiDAZZ0A8v8EZheP3GxhNQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 12 Jun 2020 14:07:02 +0800
Message-ID: <CAAhV-H5baiT+agBm8-Oo1NZ+vXBQELivpicmcuOqSgqLB5zWAg@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Alexandar,

On Thu, Jun 11, 2020 at 4:51 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> > >>> +    int fd = 0, freq = 0;
> > >>> +    char buf[1024], *buf_p;
>
> 1024 should have been defined via preprocessor constant
>
> > >>> +
> > >>> +    fd = open("/proc/cpuinfo", O_RDONLY);
> > >>> +    if (fd == -1) {
> > >>> +        fprintf(stderr, "Failed to open /proc/cpuinfo!\n");
> > >>> +        return 0;
> > >>> +    }
> > >>> +
> > >>> +    if (read(fd, buf, 1024) < 0) {
>
> The same constant should be used here.
>
> ...
>
> > >>> +    loaderparams.a1 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR;
> > >>> +    loaderparams.a2 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR + ret;
>
> What is 0xffffffff80000000ULL? Preprocessor constant possible?
>
> ...
>
> > >>> +    if (!kvm_enabled()) {
> > >>> +        if (!machine->cpu_type) {
> > >>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
> > >>> +        }
> > >>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> > >>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
> > >>> +            exit(1);
> > >>> +        }
> > >>> +    } else {
> > >>> +        if (!machine->cpu_type) {
> > >>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> > >>> +        }
> > >>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> > >>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
> > >>> +            exit(1);
> > >>> +        }
> > >>> +    }
>
> Some explanation needs to be written in comments about the code segment above.
>
> I find the whole segment a little bit questionable. For non-KVM one
> CPU, for KVM another? Why non-KVM can't use both, and allow to be
> specified via command line?
>
> > >>> +    memory_region_add_subregion(address_space_mem, 0x00000000LL, ram);
> > >>> +    memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
> > >>> +    memory_region_add_subregion(address_space_mem, 0x80000000LL, machine->ram);
> > >>> +    memory_region_add_subregion(address_space_mem, PM_MMIO_ADDR, iomem);
>
> I would avoid hard coded numbers.
>
> > >>> +
> > >>> +    /*
> > >>> +     * We do not support flash operation, just loading pmon.bin as raw BIOS.
> > >>> +     * Please use -L to set the BIOS path and -bios to set bios name.
> > >>> +     */
> > >>> +
> > >>> +    if (kernel_filename) {
> > >>> +        loaderparams.ram_size = ram_size;
> > >>> +        loaderparams.kernel_filename = kernel_filename;
> > >>> +        loaderparams.kernel_cmdline = kernel_cmdline;
> > >>> +        loaderparams.initrd_filename = initrd_filename;
> > >>> +        loaderparams.kernel_entry = load_kernel(env);
> > >>> +        rom_add_blob_fixed("bios",
> > >>> +                         bios_boot_code, sizeof(bios_boot_code), 0x1fc00000LL);
>
> Again, here, 0x1fc00000LL. This should be defined and properly named
> via preprocessor.
>
> > >>> +    } else {
> > >>> +        if (bios_name == NULL) {
> > >>> +                bios_name = LOONGSON3_BIOSNAME;
> > >>> +        }
> > >>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > >>> +        if (filename) {
> > >>> +            bios_size = load_image_targphys(filename, 0x1fc00000LL,
>
> Again.
>
> > >>> +                                            BIOS_SIZE);
> > >>> +            g_free(filename);
> > >>> +        } else {
> > >>> +            bios_size = -1;
> > >>> +        }
> > >>> +
> > >>> +    if (serial_hd(0)) {
> > >>> +        serial_mm_init(address_space_mem, 0x1fe001e0, 0, env->irq[2],
> > >>> +                           115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
>
> 115200 should be something like XXX_DEFAULT_BAUDRATE
>
> > >>> +    }
> > >>> +}
> > >>> +
> > >>> +static void mips_loongson3_machine_init(MachineClass *mc)
> > >>> +{
> > >>> +    mc->desc = "Generic Loongson-3 Platform";
> > >>> +    mc->init = mips_loongson3_init;
> > >>> +    mc->block_default_type = IF_IDE;
> > >>> +    mc->max_cpus = LOONGSON_MAX_VCPUS;
> > >>> +    mc->default_ram_id = "loongson3.highram";
> > >>> +    mc->default_ram_size = 1200 * MiB;
> > >>
> > >> 1200MiB looks wired... Why not 1024?
> > > Oh, it is just because our Fedora28 needs more than 1024MB to work
> > > fine, maybe 1280 is better?
> >
> > Ahh if that's the reason then it looks fine for me.
> >
>
> These choices should be documented in brief comments.
>
> If left this way, we leave future developers solve puzzles and
> desperately guessing.
>
> Thanks,
> Aleksandar
Thank you for your advice, I will improve that.

Huacai

