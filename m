Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7937C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824D9206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afBj0NyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824D9206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXRh-0000XC-M6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXPo-00085s-K0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:29:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXPm-0008V0-Ib
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:29:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id j26so8355497ots.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VE4WTDSHDNzlvovKwmVzZYoV0fgIme54I3r+hO9nD9c=;
 b=afBj0NyRXc2P9RQfVYQPCW089keZP0jqPLJ4lDGhCCDteMGdKHmxKz5NqCQ8BVkfH0
 7dmDEAH+EvRSQK40aQv97yKZ7Zsg2+wHjZOcyJAn95cHMQP+zGmOQ52AiE5U6sguFs1V
 66QEv2YrcSZn7ekZz9+5mYl1wTG7uHHmIgM85xT/05zKd+B/mPcb2vSxr3zkXmlwZRsX
 u6632sgRYil0t1R6czBhTABsy6rAIAtB/pZl687t7Vg8AqndGYFVCsqw6F8k8//qXJXV
 FnNI1SHR8PeiN9ka2RMjBADD8tNzQk4XaDT9YUtnkt2km8UqeaW64Kz72p/j4mMzbWUG
 ddkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VE4WTDSHDNzlvovKwmVzZYoV0fgIme54I3r+hO9nD9c=;
 b=Yt4Mj4pjRfDpvzR0h7eh4IcQrO8U7zwiCi+ThI+K+0R/F0nyjuqGvBU0429wQ6rDEI
 tid0wg5QYpILvAnNWLPKTrXxeMrozKbcVTJKJ9c4JdJBpMmeqkZM37ddHIU6wkJ+K7be
 CwkV5aP+u76XdpxPO5UWmRrXu0xDgWnwy1tUQeElUqNnejwlFezIdC17GwkRdp96zjEt
 81LAUjBbJw9HriyLsm54zjC+vTDuVPPvImxvjvDRNsswFS/HQbxS69KIWmYNla4VUzbj
 uLKgnn04qSkrbYkoORzB1gAR+LxuobwAUPGgutHgWRXu9mNUUb1WL3f5dNkzDlKltEqy
 H2sg==
X-Gm-Message-State: AGi0PubFjgJ6+u9TmDFQMPX2u0lJMkofenk0PFblajaJUqoS/rVPuoR6
 KmNB9ZjeheUkMXN8HIc8mDxcHBrq8PJARnhz2HNJCg==
X-Google-Smtp-Source: APiQypLrJsG1hDtkGacPc4m0LqTTcLvLN2XwOjdKie2lrDMxK9spGHKdFZjuIt+51N0VrDwqZGu0aoLbMauSpNMO/gs=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr13304921otj.91.1588584569082; 
 Mon, 04 May 2020 02:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <20200504011252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200504011252-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 10:29:18 +0100
Message-ID: <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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

On Mon, 4 May 2020 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 21, 2020 at 01:59:27PM +0100, Shameer Kolothum wrote:
> > This series adds NVDIMM support to arm/virt platform.
> > The series reuses some of the patches posted by Eric
> > in his earlier attempt here[1].
> >
> > This series previously had few fixes to qemu in general
> > which were discovered while adding nvdimm support to arm/virt.
> > Those were sent out seperately[2] and are now part of Qemu.
>
>
> Mostly ACPI stuff so I can merge it if I get an ack for ARM side.

Happy for you to take it; all the arm-specific bits have
been reviewed by various people (thanks!) so here's my

Acked-by: Peter Maydell <peter.maydell@linaro.org>

I notice that checkpatch complains a lot about

ERROR: Do not add expected files together with tests, follow
instructions in tests/qtest/bios-tables-test.c: both
tests/qtest/bios-tables-test-allowed-diff.h and
tests/qtest/bios-tables-test.c found

Does that need fixing, or is the checkpatch test wrong?

thanks
-- PMM

