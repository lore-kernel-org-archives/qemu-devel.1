Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9109BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D8D2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGfqypKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D8D2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXra-0004RG-ED
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXqn-0003c9-4d
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:57:26 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXqk-0004Xg-4l
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:57:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id j16so6100299oih.10
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e7GPO9m+Xws7zd9Wbw5Vjgi7NBvbZy+zDZil+YAQUN8=;
 b=CGfqypKO3lw7EhHUZAzjWPCJo7ZC6gRtfn/hP7Wp2q+S6olFmSTXlAIU42kCdRLAn6
 zipZRL1VZVB7UGsc1MhONPK/1+HeRf1vncxLoZhjZ2rPl6N9UT42iWFqBFECnooeUWwt
 8QqUgKf2y9mYuFJsU1fKVbVMP21rVv2rJj4MTDSKlSsZEKXTV5eTIDEzk0ggFaZcicPf
 wc4BtDCbft7W/cSI7w06l4b7xllhG3myIMw3pyxG8W5a7/C48ygMzJYwN9RYVu0j8u4B
 OEaTbIxQhhxhHm1wr1zgxh3Cpc1AIbFk9oxP+XInOPLZFJL0h3Wfz987OjQe1G8Yrnul
 6uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e7GPO9m+Xws7zd9Wbw5Vjgi7NBvbZy+zDZil+YAQUN8=;
 b=CeBgzpIbWg5wJBYxSC0vbLJQ7lwsMFVNTZvM3nJukTzT0ids+RAk+CG5xK2iNajnGA
 qBTvFnx1ZPo9O9xQCf5bTz1hb/9p059EpXMjjI99ETr5HV4TC3zCNRBhhsz1a0oGW57X
 NGlfdvmDeqJJeS6W+7aIcW4X7bkQDB0a/GiqTjG9W6ML8t+Hky60dg423P5O1bMZa+1K
 tqja8QW+1uuobIbKvsKWe5uePYw4KQ1ybwG5Hisw+DHw6Qz260o1hql5J119sHmHeUd4
 sd5V2wrtMUzISuUPH0e1ABdO7dYowk0MnQ959KGK4iaeRsnLKCLPdrlddCe3KDX5aNlI
 /9tw==
X-Gm-Message-State: AGi0PuY2HzHrH36VMnP7ok3qfa/gh4wFgrQ/lHItltQwtKfN3XcvT+Lq
 rEmZTtNR7CH/POQXvweA6aVdWDU2p3WSvaG60QSA6A==
X-Google-Smtp-Source: APiQypLgtoELo1NAvW4cw+EmGA9JyuGe5cO35y47UJBqHsU9+D119jpB31tvCzmN1D8pdYTc/8FVICxIIcqXKH+V5Z8=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr7721046oia.48.1588586240909; 
 Mon, 04 May 2020 02:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <20200504011252-mutt-send-email-mst@kernel.org>
 <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
 <20200504054547-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200504054547-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 10:57:09 +0100
Message-ID: <CAFEAcA86RCf7eWxGAaONjATBuR5qQ=eTpdf74U1ELUFnScYFtg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 prime.zeng@hisilicon.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 10:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 04, 2020 at 10:29:18AM +0100, Peter Maydell wrote:
> > I notice that checkpatch complains a lot about
> >
> > ERROR: Do not add expected files together with tests, follow
> > instructions in tests/qtest/bios-tables-test.c: both
> > tests/qtest/bios-tables-test-allowed-diff.h and
> > tests/qtest/bios-tables-test.c found
> >
> > Does that need fixing, or is the checkpatch test wrong?

> Hmm I don't see a patch in this series that changes both
> tests/qtest/bios-tables-test-allowed-diff.h and
> tests/qtest/bios-tables-test.c. Do you?

No, but that's not the pair of files that checkpatch is
complaining about. It warns about:

patch 1:
 tests/qtest/bios-tables-test-allowed-diff.h and hw/acpi/nvdimm.c

patch 2:
 tests/qtest/bios-tables-test-allowed-diff.h and hw/acpi/nvdimm.c
 tests/qtest/bios-tables-test-allowed-diff.h and hw/i386/acpi-build.c
 tests/qtest/bios-tables-test-allowed-diff.h and hw/i386/acpi-build.h
 tests/qtest/bios-tables-test-allowed-diff.h and hw/i386/pc_piix.c
 tests/qtest/bios-tables-test-allowed-diff.h and hw/i386/pc_q35.c
 tests/qtest/bios-tables-test-allowed-diff.h and include/hw/mem/nvdimm.h

patch 3:
 tests/qtest/bios-tables-test-allowed-diff.h and hw/arm/Kconfig
 tests/qtest/bios-tables-test-allowed-diff.h and hw/arm/virt-acpi-build.c
 tests/qtest/bios-tables-test-allowed-diff.h and hw/arm/virt.c
 tests/qtest/bios-tables-test-allowed-diff.h and hw/mem/Kconfig
 tests/qtest/bios-tables-test-allowed-diff.h and include/hw/arm/virt.h

etc, and the patches really do touch the pairs of files listed.
(It also seems to warn about each file combination multiple times.)

Are these false positives (if so, we should change the checkpatch test,
since it's clearly misfiring a lot) or problems with the patches?

thanks
-- PMM

