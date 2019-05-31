Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E55CC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 22:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2338926F5D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 22:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.fintelia.io header.i=@mg.fintelia.io header.b="bTfIF0qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2338926F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWqPF-0000Fs-1c
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 18:53:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47127)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hWqOP-0008JI-1o
	for qemu-devel@nongnu.org; Fri, 31 May 2019 18:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hWqAf-0002q3-Qw
	for qemu-devel@nongnu.org; Fri, 31 May 2019 18:38:47 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:22962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hWqAf-0002ob-DF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 18:38:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.fintelia.io;
	q=dns/txt; 
	s=mailo; t=1559342325; h=Content-Type: Cc: To: Subject: Message-ID:
	Date: From: In-Reply-To: References: MIME-Version: Sender;
	bh=LfctCIgpkBvXzrc7MpCqKZkpLZImxfqch844GhdAoaU=;
	b=bTfIF0qZF8ibqQ/QXKT6XdfUDAjoQRQWFemouN2IKUphIRpc5OhoU/9BVejEceaul/LxI0EX
	p+fAJGB8ZTas5PuDhY0eYWbMPAsVJG2/4cCcMvotnncswIglXm+NcchH6KrDW5Voci6LcPoP
	eEShZJ/OMQm2fmest6btTwA97bk=
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyI4YWE2MyIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiYjc4YTQ4Il0=
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
	[209.85.167.54])
	by mxa.mailgun.org with ESMTP id 5cf1acf0.7fd09a51a7b0-smtp-out-n01;
	Fri, 31 May 2019 22:38:40 -0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id v18so9171698lfi.1;
	Fri, 31 May 2019 15:38:39 -0700 (PDT)
X-Gm-Message-State: APjAAAW54AO9jUuUwsxbI1K33gQTmz87evIaNojqxxryvSuw1sw3ujWe
	wTgVSenMqnD3SRCcSvtE/gtfYr0teNHCNXvMnr8=
X-Google-Smtp-Source: APXvYqxUfTtp434FTNau469kleD3qet0zPoO349Mhc/DB5m73Bacopij+Z14ER1w7f0xAMSwVMasOkG4pi+aTOex/FM=
X-Received: by 2002:ac2:518d:: with SMTP id u13mr6816795lfi.40.1559342318501; 
	Fri, 31 May 2019 15:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190517222342.26394-1-jonathan@fintelia.io>
	<20190517222342.26394-3-jonathan@fintelia.io>
	<CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
	<CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
	<CAKmqyKM3C59_w214=mqLFpfwPhUjcLL0EuOY0Yk3DQePx8ZTQg@mail.gmail.com>
In-Reply-To: <CAKmqyKM3C59_w214=mqLFpfwPhUjcLL0EuOY0Yk3DQePx8ZTQg@mail.gmail.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Fri, 31 May 2019 18:38:12 -0400
X-Gmail-Original-Message-ID: <CANnJOVGyY71-aZd+dmZWAOUzEfFEOHjAAzVdbGTP_XfP4CmgkA@mail.gmail.com>
Message-ID: <CANnJOVGyY71-aZd+dmZWAOUzEfFEOHjAAzVdbGTP_XfP4CmgkA@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've thought some more about this issue, and long term I think there are a
couple different useful configurations:

   - For end users, having default firmware that loaded the OS from a block
   device would be easiest
      - Current invocation: impossible
      - Proposed: empty command line (i.e. pass neither -bios nor -kernel)
   - Custom firmware support would be good to test possible firmware
   improvements or if the default is missing something
      - Current invocation: -kernel firmware.elf
      - Proposed: -bios firmware.elf
      - A kernel developer may want to test a kernel binary without having
   to make a full disk image or bundle firmware (on x86 and perhaps other
   architectures this is done with the -kernel parameter, but for RISC-V that
   invocation currently is used to load M-mode code rather than supervisor
   code)
   - Current invocation: impossible
      - Proposed: -bios firmware.elf -kernel kernel.bin
      - Ideally `-kernel kernel.bin` be the same except using default
      firmware, but I don't know if QEMU would be willing to deprecate the
      current syntax to allow it

For now, it is probably too early to add default firmware (but perhaps
not?) which would leave only the firmware only and firmware + kernel
variants. What do other people think about this?

Jonathan

On Mon, May 20, 2019 at 12:56 PM Alistair Francis <alistair23@gmail.com>
wrote:

> On Sat, May 18, 2019 at 2:57 PM Jonathan Behrens <jonathan@fintelia.io>
> wrote:
> >
> > > I've never been fully convinced of this, why not just use the generic
> loader?
> >
> > If I understand you are proposing passing bbl (or other firmware) with
> the -kernel flag, and then vmlinux (or another kernel) with the -initrd
> flag? Wouldn't this result in losing the ability to pass a real init
> ramdisk to Linux? It also seems to open the possibility for strange
> bugs/compatibility issues later if firmware starts recognizing any "initrd"
> entries in the device tree as kernel code to jump into.
>
> No I mean passing in OpenSBI (or some other boot loader) via the
> -kernel option and then passing in the kernel with QEMU's generic
> device loader. This is documented as part of the OpenSBI boot flow:
> https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md
>
> The only disadvantage with that is that we don't get debug symbols
> from the kernel, but it does mean that the boot loader in QEMU is much
> simpler.
>
> >
> > I do wonder though how compatible the current design is with providing
> default firmware for riscv in the future.
> >
> > > This should be in a generic boot.c file and support added to all
> RISC-V boards.
> >
> > I can do this for v2.
>
> Thanks
>
> Alistair
>
> >
> > Jonathan
>
