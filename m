Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B3C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA87B2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZNpqDi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA87B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdbWF-0002qW-R3
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdbRa-00068Z-Er
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdbRZ-000334-7N
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:20:10 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdbRX-0002yw-SL; Wed, 19 Jun 2019 10:20:08 -0400
Received: by mail-lf1-x143.google.com with SMTP id q26so12293874lfc.3;
 Wed, 19 Jun 2019 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xFlM4YqK6Ynh+xOXuEnAoR5f/r3sxH1cbUi/rehTRh8=;
 b=eZNpqDi8B8iXv1WtOJgSWlY430tRosxIX632Pdcs+19qgp7bnLfm4yYyAWdboyINka
 MXX+IyMnFMXiVjzABvgQdIYFuwvgv8TMYERnISwAns8cE1Z3BhiotwoPuBdEGKMPWNtY
 C4O4s+MOtUBS29r3MUAhI03fl0yzeq11b4VOHyBi1Mh/URgO5YYQVtMUbRR++J2MGdxa
 z7m/AnKsrm3HD+vUcTdyqXzTejFOOeBkpcddznASyeCVXhwwjcsU95T3H7siMczEgaDG
 ljTn/0FDydeWF/O7HpP82uqi3dtAtIMODp//uQlDzoqXYea5j25HLGTZ7wjUTMEcdoYF
 VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xFlM4YqK6Ynh+xOXuEnAoR5f/r3sxH1cbUi/rehTRh8=;
 b=IuoThk4iIrRwH4BHBq26QyK5YXo/6c9LD6uMCwMLG80D9ALch0veVqD9w4omROKlHv
 kS8M/7DmaReoPxaGt5P+MOzmYKTbs7JGNUuov0C8RozbdKM1H99rGdgw8e/vClwmy8XU
 N0hWfH0xKeSMhdsJD10T2XJPYSKE6XN9pG9AOYl7YM3mUp/iBOXqgduOkevUBeLDPaMR
 RvhIlGwfSc7yZugoP0Fvy5RgstAP862HlHRAyQ5XYYCFWb0AY+wFrgfE4xnkdgIvWe/u
 yIAo514+Ku4ZsiYUeJzzqpvb6lHUKuwwovJDC9ksaxXsNMZV4fHIspV4uqYQ0yDaDzOF
 3Nag==
X-Gm-Message-State: APjAAAV6VedbRvwuH6oaTU9NzWHSEOazdgg+vmhZpSyPKr2ipLzJhIro
 V4YRGyvhaR23E9BXDDkXuXyJYiYua/I6h9NYa0E=
X-Google-Smtp-Source: APXvYqwc7mmlrYFEGy16UuTI2cxCJ9XaE/G0kCsn3E2W6Skl8OWUbBbfQtOORDH4hJbgcbYspUUElkxhEApScMeoM3o=
X-Received: by 2002:a19:710b:: with SMTP id m11mr56672087lfc.135.1560954004088; 
 Wed, 19 Jun 2019 07:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560821342.git.alistair.francis@wdc.com>
 <mhng-966cacce-c410-473d-b043-996f3cff9a36@palmer-si-x1e>
In-Reply-To: <mhng-966cacce-c410-473d-b043-996f3cff9a36@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 07:19:38 -0700
Message-ID: <CAKmqyKPRWASwUPQUROPWyrNC8gXTnizXTaXYdpbEAmkfjOZo1g@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v1 0/9] Update the RISC-V specification
 versions
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 3:58 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 17 Jun 2019 18:31:00 PDT (-0700), Alistair Francis wrote:
> > Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
> >
> > Now that the RISC-V spec has started to be ratified let's update our
> > QEMU implementation. There are a few things going on here:
> >  - Add priv version 1.11.0 to QEMU
> >     - This is the ratified version of the Privledge spec
> >     - There are almost no changes to 1.10
> >  - Mark the 1.09.1 privledge spec as depreated
> >      - Let's aim to remove it in two releases
> >  - Set priv version 1.11.0 as the default
> >  - Remove the user_spec version
> >      - This doesn't really mean anything so let's remove it
> >  - Add support for the "Counters" extension
> >  - Add command line options for Zifencei and Zicsr
>
> Thanks!  I'll look at the code, but I've currently got this queued up behind
> your hypervisor patches so it might take a bit.  LMK if you want me to invert
> the priority on these.  I'll probably be buried until the start of July.

Let's move the Hypervisor patches to the back then. There is a new
spec version now anyway so I'll have to update them for that.

Alistair

>
> > We can remove the spec version as it's unused and has never been exposed
> > to users. The idea is to match the specs in specifying the version. To
> > handle versions in the future we can extend the extension props to
> > handle version information.
> >
> > For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11
> >
> > NOTE: This isn't supported today as we only have one of each version.
> >
> > This will be a future change if we decide to support multiple versions
> > of extensions.
> >
> > The "priv_spec" string doesn't really match, but I don't have a better
> > way to say "Machine ISA" and "Supervisor ISA" which is what is included
> > in "priv_spec".
> >
> > For completeness I have also added the Counters, Zifencei and Zicsr
> > extensions.
> >
> > Everything else seems to match the spec names/style.
> >
> > Please let me know if I'm missing something. QEMU 4.1 is the first
> > release to support the extensions from the command line, so we can
> > easily change it until then. After that it'll take more work to change
> > the command line interface.
> >
> > Alistair Francis (9):
> >   target/riscv: Restructure deprecatd CPUs
> >   target/riscv: Add the privledge spec version 1.11.0
> >   target/riscv: Comment in the mcountinhibit CSR
> >   target/riscv: Set privledge spec 1.11.0 as default
> >   qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
> >   target/riscv: Require either I or E base extension
> >   target/riscv: Remove user version information
> >   target/riscv: Add support for disabling/enabling Counters
> >   target/riscv: Add Zifencei and Zicsr as command line options
> >
> >  qemu-deprecated.texi                          |  8 +++
> >  target/riscv/cpu.c                            | 72 ++++++++++---------
> >  target/riscv/cpu.h                            | 19 ++---
> >  target/riscv/cpu_bits.h                       |  1 +
> >  target/riscv/csr.c                            | 13 +++-
> >  .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
> >  6 files changed, 71 insertions(+), 44 deletions(-)

