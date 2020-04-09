Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD0C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9AC2072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Nt/Rqm6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9AC2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMQfL-0001VW-KZ
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 02:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1jMQd4-0000pq-Ov
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1jMQd3-0004Wr-PU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:25:34 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1jMQd1-0004Vl-4a; Thu, 09 Apr 2020 02:25:31 -0400
Received: by mail-qt1-x842.google.com with SMTP id b10so1948692qtt.9;
 Wed, 08 Apr 2020 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6TTfWkXF+KfPgXlK4TEvnMK/fjprNtCaQu2kaLN1q/U=;
 b=Nt/Rqm6TbjBddU2OSUDGTqu6qKnLeK60GVkvRw+TCdaa2W4ui0BWn2vDWeUZBaLwaz
 A6lY7V8G83vZ+gxzpmv1Km6IqEuml0+DqdD3yEtTB+tdSinNivpBcNhKV+carEJ+5eLZ
 wVJm9JBs0fxnRNpofG2pQ+WPwCMT2chrAJMoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6TTfWkXF+KfPgXlK4TEvnMK/fjprNtCaQu2kaLN1q/U=;
 b=i6Qu/vR4jKO4cl82Q+oz4a0ldd+m7P6PJRybp7/Z5g5xbeM7Xf/N9p1axDtLsqXiSY
 HQeJPii85Y+lC/ZHtmbcam2Omdt8AuK38RTQNBCgCPQYzDBFsEFW9bvUhEsWyw4wLC1u
 XqxYnlyHgXN92Koubhf8Y98BfX9d/+MM6uiMSQYfJ/QUdlkeRz81PLNwseLqDYan0QIk
 9Cano4YwFWaDSIl6QaGUHWZXtkkd107cChdZc9TSSyQQCO0qzNUMu7aqIM245gHVLLXi
 nOMTLP4LuToeMvPTHomTxj+B5XrG3lKMYB3Tty5XJRN8F6yQa5ScvnJRc9xF2hHknAcH
 NASw==
X-Gm-Message-State: AGi0PuYZTD1iQuMs65HETX+b40RjWI3y7NO8GxmmwEpBW5m4mqvVtvz1
 GeVY0rV6Wi7NTie9SPLmH1aOFXSmv+T4D/vDy+0=
X-Google-Smtp-Source: APiQypKx1e4+d9bhBd/elEn5nIiEPzNkqK5cs0LyIT4Xk23BABKOuR/RE4+n2Jp8e3Ifn7lEjIFOyVkdCo+50UePnsk=
X-Received: by 2002:ac8:342d:: with SMTP id u42mr10681255qtb.255.1586413530114; 
 Wed, 08 Apr 2020 23:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200407072517.671521-1-joel@jms.id.au>
 <CACPK8XfHnE_kEPw++CdLRG9r=xJmLZkuV4WXP7NKTo8mW+dJvA@mail.gmail.com>
 <16f057db-a4d7-889f-344c-930587fc8bf1@redhat.com>
 <141d2355-5f9d-c8f9-4021-01754f8bc2ae@kaod.org>
In-Reply-To: <141d2355-5f9d-c8f9-4021-01754f8bc2ae@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 9 Apr 2020 06:25:17 +0000
Message-ID: <CACPK8XePK4j85BrT7tSgh54bO441sUxNiKmHyP+YUepcpZ=Pow@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add boot stub for smp booting
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 08:26, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 4/7/20 10:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >
> > On 4/7/20 9:38 AM, Joel Stanley wrote:
> >> On Tue, 7 Apr 2020 at 07:25, Joel Stanley <joel@jms.id.au> wrote:

> >>>   static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t ro=
m_size,
> >>> @@ -270,6 +322,19 @@ static void aspeed_machine_init(MachineState *ma=
chine)
> >>>           }
> >>>       }
> >>>
> >>> +    if (machine->kernel_filename) {
> >>
> >> I just realised this shouldn't be executed on non-ast2600 platforms.
> >> We could test for the number of CPUs like this:
> >>
> >> if (machine->kernel_filename && aspeed_board_binfo.nb_cpus > 1) {
> >
> >   if (!strcmp(amc->soc_name, "ast2600")) { ?
>
> or a 'bool' under AspeedMachineClass ?

I considered both, but I went with the number of configured CPUs as
this means we only set it up when configured for SMP, which is the
only time it's worth doing.

Thanks for taking a look.

> A part from that,
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> C.
>
>
> >
> >>
> >>> +        /* With no u-boot we must set up a boot stub for the seconda=
ry CPU */
> >>> +        MemoryRegion *smpboot =3D g_new(MemoryRegion, 1);
> >>> +        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot=
",
> >>> +                               0x80, &error_abort);
> >>> +        memory_region_add_subregion(get_system_memory(),
> >>> +                                    AST_SMP_MAILBOX_BASE, smpboot);
> >>> +
> >>> +        aspeed_board_binfo.write_secondary_boot =3D aspeed_write_smp=
boot;
> >>> +        aspeed_board_binfo.secondary_cpu_reset_hook =3D aspeed_reset=
_secondary;
> >>> +        aspeed_board_binfo.smp_loader_start =3D AST_SMP_MBOX_CODE;
> >>> +    }
> >>> +
> >>>       aspeed_board_binfo.ram_size =3D ram_size;
> >>>       aspeed_board_binfo.loader_start =3D sc->memmap[ASPEED_SDRAM];
> >>>       aspeed_board_binfo.nb_cpus =3D bmc->soc.num_cpus;
> >>> --
> >>> 2.25.1
> >>>
> >>
> >
>

