Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A46C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED4B20645
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D72m2VA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED4B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heTyq-0000UC-EP
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 20:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1heTrb-0005GY-MB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1heTra-0002Kg-6C
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:26:39 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1heTrZ-0002I7-UE; Fri, 21 Jun 2019 20:26:38 -0400
Received: by mail-lf1-x144.google.com with SMTP id a9so6212512lff.7;
 Fri, 21 Jun 2019 17:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2X1WjOPBGjpSiiHd4I0OoWELM8TFP+RNxFEpb8/VbmY=;
 b=D72m2VA08Du74/vMvC1GurWA3iBiYCCcK266ltKdrKm+QyXZPdCcnJ5POttl+eoSAX
 +2aF+Qu39hHnTi10E8H5OstuXeyN2rPxDoQ14fRiiNen2S5r/VUcPQxdiS1D3WdkmiWT
 Mq6UEVRyhDwDGMWKCWu78MFEwMG7LyIf1YvqzjdXdSUk8MzTD7ITzD5yMyNdNpBDO7Ry
 do7YUNt87k+v7IIvFsGgmlC2+awJm9B+WgvS25WW/dI8AdaXCKhwsIyB00PxKc8dbDQ0
 /KbhRs/BgqZTuWPHbTSDbL7iny7HiWxHTfrzLTD2pYX8OnvHJ6Z+YgxOeTMnMlHvVL/F
 2YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2X1WjOPBGjpSiiHd4I0OoWELM8TFP+RNxFEpb8/VbmY=;
 b=EJgHMdBWWhO2rXCK1AHjK405/vNlBMOWsqg1R/8bAIQcBm4iypmIipVwsmJDA4urM/
 e80rnWIu+yeAv6+HKj8gSOHqcrAYEuFoGSq96OXZ3BAAFDZQO+BGUWpQ42Iva4XxH4YW
 emBEhKO/9QSc+11LETAko4/7dqNeiVy7kYqlRr14hR6kRFaunvGPQm/vl2Lc426RokAe
 RG7SYFMwFPn75lKnzrFI5BbV5UuE/+MMP+1nWf3NsFtU486N+CW23VdbS1AEQR5ogkiw
 sx7o3umgcWzIpy/t7ZT8irfFZf3JYG01KGQ78qSFClSDR+acGMOrAkEZawndWx1JD7S+
 VnFQ==
X-Gm-Message-State: APjAAAVLQ/hbPppKkld+cbcNEvGXKuV6w/dnWfMZuJtj+3cwRFvOfYV+
 Q/sy3xEzlo9Avf1I3zsfgyiGiE/qfFWiF9scKro=
X-Google-Smtp-Source: APXvYqyD8lZVu7V7afmcd8cF9+Ic0x7rj+ibuOLrVa3hpCTgCzK/FhGqBaLepQYzGV6yQ+L9DMsvK/MNuhSRm8MMbRI=
X-Received: by 2002:a19:bec1:: with SMTP id o184mr39379310lff.86.1561163196177; 
 Fri, 21 Jun 2019 17:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPRWASwUPQUROPWyrNC8gXTnizXTaXYdpbEAmkfjOZo1g@mail.gmail.com>
 <mhng-2816be05-3e0d-4cb6-a39e-082b071f8ba2@palmer-si-x1e>
In-Reply-To: <mhng-2816be05-3e0d-4cb6-a39e-082b071f8ba2@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2019 17:23:44 -0700
Message-ID: <CAKmqyKM0WBjwK+TjoJnhBOTTaAgeSeB5ATUpRgKGvxvw35Cvdg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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

On Thu, Jun 20, 2019 at 7:49 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 19 Jun 2019 07:19:38 PDT (-0700), alistair23@gmail.com wrote:
> > On Wed, Jun 19, 2019 at 3:58 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Mon, 17 Jun 2019 18:31:00 PDT (-0700), Alistair Francis wrote:
> >> > Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
> >> >
> >> > Now that the RISC-V spec has started to be ratified let's update our
> >> > QEMU implementation. There are a few things going on here:
> >> >  - Add priv version 1.11.0 to QEMU
> >> >     - This is the ratified version of the Privledge spec
> >> >     - There are almost no changes to 1.10
> >> >  - Mark the 1.09.1 privledge spec as depreated
> >> >      - Let's aim to remove it in two releases
> >> >  - Set priv version 1.11.0 as the default
> >> >  - Remove the user_spec version
> >> >      - This doesn't really mean anything so let's remove it
> >> >  - Add support for the "Counters" extension
> >> >  - Add command line options for Zifencei and Zicsr
> >>
> >> Thanks!  I'll look at the code, but I've currently got this queued up behind
> >> your hypervisor patches so it might take a bit.  LMK if you want me to invert
> >> the priority on these.  I'll probably be buried until the start of July.
> >
> > Let's move the Hypervisor patches to the back then. There is a new
> > spec version now anyway so I'll have to update them for that.
>
> OK.  Do you want me to just drop them and wait for a v2 / draft 0.4?

I haven't looked at the 0.4 yet, but I think there are still lots of
similarities so let's just put Hypervisor patches at the back of the
list and see if you get there. It would still be nice to have comments
on the v1.

Alistair

>
> >
> > Alistair
> >
> >>
> >> > We can remove the spec version as it's unused and has never been exposed
> >> > to users. The idea is to match the specs in specifying the version. To
> >> > handle versions in the future we can extend the extension props to
> >> > handle version information.
> >> >
> >> > For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11
> >> >
> >> > NOTE: This isn't supported today as we only have one of each version.
> >> >
> >> > This will be a future change if we decide to support multiple versions
> >> > of extensions.
> >> >
> >> > The "priv_spec" string doesn't really match, but I don't have a better
> >> > way to say "Machine ISA" and "Supervisor ISA" which is what is included
> >> > in "priv_spec".
> >> >
> >> > For completeness I have also added the Counters, Zifencei and Zicsr
> >> > extensions.
> >> >
> >> > Everything else seems to match the spec names/style.
> >> >
> >> > Please let me know if I'm missing something. QEMU 4.1 is the first
> >> > release to support the extensions from the command line, so we can
> >> > easily change it until then. After that it'll take more work to change
> >> > the command line interface.
> >> >
> >> > Alistair Francis (9):
> >> >   target/riscv: Restructure deprecatd CPUs
> >> >   target/riscv: Add the privledge spec version 1.11.0
> >> >   target/riscv: Comment in the mcountinhibit CSR
> >> >   target/riscv: Set privledge spec 1.11.0 as default
> >> >   qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
> >> >   target/riscv: Require either I or E base extension
> >> >   target/riscv: Remove user version information
> >> >   target/riscv: Add support for disabling/enabling Counters
> >> >   target/riscv: Add Zifencei and Zicsr as command line options
> >> >
> >> >  qemu-deprecated.texi                          |  8 +++
> >> >  target/riscv/cpu.c                            | 72 ++++++++++---------
> >> >  target/riscv/cpu.h                            | 19 ++---
> >> >  target/riscv/cpu_bits.h                       |  1 +
> >> >  target/riscv/csr.c                            | 13 +++-
> >> >  .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
> >> >  6 files changed, 71 insertions(+), 44 deletions(-)

