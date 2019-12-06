Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C004C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAA124659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOSYcnF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAA124659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFHt-0005On-Im
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idETX-0006So-Hd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idETP-0000ah-E3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:48 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idETO-0000Ys-PB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id i15so5902631oto.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KhS4gG43qgtC91LEgSVI97VHTZLo7KkC/ba4BqbDDQA=;
 b=VOSYcnF3rR0AwaPLcHqOYQhhO3CElLvh+Rawv3pFS0HhebTxFVXscRXeGD+3CxeQ5O
 huEE8S4lWuSZHvXiHhhZQMqE6E5Bqf+8RXUxPz0ORzaKk/u0V8sw8RVbQMMIyNAj0Mkt
 27U+/ugbKPZWsjq8RLxImQnin6CsFP3AD+pJA+pCaDXWpJyyRUBCQ8mvI349NvA3WyfF
 f6T++ZZlU4krHslZ20AJcYJ/gkpkakzn4oGd6EnQwnWSyteLe+Y9p+mtwenExiyzDU2+
 bYXGfGq6hoKBfgOpDfUWogzlItmfD+Etro2yOGn5nnc4Ub71Rvo4SY8X82mAfxIna/Uf
 6Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KhS4gG43qgtC91LEgSVI97VHTZLo7KkC/ba4BqbDDQA=;
 b=mFQodobfohuZdCYBIMELY1K5UyLjqodu/OkoRG5PbXWpBRSH3BM7ZELD50fLNJqAxJ
 GF5C4S/oVCTGwzbIyJ6H5Nbyw6NhXnBgiEHIbIJH/+mYxDfFNT01vy1i16Nnurr1hB8Y
 PzrcKmn7g0b+l7c6SFbC7ksFPDfd8fJDHLt6dD1eYG/eHBMH7k4x7IODPiOsBjh8pymy
 JMhGCF4KeAlTac7WB7vCUGnN6Hjm6JvvCEjf/NLh7VOLoWrHhDbQjQk6IHz0o19xt9QM
 mc8pWgnUkSQ5Eg7mOkpF42smJitqu3Dd/W/q4ZZJogEcZx/U3+7JTTp3Zvxe+8ViHwdl
 +Qrg==
X-Gm-Message-State: APjAAAVM8HOv4wpU0ebj7J06cbrbMViIqBRYgIdMxqTBflGkgMwScxLK
 EvRlI578SaFmQctToBLbBpmJV4HmI2+w8lfzzdoxlQ==
X-Google-Smtp-Source: APXvYqzon2R7riMvCbIfmw0eUySY3t+l0thH4e4kjiebly2OpJH162ICKgk240/4T+npqt9OnzSAi+lnq1kejn41kC0=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr10496157otm.221.1575640246856; 
 Fri, 06 Dec 2019 05:50:46 -0800 (PST)
MIME-Version: 1.0
References: <1552098649-28341-1-git-send-email-guoheyi@huawei.com>
 <20190312170859.73f0de9d@redhat.com>
 <ca5ccc80-663f-83e6-d9ce-4d5e3749988d@huawei.com>
In-Reply-To: <ca5ccc80-663f-83e6-d9ce-4d5e3749988d@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 13:50:35 +0000
Message-ID: <CAFEAcA_v3bh+1h8+ti_t5Kkp1M9zhEmtsqSQzcHhAobr_+JxMQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] arm/acpi: simplify aml code and
 enable SHPC
To: Guoheyi <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 Nov 2019 at 03:47, Guoheyi <guoheyi@huawei.com> wrote:
>
> Hi Peter, Igor,
>
> I couldn't find these 2 patches in the latest tree. Could you help to
> merge them?

In future I recommend pinging unapplied patches with a shorter
delay than nine months :-)  In QEMU's process, unless somebody
has specifically said they've picked up the patch, it still
"belongs" to the submitter to chase if it hasn't been
applied. In this case I simply didn't see Igor's request
that I take it -- the chances of me actually reading any
particular list email even if it's cc'd to me are not good.

I tried applying them to target-arm.next but unfortunately
they break 'make check':

  TEST    check-qtest-aarch64: tests/bios-tables-test
acpi-test: Warning! DSDT binary file mismatch. Actual
[aml:/tmp/aml-4IELC0], Expected [aml:tests/data/acpi/virt/DSDT].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-AOELC0.dsl,
aml:/tmp/aml-4IELC0], Expected [asl:/tmp/asl-XL7KC0.dsl,
aml:tests/data/acpi/virt/DSDT].
**
ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:477:test_acpi_asl:
assertion failed: (all_tables_match)
ERROR - Bail out!
ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:477:test_acpi_asl:
assertion failed: (all_tables_match)
Aborted (core dumped)
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:918:
recipe for target 'check-qtest-aarch64' failed

Could you fix and resubmit, please?

thanks
-- PMM

