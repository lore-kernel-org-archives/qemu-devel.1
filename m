Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4879C2BB55
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E10A2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTd12OEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E10A2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMjv-00036w-M7
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMiw-0002FT-JL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMiu-0001dD-QF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:51:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:33543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPMiu-0001aS-K9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:51:44 -0400
Received: by mail-ot1-x32a.google.com with SMTP id j26so865340ots.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Sl0M/kZIviz6XrZ3pqOdET9kTYEBcHoRjtvSmWa0FAM=;
 b=UTd12OEwAXetpMQr//J/y0iujNMBgZKX+MCarQAmBY3bxwcuvVzTdC8QDlNc9CKhb2
 kIAtfDkxY7qnNXXVmuITJLIrcBPVYi6JeXH6CpyIu5ypvX+a7zEVDsr5PubpJyfLaL02
 1phqUCYq7pG5qYI54m2rJwLBogf10pVZDdSz0eZtTrLCS8fKBFgiFdXz65SrpjhvMQ0j
 KAs7VYNIjPg2HjiwkUjYtt1TavffcoEAWJrELX1vqIz/HEvG7cL92q1TOrHqs4rSiNXz
 DSEqu4+hOYYeVU9Mq0LUUq1HJoawZPKa14KiGVu21MGFlHZ+In+xnyN4N3NMXyFblpPZ
 Fg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Sl0M/kZIviz6XrZ3pqOdET9kTYEBcHoRjtvSmWa0FAM=;
 b=KU+5sAjwH/cnb6Hh1YRi8lxdyJ63r/pHpj83tEKIJWDYrYi/6jBbxgas4+ObnLa9bX
 eKUq9fhAoScNB7ZrMOmOGc2kZyKSxAcNz/LNPL0z4It95PQ/4+f1oGrRf+EEsry7hubL
 kzUvwnFwRzM+Lh/i2pnh++EFbq1U1CAuXd2hyjqYerXoM4K8NUOdK4RQE44J0N9A9s+m
 Zcxv6bCXD23EEBPDR3PvTEx0DoyFhLHD7V4OnjV0nAAimdeRmjdIdcLRn7m5ApLljUFO
 3rm/h06TsL0UYBI198e2KTp5+RxhPyQ3LwLOUFE1fKdjIMjqNUzo8ryORZT+hyUaSezn
 cqCA==
X-Gm-Message-State: AGi0PuaR8DlFqKVDqZj9mXMw5i4B93Bc7pr1GBm/84dRPqFuB2KdwQgi
 7pwC5u3ky/iNCfdpzBFl2oW5voAvGCkbw2Jr48XwsA==
X-Google-Smtp-Source: APiQypIN0REwCxMD3AeWkQmyaqab4KXkRqiwBNvu6uDvcb7SyLFE1yOBAxrbMXO2X6uQ31js+BqkEfk/0qvt1AB6IXc=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr1763704otb.135.1587113502472; 
 Fri, 17 Apr 2020 01:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <87mu7ac2ah.fsf@digitalsignallabs.com>
In-Reply-To: <87mu7ac2ah.fsf@digitalsignallabs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 09:51:31 +0100
Message-ID: <CAFEAcA-aCUuf43OZD9n471-VPcasZJ89M=MYQcpg2+8kr7=JQQ@mail.gmail.com>
Subject: Re: QEMU Development Questions
To: Randy Yates <yates@digitalsignallabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

On Fri, 17 Apr 2020 at 09:07, Randy Yates <yates@digitalsignallabs.com> wro=
te:

> 2.1  Top-Level Architecture
>
> There is a MachineClass, MachineState, and MachineInstance. What are purp=
oses of these logical divisions?

class vs state is QEMU's usual object model (QOM) structs:
there is one instance of a class struct which contains
things like method pointers; each instance of the object
as a FooState struct which has the varies-per-instance
data. The doc comments in include/qom/object.h are probably
a good place to start for a summary of the object model.

'git grep MachineInstance' has no matches, so I don't know
what you have in mind there.

> 2.2  Miscellaneous
>
> Apparently the CPU has properties. What are the specific properties and t=
heir defaults? How do you change a property's default value?

Mostly undocumented; nominally introspectable. In practice,
just look at what other source code is doing. For some
devices the .h file includes a comment describing this
kind of thing, but often not.

> How do you model and implement startup from power on reset?

Not sure what you have in mind here. It just works: the
CPU starts running from the reset address.

> Bootrom code is modeled by specifying -bios <file> on the
> command line. What format should the code in <file> be?

This depends on what your board model does with the file.
If your board code doesn't do anything with the filename
in the 'bios_name' global, then the command line option
will be ignored entirely. If your board code passes the
filename to a "load this ELF file" function, then the file
has to be an ELF file. If your board code passes it to
a "load this raw data file", then the file has to be a raw
data file. Raw-data is the most common approach.

> Bootrom code performs required initializations, e.g.,
> populating the interrupt vector table at the appropriate
> spot, GIC? other registers? Copying code to DRAM?

Your guest code can do what it likes. What you need
to do is make sure you've loaded an image which provides
the initial reset vector table (usually at address 0
for Arm). QEMU will start executing from the reset vector
in the same way real h/w does, and your guest code
takes it from there.

> Once bootrom code is finished, what happens? Should it simply
> branch to the first-level bootloader (which is supposedly
> loaded into DRAM)? Is the reset vector used somehow?

You seem to be making a distinction between different
levels of boot code (bootrom, first level bootloader)
which QEMU simply does not make. QEMU provides two
possible models for loading Arm guest code:
 (1) boot this thing like a linux kernel with the
     CPU set up as the linux kernel's boot protocol
     specifies
 (2) guest code gets control of the emulated machine
     exactly as it comes out of reset

So you need to provide some guest code that does the
equivalent of what you're calling "bootrom". If you
want that to pass control to a "first level bootloader"
then you need to write the bootrom guest code to do that.

> I'm using the -pflash command-line option to map a copy of the flash code=
. Do you simply specify the address of an existing memory (DRAM) of where t=
o load the file? Is there a way to specify an entry point address (of where=
 to begin execution). How does this interact with the -bios option?

See above: you don't get to control where execution starts,
because for Arm CPUs (unless your board uses hivecs)
that's always 0. Your board code wants to load the initial
guest code into the right place, which should be where
the flash device/rom/whatever is, which ought to be address 0.

Board code gets to decide whether it pays any attention to
-bios or -pflash at all. You can ignore one and just implement
the other if you like, or you can support both, which is
what vexpress does.

> There may be custom hardware involved, e.g., GPIOs, I2Cs, etc. How would =
these be defined in the machine?

Your best reference for this is to look at existing
device and board model sources.

> Ditto above comment for the -d option.
>
> How are multiple cores traced in the debug output?

In the 'exec' tracing, "Trace 0:" means trace for core 0,
"Trace 1:" core 1, etc. Some tracing is independent of
cores (like in_asm). Some tracing doesn't specify (like
'cpu') but it's obvious from its position relative to
the 'exec' trace lines.

> The vexpress code had clocks, voltages, etc. defined. Are these necessary=
 for a bare-metal, base functioning machine? Exactly which components are a=
bsolutely required? E.g., is the busdev required?

You want a minimal machine which provides RAM,
the CPU, the interrupt controller, and maybe flash
(though you could just stick the initial boot
code into ram to start with if you don't happen
to know what the flash device is on your board).
vexpress provides a lot of stuff that's specific
to vexpress. Don't look just at vexpress : look
also at other board models. You probably want things
that most or every board model does; you probably don't
want things that only the vexpress code is doing.

> Terminology questions:
>
> Throughout there is mention of highmem/lowmem. What does this mean?

This is vexpress specific -- this board happens to
have memory in two different regions of its address
space; they are for convenience named 'highmem' and
'lowmem'.

> Throughout there are "PL" devices, e.g., PL111. What does "PL" mean?

These are Arm devices commonly used on Arm's own devboards
but very rarely found elsewhere (eg a PL011 is a UART,
a PL111 is a graphics controller). Almost certainly your
system's devices will be completely different and you won't
be able to reuse any of the PLxxx device models.

thanks
-- PMM

