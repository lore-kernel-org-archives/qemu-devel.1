Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB06C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEE32070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDBpzzAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEE32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX3L4-0002en-Qq
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jX3K4-00018M-8m
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:45:52 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jX3K2-0000XX-48
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:45:51 -0400
Received: by mail-il1-x142.google.com with SMTP id f82so1420553ilh.8
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vA6KQUkBi4xVaMboDbEqseWTVhFo6iS8ZLVANDiGEQY=;
 b=fDBpzzAxwDNw+Z2j+2YbbsptAXJHIHoM4ul+7NxZdHOWkyMTXJORkjkki5W3TdMe+L
 LudTLbwchb8iJMv2QMlEriqJklxOQQbDH6dIPn7W4dXDIboYXLKto3xiFO6pBdnGTm26
 UFKv76/szNbm27h1K/D5TVlWlXzicvwbLxUtY4XAxp4JsRf/+eLbxbdT4Vkb3Dy8Fhic
 eYU0k9q2hFyhkHzB2ky+U0R2q1ynJSDqWqAi6rtke7NjrSCHBtYkr8ziAQPLZE1srDEw
 JxRteEG+KxlKrHJqD4gitcgYFHrbOdYRxmmRVu1MY+b62WHxPwbn9NVVjiDlYFpBbazP
 rAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vA6KQUkBi4xVaMboDbEqseWTVhFo6iS8ZLVANDiGEQY=;
 b=q3A4tGefagDTENzcIAGSTMrac8OvihfSS14p462hSRgHaaR4teL1RkxVxUr5b0iH6w
 XYtdelgb8SxBqSCFq+SnYh+M4croVKlwwlhFVx2a2mxYvbI8iTY8Y0L0G2AOMttBc6LG
 NmfOGSw3JFJl8Nuc7mLBTnI6/hVKT85JKi5Md1R97NazKpxSd99inUUccp09b9buBuhS
 8isbdF1kguee4o3O8al3UdB+z+7+GqeP9LA2+QaOpJ67GUt87Wm1xR20EgcL7FNyyqg6
 jj1HGUAV7ArDHbjrZ5dhTgB/GhdwWrwJyFXPBPkfRxTx0dss6EjeWG9vE771s6bglrxp
 Lrig==
X-Gm-Message-State: AGi0PuY/OPCm/+4F4rBcZreSmheslg1VaX2VPIa8S9Sn+4zAO65vob15
 h70GYmYu3WXyxqc2gefuyN9FjPQ2rmKetZEjyts=
X-Google-Smtp-Source: APiQypJgupRh4qIOdMqnfW6x3Nr6EYFUetXsM2L8TfquhCEXM3y0TI1RJYMkldpBfBt3lHVQ/1+mTHVRwDq5mThqtBU=
X-Received: by 2002:a92:ba99:: with SMTP id t25mr2937065ill.84.1588945548790; 
 Fri, 08 May 2020 06:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
 <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
 <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
In-Reply-To: <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 8 May 2020 15:45:37 +0200
Message-ID: <CACXAS8D5YLs2BMHBR39h_XEsMZ4n7XpDE+FSdKBLDgxFGpwzbQ@mail.gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
To: Peter Tribble <peter.tribble@gmail.com>, jasper.lowell@bt.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=atar4qemu@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: tony.nguyen@bt.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 10:51 AM Peter Tribble <peter.tribble@gmail.com> wrote:
>
> I see the same behaviour as reported here when booting current SPARC illumos
> (illumos is the ongoing fork of OpenSolaris) under qemu - looks like it's booted
> up fine, but I can't type anything on the console.

There is one more option which can be relatively easily tested:
you can add two more ports (or replace the existing ttya/ttyb) to the
qemu's ultra5 model: the escc (aka zs) ports.
They definitely work under Solaris (Ultra-1, Ultra-2, E3000,
E3500...), I've seen it.
OpenBIOS already has a driver for them which is used for sun4m (and
some ppc) targets. So no new devices have to be implemented.
If your and Jasper's theory proofs to be correct, we can think of
replacing ttya/ttyb su with zs.
I guess the other sun4u operating systems do support zs as well. (This
has to be tested though)


> While I'm an illumos developer, and maintain it on SPARC, I'm unfamiliar with
> most of the internals. We'll try and have a poke around, though.
>
> (The aim would be to use qemu to allow illumos developers to test changes on SPARC
> without requiring them to have SPARC hardware, hence my interest.)

I think I managed booting Tribblix under the QEMU niagara target. It
has less devices than sun4u, but the console was working.

Regards,
Artyom

> On Fri, May 8, 2020 at 3:40 AM <jasper.lowell@bt.com> wrote:
>>
>> There are two different drivers for the 16550A in OpenSolaris.
>>
>> There is a generic driver in /usr/src/uts/common/io/asy.c. This driver
>> clearly states in comments that it is assigning the device to tty[a-d].
>> It's really obvious to me that there is support in this driver for
>> using the device for a tty.
>>
>> There is another driver at /usr/src/uts/sun4/io/su_driver.c. Judging
>> from the name this is specific for SuperIO. This driver is more than
>> 1000 lines shorter than the other driver and contains a note at the top
>> of the file that it is "modified as sparc keyboard/mouse driver." I
>> don't have much experience with Solaris internals but I can't see any
>> obvious signs that this can be used as a tty. I'd also question why
>> there are two drivers if they have the same purpose/capability. If the
>> su_driver exists to only add support for the keyboard/mouse I'm not
>> sure why it would be shorter rather than longer. It would be helpful if
>> someone with Solaris experience, that knows what they're doing (I do
>> not), can take a look at this driver and give a better opinion.
>>
>> When emulating Sun4u, the su driver is used. If you misconfigure the
>> serial device in QEMU, you can trigger errors that are unique to the
>> driver. Also, Solaris attaches the device as su0.
>>
>> Solaris can access the registers, identify/attach the device, but it
>> just never attempts to use it. Interrupts are explicitly disabled and
>> the device is never polled. I don't think asyopen in su_driver.c is
>> ever called. I've thoroughly stepped through every register access for
>> the 16550A and nothing seems out of the ordinary to me. Something I've
>> considered is that OpenBIOS is not setting properties for the device in
>> a way that Solaris expects but I'm not familiar enough with Sun's
>> OpenBOOT to make progress here. I've read through the PROM functions
>> that Solaris calls when choosing what device to use as a console and
>> nothing seemed inconsistent with what OpenBIOS does. Unfortunately,
>> OpenBIOS seems to crash or hang when using the kernel debugger module,
>> so dynamic analysis using breakpoints isn't an option.
>>
>> I don't have any concrete explanations for the broken console but
>> rather than do nothing I figured I'd see what happens by emulating the
>> SAB 82532.
>>
>> > At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the
>> > 16550A UART. I think there were more such machines. I don't expect
>> > there is anything in the Solaris kernel which would prevent any
>> > serial
>> > device known to it to be used as a tty.
>>
>> Do you happen to know if this was over SuperIO? If this machine was
>> using the same su_driver for a serial console it would rule out
>> emulating the hardware-faithful SAB 82532 as being a possible
>> improvement. I can't find anything online about someone using SuperIO
>> for a ttya on an Ultra 5 running Solaris.
>>
>> > Well, theoretically yes, but practically there is just one baudrate
>> > which can be specified in the OBP. I think it's perfectly safe to use
>> > max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.
>>
>> I'll do this while looking at whether or not the different chip fixes
>> the console problems on Sun4u. I'd personally like to avoid introducing
>> a device to QEMU that makes assumptions about how the guest may
>> configure the chip.
>>
>> Thanks,
>> Jasper Lowell.
>>
>>
>> On Thu, 2020-05-07 at 17:02 +0200, Artyom Tarasenko wrote:
>> > On Thu, May 7, 2020 at 4:29 PM <jasper.lowell@bt.com> wrote:
>> > > Just thought I'd chime in with an update.
>> > >
>> > > We are currently emulating a 16550A UART. The guest sees this as
>> > > the SU
>> > > device, referring to the SuperIO port (a pair of 16550A UARTs). On
>> > > the
>> > > Ultra 5, the machine that Sun4u is modelled against, SuperIO was
>> > > used
>> > > for the keyboard and mouse. The Ultra 5 also had a DB25 (ttya
>> > > default)
>> > > and a DB9 (ttyb default) with a SAB82532 ESSC2.
>> > >
>> > > Using tracing, I've looked through how the 16550A UART is touched
>> > > and
>> > > it looks like Solaris 10 has no issues identifying the device. I've
>> > > matched register accesses with driver code in OpenSolaris and I'm
>> > > pretty sure the device is attached successfully. Also, if you boot
>> > > Solaris 10 with debugging output, you can see that the device gets
>> > > labelled as su0. The only time Solaris is capable of writing to the
>> > > console is when OpenBIOS is used as a proxy.
>> > >
>> > > Rather than Solaris deciding against using SuperIO as a tty, I
>> > > don't
>> > > think there was ever any support for doing so (at least on SPARC
>> > > machines). This could be an explanation for why the system appears
>> > > to
>> > > be trucking along just fine despite a seemingly frozen console -
>> > > there
>> > > is no console. I don't think the frozen console is the fault of
>> > > broken
>> > > interrupt routing as the 16550A UART is never programmed to
>> > > generate
>> > > them.
>> >
>> > At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the
>> > 16550A UART. I think there were more such machines. I don't expect
>> > there is anything in the Solaris kernel which would prevent any
>> > serial
>> > device known to it to be used as a tty.
>> >
>> > > I've started work on emulating the SAB 82532 ESSC2 but it's
>> > > unfortunately way more complex than than the 16550A. For instance,
>> > > it's
>> > > possible to configure different baudrates for receiving and
>> > > transmitting. QEMU's chardev interface doesn't appear to handle
>> > > that.
>> > > QEMUSerialSetParams has a single speed value that is passed to
>> > > cfsetispeed and cfsetospeed. The chip also has support for stick
>> > > parity
>> > > , which aren't valid options right now either. If I'm wrong on
>> > > either
>> > > of those points please correct me. Unless there is an alternative,
>> > > changes to the interface may need to be made if adding this device
>> > > is
>> > > to be considered.
>> >
>> > Well, theoretically yes, but practically there is just one baudrate
>> > which can be specified in the OBP. I think it's perfectly safe to use
>> > max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.
>> >
>> > Regards,
>> > Artyom
>> > > On Sun, 2020-02-09 at 11:26 +0000, Mark Cave-Ayland wrote:
>> > > > On 05/02/2020 06:31, jasper.lowell@bt.com wrote:
>> > > >
>> > > > > I'm currently working towards emulating Solaris 10 on sun4u.
>> > > > >
>> > > > >
>> > > > >
>> > > > > The Solaris 10 ISO image I am attempting to boot is the one
>> > > > > from
>> > > > > the Oracle
>> > > > >
>> > > > > download page at
>> > > > > https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html.
>> > > > >
>> > > > > Image: sol-10-u11-ga-sparc-dvd.iso
>> > > > >
>> > > > > MD5:   53e8b066f7f250ce2fd2cef063f8072b
>> > > > >
>> > > > >
>> > > > >
>> > > > > I am using QEMU commit
>> > > > > 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
>> > > > >
>> > > > >
>> > > > >
>> > > > > The command I am using to run QEMU is:
>> > > > >
>> > > > > ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios
>> > > > > ./openbios/obj-sparc64/openbios-builtin.elf -cdrom
>> > > > > ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m
>> > > > > 3G
>> > > > >
>> > > > >
>> > > > >
>> > > > > ```
>> > > > >
>> > > > > CPUs: 1 x SUNW,UltraSPARC-IIi
>> > > > >
>> > > > > UUID: 00000000-0000-0000-0000-000000000000
>> > > > >
>> > > > > Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
>> > > > >
>> > > > >   Type 'help' for detailed information
>> > > > >
>> > > > > Trying cdrom:f...
>> > > > >
>> > > > > Not a bootable ELF image
>> > > > >
>> > > > > Not a bootable a.out image
>> > > > >
>> > > > >
>> > > > >
>> > > > > Loading FCode image...
>> > > > >
>> > > > > Loaded 7420 bytes
>> > > > >
>> > > > > entry point is 0x4000
>> > > > >
>> > > > > Evaluating FCode...
>> > > > >
>> > > > > Evaluating FCode...
>> > > > >
>> > > > > Ignoring failed claim for va 1000000 memsz af6d6!
>> > > > >
>> > > > > Ignoring failed claim for va 1402000 memsz 4dcc8!
>> > > > >
>> > > > > Ignoring failed claim for va 1800000 memsz 510c8!
>> > > > >
>> > > > > SunOS Release 5.10 Version Generic_147147-26 64-bit
>> > > > >
>> > > > > Copyright (c) 1983, 2013, Oracle and/or its affiliates. All
>> > > > > rights
>> > > > > reserved.
>> > > > >
>> > > > > could not find debugger-vocabulary-hook>threads:interpret:
>> > > > > exception -13 caught
>> > > > >
>> > > > > interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
>> > > > >
>> > > > > \ All rights reserved.
>> > > > >
>> > > > > \
>> > > > >
>> > > > > \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
>> > > > >
>> > > > >
>> > > > >
>> > > > > hex
>> > > > >
>> > > > >
>> > > > >
>> > > > > only forth also definitions
>> > > > >
>> > > > > vocabulary kdbg-words
>> > > > >
>> > > > > also kdbg-words definitions
>> > > > >
>> > > > >
>> > > > >
>> > > > > defer p@
>> > > > >
>> > > > > defer p!
>> > > > >
>> > > > > ['] x@ is p@
>> > > > >
>> > > > > ['] x! is p!
>> > > > >
>> > > > >
>> > > > >
>> > > > > 8 constant ptrsize
>> > > > >
>> > > > >
>> > > > >
>> > > > > d# 32 constant nbitsminor
>> > > > >
>> > > > > h# ffffffff constant maxmin
>> > > > >
>> > > > > \
>> > > > >
>> > > > > \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
>> > > > >
>> > > > > \ Use is subject to license terms.
>> > > > >
>> > > > > \
>> > > > >
>> > > > >
>> > > > >
>> > > > > \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
>> > > > >
>> > > > >
>> > > > >
>> > > > > h# 7ff constant v9bias
>> > > > >
>> > > > > h# unix-tte:interpret: exception -13 caught
>> > > > >
>> > > > > interpret ' unix-tte is va>tte-data failed with error
>> > > > > ffffffffffffffed
>> > > > >
>> > > > > WARNING: consconfig: cannot find driver for screen device
>> > > > > /pci@1fe,
>> > > > > 0/pci@1,1/QEMU,VGA@2
>> > > > >
>> > > > > Configuring devices.
>> > > > >
>> > > > > WARNING: Interrupt not seen after set_features
>> > > > >
>> > > > > Using RPC Bootparams for network configuration information.
>> > > > >
>> > > > > Attempting to configure interface hme0...
>> > > > >
>> > > > > WARNING: Power off requested from power button or SC, powering
>> > > > > down
>> > > > > the system!
>> > > > >
>> > > > > Skipped interface hme0
>> > > > >
>> > > > > svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs
>> > > > > mount
>> > > > > -a failed: one or
>> > > > > more file systems failed to mount
>> > > > >
>> > > > > Serial console, reverting to text install
>> > > > >
>> > > > > Beginning system identification...
>> > > > >
>> > > > > Searching for configuration file(s)...
>> > > > >
>> > > > > Search complete.
>> > > > >
>> > > > > Discovering additional network configuration...
>> > > > >
>> > > > > ```
>> > > > >
>> > > > >
>> > > > >
>> > > > > The installation menu is shown after but the console is
>> > > > > unresponsive.
>> > > > >
>> > > > >
>> > > > >
>> > > > > After some debugging, it looks like the QEMU front-end is
>> > > > > correctly
>> > > > > filling
>> > > > >
>> > > > > the serial receive buffer with characters, and then starts
>> > > > > dropping
>> > > > > them once
>> > > > >
>> > > > > the number of characters in the buffer reach the interrupt
>> > > > > level.
>> > > > > The interrupt
>> > > > >
>> > > > > level happens to be 1 when booting Solaris 10. This looks like
>> > > > > normal behaviour
>> > > > >
>> > > > > to me.
>> > > > >
>> > > > >
>> > > > >
>> > > > > I started looking at why the serial receive buffer might not be
>> > > > > consumed and
>> > > > >
>> > > > > considered that interrupts might not be being raised correctly.
>> > > > > I
>> > > > > ran with
>> > > > >
>> > > > > tracing and there were no interrupts for IRQ 0x2b like there
>> > > > > are
>> > > > > when using
>> > > > >
>> > > > > OpenBSD. When inspecting the registers of the serial device it
>> > > > > looks like the
>> > > > >
>> > > > > Interrupt Enable Register is set to zero.
>> > > > >
>> > > > >
>> > > > >
>> > > > > If Solaris 10 was using the device is polling mode, it should
>> > > > > be
>> > > > > reading the RBR
>> > > > >
>> > > > > or at least the LSR. When tracing serial_ioport_read and
>> > > > > serial_ioport_write,
>> > > > >
>> > > > > once the menu is hit, I don't see any read or writes to the
>> > > > > serial
>> > > > > device
>> > > > >
>> > > > > registers despite me trying to send characters and use the
>> > > > > menu.
>> > > > >
>> > > > >
>> > > > >
>> > > > > The driver Solaris 10 is using for the device appears to be
>> > > > > similar/same as
>> > > > >
>> > > > > /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found
>> > > > > at
>> > > > > https://github.com/nxmirrors/onnv.
>> > > > >
>> > > > >
>> > > > >
>> > > > > ```
>> > > > >
>> > > > > asy->asy_hwtype = ASY16550AF;
>> > > > >
>> > > > > OUTB(FIFOR, 0x00); /* clear fifo register */
>> > > > >
>> > > > > asy->asy_trig_level = 0x00; /* sets the fifo Threshold to 1 */
>> > > > >
>> > > > >
>> > > > >
>> > > > > /* set/Enable FIFO */
>> > > > >
>> > > > > OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
>> > > > >
>> > > > > (asy->asy_trig_level & 0xff));
>> > > > >
>> > > > >
>> > > > >
>> > > > > if ((INB(ISR) & 0xc0) == 0xc0)
>> > > > >
>> > > > >     asy->asy_use_fifo = FIFO_ON; /* QEMU REACHES HERE. */
>> > > > >
>> > > > > else {
>> > > > >
>> > > > >     asy->asy_hwtype = ASY8250;
>> > > > >
>> > > > >     OUTB(FIFOR, 0x00); /* NO FIFOs */
>> > > > >
>> > > > >     asy->asy_trig_level = 0;
>> > > > >
>> > > > > }
>> > > > >
>> > > > > ```
>> > > > >
>> > > > >
>> > > > >
>> > > > > From what I can tell when tracing serial_ioport_write and
>> > > > > serial_ioport_read,
>> > > > >
>> > > > > Solaris 10 correctly identifies the serial device and
>> > > > > successfully
>> > > > > attaches it.
>> > > > >
>> > > > > In the asyattach function (OpenSolaris driver), interrupts are
>> > > > > disabled by zeroing the
>> > > > >
>> > > > > Interrupt Enable Register. From what I'm reading in OpenSolaris
>> > > > > source code, interrupts
>> > > > >
>> > > > > are reenabled when the device is "opened". This seems like
>> > > > > consistent and
>> > > > >
>> > > > > correct behaviour though I'm not sure why the device is not
>> > > > > being
>> > > > > opened to be
>> > > > >
>> > > > > used by the serial console.
>> > > > >
>> > > > >
>> > > > >
>> > > > > Is this an issue anyone else has tried to debug?
>> > > > >
>> > > > > Are there any leads that I can follow up on for why the serial
>> > > > > console becomes
>> > > > > unresponsive
>> > > > >
>> > > > > on Solaris 10?
>> > > >
>> > > > It has been a while since I've looked at booting Solaris >= 10
>> > > > but
>> > > > certainly the
>> > > > messages above about set_features and the frozen console suggest
>> > > > that
>> > > > something is
>> > > > going amiss with interrupt routing, although since Linux and
>> > > > NetBSD
>> > > > were fine the
>> > > > last time I ran my OpenBIOS release tests then Solaris must be
>> > > > doing
>> > > > something
>> > > > different here.
>> > > >
>> > > > Note that the serial interrupts are routed from the ebus into
>> > > > sabre
>> > > > so the first
>> > > > thing to check would be that the end-to-end routing from device
>> > > > to
>> > > > CPU looks correct
>> > > > when using Solaris.
>> > > >
>> > > >
>> > > > ATB,
>> > > >
>> > > > Mark.
>> >
>> >
>
>
>
> --
> -Peter Tribble
> http://www.petertribble.co.uk/ - http://ptribble.blogspot.com/



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

