Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3677F207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Guw1CG5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3677F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUhM-0000Qz-AA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUfr-0007HE-1l
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUfp-0004Ha-RA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:52:10 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUfp-0004Fj-N3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:52:09 -0500
Received: by mail-ot1-x342.google.com with SMTP id b18so50441553otp.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jYJwQ2h8YBorrIaF1tFRh50Uxv68nRf2ixv9iY02j3Q=;
 b=Guw1CG5Ef8DI3lhJrC9h8xJfXCpz85k/o9O01coOL3kqntMYbR7I/hqFL4h/0wxH9K
 hcQrB+yYmwZZqD/8dtq3rjFEsWaTEMMvTPKjquGB/cIlgKkHJ1wDm1e+80U3yif9JIjN
 BM23KaaIWTCbWUsG3LucS8GEiC3UbVFkjTmI7x0oXtEyCBCU2LCPWd4wfSh1UYIJMAN/
 1cVaM/xRZUgzAVkGzgKFq8MrrQ+7pkhHA7zKxsT8mqK8KJXyjCaPzYyNjTAiT/Kj0oI6
 wvaFU3jiCj415sHef/WdvdU9EwJfTGakPJn/18HcOQBn0bGuzklIi7WyhsKbFIJ7nm+Z
 2KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jYJwQ2h8YBorrIaF1tFRh50Uxv68nRf2ixv9iY02j3Q=;
 b=KALE4ghvgxzYSvGSfrFi0tYBv/oKdfgjKJuk5a1BKbpIlTQehd9gmF+TN6MwGaDNpq
 B9Bz9WtSJaHouAEUSvvvq/wqPBmUuJvtnuLr0YiPJJfYBJgFjQnY9Nlp8EHVKtSY11Pi
 dYqlgzf7P8kEBjLT946zeRAZiq5ffFnWuwQPHeYTaFs1dQ1U4go8FX+tHwhJIxLoKSDu
 V2lUmKKzRsSIl+ZXQMKuymUWm/ck6A4/PIDDY2oFukmSQocl85dGCNZZKYI51GP0fU1J
 iQhETktokzWeYvyN1D5Z5RaZQ94VLG1kUqH/vSD9J8GSnIIgNniMDthm+myzmpyE4/Li
 PlvA==
X-Gm-Message-State: APjAAAU4uBFoVGl9FWnZqrWfY0UluHi+NCSDvyvHkE25cg04qEUVm13E
 oiI9u0jf3E824xMQCqrlsTMQd5Bz8PFdFV1FAQInjA==
X-Google-Smtp-Source: APXvYqx+1a91gZtR+3hpyT8LVXkh4isTs1j38trLAS3yBnnQyWhD2rWlQW/dc60Vesyp5X7R2kzfOH2eYwPn7X9AQD4=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr117367409otd.91.1578325928753; 
 Mon, 06 Jan 2020 07:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200105072504-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:51:57 +0000
Message-ID: <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Corey Minyard <cminyard@mvista.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jan 2020 at 12:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote:

> >  hw/arm/virt-acpi-build.c          |   8 --------
> >  tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
> >  tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
> >  tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
> >  4 files changed, 8 deletions(-)

> Please do not include binary changes in acpi patches.
>
> See comment at the top of tests/bios-tables-test.c for documentation
> on how to update these.

If you want the patches not to include binary changes then
you will need to take these yourself through your own tree.
As the Arm subtree maintainer I am not going to follow a
specific process for acpi related patches that requires me
 to do anything other than "apply patches from email, test
them, send pull request". I also have no way to
identify whether any differences that I might see if I
disassembled the ACPI tables make sense, as that comment
suggests I should be doing. The differences in the tables need
to be checked by the people reviewing the patches, which will
not be me for anything ACPI related -- I just don't know
enough about the ACPI specs.

Patches should be self contained, including updating test
cases as required. The underlying problem here is that
the 'golden master' data for the acpi tests is a pile
of binary blobs rather than something that's human
readable and reviewable as part of a patch.

thanks
-- PMM

