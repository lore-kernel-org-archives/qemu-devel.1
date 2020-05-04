Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46257C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF6E20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmlMoNfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF6E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVY0e-0004ll-W5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVY05-000464-Gd
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:07:01 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVY04-0002dX-Iu
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:07:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id t199so6150170oif.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JIEX/w3bf0cjwHgdmYdRZ0vsBANcQ731ZClQImQnZFQ=;
 b=jmlMoNfEGDfF5YztKd5upH0jQSYcUCavmoNGSnX/gyfElzwAVi19iNonl57SSjdRB4
 rDsXttR/+vCWiDjev0vYbdb1pVfh0aemIC6qM72oRed6jkN18wQuuMbjvsrjKK3c3nsc
 +yDAKics1mgyzGPrHWqybc/TINy1H8mBFju14UXavz/U9ATe6OZkdPNXZTjZSJ59EtlG
 LYbdLAK/7kuacVoJ9JdoACMyg/yGBG00OAHWqv/okXpRpBlE1gTwkmJpyltcu9DROd9G
 wHgrt3ujCIR0jwbcIgR6Plzjz2kt8t6YxHshHWlbD+82zQDHDb7xVhtc+UPLACEJrut0
 ZTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JIEX/w3bf0cjwHgdmYdRZ0vsBANcQ731ZClQImQnZFQ=;
 b=DctWatAEETQ3QFUC0TlFgTd+POWGBLLjc7RvVTB1fUZ8uCLkc8u7WQ0x+yVqdZifVR
 PCrpvAlBr2WYWCbfGsK6q3snWQPzEGKJqz40t+gNIUUyULLToZavnvEFH9mQMN1Fszjo
 20c4ERGiVaZXmriiwfo4pR7Ip7qwt5IAyiTqIhD2+nfknj1o16UGIIbRNg7uUcKNaGt2
 XL+Mh+m03itvnVY2ZJjqcbwK3peyh5H7TWDEb4LArnbWpDUtBPzw5qJ1kNrEQEQyRFgr
 Uxzi2KUCVddcOg3u22Q/d/1eAm5W2KeJOFPawUjdMntEQnMUXiUKk/TrDSsKdvEqpAgL
 yIyA==
X-Gm-Message-State: AGi0PuZYnR3cTRIR6yi/RPkDayJvVAyV5SXCa49GBjw1yD3pjDMV3CNo
 6mS6wMsVFIkkKmow1lEjTg2IU2OgBeN7Scu30fnwpg==
X-Google-Smtp-Source: APiQypJ6JBMzBRMu/ZaiHqKWt3MJFE3cld1M3Ig95XMzUiwQvEHs0kVGkLACOvlpUFailztHbmTVyV336ivFVoYCEzw=
X-Received: by 2002:aca:3441:: with SMTP id b62mr7934429oia.146.1588586819285; 
 Mon, 04 May 2020 03:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <158748197516.25490.13137194821077838492@39012742ff91>
 <20200504055608-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200504055608-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 11:06:48 +0100
Message-ID: <CAFEAcA_VGtbjpVTb1VE1XCT43JODjkW8o1zSsVmzO3fg1+fr+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 prime.zeng@hisilicon.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 10:57, Michael S. Tsirkin <mst@redhat.com> wrote:

> > ./scripts/checkpatch.pl --mailback base..

> > 2/7 Checking commit 5554e78b18ea (nvdimm: Use configurable ACPI IO base and size)
> > ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allowed-diff.h and hw/acpi/nvdimm.c found
>
> This beats me. Where did we get
> tests/qtest/bios-tables-test-allowed-diff.h from?
> It's a different patch, isn't it?

Ah, this is a bug in the checkfilename() function -- it uses
some globals $acpi_testexpected and $acpi_nontestexpected, but
there is no code to reset these when checkpatch starts checking
a new patch. So if you only check one patch in a checkpatch run
(eg by just passing it a single patch file) then it will work, but if
a single checkpatch execution is checking several commits
(eg in the way patchew runs it to check the whole series of
git commits at once, or if you pass it several patch files) then
it will give wrong results for the second and later patches.
I think the variables need to be reset at the top of 'sub process()'.

thanks
-- PMM

