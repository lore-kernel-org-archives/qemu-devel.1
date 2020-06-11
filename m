Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BA620656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXfZtLfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BA620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIwK-0003GX-Iu
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjIvX-0002qT-Ei
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:51:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54925)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjIvW-0004Dv-Es
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:51:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id g10so4199636wmh.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XcV31mE9cV85LRDKBkaUuOKqUXVQcEtcxcXOxsgcs4M=;
 b=DXfZtLfIJ6BE4siMm8LmrYiene3EC066wjBuabCz1ohSCHkbLmm02XNg3aSQrRMmPm
 d9TzjwYrP4+g1spj5MJt+vpSb3fKvGM3to2kEopbmugOQ0rWsrohzmzoy3mnoZT0bq/I
 Hn4NkFASPghH8cXI03FtoxSDwhGyKv8LVMH26D/m/WGWYlKlFg+qw7Z4Y+fwAgqwxi1d
 ZjIw5/Y6dMBKLzKTdT6Ec0mqmYcSexhO8jrbcHpGscwqVJGIOMJY1aXIkqWUmWo8r50k
 uiFmSxtC0EBOMluPVDt/9RY8XRYFWyymkSnDvsSHDpewyFw/GtwnYyDIVnuI7iZZUs55
 SgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XcV31mE9cV85LRDKBkaUuOKqUXVQcEtcxcXOxsgcs4M=;
 b=qGE/sNvKwEBAlUIerZfrnC7FEkqw1AXS8UX4ktaOkiY7Y+gQUWZaEAaL+6wJtwH/O+
 OxRyI7+nTe+AcoyHbOu4erRRCodzvS+senjkZJbso0Y8GY4UXFDY2UyZElGXNSjgggFr
 qm0hXnmk0A+cyLSj0sfl6F8cjColeB7W3KwjV+Hg8ovj6ANREn5iWenM252SOvDnVxhL
 tZN7KEUzTHHMCC0IbV2gLtrehuo4iupF3WYHhgxrHz7UMhXlASAGZrHM2ti/vggZ2z14
 r7A53C/A9mly+j1LbAkqNVXkDrPH+jvPIDb2GMWcCqvrZUFkqeSYix9ISadrt4rFzfXV
 kTKQ==
X-Gm-Message-State: AOAM531/qT/jzHoVBtXk0jjpFiMg7Ye8rR15DQBLz5oN4x/GLx+cCvA9
 F/mqkx8QCeudxmQI7f/LAT0+B4c3ThW6BRaRS+M=
X-Google-Smtp-Source: ABdhPJyn57R5h+I26YEdCt+5sJ5xnT5/2JWBbE6iKLGSj5M57bhUNvoZtg58r5jJ4VyanB0Kk4r3ZigM/7LsCts3Hxc=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr7584148wmb.168.1591865463862; 
 Thu, 11 Jun 2020 01:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-4-git-send-email-chenhc@lemote.com>
 <59a6cfbb-3b53-1ca0-7871-5956b4188e31@flygoat.com>
 <CAAhV-H66OdX3zNwWj5sRjAWLJWoB5GPLsj1-MnV5G8Dt0i_RmQ@mail.gmail.com>
 <3cfda172-7637-2791-cf65-0ba7a2e4c6bb@flygoat.com>
In-Reply-To: <3cfda172-7637-2791-cf65-0ba7a2e4c6bb@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 10:50:45 +0200
Message-ID: <CAHiYmc7BoPkwDHOoOOKAWdW7gyZ5UiDAZZ0A8v8EZheP3GxhNQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >>> +    int fd = 0, freq = 0;
> >>> +    char buf[1024], *buf_p;

1024 should have been defined via preprocessor constant

> >>> +
> >>> +    fd = open("/proc/cpuinfo", O_RDONLY);
> >>> +    if (fd == -1) {
> >>> +        fprintf(stderr, "Failed to open /proc/cpuinfo!\n");
> >>> +        return 0;
> >>> +    }
> >>> +
> >>> +    if (read(fd, buf, 1024) < 0) {

The same constant should be used here.

...

> >>> +    loaderparams.a1 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR;
> >>> +    loaderparams.a2 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR + ret;

What is 0xffffffff80000000ULL? Preprocessor constant possible?

...

> >>> +    if (!kvm_enabled()) {
> >>> +        if (!machine->cpu_type) {
> >>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
> >>> +        }
> >>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> >>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
> >>> +            exit(1);
> >>> +        }
> >>> +    } else {
> >>> +        if (!machine->cpu_type) {
> >>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> >>> +        }
> >>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> >>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
> >>> +            exit(1);
> >>> +        }
> >>> +    }

Some explanation needs to be written in comments about the code segment above.

I find the whole segment a little bit questionable. For non-KVM one
CPU, for KVM another? Why non-KVM can't use both, and allow to be
specified via command line?

> >>> +    memory_region_add_subregion(address_space_mem, 0x00000000LL, ram);
> >>> +    memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
> >>> +    memory_region_add_subregion(address_space_mem, 0x80000000LL, machine->ram);
> >>> +    memory_region_add_subregion(address_space_mem, PM_MMIO_ADDR, iomem);

I would avoid hard coded numbers.

> >>> +
> >>> +    /*
> >>> +     * We do not support flash operation, just loading pmon.bin as raw BIOS.
> >>> +     * Please use -L to set the BIOS path and -bios to set bios name.
> >>> +     */
> >>> +
> >>> +    if (kernel_filename) {
> >>> +        loaderparams.ram_size = ram_size;
> >>> +        loaderparams.kernel_filename = kernel_filename;
> >>> +        loaderparams.kernel_cmdline = kernel_cmdline;
> >>> +        loaderparams.initrd_filename = initrd_filename;
> >>> +        loaderparams.kernel_entry = load_kernel(env);
> >>> +        rom_add_blob_fixed("bios",
> >>> +                         bios_boot_code, sizeof(bios_boot_code), 0x1fc00000LL);

Again, here, 0x1fc00000LL. This should be defined and properly named
via preprocessor.

> >>> +    } else {
> >>> +        if (bios_name == NULL) {
> >>> +                bios_name = LOONGSON3_BIOSNAME;
> >>> +        }
> >>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >>> +        if (filename) {
> >>> +            bios_size = load_image_targphys(filename, 0x1fc00000LL,

Again.

> >>> +                                            BIOS_SIZE);
> >>> +            g_free(filename);
> >>> +        } else {
> >>> +            bios_size = -1;
> >>> +        }
> >>> +
> >>> +    if (serial_hd(0)) {
> >>> +        serial_mm_init(address_space_mem, 0x1fe001e0, 0, env->irq[2],
> >>> +                           115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);

115200 should be something like XXX_DEFAULT_BAUDRATE

> >>> +    }
> >>> +}
> >>> +
> >>> +static void mips_loongson3_machine_init(MachineClass *mc)
> >>> +{
> >>> +    mc->desc = "Generic Loongson-3 Platform";
> >>> +    mc->init = mips_loongson3_init;
> >>> +    mc->block_default_type = IF_IDE;
> >>> +    mc->max_cpus = LOONGSON_MAX_VCPUS;
> >>> +    mc->default_ram_id = "loongson3.highram";
> >>> +    mc->default_ram_size = 1200 * MiB;
> >>
> >> 1200MiB looks wired... Why not 1024?
> > Oh, it is just because our Fedora28 needs more than 1024MB to work
> > fine, maybe 1280 is better?
>
> Ahh if that's the reason then it looks fine for me.
>

These choices should be documented in brief comments.

If left this way, we leave future developers solve puzzles and
desperately guessing.

Thanks,
Aleksandar

