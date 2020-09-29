Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34DCC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA7C207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKQdiBJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA7C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDJM-0007Om-85
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDIX-0006ZH-NV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDIR-0001gf-KJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:55:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601376945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0XCCy5dPRiTXDcfh5qbVdAq0+KxXX3IER6vqKAnWMmc=;
 b=QKQdiBJL/Llat07vyeywp3ZwS/Kh3m4bIumcrgCoqOzp0bAJFU/qBcmXolkFRvc5x4Hw3B
 Khtx2Z9qhHhAC/zyHc2WuI6nOGRa/VNZ5p0XObf8vPGDzlbEJ+tQRBDWNprqvIY2PobXYN
 VysibIAyuMgSrKGlnnqkklzda2Lo+Lw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-uOqyFMvjM46CQqTaATF_jg-1; Tue, 29 Sep 2020 06:55:43 -0400
X-MC-Unique: uOqyFMvjM46CQqTaATF_jg-1
Received: by mail-wm1-f70.google.com with SMTP id a7so1681046wmc.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0XCCy5dPRiTXDcfh5qbVdAq0+KxXX3IER6vqKAnWMmc=;
 b=VY4wXa023/UY1VP2r/qrLalxHsAbhAWeMoTPwVNnjP7VSvF4Enu3542sUrtKMY2Ms2
 kvml8uTTLLBpiBi0byrFd0AUNZ3ErLxVGpcaQ4FVfelBfUJJ6QvynldzvK3axTxS/sVY
 dEqCwVWzYXVqd21xc5rLaKGj9qAUbOpDNuVcSamKTOwHeDr9FckhuEX1AL/JuO7T4EtN
 yVOqAz8nzhSxIogVv1DxXyDAXWxYVj7AuDFWwBGsbZb3YqmU5o5fbK1Bia2xCDuOpzON
 smLz4+pXQNVp0UtFuf5JQfuKSmV2mOac6NoOhKCJPLG98VCeVAP8r05sLJx6yGaW+v0k
 3E1Q==
X-Gm-Message-State: AOAM533FCF42Wy26cCkDsgxW/U8ZR8GfyeGNrultIkYfR/lHN/kcg34L
 JsUE7JFtNzvusdTVhFmcw2Xy6EziSKAi+c0rIgd/qV5Qj0oWyCgDtnWqf5KyHCRXpiNkoRIUpTO
 HBAmv+C29J7TZEZA=
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr3535175wrx.3.1601376942585; 
 Tue, 29 Sep 2020 03:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3jnSlJA2CHbo6Wn0K/uTmClXtHqtGqXb5/VauEz5RY0AI5Bmm/PUezMyAV/8I50nf3UOaVg==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr3535144wrx.3.1601376942369; 
 Tue, 29 Sep 2020 03:55:42 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id k15sm5774621wrv.90.2020.09.29.03.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 03:55:41 -0700 (PDT)
Date: Tue, 29 Sep 2020 06:55:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200929064858-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:
> On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > >
> > > > In your pull request the following patch is completely screwed up:
> > > >
> > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> > > > Author: Ani Sinha <ani@anisinha.ca>
> > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> > > >
> > > >     tests/acpi: update golden master DSDT binary table blobs for q35
> > > >
> > > >
> > > > This is not my patch. It has all sorts of changes which does not
> > > > belong there. Can you please check?
> > >
> > > See https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
> >
> >
> > I had to regenerate the binary, yes. That's par for the course.
> > But it looks like I added disasssembled files. Will fix up and drop,
> > thanks for noticing this.

OK I pushed out a fixed variant. Pls take a look.

> I think DSDT.hbridge is wrong. The checksum looks weird:
> 
> 
> + *     Length           0x00000B89 (2953)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x05

What is weird about it?

> 
> This file should be introduced just by one patch. my patch.

I just re-run rebuild-expected-aml, no changes.

I have this:
commit 5e3a486211f02d9ecb18939ca21087515ec81883
Author: Ani Sinha <ani@anisinha.ca>
Date:   Fri Sep 18 14:11:05 2020 +0530

    tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
    
    This change adds a new unit test for the global flag
    'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
    bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
    on all pci bridges.


Here is the full DSDT header, attached:

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190509 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 *
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29 06:51:03 2020
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000139D (5021)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0x05
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "BXPCDSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)

-- 
MST


