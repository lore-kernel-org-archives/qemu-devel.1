Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634FC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABE520684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJh5SSln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABE520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1Ys-00062z-8b
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hZ1Wt-0004N8-8D
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hZ1Wr-0004Ez-Vh
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:10:43 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hZ1Wr-0004BH-KQ; Thu, 06 Jun 2019 19:10:41 -0400
Received: by mail-lj1-x242.google.com with SMTP id 16so77373ljv.10;
 Thu, 06 Jun 2019 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QnjzLAuecYO6cCduWJx1ezPBtP44QqdheBhzqRuvzg8=;
 b=AJh5SSlnlfhqqiOhv7pCy4XJLGLcul7qOqd/36x7W9Wbiy6suQk/ZjGwh7vQAkK3tG
 AanXuXDSwDoOAKHXhUJ1ftjkgcCD+FUn0zkLj5jHw/oGVsVoUsGeWWHJE/a/92IRn8Fd
 Xx546aZcAxpUZ/L+ew6jGqFmdrtOPZYIaYaNgwi3NA7us/qdxtmHUPZMiQ9f+9Ql4aN0
 dFeAfTtte9F79GxZYAnFXRqIjwSvi35y0eR6KFhqRckE4wBdMUnPF3yz+bcTu2uuTver
 cLnUYkf2ce22bcqDtvCnWaZAZ4IejD57PRJJU3G3FesUgdoZWUEXYwFZAi4L1e6aQLY3
 Yrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QnjzLAuecYO6cCduWJx1ezPBtP44QqdheBhzqRuvzg8=;
 b=rgmqPLBk53vqDmgxUj1ZoA5850k5s4iqKsCEXgKCbzf2NhKIU7Dpvi6WHGtLhuWbtx
 PP9YwL94GGrjfstkGUJlBsKOK1Hv4Ml83usxSY4/JysusUEEz1EpKIhgtLKMXG6LQA7/
 wlg0stZsO3rg2/+jZc1uHgK0D5wrBUdf88sY9qWuuIO6w+vqbmHAONtm6QnWa4k5Hl+d
 sKbD2+P6Q6zYR7z5FaY+QTZJMdWyJ2jS4qYIlcnZxKRrHWy4Zdr7TcTJ9QwwYLG7/w0A
 RNV2WUHoYj7+Uljl/N1iytF0JxqwFMbt6byrAGrtg9i3Q5+IrZA3rlXxk/hKWoMffwnR
 uunQ==
X-Gm-Message-State: APjAAAVFBaXTPo+mj8DOX8n3tzzlY1QBrMNSpemAK3q5LB/RTTcNt+fM
 1AQLviI6gvr0/QTww/xQgG+aWFmwzOrFGtM30n0=
X-Google-Smtp-Source: APXvYqzIwgwTPbStoPu2NkiSHADKTP3pAz3haxc7lKDDplcrP3Om98o2oJWjEqfeIs7rCKfbjZKbCJRaEcfPAeujz+8=
X-Received: by 2002:a2e:6313:: with SMTP id x19mr17108848ljb.25.1559862640106; 
 Thu, 06 Jun 2019 16:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517222342.26394-1-jonathan@fintelia.io>
 <20190517222342.26394-3-jonathan@fintelia.io>
 <CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
 <CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
 <CAKmqyKM3C59_w214=mqLFpfwPhUjcLL0EuOY0Yk3DQePx8ZTQg@mail.gmail.com>
 <CANnJOVGyY71-aZd+dmZWAOUzEfFEOHjAAzVdbGTP_XfP4CmgkA@mail.gmail.com>
In-Reply-To: <CANnJOVGyY71-aZd+dmZWAOUzEfFEOHjAAzVdbGTP_XfP4CmgkA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2019 16:08:05 -0700
Message-ID: <CAKmqyKNiPsoMSi0nnJTz8mTh-W4FwPDitxkmF1JGEK-VdfWpCQ@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 3:38 PM Jonathan Behrens <jonathan@fintelia.io> wro=
te:
>
> I've thought some more about this issue, and long term I think there are =
a couple different useful configurations:
>
> For end users, having default firmware that loaded the OS from a block de=
vice would be easiest
>
> Current invocation: impossible
> Proposed: empty command line (i.e. pass neither -bios nor -kernel)
>
> Custom firmware support would be good to test possible firmware improveme=
nts or if the default is missing something
>
> Current invocation: -kernel firmware.elf
> Proposed: -bios firmware.elf
>
> A kernel developer may want to test a kernel binary without having to mak=
e a full disk image or bundle firmware (on x86 and perhaps other architectu=
res this is done with the -kernel parameter, but for RISC-V that invocation=
 currently is used to load M-mode code rather than supervisor code)
>
> Current invocation: impossible
> Proposed: -bios firmware.elf -kernel kernel.bin
> Ideally `-kernel kernel.bin` be the same except using default firmware, b=
ut I don't know if QEMU would be willing to deprecate the current syntax to=
 allow it
>
> For now, it is probably too early to add default firmware (but perhaps no=
t?) which would leave only the firmware only and firmware + kernel variants=
. What do other people think about this?

I generally agree with what you are saying. I know that x86 includes
seabios (although I'm not sure how) and maybe that is something we can
look at. There is now a default RISC-V firmware which would be useful
to include so that users can just boot their kernel. We would have to
make sure it's possible to overwrite this default one so that people
can test their own.

The hard part becomes building the firmware as we don't expect people
to have a RISC-V toolchain installed.

I think the best bet here is to look at what x86 does for their BIOS
and we can start to move towards that.

Alistair

>
> Jonathan
>
> On Mon, May 20, 2019 at 12:56 PM Alistair Francis <alistair23@gmail.com> =
wrote:
>>
>> On Sat, May 18, 2019 at 2:57 PM Jonathan Behrens <jonathan@fintelia.io> =
wrote:
>> >
>> > > I've never been fully convinced of this, why not just use the generi=
c loader?
>> >
>> > If I understand you are proposing passing bbl (or other firmware) with=
 the -kernel flag, and then vmlinux (or another kernel) with the -initrd fl=
ag? Wouldn't this result in losing the ability to pass a real init ramdisk =
to Linux? It also seems to open the possibility for strange bugs/compatibil=
ity issues later if firmware starts recognizing any "initrd" entries in the=
 device tree as kernel code to jump into.
>>
>> No I mean passing in OpenSBI (or some other boot loader) via the
>> -kernel option and then passing in the kernel with QEMU's generic
>> device loader. This is documented as part of the OpenSBI boot flow:
>> https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md
>>
>> The only disadvantage with that is that we don't get debug symbols
>> from the kernel, but it does mean that the boot loader in QEMU is much
>> simpler.
>>
>> >
>> > I do wonder though how compatible the current design is with providing=
 default firmware for riscv in the future.
>> >
>> > > This should be in a generic boot.c file and support added to all RIS=
C-V boards.
>> >
>> > I can do this for v2.
>>
>> Thanks
>>
>> Alistair
>>
>> >
>> > Jonathan

