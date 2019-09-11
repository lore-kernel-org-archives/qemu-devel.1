Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4BC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C5D20863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCCba/L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C5D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82Cf-0000TI-Vo
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i82BT-0008Lv-L0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i82BS-0004Ij-MX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:57:19 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:40378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i82BS-0004Hm-HN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:57:18 -0400
Received: by mail-ot1-x32a.google.com with SMTP id y39so22436924ota.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SOap77KTx0gqzhFspEa0CktrrJq9aiwd3k62uwt4J+4=;
 b=OCCba/L0ZL24T6dxZd5QSQX476rGVOL472UigXKLg9WVSZGRjTb27oeZTIszE3kdOP
 WSs5WZS5MpHyLuVwvwKA8D8XMw0xsAKBZoCNVBpQip5GtSaF0Q0nWYNw/h0JUwIs1sWh
 3liMa/1K+q80tnMVibP2/ehNTU/+4lGbl6v0IAhxBxLB2X8q3yWz7L22DDI8Kbezvunz
 evX61bMExRHbzXcbRTx7dnNdjbOVTnZHuirvjzhIuUyf6mFXhP3i1fyRPpLsgKK8+lBE
 83jMLX4yzbZPQNVUtmX8igKv1Vj66yMvRYYhPhH2vC/DrXTd5IQewIQNeBUiJIYwhAox
 MaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SOap77KTx0gqzhFspEa0CktrrJq9aiwd3k62uwt4J+4=;
 b=PmEqc+bFyTnMzgJ4/iVsc80ZazezR+apA7EzkLJKJKh2WNzN58RwI1m+JbvhvdkyOE
 uqsq+hQ6Ff1GdOzj7QAyCwDtFT6W7hvYlO0pApaxPNem+ygvRRqvf2uly3/OC3XmYelu
 8pKU+yUhDkIFxh0qgddOkIEV1WaxGrje1NmEZ6+N/FynY+M0ValMSOkJefUeKUBc3VLR
 HORfKGpWaSILXDwdfr9vliErsSWlFZFb9VerwaVncPdLpu4VT3ZuXFd3wdteCBXrcWoB
 Fg3esrXc3aa702BG472I+vLzO6lpvslgcYVwegYXWQIal8O8KPn55Uh9X9ZOIVlMtVCi
 EXsg==
X-Gm-Message-State: APjAAAXwDPCpHfOEwC1uEqTZZxbnTEIncSci6nvJ678lNZA8jrk2Bw+t
 VbnJ4NCEljJkVr1Eu55u+Si1JucZftul6z3T3nY4Yw==
X-Google-Smtp-Source: APXvYqx7AO8BettLLJnDKhtfctdJizzyqhEDjHYPA4wlYSCiTHVFR2iwDFTBUZJncVrSvV5+0U9vVzuD7a/sTbhP3hw=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr31673472oti.91.1568206637672; 
 Wed, 11 Sep 2019 05:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-11-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190904085629.13872-11-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2019 13:57:06 +0100
Message-ID: <CAFEAcA8sEhgOXnj-DGo04pSnpTObO+EeC94yrdGEikKq0=2QeA@mail.gmail.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 09:58, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> This patch is in preparation for adding numamem and memhp tests
> to arm/virt board so that 'make check' is happy. This may not
> be required once the scripts are run and new tables are
> generated with ".numamem" and ".memhp" extensions.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> I am not sure this is the right way to do this. But without this, when
> the numamem and memhp tests are added, you will get,
>
> Looking for expected file 'tests/data/acpi/virt/SRAT.numamem'
> Looking for expected file 'tests/data/acpi/virt/SRAT'
> **
> ERROR:tests/bios-tables-test.c:327:load_expected_aml: assertion failed: (exp_sdt.aml_file)
>
> ---
>  tests/data/acpi/virt/SLIT | Bin 0 -> 48 bytes
>  tests/data/acpi/virt/SRAT | Bin 0 -> 224 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 tests/data/acpi/virt/SLIT
>  create mode 100644 tests/data/acpi/virt/SRAT

Do the tests pass with this patch and without the
patch that adds the tests? (That is, can we keep the
two patches separate without breaking bisection, or
do we need to squash them together?)

I'll leave it to somebody who understands the ACPI
tests stuff to answer whether there's a better way to
do this.

thanks
-- PMM

