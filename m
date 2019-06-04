Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89BC28CC3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29ABC2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgdgzIwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ABC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYBp1-0002W1-Pd
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:57:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYBoI-00027R-OR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYBoH-0004LM-NZ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:57:14 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:41237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYBoH-0004Jc-Ho
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:57:13 -0400
Received: by mail-ot1-x335.google.com with SMTP id 107so14202001otj.8
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hU4n3P3vkQHB4Fvyj6fU4EpSIzKCsQ1tR+oXly+Hhpc=;
	b=vgdgzIwBvywVqO1PXyApVgi92/og5RoFKY6ZbjK2jIrTBBMK2HV+P6G+lEjSJYEQqg
	jwJcede/FXJzgCsb+s4cMETYDbwm2uzPYKkqt50r5afjfsfRr2f9FsKjmFe96oXu0xYq
	isntIflAmlh/rJIbqTh9qfFH9nCHVq2bAZLTBzoq94WgWg2MMLcn03qH0ZvcvM1eHipI
	C9jlfg+1rlJeYSBZLa8tX23T7D1shgEwO06bHugBbZomwQ7Z6ihwwtTH48sHL+uTdEPu
	L69icNb5MCLgIbGgM6oQu7CUPN/J/XOScZ5NA6WlQnaammVZj9naU4ibSq1rUhgOTARd
	lFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hU4n3P3vkQHB4Fvyj6fU4EpSIzKCsQ1tR+oXly+Hhpc=;
	b=jD5Hk7dbZSfD0nm3vu9mTwygO+wIQAHFjJdpO72BR/oBE/WFbJPViI/Y5hZOhVDQ6R
	hignFtaWqReqgbTciWCTIAxaHTEvf3iKC9xBV/lve/kiEiQQh1WtXVVXK1LOkQ0p1/SB
	iRJWOQmBQFUcddPpm8HJnSkOAHgtM4vqXaNsROyoktInrdzLCVi1UfNEUxtef7cNq3O/
	slHEM341nSe/bM/jn5cER/kca0Ldb2EvE0hYHG+3DDPnSZuTDZrP5APhImoFJI9PFN65
	0mz3HgwKmzkZgKFuNhBuAX1fwo0CwCal5wZmCCa/PVP57tzQQFzhc8QBCobBzBQI8qYw
	+Gwg==
X-Gm-Message-State: APjAAAWOjhcSArsRlzEFuid5p2KB5vL0ZfA3PzoQuVN/qIcwlnQ7xXH7
	AXOaCqfEALoR4WGqQmHNwVfros9AbxJ50X/vhx0/FQ==
X-Google-Smtp-Source: APXvYqwPrwmfXDtpD/daG9s9Z3TItPXKFSXdXpoKKw4pOahOOzt0zpJOaDnaYRtsdIzXfN0j6xVBEvqdGAwzTrEduhI=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr5802416otp.91.1559663831727; 
	Tue, 04 Jun 2019 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190603180807.16140-1-mst@redhat.com>
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jun 2019 16:57:00 +0100
Message-ID: <CAFEAcA8zMLAs6-ssLhsKBfhRECzADUzpKWw+_jgJhQz0BnxciQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL v2 00/14] virtio, pci, pc: cleanups, features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 19:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to df7cafdeb68b6572fa81d2be9a1910547c4dfafc:
>
>   bios-tables-test: list all tables that differ (2019-06-03 08:05:43 -0400)
>
> ----------------------------------------------------------------
> virtio, pci, pc: cleanups, features
>
> stricter rules for acpi tables: we now fail
> on any difference that isn't whitelisted.
>
> vhost-scsi migration.
>
> some cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Hi; I'm afraid this fails 'make check' on my aarch32 build:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/bios-tables-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="bios-tables-test"

Looking for expected file 'tests/data/acpi/pc/FACP'
Using expected file 'tests/data/acpi/pc/FACP'
Looking for expected file 'tests/data/acpi/pc/APIC'
Using expected file 'tests/data/acpi/pc/APIC'
Looking for expected file 'tests/data/acpi/pc/HPET'
Using expected file 'tests/data/acpi/pc/HPET'
Looking for expected file 'tests/data/acpi/pc/FACS'
Using expected file 'tests/data/acpi/pc/FACS'
Looking for expected file 'tests/data/acpi/pc/DSDT'
Using expected file 'tests/data/acpi/pc/DSDT'
PASS 1 bios-tables-test /i386/acpi/piix4

Looking for expected file 'tests/data/acpi/q35/FACP'
Using expected file 'tests/data/acpi/q35/FACP'
Looking for expected file 'tests/data/acpi/q35/APIC'
Using expected file 'tests/data/acpi/q35/APIC'
Looking for expected file 'tests/data/acpi/q35/HPET'
Using expected file 'tests/data/acpi/q35/HPET'
Looking for expected file 'tests/data/acpi/q35/MCFG'
Using expected file 'tests/data/acpi/q35/MCFG'
Looking for expected file 'tests/data/acpi/q35/FACS'
Using expected file 'tests/data/acpi/q35/FACS'
Looking for expected file 'tests/data/acpi/q35/DSDT'
Using expected file 'tests/data/acpi/q35/DSDT'
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-NKUU2Z.dsl,
aml:/tmp/aml-UERV2Z], Expected [asl:/tmp/asl-3ITW2Z.dsl,
aml:tests/data/acpi/q35/DSDT].
acpi-test: Warning. not showing difference since no diff utility is
specified. Set 'DIFF' environment variable to a preferred diff utility
and run 'make V=1 check' again to see ASL difference.**
ERROR:/home/peter.maydell/qemu/tests/bios-tables-test.c:422:test_acpi_asl:
assertion failed: (all_tables_match)
Aborted
ERROR - too few tests run (expected 15, got 1)
/home/peter.maydell/qemu/tests/Makefile.include:884: recipe for target
'check-qtest-i386' failed


This is the only 32-bit host I test on, so it may be a generic
32-bit host problem rather than arm-specific.

thanks
-- PMM

