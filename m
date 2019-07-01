Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CAAC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEDF2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S19RzFaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEDF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxVu-0003ne-Ol
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhx6L-0002nF-2L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhx6J-0005cn-HZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:16:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhx6J-0005br-5G
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:16:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so13322659ota.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EY4Adx0OcbtAOPWeOiQ6foI2RYDNLt0gmr6T8P4rYnc=;
 b=S19RzFaHFMPAsC8JggOBvrQ0XCcqqUvZaHS/xgr5bTJgOF1D32KN6NODKaUA6S4rpa
 5dbFGqRGu6eQVDS3Ju98o7q2T0uyMo6q+xDBGEgR+y6w9MNmDND4Ge4fvP2/JkT9ysku
 voC0Hn/Sr/iR8MPDEn2J08NV5BkYZncBBgb1BlMOZ4RizZ/6eok/jFuppEUgr8jq9BqH
 nnGZ+fOIX0A32Yuq2DI7Ln9jLSCJF8y0mMDsXMR8pg7K9eAsU/gTSFGX1FQFNjTAHQ7W
 fMWXx/0EXMsOSe24u7ngsX1fIJutPF7YKjbpK4VD4sVpjggNdVNDRB1pJoXfuqTwW2FA
 r9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EY4Adx0OcbtAOPWeOiQ6foI2RYDNLt0gmr6T8P4rYnc=;
 b=XUrePyHF4eZl1OVJj8q5UsUbdPxlDAm/68o1g67sSHKx1UQoxt6uBH5woP0qfUY/a6
 zFW/ej/3lPKhw+Qp1gXtmShwGkeeRn4HfglGO5cHT+nWS6mE06uPencP3Y/+VsFJnLqG
 MVdrzTRVL9MVryh4r2eKveghyKUaTE5MH6pt6H/S7EVmmT/oplVMCZsWtNnDKL0pTzvU
 xw1wFPme9D70Y/2CHEkIefriGC/honQf5YqwSw2j+spZwRoZYUAijexLXh4sdEusloG0
 eW16WYqAZIMUHwTM4t6BdYlOp6q4JKaPfsZAg26pPJMBVUW4WSinXRoWZwTbcGZzSb8E
 rdzg==
X-Gm-Message-State: APjAAAU+8zVtfh9YhePylcFQ+cWw0Jab0h2ZSxpOVlaJVneEetEY6bq+
 zPeTP+/3cM7sP94WFXfP+j/HXoUcIT5v6nYhCbGuKw==
X-Google-Smtp-Source: APXvYqzdGFS/f8xo5e9jpYynCQWW4r6cciJTzD5y5Zmjpb91hBQPXoaFxIIJJx8iub15B6j7PQCDSyaxMqyPf8rtw/c=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr20494605oti.91.1561990570216; 
 Mon, 01 Jul 2019 07:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:15:59 +0100
Message-ID: <CAFEAcA8cut67vuwsc++H2TWa8Aq0g1ss8Gda3QnoyyP_-6WgwQ@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 30 Jun 2019 at 11:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware,  to support
> firmware and OS development for pysical Aarch64 machines.
>
> This machine comes with:
>  - Re-designed memory map.
>  - CPU cortex-a57.
>  - EL2 and EL3 enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus XHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Only minimal device tree nodes.
> And without:
>  - virtio deivces.
>  - fw_cfg device.
>  - ACPI tables.
>
> Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> it should supply ACPI tables to load OS, the minimal device tree nodes
> supplied from this platform are only to pass the dynamic info reflecting
> command line input to firmware, not for loading OS.

Hi; this fails "make check" for me. Running the relevant bit of the
test suite standalone:

e104462:bionic:arm-clang$
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
tests/qom-test
/arm/qom/integratorcp: OK
/arm/qom/nuri: OK
/arm/qom/mps2-an511: OK
/arm/qom/verdex: OK
/arm/qom/mps2-an505: OK
/arm/qom/ast2500-evb: OK
/arm/qom/smdkc210: OK
/arm/qom/collie: OK
/arm/qom/imx25-pdk: OK
/arm/qom/none: OK
/arm/qom/spitz: OK
/arm/qom/musca-b1: OK
/arm/qom/realview-pbx-a9: OK
/arm/qom/realview-eb: OK
/arm/qom/realview-pb-a8: OK
/arm/qom/versatilepb: OK
/arm/qom/emcraft-sf2: OK
/arm/qom/musicpal: OK
/arm/qom/sbsa-ref: **
ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:628:object_new_with_type:
assertion failed: (type != NULL)
Broken pipe
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/libqtest.c:145:
kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)

It looks like the new board model is being added to the
32-bit qemu-system-arm as well as to qemu-system-aarch64.
This seems wrong, since the board will only work with a
64-bit CPU.

thanks
-- PMM

