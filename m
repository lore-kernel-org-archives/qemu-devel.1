Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A01C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6190521924
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="MPlzCcmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6190521924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDZ3-0007yw-Fc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNDSR-0000Ig-1d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:06:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNDSN-0003G3-GW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:06:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id o5so4846376wrn.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O4tAYLANHIt5Lp6A2ucqp7kGMfkHYdvTANSk7ZWg13c=;
 b=MPlzCcmMjrDyOhJ5+h2TsAPxDDFkuVBV1fPK0Pg5lb8n6qEMnWVynZEVLiC1xuzwH3
 lnqLwnQMkCgKMdn2VMSA9b+nrc8iDbIa7O6+z97stc1peLJJFU46Qz0O8DbT9d7WSa/y
 d7RQCxB0vVrVKeU50Y211hInf7LCIOPsr2ExsPzhxb5plRYuPMwpL1UcLPyQ/ipU1igH
 CFXVMQMi9LbUfn/bWuzaiqra8XCRAMaF1ua6XGizi5LoUiPNpiLU3SpwA77/AknLMntp
 wvq/wii882PpwxtgSCIeY4ME5zzsMjWpUNyLytKE2yJs2+fOn36jLEhfP2e2bq1mqPRw
 jgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O4tAYLANHIt5Lp6A2ucqp7kGMfkHYdvTANSk7ZWg13c=;
 b=M1fRpHBLkwdC79FCwzIGamiYUTe3/lYGZWnhR0noq+b128nh4dOi/tHfK2bHuRBrmX
 amKPtg5rPTAeJeDJesKvQNn7VOtPsmLlcN5VP7yAJ5KjQGjqohG6wVagkU2oy37Ws29r
 dO4vgL+Uuk8c2aR+//v5XC+YjhwK7YJaH6WINgHWZXMdiCTFdn5SiOthKuCGr1hD6Y8I
 OwA3xFN5Ot8RcQpldhl5mkYk6RZSIGkZ8o4tQtyL0USMuuqtZkM+NA1o5fNykK/8q92h
 E8yy3z0rj3Kg4Hzc+dufKG8FAVsIJFVpqGdBKPrq27w4TjkuJE7g/QJPJoPVIo2/ptMG
 HZxQ==
X-Gm-Message-State: AOAM532pZ4QjqjqZFtO5ZPJALyeTfn+ZARBjfFkYpnI8ndx48qNcst7R
 JJvZcf7toYldsXhKghWNOvNzkLv+grSRGDVN74PqJA==
X-Google-Smtp-Source: ABdhPJzj1p80xDMYJQjkdPaRFtn7BuXDer0+Q4LAGR+rmf7T0l9RRedVpPB27P7Ie5VVXmegTpOY/iiozr0MKkN0gK8=
X-Received: by 2002:adf:e410:: with SMTP id g16mr3652073wrm.76.1601377561848; 
 Tue, 29 Sep 2020 04:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAARzgwzdVCwzXE2hUgPQdQpnp8eTf0JyEt3vctKWnZgwZZAfuA@mail.gmail.com>
 <20200929032619-mutt-send-email-mst@kernel.org>
 <CAARzgwz7x6uinPQ+oC+yAuFCbQEWhQuDmGU73E5NZ2WCH_C_kA@mail.gmail.com>
 <CAARzgwwxjjCAVsFB6_987pa1Z_in2G50rViYiRGVae-c_wn6xQ@mail.gmail.com>
 <20200929053823-mutt-send-email-mst@kernel.org>
 <CAARzgwxBcTDkK7QhHP=_mpYoAYYgRY+d6o+2SCSP-haBPDttwA@mail.gmail.com>
 <CAARzgwy8QNw=OD6cOEkDY-x9mC10ry+NTdCH2gNKuLXp8bAAyg@mail.gmail.com>
 <CAARzgwyNPZB5PGc-B9vDn9V-uEwVCiCvXgvamMaGTvBCPJQiCg@mail.gmail.com>
 <20200929063539-mutt-send-email-mst@kernel.org>
 <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
 <20200929064858-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929064858-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 29 Sep 2020 16:35:50 +0530
Message-ID: <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:
> > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > >
> > > > > In your pull request the following patch is completely screwed up:
> > > > >
> > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> > > > > Author: Ani Sinha <ani@anisinha.ca>
> > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> > > > >
> > > > >     tests/acpi: update golden master DSDT binary table blobs for q35
> > > > >
> > > > >
> > > > > This is not my patch. It has all sorts of changes which does not
> > > > > belong there. Can you please check?
> > > >
> > > > See https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
> > >
> > >
> > > I had to regenerate the binary, yes. That's par for the course.
> > > But it looks like I added disasssembled files. Will fix up and drop,
> > > thanks for noticing this.
>
> OK I pushed out a fixed variant. Pls take a look.

OK I am not used to this workflow. How am I supposed to get it? Which tag?


>
> > I think DSDT.hbridge is wrong. The checksum looks weird:
> >
> >
> > + *     Length           0x00000B89 (2953)
> >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > - *     Checksum         0x05
>
> What is weird about it?
>
> >
> > This file should be introduced just by one patch. my patch.
>
> I just re-run rebuild-expected-aml, no changes.
>
> I have this:
> commit 5e3a486211f02d9ecb18939ca21087515ec81883
> Author: Ani Sinha <ani@anisinha.ca>
> Date:   Fri Sep 18 14:11:05 2020 +0530
>
>     tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
>
>     This change adds a new unit test for the global flag
>     'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
>     bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
>     on all pci bridges.
>
>
> Here is the full DSDT header, attached:
>
> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20190509 (64-bit version)
>  * Copyright (c) 2000 - 2019 Intel Corporation
>  *
>  * Disassembling to symbolic ASL+ operators
>  *
>  * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29 06:51:03 2020
>  *
>  * Original Table Header:
>  *     Signature        "DSDT"
>  *     Length           0x0000139D (5021)
>  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
>  *     Checksum         0x05
>  *     OEM ID           "BOCHS "
>  *     OEM Table ID     "BXPCDSDT"
>  *     OEM Revision     0x00000001 (1)
>  *     Compiler ID      "BXPC"
>  *     Compiler Version 0x00000001 (1)
>  */
> DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
>
> --
> MST
>

