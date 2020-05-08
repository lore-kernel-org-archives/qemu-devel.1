Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC30E207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF1wzrbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC30E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWykM-0000K3-Vp
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.tribble@gmail.com>)
 id 1jWyjf-0008LM-1M
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:51:59 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.tribble@gmail.com>)
 id 1jWyjc-0000y1-Dw
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:51:58 -0400
Received: by mail-ot1-x32b.google.com with SMTP id m13so895856otf.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NPWvG7SJQtIGeaSAVXqNlJa3wxnSooA+Uw3g6g6XU7A=;
 b=eF1wzrbusMH9zZ6fu1ngjAr4/EPMUvqeWjOFYyU+CKqUGnPXYxtYWpflbJRpVyySwJ
 LM/0dfOtTPDbrRfk06r+fr463OOup39lKPPGmzGwSe5DmnQ0yZRe73VSRr3FmFdqah5b
 uWQENmYiG3bwCnJha1PXaT1+SGwqdkG/nFbcyctDh/ieaWDykudOl6nGv8IoOKtcybAb
 cJ8YckqeUvloY1Sdjh/CSLLmOHQpS1cJPh+kNERcCnzQdCSk6s1hwtEChpvRm5hMLI3g
 yzs8ElmR+f+4kqO/g0eVPTIMqDcpkJh/xJ+nBSgQHXnx0Z3+niERoq0yDYfmvYWw5zIV
 O8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NPWvG7SJQtIGeaSAVXqNlJa3wxnSooA+Uw3g6g6XU7A=;
 b=bfiQcPTRIMWpOkvFzF3Q2B9Qrrh9psM7hscKkfNVTE0stX/pXukFWq7eqrCLexoWkO
 MEi4UMfZHy+Y6aINVM4nCFOfPNtr6qZH/LZPIvMt3iTsNbAhs9LGwusHOcpQwvXNMq9J
 ZeOkmCj7C4shnSnX2cEngjIyMYxdjTA74/z7RTiGzt/U63exfwLOXh9G6/qW9nHk/zSg
 Gr9ksX1kRBl3vyBdSVyFyAyKBkZtQtsLmEuDUAdDunt+08LCuk0GaBJ3ITl3RTwluaCn
 YczzRQtYGvotP3IChhn+911KTfSyTjX2RNI12FJ12OwhMpPqOYGkihSneTpZ4S3M26Ig
 VxVA==
X-Gm-Message-State: AGi0PuZnPqM+KWivR9gUy8L57WEKdL92Oh7f4yt12Sp58+hsMeDqNLqQ
 8oy0HQ12NuX7s3JKVZkBhNA+04hZgC6c7qDbWQ==
X-Google-Smtp-Source: APiQypLaQKa1iLSwdC0SdmKrVIkAmtArgHBakT5AoZDLN9+CGqmFNj/zIc2sIReUsudjCrBUYYUZdQnSsAwgJ0JYXQ0=
X-Received: by 2002:a05:6830:16cc:: with SMTP id
 l12mr1307674otr.278.1588927914664; 
 Fri, 08 May 2020 01:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
 <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
In-Reply-To: <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
From: Peter Tribble <peter.tribble@gmail.com>
Date: Fri, 8 May 2020 09:51:33 +0100
Message-ID: <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
To: jasper.lowell@bt.com
Content-Type: multipart/alternative; boundary="000000000000ed65d205a51f1bce"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.tribble@gmail.com; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk,
 QEMU Developers <qemu-devel@nongnu.org>, atar4qemu@gmail.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ed65d205a51f1bce
Content-Type: text/plain; charset="UTF-8"

I see the same behaviour as reported here when booting current SPARC illumos
(illumos is the ongoing fork of OpenSolaris) under qemu - looks like it's
booted
up fine, but I can't type anything on the console.

While I'm an illumos developer, and maintain it on SPARC, I'm unfamiliar
with
most of the internals. We'll try and have a poke around, though.

(The aim would be to use qemu to allow illumos developers to test changes
on SPARC
without requiring them to have SPARC hardware, hence my interest.)

On Fri, May 8, 2020 at 3:40 AM <jasper.lowell@bt.com> wrote:

> There are two different drivers for the 16550A in OpenSolaris.
>
> There is a generic driver in /usr/src/uts/common/io/asy.c. This driver
> clearly states in comments that it is assigning the device to tty[a-d].
> It's really obvious to me that there is support in this driver for
> using the device for a tty.
>
> There is another driver at /usr/src/uts/sun4/io/su_driver.c. Judging
> from the name this is specific for SuperIO. This driver is more than
> 1000 lines shorter than the other driver and contains a note at the top
> of the file that it is "modified as sparc keyboard/mouse driver." I
> don't have much experience with Solaris internals but I can't see any
> obvious signs that this can be used as a tty. I'd also question why
> there are two drivers if they have the same purpose/capability. If the
> su_driver exists to only add support for the keyboard/mouse I'm not
> sure why it would be shorter rather than longer. It would be helpful if
> someone with Solaris experience, that knows what they're doing (I do
> not), can take a look at this driver and give a better opinion.
>
> When emulating Sun4u, the su driver is used. If you misconfigure the
> serial device in QEMU, you can trigger errors that are unique to the
> driver. Also, Solaris attaches the device as su0.
>
> Solaris can access the registers, identify/attach the device, but it
> just never attempts to use it. Interrupts are explicitly disabled and
> the device is never polled. I don't think asyopen in su_driver.c is
> ever called. I've thoroughly stepped through every register access for
> the 16550A and nothing seems out of the ordinary to me. Something I've
> considered is that OpenBIOS is not setting properties for the device in
> a way that Solaris expects but I'm not familiar enough with Sun's
> OpenBOOT to make progress here. I've read through the PROM functions
> that Solaris calls when choosing what device to use as a console and
> nothing seemed inconsistent with what OpenBIOS does. Unfortunately,
> OpenBIOS seems to crash or hang when using the kernel debugger module,
> so dynamic analysis using breakpoints isn't an option.
>
> I don't have any concrete explanations for the broken console but
> rather than do nothing I figured I'd see what happens by emulating the
> SAB 82532.
>
> > At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the
> > 16550A UART. I think there were more such machines. I don't expect
> > there is anything in the Solaris kernel which would prevent any
> > serial
> > device known to it to be used as a tty.
>
> Do you happen to know if this was over SuperIO? If this machine was
> using the same su_driver for a serial console it would rule out
> emulating the hardware-faithful SAB 82532 as being a possible
> improvement. I can't find anything online about someone using SuperIO
> for a ttya on an Ultra 5 running Solaris.
>
> > Well, theoretically yes, but practically there is just one baudrate
> > which can be specified in the OBP. I think it's perfectly safe to use
> > max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.
>
> I'll do this while looking at whether or not the different chip fixes
> the console problems on Sun4u. I'd personally like to avoid introducing
> a device to QEMU that makes assumptions about how the guest may
> configure the chip.
>
> Thanks,
> Jasper Lowell.
>
>
> On Thu, 2020-05-07 at 17:02 +0200, Artyom Tarasenko wrote:
> > On Thu, May 7, 2020 at 4:29 PM <jasper.lowell@bt.com> wrote:
> > > Just thought I'd chime in with an update.
> > >
> > > We are currently emulating a 16550A UART. The guest sees this as
> > > the SU
> > > device, referring to the SuperIO port (a pair of 16550A UARTs). On
> > > the
> > > Ultra 5, the machine that Sun4u is modelled against, SuperIO was
> > > used
> > > for the keyboard and mouse. The Ultra 5 also had a DB25 (ttya
> > > default)
> > > and a DB9 (ttyb default) with a SAB82532 ESSC2.
> > >
> > > Using tracing, I've looked through how the 16550A UART is touched
> > > and
> > > it looks like Solaris 10 has no issues identifying the device. I've
> > > matched register accesses with driver code in OpenSolaris and I'm
> > > pretty sure the device is attached successfully. Also, if you boot
> > > Solaris 10 with debugging output, you can see that the device gets
> > > labelled as su0. The only time Solaris is capable of writing to the
> > > console is when OpenBIOS is used as a proxy.
> > >
> > > Rather than Solaris deciding against using SuperIO as a tty, I
> > > don't
> > > think there was ever any support for doing so (at least on SPARC
> > > machines). This could be an explanation for why the system appears
> > > to
> > > be trucking along just fine despite a seemingly frozen console -
> > > there
> > > is no console. I don't think the frozen console is the fault of
> > > broken
> > > interrupt routing as the 16550A UART is never programmed to
> > > generate
> > > them.
> >
> > At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the
> > 16550A UART. I think there were more such machines. I don't expect
> > there is anything in the Solaris kernel which would prevent any
> > serial
> > device known to it to be used as a tty.
> >
> > > I've started work on emulating the SAB 82532 ESSC2 but it's
> > > unfortunately way more complex than than the 16550A. For instance,
> > > it's
> > > possible to configure different baudrates for receiving and
> > > transmitting. QEMU's chardev interface doesn't appear to handle
> > > that.
> > > QEMUSerialSetParams has a single speed value that is passed to
> > > cfsetispeed and cfsetospeed. The chip also has support for stick
> > > parity
> > > , which aren't valid options right now either. If I'm wrong on
> > > either
> > > of those points please correct me. Unless there is an alternative,
> > > changes to the interface may need to be made if adding this device
> > > is
> > > to be considered.
> >
> > Well, theoretically yes, but practically there is just one baudrate
> > which can be specified in the OBP. I think it's perfectly safe to use
> > max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.
> >
> > Regards,
> > Artyom
> > > On Sun, 2020-02-09 at 11:26 +0000, Mark Cave-Ayland wrote:
> > > > On 05/02/2020 06:31, jasper.lowell@bt.com wrote:
> > > >
> > > > > I'm currently working towards emulating Solaris 10 on sun4u.
> > > > >
> > > > >
> > > > >
> > > > > The Solaris 10 ISO image I am attempting to boot is the one
> > > > > from
> > > > > the Oracle
> > > > >
> > > > > download page at
> > > > >
> https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html
> .
> > > > >
> > > > > Image: sol-10-u11-ga-sparc-dvd.iso
> > > > >
> > > > > MD5:   53e8b066f7f250ce2fd2cef063f8072b
> > > > >
> > > > >
> > > > >
> > > > > I am using QEMU commit
> > > > > 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
> > > > >
> > > > >
> > > > >
> > > > > The command I am using to run QEMU is:
> > > > >
> > > > > ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios
> > > > > ./openbios/obj-sparc64/openbios-builtin.elf -cdrom
> > > > > ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m
> > > > > 3G
> > > > >
> > > > >
> > > > >
> > > > > ```
> > > > >
> > > > > CPUs: 1 x SUNW,UltraSPARC-IIi
> > > > >
> > > > > UUID: 00000000-0000-0000-0000-000000000000
> > > > >
> > > > > Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
> > > > >
> > > > >   Type 'help' for detailed information
> > > > >
> > > > > Trying cdrom:f...
> > > > >
> > > > > Not a bootable ELF image
> > > > >
> > > > > Not a bootable a.out image
> > > > >
> > > > >
> > > > >
> > > > > Loading FCode image...
> > > > >
> > > > > Loaded 7420 bytes
> > > > >
> > > > > entry point is 0x4000
> > > > >
> > > > > Evaluating FCode...
> > > > >
> > > > > Evaluating FCode...
> > > > >
> > > > > Ignoring failed claim for va 1000000 memsz af6d6!
> > > > >
> > > > > Ignoring failed claim for va 1402000 memsz 4dcc8!
> > > > >
> > > > > Ignoring failed claim for va 1800000 memsz 510c8!
> > > > >
> > > > > SunOS Release 5.10 Version Generic_147147-26 64-bit
> > > > >
> > > > > Copyright (c) 1983, 2013, Oracle and/or its affiliates. All
> > > > > rights
> > > > > reserved.
> > > > >
> > > > > could not find debugger-vocabulary-hook>threads:interpret:
> > > > > exception -13 caught
> > > > >
> > > > > interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
> > > > >
> > > > > \ All rights reserved.
> > > > >
> > > > > \
> > > > >
> > > > > \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
> > > > >
> > > > >
> > > > >
> > > > > hex
> > > > >
> > > > >
> > > > >
> > > > > only forth also definitions
> > > > >
> > > > > vocabulary kdbg-words
> > > > >
> > > > > also kdbg-words definitions
> > > > >
> > > > >
> > > > >
> > > > > defer p@
> > > > >
> > > > > defer p!
> > > > >
> > > > > ['] x@ is p@
> > > > >
> > > > > ['] x! is p!
> > > > >
> > > > >
> > > > >
> > > > > 8 constant ptrsize
> > > > >
> > > > >
> > > > >
> > > > > d# 32 constant nbitsminor
> > > > >
> > > > > h# ffffffff constant maxmin
> > > > >
> > > > > \
> > > > >
> > > > > \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
> > > > >
> > > > > \ Use is subject to license terms.
> > > > >
> > > > > \
> > > > >
> > > > >
> > > > >
> > > > > \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
> > > > >
> > > > >
> > > > >
> > > > > h# 7ff constant v9bias
> > > > >
> > > > > h# unix-tte:interpret: exception -13 caught
> > > > >
> > > > > interpret ' unix-tte is va>tte-data failed with error
> > > > > ffffffffffffffed
> > > > >
> > > > > WARNING: consconfig: cannot find driver for screen device
> > > > > /pci@1fe,
> > > > > 0/pci@1,1/QEMU,VGA@2
> > > > >
> > > > > Configuring devices.
> > > > >
> > > > > WARNING: Interrupt not seen after set_features
> > > > >
> > > > > Using RPC Bootparams for network configuration information.
> > > > >
> > > > > Attempting to configure interface hme0...
> > > > >
> > > > > WARNING: Power off requested from power button or SC, powering
> > > > > down
> > > > > the system!
> > > > >
> > > > > Skipped interface hme0
> > > > >
> > > > > svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs
> > > > > mount
> > > > > -a failed: one or
> > > > > more file systems failed to mount
> > > > >
> > > > > Serial console, reverting to text install
> > > > >
> > > > > Beginning system identification...
> > > > >
> > > > > Searching for configuration file(s)...
> > > > >
> > > > > Search complete.
> > > > >
> > > > > Discovering additional network configuration...
> > > > >
> > > > > ```
> > > > >
> > > > >
> > > > >
> > > > > The installation menu is shown after but the console is
> > > > > unresponsive.
> > > > >
> > > > >
> > > > >
> > > > > After some debugging, it looks like the QEMU front-end is
> > > > > correctly
> > > > > filling
> > > > >
> > > > > the serial receive buffer with characters, and then starts
> > > > > dropping
> > > > > them once
> > > > >
> > > > > the number of characters in the buffer reach the interrupt
> > > > > level.
> > > > > The interrupt
> > > > >
> > > > > level happens to be 1 when booting Solaris 10. This looks like
> > > > > normal behaviour
> > > > >
> > > > > to me.
> > > > >
> > > > >
> > > > >
> > > > > I started looking at why the serial receive buffer might not be
> > > > > consumed and
> > > > >
> > > > > considered that interrupts might not be being raised correctly.
> > > > > I
> > > > > ran with
> > > > >
> > > > > tracing and there were no interrupts for IRQ 0x2b like there
> > > > > are
> > > > > when using
> > > > >
> > > > > OpenBSD. When inspecting the registers of the serial device it
> > > > > looks like the
> > > > >
> > > > > Interrupt Enable Register is set to zero.
> > > > >
> > > > >
> > > > >
> > > > > If Solaris 10 was using the device is polling mode, it should
> > > > > be
> > > > > reading the RBR
> > > > >
> > > > > or at least the LSR. When tracing serial_ioport_read and
> > > > > serial_ioport_write,
> > > > >
> > > > > once the menu is hit, I don't see any read or writes to the
> > > > > serial
> > > > > device
> > > > >
> > > > > registers despite me trying to send characters and use the
> > > > > menu.
> > > > >
> > > > >
> > > > >
> > > > > The driver Solaris 10 is using for the device appears to be
> > > > > similar/same as
> > > > >
> > > > > /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found
> > > > > at
> > > > > https://github.com/nxmirrors/onnv.
> > > > >
> > > > >
> > > > >
> > > > > ```
> > > > >
> > > > > asy->asy_hwtype = ASY16550AF;
> > > > >
> > > > > OUTB(FIFOR, 0x00); /* clear fifo register */
> > > > >
> > > > > asy->asy_trig_level = 0x00; /* sets the fifo Threshold to 1 */
> > > > >
> > > > >
> > > > >
> > > > > /* set/Enable FIFO */
> > > > >
> > > > > OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
> > > > >
> > > > > (asy->asy_trig_level & 0xff));
> > > > >
> > > > >
> > > > >
> > > > > if ((INB(ISR) & 0xc0) == 0xc0)
> > > > >
> > > > >     asy->asy_use_fifo = FIFO_ON; /* QEMU REACHES HERE. */
> > > > >
> > > > > else {
> > > > >
> > > > >     asy->asy_hwtype = ASY8250;
> > > > >
> > > > >     OUTB(FIFOR, 0x00); /* NO FIFOs */
> > > > >
> > > > >     asy->asy_trig_level = 0;
> > > > >
> > > > > }
> > > > >
> > > > > ```
> > > > >
> > > > >
> > > > >
> > > > > From what I can tell when tracing serial_ioport_write and
> > > > > serial_ioport_read,
> > > > >
> > > > > Solaris 10 correctly identifies the serial device and
> > > > > successfully
> > > > > attaches it.
> > > > >
> > > > > In the asyattach function (OpenSolaris driver), interrupts are
> > > > > disabled by zeroing the
> > > > >
> > > > > Interrupt Enable Register. From what I'm reading in OpenSolaris
> > > > > source code, interrupts
> > > > >
> > > > > are reenabled when the device is "opened". This seems like
> > > > > consistent and
> > > > >
> > > > > correct behaviour though I'm not sure why the device is not
> > > > > being
> > > > > opened to be
> > > > >
> > > > > used by the serial console.
> > > > >
> > > > >
> > > > >
> > > > > Is this an issue anyone else has tried to debug?
> > > > >
> > > > > Are there any leads that I can follow up on for why the serial
> > > > > console becomes
> > > > > unresponsive
> > > > >
> > > > > on Solaris 10?
> > > >
> > > > It has been a while since I've looked at booting Solaris >= 10
> > > > but
> > > > certainly the
> > > > messages above about set_features and the frozen console suggest
> > > > that
> > > > something is
> > > > going amiss with interrupt routing, although since Linux and
> > > > NetBSD
> > > > were fine the
> > > > last time I ran my OpenBIOS release tests then Solaris must be
> > > > doing
> > > > something
> > > > different here.
> > > >
> > > > Note that the serial interrupts are routed from the ebus into
> > > > sabre
> > > > so the first
> > > > thing to check would be that the end-to-end routing from device
> > > > to
> > > > CPU looks correct
> > > > when using Solaris.
> > > >
> > > >
> > > > ATB,
> > > >
> > > > Mark.
> >
> >
>


-- 
-Peter Tribble
http://www.petertribble.co.uk/ - http://ptribble.blogspot.com/

--000000000000ed65d205a51f1bce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I see the same behaviour as reported here when booting cur=
rent SPARC illumos<br><div><div>(illumos is the ongoing fork of OpenSolaris=
) under qemu - looks like it&#39;s booted<br></div><div>up fine, but I can&=
#39;t type anything on the console.<br><br></div><div>While I&#39;m an illu=
mos developer, and maintain it on SPARC, I&#39;m unfamiliar with<br>most of=
 the internals. We&#39;ll try and have a poke around, though.<br></div><div=
><br></div><div>(The aim would be to use qemu to allow illumos developers t=
o test changes on SPARC<br></div><div>without requiring them to have SPARC =
hardware, hence my interest.)<br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Fri, May 8, 2020 at 3:40 AM &lt;<a href=
=3D"mailto:jasper.lowell@bt.com">jasper.lowell@bt.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">There are two differen=
t drivers for the 16550A in OpenSolaris.<br>
<br>
There is a generic driver in /usr/src/uts/common/io/asy.c. This driver<br>
clearly states in comments that it is assigning the device to tty[a-d]. <br=
>
It&#39;s really obvious to me that there is support in this driver for<br>
using the device for a tty.<br>
<br>
There is another driver at /usr/src/uts/sun4/io/su_driver.c. Judging<br>
from the name this is specific for SuperIO. This driver is more than<br>
1000 lines shorter than the other driver and contains a note at the top<br>
of the file that it is &quot;modified as sparc keyboard/mouse driver.&quot;=
 I<br>
don&#39;t have much experience with Solaris internals but I can&#39;t see a=
ny<br>
obvious signs that this can be used as a tty. I&#39;d also question why<br>
there are two drivers if they have the same purpose/capability. If the<br>
su_driver exists to only add support for the keyboard/mouse I&#39;m not<br>
sure why it would be shorter rather than longer. It would be helpful if<br>
someone with Solaris experience, that knows what they&#39;re doing (I do<br=
>
not), can take a look at this driver and give a better opinion.<br>
<br>
When emulating Sun4u, the su driver is used. If you misconfigure the<br>
serial device in QEMU, you can trigger errors that are unique to the<br>
driver. Also, Solaris attaches the device as su0.<br>
<br>
Solaris can access the registers, identify/attach the device, but it<br>
just never attempts to use it. Interrupts are explicitly disabled and<br>
the device is never polled. I don&#39;t think asyopen in su_driver.c is<br>
ever called. I&#39;ve thoroughly stepped through every register access for<=
br>
the 16550A and nothing seems out of the ordinary to me. Something I&#39;ve<=
br>
considered is that OpenBIOS is not setting properties for the device in<br>
a way that Solaris expects but I&#39;m not familiar enough with Sun&#39;s<b=
r>
OpenBOOT to make progress here. I&#39;ve read through the PROM functions<br=
>
that Solaris calls when choosing what device to use as a console and<br>
nothing seemed inconsistent with what OpenBIOS does. Unfortunately,<br>
OpenBIOS seems to crash or hang when using the kernel debugger module,<br>
so dynamic analysis using breakpoints isn&#39;t an option.<br>
<br>
I don&#39;t have any concrete explanations for the broken console but<br>
rather than do nothing I figured I&#39;d see what happens by emulating the<=
br>
SAB 82532.<br>
<br>
&gt; At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the<br>
&gt; 16550A UART. I think there were more such machines. I don&#39;t expect=
<br>
&gt; there is anything in the Solaris kernel which would prevent any<br>
&gt; serial<br>
&gt; device known to it to be used as a tty.<br>
<br>
Do you happen to know if this was over SuperIO? If this machine was<br>
using the same su_driver for a serial console it would rule out<br>
emulating the hardware-faithful SAB 82532 as being a possible<br>
improvement. I can&#39;t find anything online about someone using SuperIO<b=
r>
for a ttya on an Ultra 5 running Solaris.<br>
<br>
&gt; Well, theoretically yes, but practically there is just one baudrate<br=
>
&gt; which can be specified in the OBP. I think it&#39;s perfectly safe to =
use<br>
&gt; max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.<br>
<br>
I&#39;ll do this while looking at whether or not the different chip fixes<b=
r>
the console problems on Sun4u. I&#39;d personally like to avoid introducing=
<br>
a device to QEMU that makes assumptions about how the guest may<br>
configure the chip.<br>
<br>
Thanks,<br>
Jasper Lowell.<br>
<br>
<br>
On Thu, 2020-05-07 at 17:02 +0200, Artyom Tarasenko wrote:<br>
&gt; On Thu, May 7, 2020 at 4:29 PM &lt;<a href=3D"mailto:jasper.lowell@bt.=
com" target=3D"_blank">jasper.lowell@bt.com</a>&gt; wrote:<br>
&gt; &gt; Just thought I&#39;d chime in with an update.<br>
&gt; &gt; <br>
&gt; &gt; We are currently emulating a 16550A UART. The guest sees this as<=
br>
&gt; &gt; the SU<br>
&gt; &gt; device, referring to the SuperIO port (a pair of 16550A UARTs). O=
n<br>
&gt; &gt; the<br>
&gt; &gt; Ultra 5, the machine that Sun4u is modelled against, SuperIO was<=
br>
&gt; &gt; used<br>
&gt; &gt; for the keyboard and mouse. The Ultra 5 also had a DB25 (ttya<br>
&gt; &gt; default)<br>
&gt; &gt; and a DB9 (ttyb default) with a SAB82532 ESSC2.<br>
&gt; &gt; <br>
&gt; &gt; Using tracing, I&#39;ve looked through how the 16550A UART is tou=
ched<br>
&gt; &gt; and<br>
&gt; &gt; it looks like Solaris 10 has no issues identifying the device. I&=
#39;ve<br>
&gt; &gt; matched register accesses with driver code in OpenSolaris and I&#=
39;m<br>
&gt; &gt; pretty sure the device is attached successfully. Also, if you boo=
t<br>
&gt; &gt; Solaris 10 with debugging output, you can see that the device get=
s<br>
&gt; &gt; labelled as su0. The only time Solaris is capable of writing to t=
he<br>
&gt; &gt; console is when OpenBIOS is used as a proxy.<br>
&gt; &gt; <br>
&gt; &gt; Rather than Solaris deciding against using SuperIO as a tty, I<br=
>
&gt; &gt; don&#39;t<br>
&gt; &gt; think there was ever any support for doing so (at least on SPARC<=
br>
&gt; &gt; machines). This could be an explanation for why the system appear=
s<br>
&gt; &gt; to<br>
&gt; &gt; be trucking along just fine despite a seemingly frozen console -<=
br>
&gt; &gt; there<br>
&gt; &gt; is no console. I don&#39;t think the frozen console is the fault =
of<br>
&gt; &gt; broken<br>
&gt; &gt; interrupt routing as the 16550A UART is never programmed to<br>
&gt; &gt; generate<br>
&gt; &gt; them.<br>
&gt; <br>
&gt; At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the<br>
&gt; 16550A UART. I think there were more such machines. I don&#39;t expect=
<br>
&gt; there is anything in the Solaris kernel which would prevent any<br>
&gt; serial<br>
&gt; device known to it to be used as a tty.<br>
&gt; <br>
&gt; &gt; I&#39;ve started work on emulating the SAB 82532 ESSC2 but it&#39=
;s<br>
&gt; &gt; unfortunately way more complex than than the 16550A. For instance=
,<br>
&gt; &gt; it&#39;s<br>
&gt; &gt; possible to configure different baudrates for receiving and<br>
&gt; &gt; transmitting. QEMU&#39;s chardev interface doesn&#39;t appear to =
handle<br>
&gt; &gt; that.<br>
&gt; &gt; QEMUSerialSetParams has a single speed value that is passed to<br=
>
&gt; &gt; cfsetispeed and cfsetospeed. The chip also has support for stick<=
br>
&gt; &gt; parity<br>
&gt; &gt; , which aren&#39;t valid options right now either. If I&#39;m wro=
ng on<br>
&gt; &gt; either<br>
&gt; &gt; of those points please correct me. Unless there is an alternative=
,<br>
&gt; &gt; changes to the interface may need to be made if adding this devic=
e<br>
&gt; &gt; is<br>
&gt; &gt; to be considered.<br>
&gt; <br>
&gt; Well, theoretically yes, but practically there is just one baudrate<br=
>
&gt; which can be specified in the OBP. I think it&#39;s perfectly safe to =
use<br>
&gt; max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Artyom<br>
&gt; &gt; On Sun, 2020-02-09 at 11:26 +0000, Mark Cave-Ayland wrote:<br>
&gt; &gt; &gt; On 05/02/2020 06:31, <a href=3D"mailto:jasper.lowell@bt.com"=
 target=3D"_blank">jasper.lowell@bt.com</a> wrote:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I&#39;m currently working towards emulating Solaris 10 =
on sun4u.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The Solaris 10 ISO image I am attempting to boot is the=
 one<br>
&gt; &gt; &gt; &gt; from<br>
&gt; &gt; &gt; &gt; the Oracle<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; download page at<br>
&gt; &gt; &gt; &gt; <a href=3D"https://www.oracle.com/solaris/solaris10/dow=
nloads/solaris10-get-jsp-downloads.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-dow=
nloads.html</a>.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Image: sol-10-u11-ga-sparc-dvd.iso<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; MD5:=C2=A0 =C2=A053e8b066f7f250ce2fd2cef063f8072b<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I am using QEMU commit<br>
&gt; &gt; &gt; &gt; 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The command I am using to run QEMU is:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios<br>
&gt; &gt; &gt; &gt; ./openbios/obj-sparc64/openbios-builtin.elf -cdrom<br>
&gt; &gt; &gt; &gt; ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nogr=
aphic -m<br>
&gt; &gt; &gt; &gt; 3G<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ```<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; CPUs: 1 x SUNW,UltraSPARC-IIi<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; UUID: 00000000-0000-0000-0000-000000000000<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0Type &#39;help&#39; for detailed informatio=
n<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Trying cdrom:f...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Not a bootable ELF image<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Not a bootable a.out image<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Loading FCode image...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Loaded 7420 bytes<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; entry point is 0x4000<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Evaluating FCode...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Evaluating FCode...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Ignoring failed claim for va 1000000 memsz af6d6!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Ignoring failed claim for va 1402000 memsz 4dcc8!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Ignoring failed claim for va 1800000 memsz 510c8!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; SunOS Release 5.10 Version Generic_147147-26 64-bit<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Copyright (c) 1983, 2013, Oracle and/or its affiliates.=
 All<br>
&gt; &gt; &gt; &gt; rights<br>
&gt; &gt; &gt; &gt; reserved.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; could not find debugger-vocabulary-hook&gt;threads:inte=
rpret:<br>
&gt; &gt; &gt; &gt; exception -13 caught<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; interpret \ Copyright (c) 1995-1999 by Sun Microsystems=
, Inc.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \ All rights reserved.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \ ident &quot;@(#)data64.fth=C2=A0 1.3=C2=A0 =C2=A0 =C2=
=A000/07/17 SMI&quot;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; hex<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; only forth also definitions<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; vocabulary kdbg-words<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; also kdbg-words definitions<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; defer p@<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; defer p!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; [&#39;] x@ is p@<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; [&#39;] x! is p!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; 8 constant ptrsize<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; d# 32 constant nbitsminor<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; h# ffffffff constant maxmin<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \ Copyright 2008 Sun Microsystems, Inc.=C2=A0 All right=
s reserved.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \ Use is subject to license terms.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; \ #pragma ident=C2=A0 &quot;@(#)kdbg.fth=C2=A0 =C2=A0 1=
.20=C2=A0 =C2=A0 08/06/06 SMI&quot;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; h# 7ff constant v9bias<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; h# unix-tte:interpret: exception -13 caught<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; interpret &#39; unix-tte is va&gt;tte-data failed with =
error<br>
&gt; &gt; &gt; &gt; ffffffffffffffed<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; WARNING: consconfig: cannot find driver for screen devi=
ce <br>
&gt; &gt; &gt; &gt; /pci@1fe,<br>
&gt; &gt; &gt; &gt; 0/pci@1,1/QEMU,VGA@2<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Configuring devices.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; WARNING: Interrupt not seen after set_features<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Using RPC Bootparams for network configuration informat=
ion.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Attempting to configure interface hme0...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; WARNING: Power off requested from power button or SC, p=
owering<br>
&gt; &gt; &gt; &gt; down<br>
&gt; &gt; &gt; &gt; the system!<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Skipped interface hme0<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; svc:/system/filesystem/local:default: WARNING: /usr/sbi=
n/zfs<br>
&gt; &gt; &gt; &gt; mount<br>
&gt; &gt; &gt; &gt; -a failed: one or<br>
&gt; &gt; &gt; &gt; more file systems failed to mount<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Serial console, reverting to text install<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Beginning system identification...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Searching for configuration file(s)...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Search complete.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Discovering additional network configuration...<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ```<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The installation menu is shown after but the console is=
<br>
&gt; &gt; &gt; &gt; unresponsive.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; After some debugging, it looks like the QEMU front-end =
is<br>
&gt; &gt; &gt; &gt; correctly<br>
&gt; &gt; &gt; &gt; filling<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; the serial receive buffer with characters, and then sta=
rts<br>
&gt; &gt; &gt; &gt; dropping<br>
&gt; &gt; &gt; &gt; them once<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; the number of characters in the buffer reach the interr=
upt<br>
&gt; &gt; &gt; &gt; level.<br>
&gt; &gt; &gt; &gt; The interrupt<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; level happens to be 1 when booting Solaris 10. This loo=
ks like<br>
&gt; &gt; &gt; &gt; normal behaviour<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; to me.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I started looking at why the serial receive buffer migh=
t not be<br>
&gt; &gt; &gt; &gt; consumed and<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; considered that interrupts might not be being raised co=
rrectly.<br>
&gt; &gt; &gt; &gt; I<br>
&gt; &gt; &gt; &gt; ran with<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; tracing and there were no interrupts for IRQ 0x2b like =
there<br>
&gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; when using<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; OpenBSD. When inspecting the registers of the serial de=
vice it<br>
&gt; &gt; &gt; &gt; looks like the<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Interrupt Enable Register is set to zero.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; If Solaris 10 was using the device is polling mode, it =
should<br>
&gt; &gt; &gt; &gt; be<br>
&gt; &gt; &gt; &gt; reading the RBR<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; or at least the LSR. When tracing serial_ioport_read an=
d<br>
&gt; &gt; &gt; &gt; serial_ioport_write,<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; once the menu is hit, I don&#39;t see any read or write=
s to the<br>
&gt; &gt; &gt; &gt; serial<br>
&gt; &gt; &gt; &gt; device<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; registers despite me trying to send characters and use =
the<br>
&gt; &gt; &gt; &gt; menu.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The driver Solaris 10 is using for the device appears t=
o be<br>
&gt; &gt; &gt; &gt; similar/same as<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris cod=
e found<br>
&gt; &gt; &gt; &gt; at<br>
&gt; &gt; &gt; &gt; <a href=3D"https://github.com/nxmirrors/onnv" rel=3D"no=
referrer" target=3D"_blank">https://github.com/nxmirrors/onnv</a>.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ```<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; asy-&gt;asy_hwtype =3D ASY16550AF;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; OUTB(FIFOR, 0x00); /* clear fifo register */<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; asy-&gt;asy_trig_level =3D 0x00; /* sets the fifo Thres=
hold to 1 */<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; /* set/Enable FIFO */<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH=
 |<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (asy-&gt;asy_trig_level &amp; 0xff));<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; if ((INB(ISR) &amp; 0xc0) =3D=3D 0xc0)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0asy-&gt;asy_use_fifo =3D FIFO_ON; /*=
 QEMU REACHES HERE. */<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; else {<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0asy-&gt;asy_hwtype =3D ASY8250;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0OUTB(FIFOR, 0x00); /* NO FIFOs */<br=
>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0asy-&gt;asy_trig_level =3D 0;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; }<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; ```<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; From what I can tell when tracing serial_ioport_write a=
nd<br>
&gt; &gt; &gt; &gt; serial_ioport_read,<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Solaris 10 correctly identifies the serial device and<b=
r>
&gt; &gt; &gt; &gt; successfully<br>
&gt; &gt; &gt; &gt; attaches it.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; In the asyattach function (OpenSolaris driver), interru=
pts are<br>
&gt; &gt; &gt; &gt; disabled by zeroing the<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Interrupt Enable Register. From what I&#39;m reading in=
 OpenSolaris<br>
&gt; &gt; &gt; &gt; source code, interrupts<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; are reenabled when the device is &quot;opened&quot;. Th=
is seems like<br>
&gt; &gt; &gt; &gt; consistent and<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; correct behaviour though I&#39;m not sure why the devic=
e is not<br>
&gt; &gt; &gt; &gt; being<br>
&gt; &gt; &gt; &gt; opened to be<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; used by the serial console.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Is this an issue anyone else has tried to debug?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Are there any leads that I can follow up on for why the=
 serial<br>
&gt; &gt; &gt; &gt; console becomes<br>
&gt; &gt; &gt; &gt; unresponsive<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; on Solaris 10?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; It has been a while since I&#39;ve looked at booting Solaris=
 &gt;=3D 10<br>
&gt; &gt; &gt; but<br>
&gt; &gt; &gt; certainly the<br>
&gt; &gt; &gt; messages above about set_features and the frozen console sug=
gest<br>
&gt; &gt; &gt; that<br>
&gt; &gt; &gt; something is<br>
&gt; &gt; &gt; going amiss with interrupt routing, although since Linux and=
<br>
&gt; &gt; &gt; NetBSD<br>
&gt; &gt; &gt; were fine the<br>
&gt; &gt; &gt; last time I ran my OpenBIOS release tests then Solaris must =
be<br>
&gt; &gt; &gt; doing<br>
&gt; &gt; &gt; something<br>
&gt; &gt; &gt; different here.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Note that the serial interrupts are routed from the ebus int=
o<br>
&gt; &gt; &gt; sabre<br>
&gt; &gt; &gt; so the first<br>
&gt; &gt; &gt; thing to check would be that the end-to-end routing from dev=
ice<br>
&gt; &gt; &gt; to<br>
&gt; &gt; &gt; CPU looks correct<br>
&gt; &gt; &gt; when using Solaris.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; ATB,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Mark.<br>
&gt; <br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">-Peter Tribble<br><a href=3D"http://www.petertribble.co.uk/=
" target=3D"_blank">http://www.petertribble.co.uk/</a> - <a href=3D"http://=
ptribble.blogspot.com/" target=3D"_blank">http://ptribble.blogspot.com/</a>=
</div></div></div>

--000000000000ed65d205a51f1bce--

