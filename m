Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E368C2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="x7RKjR/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E368C2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRix-0005mk-4p
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIRiB-0005Iw-8D
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:18:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIRi8-0005Vu-UO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:18:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so5758501wrm.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z42oBDChayfqEZYKk6vATJkYEAj/nxm/5kasbc+bHMU=;
 b=x7RKjR/kdBEXskrZZoTes+i0R75hsULVWrtajsiv7u5DAMwVA1tUsO3OjgmMtAIUpZ
 QpwR1dTca4IL1J8yP5tdYdygnFuiSP1mlAtL7lSa6FKF5Yk3QNxsebzrpk0JeirjZf52
 P4IisBaeKVbwg+vjk+V5CUt/ujFIjss1vNEux8G82HvEjeKrDrsSINmPr7Hw7Bxfppd/
 vpksy58xLqhJTgL9bnRgyjRV6T1+alx+MSas/SVNZ+bmrMEx3Lx3PpW3slnsoAcLEOFd
 pYb/Tk+sQhBFECk0DKkrzwY9AVGTPEElodOWQXzi19RJGQ+lFB42IVV9nQ2ifL7w77Te
 jm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z42oBDChayfqEZYKk6vATJkYEAj/nxm/5kasbc+bHMU=;
 b=kSB60OiCbVG2HppbhA+9vPYMTpyujOLLrH7Zs5xitCbb8tePE+/EjgO1GQT3dR+/8D
 x+9TH7QUx1GGJFoXCZptOyHbuxn+HlY/ikNRZqXb1CrKpYspsKS49EgZV6Deq2YxSofa
 plXbrtZVZeG1T2OF7QYUAa5Cntihpk+j3ygflo2sNiHXV6yTX0e+I51frZ2utc6YHcL5
 wnRV20uV2Ll0l85SvTMtlhQjaGcZIWfjIX4Cye5Y7nBENQP/aWvFTDe97S4GHDTHthpQ
 UqMKGrsZDcN2KsSmMnKZJynx4HgK/dRKj1a6Wj3U1UiIs/VWGh1Ndsp5Et+EdesUSOvP
 XrTA==
X-Gm-Message-State: AOAM5314BVgvZIp3Rop4tDvQUxGvYIac1XUdRcgJXlqpVXaz9UQY1v6+
 Rqn3DDgizn5OjRSh8Rvo8IxZjjDhi3TB9q1yFq7zJg==
X-Google-Smtp-Source: ABdhPJzNUVEOf4HWOZ9CoyBQLnWuOIAqnGqr56j6fcFasg6C9a1Fc2pSwjOaVfVHM1giRRxQo/3vxCzX7TNEzz+8Tyg=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr24661941wrv.369.1600240714867; 
 Wed, 16 Sep 2020 00:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916091554.5c695601@redhat.com>
In-Reply-To: <20200916091554.5c695601@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 16 Sep 2020 12:48:22 +0530
Message-ID: <CAARzgwybU2yUqF=QMjsqrXDp7Q3mb+Ue2Vwm964BciVksJ0HMQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] i440fx/acpi: addition of feature and bug fixes.
To: Igor Mammedov <imammedo@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Got it.

On Wed, Sep 16, 2020 at 12:46 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 16 Sep 2020 11:43:24 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > In v4 I have made the following changes:
> >
> > - a cosmetic change for patch #4. Commit log was updated as per Igor's suggestion.
> > - patches #10 and #11 were added to unit test patch #9.
> >
> > The DSDT table after disabling hotplug on the root bus and the pci bridges is shown here:
> >
> > https://pastebin.ubuntu.com/p/WvpYYjpPN8/
> >
> > This was generated by disassembling the newly added DSDT golden master binary table blob
> > DSDT.hpbrroot.
> >
> > I sincerely hope this is the final iteration of the set of patches.  The patches has been
> > unit tested on top of latest qemu upstream master branch.
>
> usually one includes Reviewed|...|-by tags from previous version,
> unless there was a functional change in a reviewed patch or you
> feel that trivial changes (if any) deserve review.
>
>
> > Ani Sinha (11):
> >   tests/acpi: document addition of table DSDT.roothp for unit testing
> >     root pci hotplug on/off
> >   tests/acpi: add a new unit test to test hotplug off/on feature on the
> >     root pci bus
> >   tests/acpi: add a new ACPI table in order to test root pci hotplug
> >     on/off
> >   Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
> >     non-hotpluggable bus
> >   i440fx/acpi: do not add hotplug related amls for cold plugged bridges
> >   tests/acpi: list added acpi table binary file for pci bridge hotplug
> >     test
> >   tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
> >     bridge flag
> >   tests/acpi: add newly added acpi DSDT table blob for pci bridge
> >     hotplug flag
> >   piix4: don't reserve hw resources when hotplug is off globally
> >   tests/acpi: unit test exercizing hotplug off for pci root bus & bridge
> >     in i440fx
> >   tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx
> >     hotplug
> >
> >  hw/acpi/pcihp.c                   |  15 ++++++++++
> >  hw/acpi/piix4.c                   |   6 ++--
> >  hw/i386/acpi-build.c              |  37 ++++++++++++++---------
> >  tests/data/acpi/pc/DSDT.hpbridge  | Bin 0 -> 4895 bytes
> >  tests/data/acpi/pc/DSDT.hpbrroot  | Bin 0 -> 2953 bytes
> >  tests/data/acpi/pc/DSDT.roothp    | Bin 0 -> 5130 bytes
> >  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7670 bytes
> >  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 8994 bytes
> >  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7688 bytes
> >  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8133 bytes
> >  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9323 bytes
> >  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7745 bytes
> >  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9029 bytes
> >  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8801 bytes
> >  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7676 bytes
> >  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8276 bytes
> >  tests/qtest/bios-tables-test.c    |  47 ++++++++++++++++++++++++++++++
> >  17 files changed, 90 insertions(+), 15 deletions(-)
> >  create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
> >  create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot
> >  create mode 100644 tests/data/acpi/pc/DSDT.roothp
> >
>

