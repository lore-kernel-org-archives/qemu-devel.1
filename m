Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE4C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 01:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4E621D43
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 01:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxZ8w4aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4E621D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJRGa-0000Ua-25
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 21:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kJRF3-0008UC-LH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 21:00:42 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kJRF1-00038J-3E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 21:00:41 -0400
Received: by mail-io1-xd43.google.com with SMTP id r25so9052644ioj.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R1YHF3NxcNs53+6IjRGYPBYBLOmRZ3gwW3qtyuskw28=;
 b=NxZ8w4awu9pp5LoU5ALOgz1e7Wpt8zP95Abr6g4AOOS6DdeukMSSP/C9rqhagQy9LR
 7RzPVLeVbow7b95g7vYo95+MH4XR59BSVgnhwhwJ/mabG73Db2vHX7wRfiqwzFzlBZbS
 NB+d3h9aCpZNDsNa1n4tIs778dVsrw/9fujiK+fJITQHeg8uSvVWCuSwK45K94fjpjTu
 oDviu7mpcgw6utg/JpSHlMwQCil5FgZwY0LgcLH/xMGjhAzQhxhXORUxLSbRsPu8mdsM
 okkuMmltrP0bpJvk7GdHXsOiw0p8/tlaEbjWgswPmdXKtQHFDosCJlT80Z67PFKtCSvz
 zWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R1YHF3NxcNs53+6IjRGYPBYBLOmRZ3gwW3qtyuskw28=;
 b=CE9vzMyy1HB3odqSrXQPjitMNDin6EhPoVeoi3bPE2H8Kvo/iBfuE8Ar6f32sncZVb
 sZ80sOtVJGfqqWV1NtkazVw+qlpXkYSGFkWfVW0Vgn143f5VZwspR2BL0fXKC2OFkjak
 3eH4i3aePhMBFZW0eeBcssrP6GKbeDYxZIsYSBjyE67NHCKq6JoTJJpcb8GOjR8JE9cj
 H4U1+YyW4ig/j2b+sAgFOiMeOWiHTxpFRRkjHSXv0fKK7I4KBW0flB7+kCtSxwTrBmg2
 fJhiHuZ8Rzi/izXuc9OsIOdwx4IPxemmUTyVvhrsVcFXomOQe5Eg2M5Ro0VVPx0nARTy
 O54w==
X-Gm-Message-State: AOAM532P4Lk38/RRRRKMY/vU4HrpDJGuUQ3Nw5HGgvjY5vY5LLT6nqEb
 hLKt598wF9ko3AyMzfYQ0bm2RceiCrpPrm7iibE=
X-Google-Smtp-Source: ABdhPJykqkVVSgg7UAKWsJzumlHjjxXsDYjsQsvshXL8PfpUzEuec0wwf0xd9IFCd2mIbyfIQyVDPt7BNCpxfGGA4q8=
X-Received: by 2002:a02:a498:: with SMTP id d24mr33134809jam.137.1600477237968; 
 Fri, 18 Sep 2020 18:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
 <63a89ba1-a920-c2b9-bd4f-7f523fdda895@amsat.org>
 <31d4f14f-bba5-a5a5-d024-668558416083@amsat.org>
In-Reply-To: <31d4f14f-bba5-a5a5-d024-668558416083@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 19 Sep 2020 09:00:26 +0800
Message-ID: <CAAhV-H71RPoqf046-BJWEHkSumNM5mohxhwShSD9PyELTEzEtw@mail.gmail.com>
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Thu, Sep 17, 2020 at 3:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 9/16/20 12:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/16/20 11:49 AM, Huacai Chen wrote:
> >> On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> >>> On 9/16/20 4:12 AM, Huacai Chen wrote:
> > [...]
> >>>> +static void mips_loongson3_virt_init(MachineState *machine)
> >>>> +{
> >>>> +    int i;
> >>>> +    long bios_size;
> >>>> +    MIPSCPU *cpu;
> >>>> +    CPUMIPSState *env;
> >>>> +    DeviceState *liointc;
> >>>> +    char *filename;
> >>>> +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> >>>> +    const char *kernel_filename =3D machine->kernel_filename;
> >>>> +    const char *initrd_filename =3D machine->initrd_filename;
> >>>> +    ram_addr_t ram_size =3D machine->ram_size;
> >>>> +    MemoryRegion *address_space_mem =3D get_system_memory();
> >>>> +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >>>> +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> >>>> +    MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
> >>>> +
> >>>> +    /* TODO: TCG will support all CPU types */
> >>>> +    if (!kvm_enabled()) {
> >>>> +        if (!machine->cpu_type) {
> >>>> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A10=
00");
> >>>> +        }
> >>>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> >>>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1=
000");
> >>>> +            exit(1);
> >>>> +        }
> >>>> +    } else {
> >>>> +        if (!machine->cpu_type) {
> >>>> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A40=
00");
> >>>> +        }
> >>>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> >>>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4=
000");
> >>>> +            exit(1);
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (ram_size < 512 * MiB) {
> >>>> +        error_report("Loongson-3 need at least 512MB memory");
> >>>
> >>> Typo "needs", but why?
> >> Though you told me "QEMU shouldn't assume anything about the guest",
> >> but Loongson-3 machine really need at least 512M memory. And as you
> >> said, this can simplify the memsize/highmemsize process (always larger
> >> than 256).
> >
> > OK, that's fine.
> >
> >>
> >>>
> >>>> +        exit(1);
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * The whole MMIO range among configure registers doesn't gener=
ate
> >>>> +     * exception when accessing invalid memory. Create an empty slo=
t to
> >>>> +     * emulate this feature.
> >>>> +     */
> >>>> +    empty_slot_init("fallback", 0, 0x80000000);
> >>>
> >>> Again, this doesn't look correct (no comment in my previous review).
> >> This is written by Jiaxun because this is only needed by TCG, and he
> >> said that malta also uses empty_slot_init() here.
> >
> > IIRC for Malta this is a GT64120 specific hole.
> >
> > In this case I'd like to know the justification first.
> > Maybe you want to add this hole in the LOONGSON_LIOINTC device...
>
> Which makes me also wonder why are you splitting out 256MB of the RAM?
>
> This was a physical restriction of the GT64120 on 32-bit targets.
> Your hardware is virtual and 64-bit...
The physical memory address layout of Loongson-3:
0-0x40000000  Low RAM (256MB)
0x40000000-0x80000000 Hole for several MMIO registers (256MB)
0x80000000-TopOfMemory High RAM

Thogh this is a virtual platform, but the kernel link address is in
CKSEG0, so "Low RAM" should exist. Though MMIO is different from real
hardware, but put it in the same hole can make life easy.

Then it seems there is really a mistake of empty_slot_init() but has
nothing to do with liointc, and the right one should be
empty_slot_init("fallback", 0x40000000, 0x40000000);

Huacai

