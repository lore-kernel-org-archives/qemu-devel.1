Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629CC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 00:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6D9206CC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 00:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6D9206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0DbH-0002kW-01
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 19:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j0Dag-0002Ka-NU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j0Dae-0002lL-5e
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:03:17 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:33560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j0Dad-0002YS-4H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:03:15 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6EC35747DF5;
 Sat,  8 Feb 2020 01:03:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3FEB3747871; Sat,  8 Feb 2020 01:03:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E3EB746383;
 Sat,  8 Feb 2020 01:03:11 +0100 (CET)
Date: Sat, 8 Feb 2020 01:03:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
Message-ID: <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: John Snow <jsnow@redhat.com>, mark.cave-ayland@ilande.co.uk,
 dgilbert@redhat.com, atar4qemu@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, 7 Feb 2020, jasper.lowell@bt.com wrote:
> I haven't figured out where that is coming from.
> The error doesn't look like it's in the OpenSolaris source code so I don't have any context behind it.
> The error does show up here: https://docs.oracle.com/cd/E23824_01/html/821-1475/uata-7d.html so it might be related to the IDE controller.
> The behaviour of Solaris 10 does make me think there is a problem with interrupts but OpenBSD works just fine on this architecture.

Not sure if my problem I see on other machine emulation I'm working on is 
related at all but there's a possibility it might be. I got this with 
different arch (ppc but could also reproduce something similar with mips) 
and ide controller emulation (via-ide) but the PCI bmdma code is shared by 
CMD646, via-ide and sii3112 and also the ide-cdrom emulation is the same 
so if there's a bug in these that could cause similar problems for 
different components. Or it could be that we get similar symptoms due to 
different reasons in which case sorry for the distracion but maybe we can 
learn from the experience of each other even in that case.

What I get is tracked here:

https://osdn.net/projects/qmiga/ticket/38949

(background on emulated machine: https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2 )

Originally I had both Linux and MorphOS fail after enabling BMDMA before I 
had interrupt controller emulation (so that means it could be a problem 
with that in your case as well so something to check). Now that I've 
implemented interrupts Linux boots with DMA from CDROM but MorphOS is 
still not happy. You saw OpenBSD work but Solaris not so that could be 
similar in case the drivers do something differently or one relies on 
something the other does not care about. It could also be that since Linux 
is working, BMDMA and/or ide-cdrom may not emulate something other drivers 
may need which could cause simlar problems on multiple archs/emulations 
but I could be wrong about that.

An advice I got before to debug this is to try enabling ide traces:

https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg05656.html

I've tried that but lacking detailed knowledge about ide controllers I 
could not make much sense of the results so far.

Not sure how much help this is but maybe if more people are looking at it 
we might find something out. I've cc'd the IDE maintainer in case he has 
something more useful to add.

Regards,
BALATON Zoltan

> I've also tried using kmdb (Solaris kernel debugger) by running using `boot cdrom -kvd` at the OpenBIOS prompt.
> I thought this might help diagnose the problem.
> After the kernel debugger prompt occurs and I type `::cont` to continue, the system hangs completely.
>
> Thanks,
> Lowell.
>
> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Thursday, 6 February 2020 4:33 AM
> To: Lowell,J,Jasper,VIM R <jasper.lowell@bt.com>
> Cc: qemu-devel@nongnu.org; mark.cave-ayland@ilande.co.uk; atar4qemu@gmail.com
> Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
>
> * jasper.lowell@bt.com (jasper.lowell@bt.com) wrote:
>> I'm currently working towards emulating Solaris 10 on sun4u.
>>
>> The Solaris 10 ISO image I am attempting to boot is the one from the
>> Oracle download page at https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html.
>> Image: sol-10-u11-ga-sparc-dvd.iso
>> MD5:   53e8b066f7f250ce2fd2cef063f8072b
>>
>> I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
>>
>> The command I am using to run QEMU is:
>> ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios
>> ./openbios/obj-sparc64/openbios-builtin.elf -cdrom
>> ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m 3G
>>
>> ```
>> CPUs: 1 x SUNW,UltraSPARC-IIi
>> UUID: 00000000-0000-0000-0000-000000000000
>> Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
>>   Type 'help' for detailed information Trying cdrom:f...
>> Not a bootable ELF image
>> Not a bootable a.out image
>>
>> Loading FCode image...
>> Loaded 7420 bytes
>> entry point is 0x4000
>> Evaluating FCode...
>> Evaluating FCode...
>> Ignoring failed claim for va 1000000 memsz af6d6!
>> Ignoring failed claim for va 1402000 memsz 4dcc8!
>> Ignoring failed claim for va 1800000 memsz 510c8!
>> SunOS Release 5.10 Version Generic_147147-26 64-bit Copyright (c)
>> 1983, 2013, Oracle and/or its affiliates. All rights reserved.
>> could not find debugger-vocabulary-hook>threads:interpret: exception
>> -13 caught interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
>> \ All rights reserved.
>> \
>> \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
>>
>> hex
>>
>> only forth also definitions
>> vocabulary kdbg-words
>> also kdbg-words definitions
>>
>> defer p@
>> defer p!
>> ['] x@ is p@
>> ['] x! is p!
>>
>> 8 constant ptrsize
>>
>> d# 32 constant nbitsminor
>> h# ffffffff constant maxmin
>> \
>> \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
>> \ Use is subject to license terms.
>> \
>>
>> \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
>>
>> h# 7ff constant v9bias
>> h# unix-tte:interpret: exception -13 caught interpret ' unix-tte is
>> va>tte-data failed with error ffffffffffffffed
>> WARNING: consconfig: cannot find driver for screen device
>> /pci@1fe,0/pci@1,1/QEMU,VGA@2 Configuring devices.
>> WARNING: Interrupt not seen after set_features
>
> GIven that your problem below is looking like an interrupt related problem, have you figured out where that's coming from?
>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>

