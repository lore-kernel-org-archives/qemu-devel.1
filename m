Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDCB20760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq+b+WNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDCB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNNt-0002x4-LB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjNNJ-0002K1-O4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:36:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35606)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjNNI-0004Vw-Oi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:36:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so5098615wmj.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nlNCCOKk3HnnOhZXKfa4bt4IiZGyqM7tzNqbxt+wSls=;
 b=Mq+b+WNO+ZoOFNV9jDBlBMh+hZGTGddhQu6qmfXTNarvdL5Y3Wx5xH8FLPc3lwYxH5
 BYRSfyRYWW9a0VgdHUiCm4bpCVaDDIVVhBdh+G1oP/Vcimi6MX+Mh+j7b4JCw31jvoY+
 O7hXSSPU3UtEktQYOT2pj9ElDqS+Xo6jbgTPFQVCoCWBr33R3gFoBfSiE4zJn9ymx9Ad
 er+B3YqwA0ueG3Wkpl93L4VcxZq0yL0r4rjnHl4zGX3km1u/1z19yYiRq+ya/MZzYcLe
 1Y1JXXcPwP2vka6+golUGJC1QxEHBvH6IlI4s/ns9kGG8zengfIOYnyTkLZ4sOW36Ha/
 oiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nlNCCOKk3HnnOhZXKfa4bt4IiZGyqM7tzNqbxt+wSls=;
 b=Ok6nwiHjTY3LzHkV5FkFw5DkxQLErMuQpMeKbI0S4P/+0jgbR7aVBbYCIZ+5EL/V40
 k5Cq8QVoFMz1XbWKliHU4MM3JrNynlWBQ0b/HAUD7bJYxomM402fQ4lzGL1nTuGxyP2L
 KTB1kn98ZVFl0+RMXVflYYucWqBQZBx6jRBIsUx8ZUfe9uLAlupfiGxcHvuk7uUWLu9D
 +0BU7GXu852/ny6cd1eawk8ucfBp8XLH63JRS4rlBvTfIFp9V+3eSLdqz/e0GkWjkw8j
 sU45qCD6ayx5/BjVmsbf1gLVGASbum/+uJRpmHuovM/6mY8+S5xuKjaxMAawriZWnTYW
 IVkQ==
X-Gm-Message-State: AOAM532WTn9+tC4ZtoX/6NOgPVR6xXpzeIpNb1iBz1UnXasetXgSwOwC
 RPGkG0Z6yQVMO3XkD8+ATP5Bmrzk10MrOOM/HJE=
X-Google-Smtp-Source: ABdhPJzGYlk2W3hi5x/zMeb4WvjpyU4mKzoU0A5btHJVvwa/40L7ICc2b32OoiZKli3bQmIG+z3ogRYfk+Zq3FN0D78=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr8717272wmg.50.1591882561632; 
 Thu, 11 Jun 2020 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200609073214.14079-1-f4bug@amsat.org>
 <da5851a4-953b-8915-7bc8-37c20a23805f@ilande.co.uk>
 <c2cfa843-ca76-8aa7-7b74-1ad261222c3e@amsat.org>
In-Reply-To: <c2cfa843-ca76-8aa7-7b74-1ad261222c3e@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 15:35:48 +0200
Message-ID: <CAHiYmc5_9HY-RtKuMfqrU-Lwu0zA3xEwBJUH+01PpzDNaZ2vcw@mail.gmail.com>
Subject: Re: [PULL 00/16] SPARC patches for 2020-06-09
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 15:30 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/9/20 10:55 PM, Mark Cave-Ayland wrote:
> > On 09/06/2020 08:31, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >> Hi Peter,
> >>
> >> These are the latest SPARC patches sent to the list.
> >>
> >> This pull request is with authorization of Artyom and Mark:
> >> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710154.html
> >> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710156.html
> >>
> >> Frederic doesn't have his GPG key signed:
> >> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg706509.html
> >>
> >> The following changes since commit 49ee11555262a256afec592dfed7c5902d5=
eefd2:
> >>
> >>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.=
1-pull-=3D
> >> request' into staging (2020-06-08 11:04:57 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/philmd/qemu.git tags/sparc-next-20200609
> >>
> >> for you to fetch changes up to 86e8c353f705f14f2f2fd7a6195cefa431aa24d=
9:
> >>
> >>   target/sparc/int32_helper: Extract and use excp_name_str() (2020-06-=
09 09:2=3D
> >> 1:10 +0200)
> >>
> >> ----------------------------------------------------------------
> >> SPARC patches
> >>
> >> HW:
> >> - Use UNIMP device instead of EMPTY_SLOT
> >> - Make EMPTY_SLOT similar to UNIMP device
> >> - Map UART devices unconditionally
> >> - Pair of fixes for AHB PnP
> >> - Add trace events to AHB PnP
> >>
> >> TCG:
> >> - Improve exception logging
> >>
> >> CI:
> >> - https://gitlab.com/philmd/qemu/-/pipelines/154231191
> >> - https://travis-ci.org/github/philmd/qemu/builds/696321130
> >>
> >> ----------------------------------------------------------------
> >>
> >> Philippe Mathieu-Daud=3DC3=3DA9 (16):
> >>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
> >>   hw/misc/empty_slot: Lower address space priority
> >>   hw/misc/empty_slot: Convert 'size' field as qdev property
> >>   hw/misc/empty_slot: Add a 'name' qdev property
> >>   hw/misc/empty_slot: Convert debug printf() to trace event
> >>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
> >>   hw/misc/empty_slot: Name the slots when created
> >>   hw/sparc/leon3: Map the UART device unconditionally
> >>   hw/sparc64/niagara: Map the UART device unconditionally
> >>   hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE definition
> >>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
> >>     registers
> >>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
> >>   hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
> >>   hw/timer/grlib_gptimer: Display frequency in decimal
> >>   target/sparc/int32_helper: Remove DEBUG_PCALL definition
> >>   target/sparc/int32_helper: Extract and use excp_name_str()
> >>
> >>  include/hw/empty_slot.h        |  9 -------
> >>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
> >>  hw/mips/malta.c                |  4 +--
> >>  hw/{core =3D3D> misc}/empty_slot.c | 47 +++++++++++++++++++----------=
-----
> >>  hw/misc/grlib_ahb_apb_pnp.c    | 24 +++++++++++++++--
> >>  hw/sparc/leon3.c               | 18 ++++++-------
> >>  hw/sparc/sun4m.c               | 23 +++++++++++------
> >>  hw/sparc64/niagara.c           |  7 ++---
> >>  target/sparc/int32_helper.c    | 23 +++++++++--------
> >>  MAINTAINERS                    |  7 +++++
> >>  hw/core/Makefile.objs          |  1 -
> >>  hw/misc/Makefile.objs          |  1 +
> >>  hw/misc/trace-events           |  8 ++++++
> >>  hw/sparc/Kconfig               |  1 +
> >>  hw/timer/trace-events          |  2 +-
> >>  15 files changed, 124 insertions(+), 70 deletions(-)
> >>  delete mode 100644 include/hw/empty_slot.h
> >>  create mode 100644 include/hw/misc/empty_slot.h
> >>  rename hw/{core =3D3D> misc}/empty_slot.c (66%)
> >>
> >> --=3D20
> >> 2.21.3
> >
> > Philippe, thanks so much for handling this - things are really busy her=
e at the
> > moment, so the help is greatly appreciated :)
>
> I know you were busy, and the patches are just cleanups, so no problem.
>

I guess it is just a matter of time Philippe would ask for SPARC
maintainership. Mark, would you perhaps accept Philippe as a
co-maintainer?

Yours,
Aleksandar

> Before sending, I tested with all the images I could grab from
> https://wiki.qemu.org/Documentation/Platforms/SPARC
> and
> https://www.qemu.org/docs/master/system/target-sparc64.html
>
> I might add more acceptance tests later to automate that.
>
> Regards,
>
> Phil.

