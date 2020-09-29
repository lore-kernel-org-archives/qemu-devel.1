Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC3C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F1C23D21
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AibuKRMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F1C23D21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDot-0002qX-8k
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDb5-00024O-Kq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDb3-0004Pe-7f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:15:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601378100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U90gmN+Gaq44papNIsP8r0dpxsRqGvyvz7WDV0MGLZQ=;
 b=AibuKRMD6/GI5GkferEH1CU3xgG/YR0aqUIwcvc9oyjT4addWoxzWAi52kaubCoVOBtQ8M
 YXZUJ42eNEChVrsgTBgEi0bT9BlTOkO4ecoPmxi9oy2IeLMkNvLd0/JrDx9SWgkV8xSuDi
 XfQaWFy5M49syFO0Z5ABEO5wL4iSuYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Pumr6lKqOe2Ei5VcQv1LeQ-1; Tue, 29 Sep 2020 07:14:39 -0400
X-MC-Unique: Pumr6lKqOe2Ei5VcQv1LeQ-1
Received: by mail-wm1-f69.google.com with SMTP id x6so1701740wmi.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U90gmN+Gaq44papNIsP8r0dpxsRqGvyvz7WDV0MGLZQ=;
 b=G8O7lyovLiy8c2lQXTnsVKLLq/FzDMPPNDn//24ajSHA64Pp4bcTnudA6jXs5XufEh
 sIxMJofO9s1s2ULD28LAdbTA8AMtkxBY1ap8FeaXIes+UnyvvMD4OHT4SFakQt94TL2V
 3wtRQFYD2Qsz3R488s4oLC1W4cxRz095d8g0MUcj8bwaw3IW3T+oK77249NRzP5qFeyu
 8DVzAr7oFY2acTt1ZYizfICSdqo0upPI3b30lQ8d86RLOY+1nyvopc7yWmbvHpTMPMXA
 P9eZrqy8dvDYXE2dcU+g7dFHoS8YTG3lu8PvFc1qPmZOjbKsXexRhgb0SjibVtW1r/8s
 cGMg==
X-Gm-Message-State: AOAM530dOOi5c/cN8ty8+mKYmLNxYnHemUUjbuQCoP44WjLLzSbXCuz8
 lSLGtxb2KPBFBF21sJT/fKFIidizIGNPB8vv6jsFHzuvGGrm43D/ho+t82g2R/OmSmzYmSqsBWm
 ya4foKMi9GLYTqIg=
X-Received: by 2002:adf:db4d:: with SMTP id f13mr3693196wrj.155.1601378078088; 
 Tue, 29 Sep 2020 04:14:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXdr6qCCOaSprVwLZ5u2jApXuhAVJFYNUH+CYlRvJMhPWEoUk6mKEJ+JDk8elxTI72pCYVtQ==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr3693167wrj.155.1601378077819; 
 Tue, 29 Sep 2020 04:14:37 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q13sm5872928wra.93.2020.09.29.04.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 04:14:37 -0700 (PDT)
Date: Tue, 29 Sep 2020 07:14:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200929071412-mutt-send-email-mst@kernel.org>
References: <CAARzgwz7x6uinPQ+oC+yAuFCbQEWhQuDmGU73E5NZ2WCH_C_kA@mail.gmail.com>
 <CAARzgwwxjjCAVsFB6_987pa1Z_in2G50rViYiRGVae-c_wn6xQ@mail.gmail.com>
 <20200929053823-mutt-send-email-mst@kernel.org>
 <CAARzgwxBcTDkK7QhHP=_mpYoAYYgRY+d6o+2SCSP-haBPDttwA@mail.gmail.com>
 <CAARzgwy8QNw=OD6cOEkDY-x9mC10ry+NTdCH2gNKuLXp8bAAyg@mail.gmail.com>
 <CAARzgwyNPZB5PGc-B9vDn9V-uEwVCiCvXgvamMaGTvBCPJQiCg@mail.gmail.com>
 <20200929063539-mutt-send-email-mst@kernel.org>
 <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
 <20200929064858-mutt-send-email-mst@kernel.org>
 <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:
> On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha wrote:
> > > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > > >
> > > > > > In your pull request the following patch is completely screwed up:
> > > > > >
> > > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> > > > > > Author: Ani Sinha <ani@anisinha.ca>
> > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> > > > > >
> > > > > >     tests/acpi: update golden master DSDT binary table blobs for q35
> > > > > >
> > > > > >
> > > > > > This is not my patch. It has all sorts of changes which does not
> > > > > > belong there. Can you please check?
> > > > >
> > > > > See https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
> > > >
> > > >
> > > > I had to regenerate the binary, yes. That's par for the course.
> > > > But it looks like I added disasssembled files. Will fix up and drop,
> > > > thanks for noticing this.
> >
> > OK I pushed out a fixed variant. Pls take a look.
> 
> OK I am not used to this workflow. How am I supposed to get it? Which tag?

New for_upstream tag - I just sent in a pull request.

> 
> >
> > > I think DSDT.hbridge is wrong. The checksum looks weird:
> > >
> > >
> > > + *     Length           0x00000B89 (2953)
> > >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > > - *     Checksum         0x05
> >
> > What is weird about it?
> >
> > >
> > > This file should be introduced just by one patch. my patch.
> >
> > I just re-run rebuild-expected-aml, no changes.
> >
> > I have this:
> > commit 5e3a486211f02d9ecb18939ca21087515ec81883
> > Author: Ani Sinha <ani@anisinha.ca>
> > Date:   Fri Sep 18 14:11:05 2020 +0530
> >
> >     tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
> >
> >     This change adds a new unit test for the global flag
> >     'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> >     bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
> >     on all pci bridges.
> >
> >
> > Here is the full DSDT header, attached:
> >
> > /*
> >  * Intel ACPI Component Architecture
> >  * AML/ASL+ Disassembler version 20190509 (64-bit version)
> >  * Copyright (c) 2000 - 2019 Intel Corporation
> >  *
> >  * Disassembling to symbolic ASL+ operators
> >  *
> >  * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29 06:51:03 2020
> >  *
> >  * Original Table Header:
> >  *     Signature        "DSDT"
> >  *     Length           0x0000139D (5021)
> >  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> >  *     Checksum         0x05
> >  *     OEM ID           "BOCHS "
> >  *     OEM Table ID     "BXPCDSDT"
> >  *     OEM Revision     0x00000001 (1)
> >  *     Compiler ID      "BXPC"
> >  *     Compiler Version 0x00000001 (1)
> >  */
> > DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
> >
> > --
> > MST
> >


