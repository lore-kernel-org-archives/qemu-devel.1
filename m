Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942C6208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yh4lYjea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942C6208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNbh-0006p4-QK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNaq-0005zG-B8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:27:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNan-0006TF-Jc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:27:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id 5so24927424oty.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OvtypjP46Gi5l1M0bRK4+tNsXw8ex82kYIH7sgZ717E=;
 b=yh4lYjeauRjBRLtRjxqxH9iNQn9RjLIe3QPDdzfkP/jvKnzFMiadEwVe+uTI4bfB1T
 hRGcIe280TlLTGL9UoPNUTO/57A4kYnOeX7j8+EvrALRq0mETHE81i9CA9zz9JHGCKx1
 4kRXtGYejnXsc+2YLFarDV+8DvqdsxlFKjKoVD9pZtv7tDZoCpsEi3gLxBEh8tXj3BD3
 6kKrLlXdbV2ziIi/fY0Vdu4QTUpGzL9uybXRCmZbqPd/tVHWOUnaJW+yBBUNoZ1WmjLy
 C5MwbjZmCDYbRzb9PUs3OG0GMuNIu1C7qrlOWiwaFfba5v4UBKI8HL+rsEeug9I2Cxv/
 Hopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OvtypjP46Gi5l1M0bRK4+tNsXw8ex82kYIH7sgZ717E=;
 b=VrvT/ZHo72TXZ2SndUs6+8Y7C0vvFrJqGcZO+CCmw4j9FhrNBdCBWc1uX2qpbf8cxE
 BLYHs2wHzNqQKoUNH+DfxeZ8+ihEE+3yRmB6cc1mK/oUEEZ4gxbbnrWv8JgafiJ+xlT4
 0pxUNyPDrHrjjukAEX6irb/KpGJEt24kPVd98PE91ph5X8SKY4UmEzgwlfjJEoDdzRio
 R4bqL4OnDdR7zswMUN3J9mSSHiiBhd65q9lNQ7kHN12XXL+r0iFVXu0T1B6dWlMb55gw
 i9As1XNtrp24tuuvlkiNiYRVxnUxFOgO6Zp65vy5moHc9VcDrATOiJExuLfekoJLb9Li
 WsEA==
X-Gm-Message-State: AOAM533t6S9krWe0UpAYjXsZDMKVWWxGAgp+F39W8gZT1++CdmC3GvkB
 pda51daQ3KUa6jgWX4wkNpmqFBoTPbLZT+ZLel/1OQ==
X-Google-Smtp-Source: ABdhPJwpo422oyNCpi2IMD3v+q8qkuz53FTjLdeS54nQyvW3gWVnDO8hRagSzY5iTJwwHhhLIukxNQfUJtz4Ja7HJWQ=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24922079otk.221.1593790027888; 
 Fri, 03 Jul 2020 08:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200701161153.30988-1-alex.bennee@linaro.org>
 <20200701161153.30988-2-alex.bennee@linaro.org>
In-Reply-To: <20200701161153.30988-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 16:26:56 +0100
Message-ID: <CAFEAcA810JVTTfwkf9ezR=0dkwRLxERBUSgroUV3OTy4ZGu5Dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] docs/booting.rst: start documenting the boot
 process
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 17:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While working on some test cases I realised there was quite a lot of
> assumed knowledge about how things boot up. I thought it would be
> worth gathering this together in a user facing document where we could
> pour in the details and background to the boot process. As it's quite
> wordy I thought it should be a separate document to the manual (which
> can obviously reference this).
>
> The document follows the socratic method and leaves the reader to ask
> themselves some questions in an effort to elucidate them about any
> problems they may be having.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190308211557.22589-1-alex.bennee@linaro.org>
>

I have some typo/grammar nits below, but more significantly:
I don't really see why this is a bit of QEMU's documentation
rather than, say, a blog post. It doesn't really say much
about QEMU in particular. It's also rather vague about
what guest architecture it's talking about, and they can
differ significantly both in the real world and in how QEMU
handles them. Also, why put it in interop?

> ---
> v2
>   - fix a lot of it's/its
>   - mention microvm style booting
>   - add some questions to the end
> ---
>  docs/interop/booting.rst | 159 +++++++++++++++++++++++++++++++++++++++
>  docs/interop/index.rst   |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 docs/interop/booting.rst
>
> diff --git a/docs/interop/booting.rst b/docs/interop/booting.rst
> new file mode 100644
> index 00000000000..8579a775d04
> --- /dev/null
> +++ b/docs/interop/booting.rst
> @@ -0,0 +1,159 @@
> +..
> +  Copyright (c) 2019-2020 Linaro Ltd.
> +
> +  This work is licensed under the terms of the GNU GPL, version 2 or
> +  later. See the COPYING file in the top-level directory.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Anatomy of a Boot, a QEMU perspective
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document attempts to give an overview of how machines boot and
> +how this matters to QEMU. We will discuss firmware and BIOSes and the
> +things they do before the OS kernel is loaded and your usable system
> +is finally ready.
> +
> +Firmware
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When a CPU is powered up it knows nothing about its environment. The
> +internal state, including the program counter (PC), will be reset to a
> +defined set of values and it will attempt to fetch the first
> +instruction and execute it. It is the job of the firmware to bring a
> +CPU up from the initial few instructions to running in a relatively
> +sane execution environment. Firmware tends to be specific to the
> +hardware in question and is stored on non-volatile memory (memory that
> +survives a power off) usually a ROM or flash device on the computers

", usually"

> +main board.
> +
> +Some examples of what firmware does include:
> +
> +Early Hardware Setup
> +--------------------
> +
> +Modern hardware often requires configuring before it is usable. For
> +example most modern systems won't have working RAM until the memory
> +controller has been programmed with the correct timings for whatever
> +memory is installed on the system. Processors may boot with a very
> +restricted view of the memory map until RAM and other key peripherals
> +have been configured to appear in its address space. Some hardware
> +may not even appear until some sort of blob has been loaded into it so
> +it can start responding to the CPU.
> +
> +Fortunately for QEMU we don't have to worry too much about this very
> +low level configuration. The device model we present to the CPU at
> +start-up will generally respond to IO access from processor straight

"the processor"

> +away.
> +
> +BIOS or Firmware Services
> +-------------------------
> +
> +In the early days of the PC era the BIOS or Basic Input/Output System
> +provided an abstraction interface to the operating system which
> +allowed them to do basic IO operations without having to directly

"allowed the OS"

> +drive the hardware. Since then the scope of these firmware services
> +have grown as systems become more and more complex.

"has grown"

> +
> +Modern firmware often follows the Unified Extensible Firmware
> +Interface (UEFI) which provides services like secure boot, persistent
> +variables and external time-keeping.
> +
> +There can often be multiple levels of firmware service functions. For
> +example systems which support secure execution enclaves generally have
> +a firmware component that executes in this secure mode which the
> +operating system can call in a defined secure manner to undertake
> +security sensitive tasks on its behalf.
> +
> +Hardware Enumeration
> +--------------------
> +
> +It is easy to assume that modern hardware is built to be discover-able

"discoverable"

> +and all the operating system needs to do is enumerate the various
> +buses on the system to find out what hardware exists. While buses like
> +PCI and USB do support discovery there is usually much more on a
> +modern system than just these two things.
> +
> +This process of discovery can take some time as devices usually need
> +to be probed and some time allowed for the buses to settle and the
> +probe complete. For purely virtual machines operating in on-demand

"probe to complete".

> +cloud environments you may operate with stripped down kernels that
> +only support a fixed expected environment so they can boot as fast as
> +possible.
> +
> +In the embedded world it used to be acceptable to have a similar
> +custom compiled kernel which knew where everything is meant to be.
> +However this was a brittle approach and not very flexible. For example
> +a general purpose distribution would have to ship a special kernel for
> +each variant of hardware you wanted to run on. If you try and use a
> +kernel compiled for one platform that nominally uses the same
> +processor as another platform the result will rarely work given a
> +processor rarely works in isolation.

"the result will generally not work."

> +
> +The more modern approach is to have a "generic" kernel that has a
> +number of different drivers compiled in which are then enabled based
> +on a hardware description provided by the firmware. This allows
> +flexibility on both sides. The software distribution is less concerned
> +about managing lots of different kernels for different pieces of
> +hardware. The hardware manufacturer is also able to make small changes
> +to the board over time to fix bugs or change minor components.
> +
> +The two main methods for this are the Advanced Configuration and Power
> +Interface (ACPI) and Device Trees. ACPI originated from the PC world
> +although it is becoming increasingly common for "enterprise" hardware
> +like servers. Device Trees of various forms have existed for a while
> +with perhaps the most common being Flattened Device Trees (FDT).
> +
> +Boot Code
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The line between firmware and boot code is a very blurry one. However
> +from a functionality point of view we have moved from ensuring the
> +hardware is usable as a computing device to finding and loading a
> +kernel which is then going to take over control of the system. Modern
> +firmware often has the ability to boot a kernel directly and in some
> +systems you might chain through several boot loaders before the final
> +kernel takes control.
> +
> +The boot loader needs to do 3 things:
> +
> +  - find a kernel and load it into RAM
> +  - ensure the CPU is in the correct mode for the kernel to boot
> +  - pass any information the kernel may need to boot and can't find itse=
lf
> +
> +Once it has done these things it can jump to the kernel and let it get
> +on with things.
> +
> +Kernel
> +=3D=3D=3D=3D=3D=3D
> +
> +The Kernel now takes over and will be in charge of the system from now
> +on. It will enumerate all the devices on the system (again) and load
> +drivers that can control them. It will then locate some sort of
> +file-system and eventually start running programs that actually do
> +work.
> +
> +Questions to ask yourself
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Having given this overview of booting here are some questions you
> +should ask when diagnosing boot problems.
> +
> +Hardware
> +~~~~~~~~

Previously you used '-----' as the title format for "next
level below "=3D=3D=3D=3D=3D"; Sphinx will complain that you're not
being consistent (see the patchew emails).

> +
> + - is the platform fixed or dynamic?
> + - is the platform enumeratable (e.g. PCI/USB)?
> +
> +Firmware
> +~~~~~~~~
> +
> + - is the firmware built for the platform your are booting?

"you are"

> + - does the firmware need storage for variables (boot index etc)?
> + - does the firmware provide a service to kernels (e.g. ACPI/EFI)?
> +
> +Kernel
> +~~~~~~
> +
> + - is the kernel platform specific or generic?
> + - how will the kernel enumerate the platform?
> + - can the kernel interface talk to the firmware?
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 049387ac6de..58d587444b3 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -12,6 +12,7 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> +   booting
>     bitmaps
>     dbus
>     dbus-vmstate
> --

thanks
-- PMM

