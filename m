Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0BEC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5795E20659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZ55qWJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5795E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxOy-0004t5-KM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwjb-0002MF-Sd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwja-0002vt-Pk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:52:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhwja-0002vD-Hy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:52:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id s184so9994242oie.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JFZ6A9/Tq76ek+zANoM+rQdepd9TjEaPsh9J0af/75E=;
 b=GZ55qWJsqoxbOFEgWG6NDxXqA6nNS68JmcxyPZH8SKhehT3VL72uFg+hTRxcEylGXz
 o2IRsQEO71sUxYxBP/L8LjUOlDFRNoB15DZxbPGklVmQcOzkSwFl7QPZh6DjxWqhw7Pu
 y24RriH3HNbxNmU7QghISWoz8pTC+EeFjw9in+ez/JvJ967zK3MNIeVAhOW6K5ooaBF8
 EtK9wg0e8J6pnLduf1E0bGTJvFVP9vVWbzB1goPS6LjnsqHkDxRcH1LoHrwMcqbhbU/4
 R/fI4iwHKdCGEZ8B+80paCq5jSlGmzhKE3GePKnte5RqTWTP5IN8AGlcm7OT47yjp2YN
 8kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JFZ6A9/Tq76ek+zANoM+rQdepd9TjEaPsh9J0af/75E=;
 b=bAGepvr9ON25luoSId6m94TamkfupWjTPyhoqulCtz4RxtLDDg/YySN2SLb5J2LURq
 oOTZ54FQHooqR3sT530UpH4aspEX6vD9arIOqaSYnVCetoTSp6oMpojyLr69cnjHdAjU
 a5Pg3chWVOd5oe010uO4K27+IAymQPIstgLP8OC7TFmQXMB2SRKKZ9dkt+u2mvIBQeZ1
 TYUEBOO6SOfuaNEzQqsz7K7rJNrZZX6DxZWpLJ8SGkSpi96tVE8exIMT7h+tZUrQiynV
 eyQVPJHLGmkboWhleBBrgY9xhdfBZZhOfMnGys47bk7FKQ+a17uRM4vAVgVkAeHXdmnI
 bXHw==
X-Gm-Message-State: APjAAAU1CSsBD82yDfFZvDsYrusp6PdfmkOTSRs6d/OtOouG7rV71rL3
 sr8BfW0ke/aLJxeJK/sdCldRTagt97kirbg54q1bCw==
X-Google-Smtp-Source: APXvYqxwnmNItwiw/dyGNP5B2WIx/Cvfnvu53TSRsdMCKr8ZdI47ZiHDSl4S3TnVFcwS8vVdAaMgWRtV39+sFotpshU=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr6609602oij.98.1561989161521; 
 Mon, 01 Jul 2019 06:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 14:52:30 +0100
Message-ID: <CAFEAcA-w1AijFogZxX_9gz2+oDGH-=e2QAOdyCRdji_6k87d-A@mail.gmail.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
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

On Tue, 25 Jun 2019 at 13:15, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> This series is an attempt to provide device memory hotplug support
> on ARM virt platform. This is based on Eric's recent works here[1]
> and carries some of the pc-dimm related patches dropped from his
> series.
>
> The kernel support for arm64 memory hot add was added recently by
> Robin and hence the guest kernel should be => 5.0-rc1.
>
> NVDIM support is not included currently as we still have an unresolved
> issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
> can be included, but not done for now, for keeping it simple.
>
> This makes use of GED device to sent hotplug ACPI events to the
> Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
> Sebastien to add the hardware-reduced support to Nemu using GED
> device[3]. (Please shout if I got the author/signed-off wrong for
> those patches or missed any names).
>
> This is sanity tested on a HiSilicon ARM64 platform and appreciate
> any further testing.

Hi; this seems to fail 'make check' (on an x86 host):

acpi-test: Warning! DSDT binary file mismatch. Actual
[aml:/tmp/aml-01P83Z], Expected [aml:tests/data/acpi/virt/DSDT].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-4ZP83Z.dsl,
aml:/tmp/aml-01P83Z], Expected [asl:/tmp/asl-H7UE4Z.dsl,
aml:tests/data/acpi/virt/DSDT].
**
ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:434:test_acpi_asl:
assertion failed: (all_tables_match)
ERROR - Bail out!
ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:434:test_acpi_asl:
assertion failed: (all_tables_match)
Aborted (core dumped)
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:894:
recipe for target 'check-qtest-aarch64' failed

Is there a need to update the reference DSDT used by the test?

thanks
-- PMM

