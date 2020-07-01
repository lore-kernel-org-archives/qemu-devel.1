Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1492D20722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAoPm0YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqWnR-0006SV-9l
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 03:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jqWmh-00061T-Lj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:03:55 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jqWme-00072w-S1
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:03:55 -0400
Received: by mail-ed1-x543.google.com with SMTP id e22so18595541edq.8
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=6eNZuzFNJ6OxbyFGv/sTyrbXRJOgNAq4o3gC0+HLpag=;
 b=UAoPm0YKD/s7r6iPfz/T0PuEhqOaM4+nyi4tMmyeXBtD9suQ2kjadh3JuiLeOe4eHP
 cyhesJE195NEHpLjShWKGowwJ2vFh9NDRWQgUT0BOvk7KdBczKx8k+qTYqp0X9p0Z0K4
 0FnjU6d71yidlpIGI+FHodFAj4jEQR75u/8Sa1hZPgcvfRPmZ3YEOhFwlJCbVJiyLhD8
 DR5ywCRQB021jF6sxzXcVOBKC4sn6d3B50DgGWdNU1ppEIvCEKWFrfDD9AtLaSCZREJM
 hwZsxh+Wgg2SJEPcE2oYiNXvfs9b3wvVtt2+uqVAeJ6XDju0Kpexs3neZwdAbxVEPuom
 zsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=6eNZuzFNJ6OxbyFGv/sTyrbXRJOgNAq4o3gC0+HLpag=;
 b=f7D29beGB3fRVq4oGOmsW8ZW91gsoxYlML7PE692RPeMfuBucwkjzbeaJ2BTjszSy3
 iso06sRsuk8n90AeK6ksMn0DOYpW0yGv7OOKm7iTigfl1v4oEMRDTE2iJvWOhoLmfTUC
 0gzmVfSjrrfeg+Vi8bWNDRJgM9KzzyqYwZBuuqeHUHgZSaCRwhvT7iDDcvvfwQ0PXym4
 M8iutwdUq5OdjOZhzjAJSdHrY6lrn2Fwan2wbm/IorKo5gkU+jt7fq5svFFE8lMvsCkR
 WOt6dHIQy3L+i80EvAsjlMTeyQzVz3oaRHVHo/nsIV6QmKiLKWRpoWgpnTEY+Fv1HeqU
 tqxw==
X-Gm-Message-State: AOAM533hZ5ICNsggjvoC7eGi4v7UadPmZtHuBQmihNHdMVK7s7F5Y0g0
 99NX3BYtLJYnsQqqfwPt+uY=
X-Google-Smtp-Source: ABdhPJz4LIGFdOnkn9jdZqEhUBlzB6LaMc2aOiaq72jXKhCB/fO/5680G+Tj706S1ohuE+kvZnnySA==
X-Received: by 2002:a05:6402:1ca6:: with SMTP id
 cz6mr9805142edb.171.1593587031355; 
 Wed, 01 Jul 2020 00:03:51 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id z1sm3961362eji.92.2020.07.01.00.03.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 00:03:50 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <xen-devel@lists.xenproject.org>, <qemu-devel@nongnu.org>
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
In-Reply-To: <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
Subject: RE: [PATCH 2/2] xen: cleanup unrealized flash devices
Date: Wed, 1 Jul 2020 08:03:49 +0100
Message-ID: <000801d64f75$c604f570$520ee050$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSqy6H9p+wwq7WTKLIQgTsJ4xkIwGyH0+lAvluRd8CNjldPAM3wS46p6jIZ4A=
Content-Language: en-gb
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x543.google.com
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
Reply-To: paul@xen.org
Cc: 'Eduardo Habkost' <ehabkost@redhat.com>,
 'Jason Andryuk' <jandryuk@gmail.com>, 'Paul Durrant' <pdurrant@amazon.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 30 June 2020 18:27
> To: paul@xen.org; xen-devel@lists.xenproject.org; =
qemu-devel@nongnu.org
> Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' =
<mst@redhat.com>; 'Paul Durrant'
> <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo =
Bonzini' <pbonzini@redhat.com>;
> 'Richard Henderson' <rth@twiddle.net>
> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>=20
> On 6/30/20 5:44 PM, Paul Durrant wrote:
> >> -----Original Message-----
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Sent: 30 June 2020 16:26
> >> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; =
qemu-devel@nongnu.org
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin =
<mst@redhat.com>; Paul Durrant
> >> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo =
Bonzini <pbonzini@redhat.com>;
> >> Richard Henderson <rth@twiddle.net>
> >> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> >>
> >> On 6/24/20 2:18 PM, Paul Durrant wrote:
> >>> From: Paul Durrant <pdurrant@amazon.com>
> >>>
> >>> The generic pc_machine_initfn() calls pc_system_flash_create() =
which creates
> >>> 'system.flash0' and 'system.flash1' devices. These devices are =
then realized
> >>> by pc_system_flash_map() which is called from =
pc_system_firmware_init() which
> >>> itself is called via pc_memory_init(). The latter however is not =
called when
> >>> xen_enable() is true and hence the following assertion fails:
> >>>
> >>> qemu-system-i386: hw/core/qdev.c:439: =
qdev_assert_realized_properly:
> >>> Assertion `dev->realized' failed
> >>>
> >>> These flash devices are unneeded when using Xen so this patch =
avoids the
> >>> assertion by simply removing them using =
pc_system_flash_cleanup_unused().
> >>>
> >>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> >>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with =
-blockdev")
> >>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> >>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> >>> ---
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Richard Henderson <rth@twiddle.net>
> >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >>> ---
> >>>  hw/i386/pc_piix.c    | 9 ++++++---
> >>>  hw/i386/pc_sysfw.c   | 2 +-
> >>>  include/hw/i386/pc.h | 1 +
> >>>  3 files changed, 8 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >>> index 1497d0e4ae..977d40afb8 100644
> >>> --- a/hw/i386/pc_piix.c
> >>> +++ b/hw/i386/pc_piix.c
> >>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
> >>>      if (!xen_enabled()) {
> >>>          pc_memory_init(pcms, system_memory,
> >>>                         rom_memory, &ram_memory);
> >>> -    } else if (machine->kernel_filename !=3D NULL) {
> >>> -        /* For xen HVM direct kernel boot, load linux here */
> >>> -        xen_load_linux(pcms);
> >>> +    } else {
> >>> +        pc_system_flash_cleanup_unused(pcms);
> >>
> >> TIL pc_system_flash_cleanup_unused().
> >>
> >> What about restricting at the source?
> >>
> >
> > And leave the devices in place? They are not relevant for Xen, so =
why not clean up?
>=20
> No, I meant to not create them in the first place, instead of
> create+destroy.
>=20
> Anyway what you did works, so I don't have any problem.

IIUC Jason originally tried restricting creation but encountered a =
problem because xen_enabled() would always return false at that point, =
because machine creation occurs before accelerators are initialized.

  Paul

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> >
> >   Paul
> >
> >> -- >8 --
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1004,24 +1004,26 @@ void pc_memory_init(PCMachineState *pcms,
> >>                                      &machine->device_memory->mr);
> >>      }
> >>
> >> -    /* Initialize PC system firmware */
> >> -    pc_system_firmware_init(pcms, rom_memory);
> >> -
> >> -    option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
> >> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", =
PC_ROM_SIZE,
> >> -                           &error_fatal);
> >> -    if (pcmc->pci_enabled) {
> >> -        memory_region_set_readonly(option_rom_mr, true);
> >> -    }
> >> -    memory_region_add_subregion_overlap(rom_memory,
> >> -                                        PC_ROM_MIN_VGA,
> >> -                                        option_rom_mr,
> >> -                                        1);
> >> -
> >>      fw_cfg =3D fw_cfg_arch_create(machine,
> >>                                  x86ms->boot_cpus, =
x86ms->apic_id_limit);
> >>
> >> -    rom_set_fw(fw_cfg);
> >> +    /* Initialize PC system firmware */
> >> +    if (!xen_enabled()) {
> >> +        pc_system_firmware_init(pcms, rom_memory);
> >> +
> >> +        option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
> >> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", =
PC_ROM_SIZE,
> >> +                               &error_fatal);
> >> +        if (pcmc->pci_enabled) {
> >> +            memory_region_set_readonly(option_rom_mr, true);
> >> +        }
> >> +        memory_region_add_subregion_overlap(rom_memory,
> >> +                                            PC_ROM_MIN_VGA,
> >> +                                            option_rom_mr,
> >> +                                            1);
> >> +
> >> +        rom_set_fw(fw_cfg);
> >> +    }
> >>
> >>      if (pcmc->has_reserved_memory && machine->device_memory->base) =
{
> >>          uint64_t *val =3D g_malloc(sizeof(*val));
> >> ---
> >>
> >>> +        if (machine->kernel_filename !=3D NULL) {
> >>> +            /* For xen HVM direct kernel boot, load linux here */
> >>> +            xen_load_linux(pcms);
> >>> +        }
> >>>      }
> >>>
> >>>      gsi_state =3D pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
> >>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> >>> index ec2a3b3e7e..0ff47a4b59 100644
> >>> --- a/hw/i386/pc_sysfw.c
> >>> +++ b/hw/i386/pc_sysfw.c
> >>> @@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState =
*pcms)
> >>>      }
> >>>  }
> >>>
> >>> -static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> >>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> >>>  {
> >>>      char *prop_name;
> >>>      int i;
> >>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> >>> index e6135c34d6..497f2b7ab7 100644
> >>> --- a/include/hw/i386/pc.h
> >>> +++ b/include/hw/i386/pc.h
> >>> @@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType =
fd0);
> >>>
> >>>  /* pc_sysfw.c */
> >>>  void pc_system_flash_create(PCMachineState *pcms);
> >>> +void pc_system_flash_cleanup_unused(PCMachineState *pcms);
> >>>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion =
*rom_memory);
> >>>
> >>>  /* acpi-build.c */
> >>>
> >
> >



