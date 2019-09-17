Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45379C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAE52171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAE52171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFJq-0004Ke-7P
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8c-000342-JI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8b-0000Yx-AE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8b-0000YX-1z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:29 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 492442A09B3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:28 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id y189so4551733qkb.14
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IG7CfctVDXfGwR9kbPlgS5F237tLtpXXVxR0qikO/9A=;
 b=M5n3AZUK0d9WEBKRci+IyFy3bxXCBpUAZiJH3KU7SLo1wKDJfQF0EabxP8tNvX9c6W
 B4he9OQdlDY0zSBTZCVMna84/pEfdJ3ixxtY/FsoDO4oWLkkdsdxCnQ4jToDfAfJwyhf
 +QvEt0x4hpNpo8vRfRyYpFk8qhVvZbeRLfSEb9M65Lb1ckGu2g9TR9eMOVynNnXvL/kP
 3GcBnPvjFZ4F2CblzyMU7HwE0PIjYHGxl68NRGjw9zMfTjIueGP6X8kIloG7nMeYcWsw
 1lrtWQx+cj2Sdx8V25xdNxbkzo5jEPjL82mszFbai6wZtNm144GRW8AtE4/hYmsdma5v
 hDog==
X-Gm-Message-State: APjAAAVi/P3wpzJoaQhbkypjQRu0p7rQMP1PUgIHYDoY9VXU1TxGXSLs
 20JdeeRgVvOP7s4RetN+BThsqV/OujOYMI/81X/e8rQvV0QXxSDTrC2yif4o4ttssNLQOqcnST4
 X3E2rob0TS8RG2xA=
X-Received: by 2002:aed:2902:: with SMTP id s2mr2825646qtd.205.1568733087291; 
 Tue, 17 Sep 2019 08:11:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwm4dRxgVCStN0fnW4ROs5X8TQgTR9uc6tr2OMwQjH/VjLF6GieDZUs0Al0YP9t4gBA+AWQNQ==
X-Received: by 2002:aed:2902:: with SMTP id s2mr2825621qtd.205.1568733087111; 
 Tue, 17 Sep 2019 08:11:27 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id j7sm1561893qtc.73.2019.09.17.08.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:26 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190917111100-mutt-send-email-mst@kernel.org>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-11-shameerali.kolothum.thodi@huawei.com>
 <CAFEAcA8sEhgOXnj-DGo04pSnpTObO+EeC94yrdGEikKq0=2QeA@mail.gmail.com>
 <20190911155015.3627b072@redhat.com>
 <20190911095332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911095332-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 10/11] tests: add dummy ACPI
 tables for arm/virt board
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 09:55:34AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 11, 2019 at 03:50:15PM +0200, Igor Mammedov wrote:
> > On Wed, 11 Sep 2019 13:57:06 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > 
> > > On Wed, 4 Sep 2019 at 09:58, Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > > This patch is in preparation for adding numamem and memhp tests
> > > > to arm/virt board so that 'make check' is happy. This may not
> > > > be required once the scripts are run and new tables are
> > > > generated with ".numamem" and ".memhp" extensions.
> > > >
> > > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > > I am not sure this is the right way to do this. But without this, when
> > > > the numamem and memhp tests are added, you will get,
> > > >
> > > > Looking for expected file 'tests/data/acpi/virt/SRAT.numamem'
> > > > Looking for expected file 'tests/data/acpi/virt/SRAT'
> > > > **
> > > > ERROR:tests/bios-tables-test.c:327:load_expected_aml: assertion failed: (exp_sdt.aml_file)
> > > >
> > > > ---
> > > >  tests/data/acpi/virt/SLIT | Bin 0 -> 48 bytes
> > > >  tests/data/acpi/virt/SRAT | Bin 0 -> 224 bytes
> > > >  2 files changed, 0 insertions(+), 0 deletions(-)
> > > >  create mode 100644 tests/data/acpi/virt/SLIT
> > > >  create mode 100644 tests/data/acpi/virt/SRAT  
> > > 
> > > Do the tests pass with this patch and without the
> > > patch that adds the tests? (That is, can we keep the
> > > two patches separate without breaking bisection, or
> > > do we need to squash them together?)
> > > 
> > > I'll leave it to somebody who understands the ACPI
> > > tests stuff to answer whether there's a better way to
> > I'd squash this patch into 11/11 test case,
> 
> 
> Pls don't - the way to add this is to add the files in question to
> tests/bios-tables-test-allowed-diff.h.
> 
> Maintainer will create a separate commit updating
> the binaries and removing them from the whitelist.
> 
> This way things like rebase work seemlessly.


OK?

Can you post v11 like this? I'll ack then.

> 
> > CCing Michael (since he's the one who applies ACPI patches)
> > 
> > > do this.
> > > 
> > > thanks
> > > -- PMM
> > > 

