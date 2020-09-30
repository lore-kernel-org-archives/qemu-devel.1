Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7DDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B5020738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="QhBLq14F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B5020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXA3-0004rG-OO
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNX8x-0004N1-MJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:07:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNX8v-0005fK-1V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:07:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so670364wmi.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5IFGrRsiGUbveeAmt24po8ZGSYM6sDqBuzE2j7tjfSs=;
 b=QhBLq14FJ38jM0v+W/vi+RYAd3uGeV+ZxI0MMnsvBCNM4+xXB2CHiC7lGSzgrILSLZ
 DiTN/q13lKQeYgr/K3aPldWSSBwxQCE53JrPpzs6xJ5CMQEP735YQoI+hgpERT5y0yxT
 Q7RjsdIt6OJMa6dOfVijKpKu4fxaHLaevvQGTvYOvDV6axsAIBsc6sGoWXrNnu/zZL5x
 QekR+8nLpAnGdnWuH0MyLM/i59cG7kvDfd2FPqjEHgPEeO8lt9gx288bQM2m81okcsJ1
 MIvb8JASzfo8rC1ZkcEqqnW70vuykk5iW2crfo66BsaWr3rWdsZFAkCHevM+5owlCvQ/
 Gf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5IFGrRsiGUbveeAmt24po8ZGSYM6sDqBuzE2j7tjfSs=;
 b=YnhS+93QdxywEe0qxv5zdo9p+8ac90VDJ5UhEes1aPyIerD5u7wBDehN9dMQ/v4ZOf
 zGNhDLh2z3R+5Nix1DzpocZxGJ5gzBL2g0bpzNtOOF44/u8Z+pUkHWhg0qVH/kbGA09R
 PZMW7dRHBE0WMjT5UbPyfFoEyC/n3X154Fu0VKMfYbFsN4zlzFFmhLcua0AqEq/GGqME
 PcC/puvGyOns7WUAg1+Ps1O9kVC7YVmYXWNDFNToXy5BaXJ85NtnGrXYIUUUv8DX1HrJ
 9/PUorE8qW9MznxekhQzsapHHb5Vwo/WmClUASyXSgRp+s6HPt10g0DYkpL1y9wdX46+
 q59g==
X-Gm-Message-State: AOAM5319U1zwX8GqlZBENm4oaBLvqnaFYgYB/mCtXUOMCA9/e9mARxZ8
 5d4+EI7//EG5Rm3egh2U0U87yPYPBJ2RUwZ7fVPeQw==
X-Google-Smtp-Source: ABdhPJwYikvK6QjWE/yNt59TfxLg8a8nyxhLv2h+/0lfoa8KdXQ6AV/MigDGNRdaTJEXpg9hGcm9tZcKK7Cez3om4g0=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1691368wmg.137.1601453235156; 
 Wed, 30 Sep 2020 01:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200929064858-mutt-send-email-mst@kernel.org>
 <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
 <20200929071412-mutt-send-email-mst@kernel.org>
 <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
 <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
 <20200930034220-mutt-send-email-mst@kernel.org>
 <CAARzgwy_+kVWQs5sQo4qAYC3Gi5LhdLoMQDPzKadwRPZ1D8Brw@mail.gmail.com>
 <20200930040207-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200930040207-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 30 Sep 2020 13:37:03 +0530
Message-ID: <CAARzgwz1TJpyVZfxJF=yCoj4pBMsUxOvaVmZCCn0Dfni-dB5kw@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
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

On Wed, Sep 30, 2020 at 1:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 30, 2020 at 01:17:53PM +0530, Ani Sinha wrote:
> >
> >
> > On Wed, Sep 30, 2020 at 1:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >     On Wed, Sep 30, 2020 at 01:09:09PM +0530, Ani Sinha wrote:
> >
> >     >
> >
> >     >
> >
> >     > On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin <mst@redhat.com>
> >     wrote:
> >
> >     >
> >
> >     >     On Tue, Sep 29, 2020 at 06:03:00PM +0530, Ani Sinha wrote:
> >
> >     >
> >
> >     >     > On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin <mst@redhat.com>
> >
> >     >     wrote:
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > > On Tue, Sep 29, 2020 at 04:58:03PM +0530, Ani Sinha wrote:
> >
> >     >
> >
> >     >     > > > On Tue, Sep 29, 2020 at 4:45 PM Michael S. Tsirkin <
> >     mst@redhat.com>
> >
> >     >     wrote:
> >
> >     >
> >
> >     >     > > > >
> >
> >     >
> >
> >     >     > > > > On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:
> >
> >     >
> >
> >     >     > > > > > On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin <
> >
> >     >     mst@redhat.com> wrote:
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha
> >     wrote:
> >
> >     >
> >
> >     >     > > > > > > > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <
> >
> >     >     mst@redhat.com> wrote:
> >
> >     >
> >
> >     >     > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha
> >     wrote:
> >
> >     >
> >
> >     >     > > > > > > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <
> >
> >     >     ani@anisinha.ca> wrote:
> >
> >     >
> >
> >     >     > > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > > In your pull request the following patch is
> >     completely
> >
> >     >     screwed up:
> >
> >     >
> >
> >     >     > > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> >
> >     >
> >
> >     >     > > > > > > > > > > Author: Ani Sinha <ani@anisinha.ca>
> >
> >     >
> >
> >     >     > > > > > > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> >
> >     >
> >
> >     >     > > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > >     tests/acpi: update golden master DSDT binary
> >     table
> >
> >     >     blobs for q35
> >
> >     >
> >
> >     >     > > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > > This is not my patch. It has all sorts of changes
> >     which
> >
> >     >     does not
> >
> >     >
> >
> >     >     > > > > > > > > > > belong there. Can you please check?
> >
> >     >
> >
> >     >     > > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > > See https://patchew.org/QEMU/
> >
> >     >     20200929071948.281157-1-mst@redhat.com/
> >
> >     >     20200929071948.281157-46-mst@redhat.com/
> >
> >     >
> >
> >     >     > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > > I had to regenerate the binary, yes. That's par for
> >     the
> >
> >     >     course.
> >
> >     >
> >
> >     >     > > > > > > > > But it looks like I added disasssembled files. Will
> >     fix up
> >
> >     >     and drop,
> >
> >     >
> >
> >     >     > > > > > > > > thanks for noticing this.
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > OK I pushed out a fixed variant. Pls take a look.
> >
> >     >
> >
> >     >     > > > > >
> >
> >     >
> >
> >     >     > > > > > OK I am not used to this workflow. How am I supposed to get
> >     it?
> >
> >     >     Which tag?
> >
> >     >
> >
> >     >     > > > >
> >
> >     >
> >
> >     >     > > > > New for_upstream tag - I just sent in a pull request.
> >
> >     >
> >
> >     >     > > >
> >
> >     >
> >
> >     >     > > > Can you please point me to your tree?
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/
> >     for_upstream
> >
> >     >
> >
> >     >     >
> >
> >     >
> >
> >     >     > I have sent the updated patches based on your pull request tag. I
> >     just
> >
> >     >
> >
> >     >     > had to regenrated the blob for tests/data/acpi/pc/DSDT.hpbrroot.
> >
> >     >
> >
> >     >     >
> >
> >     >
> >
> >     >     > make && make check-qtest-x86_64 V=1 passes.
> >
> >     >
> >
> >     >     >
> >
> >     >
> >
> >     >     > The diff looks good.
> >
> >     >
> >
> >     >     >
> >
> >     >
> >
> >     >     > Can you please send a pull request with these two patches ASAP?
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >     Thanks, I will queue them and merge in the next pull request.
> >
> >     >
> >
> >     >
> >
> >     > I'm willing to get down on my knees begging you to just do one another
> >     pull
> >
> >     > request for these two patches. Were so close with my entire work merged.
> >
> >     >
> >
> >     > Please let's not wait another week or so.
> >
> >
> >
> >
> >
> >     OK it's not too much work but ... could you please add justification
> >
> >     about why adding this one unit test is needed so urgently?
> >
> >     That motivation would be quite helpful for the pull request.
> >
> >
> > A patch without unit test doesn't complete the patch work. A unit test makes
> > sure that the change would not get broken by other changes that come in later.
> > Typically all code changes are accompanied by unit test in the same patch.
> > Hence since the main work has already been merged, the unit test should merge
> > ASAP so that no breakage can happen in between.
> >
> > Plus this completes an entire series of work which I've been working for a
> > while. I really would love to see it all merged cleanly and fully completed.
> >
>
> Absolutely, thanks for the great work!
> I am not sure that's a good justification to rushing a pull request
> though ... are you waiting to get paid and it hinges on the test, or are
> under a deadline, or something like this? It's okay to say so if so.

Yes I am under a deadline too. Unfortunately can't disclose more details.

>
> >
> >
> >
> >
> >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >     > > > >
> >
> >     >
> >
> >     >     > > > > >
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > I think DSDT.hbridge is wrong. The checksum looks
> >     weird:
> >
> >     >
> >
> >     >     > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > + *     Length           0x00000B89 (2953)
> >
> >     >
> >
> >     >     > > > > > > >   *     Revision         0x01 **** 32-bit table (V1),
> >     no
> >
> >     >     64-bit math support
> >
> >     >
> >
> >     >     > > > > > > > - *     Checksum         0x05
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > What is weird about it?
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > >
> >
> >     >
> >
> >     >     > > > > > > > This file should be introduced just by one patch. my
> >     patch.
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > I just re-run rebuild-expected-aml, no changes.
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > I have this:
> >
> >     >
> >
> >     >     > > > > > > commit 5e3a486211f02d9ecb18939ca21087515ec81883
> >
> >     >
> >
> >     >     > > > > > > Author: Ani Sinha <ani@anisinha.ca>
> >
> >     >
> >
> >     >     > > > > > > Date:   Fri Sep 18 14:11:05 2020 +0530
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > >     tests/acpi: unit test for
> >
> >     >     'acpi-pci-hotplug-with-bridge-support' bridge flag
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > >     This change adds a new unit test for the global flag
> >
> >     >
> >
> >     >     > > > > > >     'acpi-pci-hotplug-with-bridge-support' which is
> >     available
> >
> >     >     for cold plugged pci
> >
> >     >
> >
> >     >     > > > > > >     bridges in i440fx. The flag can be used to turn off
> >     ACPI
> >
> >     >     based hotplug support
> >
> >     >
> >
> >     >     > > > > > >     on all pci bridges.
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > Here is the full DSDT header, attached:
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > /*
> >
> >     >
> >
> >     >     > > > > > >  * Intel ACPI Component Architecture
> >
> >     >
> >
> >     >     > > > > > >  * AML/ASL+ Disassembler version 20190509 (64-bit
> >     version)
> >
> >     >
> >
> >     >     > > > > > >  * Copyright (c) 2000 - 2019 Intel Corporation
> >
> >     >
> >
> >     >     > > > > > >  *
> >
> >     >
> >
> >     >     > > > > > >  * Disassembling to symbolic ASL+ operators
> >
> >     >
> >
> >     >     > > > > > >  *
> >
> >     >
> >
> >     >     > > > > > >  * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue
> >     Sep 29
> >
> >     >     06:51:03 2020
> >
> >     >
> >
> >     >     > > > > > >  *
> >
> >     >
> >
> >     >     > > > > > >  * Original Table Header:
> >
> >     >
> >
> >     >     > > > > > >  *     Signature        "DSDT"
> >
> >     >
> >
> >     >     > > > > > >  *     Length           0x0000139D (5021)
> >
> >     >
> >
> >     >     > > > > > >  *     Revision         0x01 **** 32-bit table (V1), no
> >     64-bit
> >
> >     >     math support
> >
> >     >
> >
> >     >     > > > > > >  *     Checksum         0x05
> >
> >     >
> >
> >     >     > > > > > >  *     OEM ID           "BOCHS "
> >
> >     >
> >
> >     >     > > > > > >  *     OEM Table ID     "BXPCDSDT"
> >
> >     >
> >
> >     >     > > > > > >  *     OEM Revision     0x00000001 (1)
> >
> >     >
> >
> >     >     > > > > > >  *     Compiler ID      "BXPC"
> >
> >     >
> >
> >     >     > > > > > >  *     Compiler Version 0x00000001 (1)
> >
> >     >
> >
> >     >     > > > > > >  */
> >
> >     >
> >
> >     >     > > > > > > DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT",
> >
> >     >     0x00000001)
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > > > > --
> >
> >     >
> >
> >     >     > > > > > > MST
> >
> >     >
> >
> >     >     > > > > > >
> >
> >     >
> >
> >     >     > > > >
> >
> >     >
> >
> >     >     > >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >     >
> >
> >
> >
> >
>

