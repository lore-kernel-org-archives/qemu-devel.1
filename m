Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EEC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9697320857
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzgN5tjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9697320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWi3K-00053p-Ns
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jWi2V-0004ZV-3Y
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:02:19 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jWi2T-0001Hm-GY
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:02:18 -0400
Received: by mail-il1-x143.google.com with SMTP id q10so1493849ile.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f9KNQlik2VfM7asJPdxG5AqMNS4LIEdL2VZcMtZawtY=;
 b=WzgN5tjOZHlDD79mbXWzwE+jTTxud/Zk6KIhMzT8/EPkKkrYf7xVNgObFt0RCeTVeX
 nBvaSaNIilLqPXJvJbcIeGLo595nfYbw7H3r7ciQgZg4wG3HDkBj87f0wHknWBeSxQdA
 4qJHDnAAIobPAf795xIOuIenIe8LmSREw5tWtEDnYwKFMgIq8i8LCuMCP9KHzU/oRFcT
 PD9ww0+aWRFsciXPTWpxEsYYITEFZ+FrWOPDAsEnuK4j1wjRHRPTIMUF4JH8fTP9aGDJ
 yyEEo4pbeV+sF2EPyt8G2fo7ejs8222uuRErglJ5Xdov9Dy6KciG5PX013fDyuyMp0ds
 hq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f9KNQlik2VfM7asJPdxG5AqMNS4LIEdL2VZcMtZawtY=;
 b=ryM/HOqU2VRMs76KYnOfg1YzWYwAjzTlTNSjCMScEQXJBzIQXYpVrPRcKuZYqrhUnP
 wglBJPyhW5eKYJcY4+cbp6Pc/r1ZguWU1ktl8NucmMGnAhTr5UxwbWp+H7l02HOP8J5Q
 4cvtNV4R0m8BaFtF784cEdYDekq2MCeYxDy3wHtjfnz1cZgg3cyfWOgst+yTReuh26jg
 0mE9LvzSl4EEUwJ7k2bEgFoaL1NiprYrbyDGMlhMkTyUdaqZb0J3GLrP/mvP5+tPVk7L
 TiXV68j8cOXcbxnMx4c0+AdqaQuC9uRMMkZ33YG/9rrKPwh2/oSINbs1rWU9ZmV4PSwT
 RXqw==
X-Gm-Message-State: AGi0PuZDbzTNe7LSCDM28pubHk6Xx/s/2u3MCPRFNW1OzhT3PlpMy5dC
 Y6iy1eqkjBK1wuNJwzoVA8fs9pdn9ohfNPDLESE=
X-Google-Smtp-Source: APiQypLpPnMJYJKHiF0ruBtpQmew54TwBaB67i1UetfS2jN/oz30PdDnWffoB0EWiieoCYj86Tdob822nJ/GEPXBtYY=
X-Received: by 2002:a92:4152:: with SMTP id o79mr4469170ila.198.1588863735677; 
 Thu, 07 May 2020 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
In-Reply-To: <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 7 May 2020 17:02:03 +0200
Message-ID: <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
To: jasper.lowell@bt.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=atar4qemu@gmail.com; helo=mail-il1-x143.google.com
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
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 4:29 PM <jasper.lowell@bt.com> wrote:
>
> Just thought I'd chime in with an update.
>
> We are currently emulating a 16550A UART. The guest sees this as the SU
> device, referring to the SuperIO port (a pair of 16550A UARTs). On the
> Ultra 5, the machine that Sun4u is modelled against, SuperIO was used
> for the keyboard and mouse. The Ultra 5 also had a DB25 (ttya default)
> and a DB9 (ttyb default) with a SAB82532 ESSC2.
>
> Using tracing, I've looked through how the 16550A UART is touched and
> it looks like Solaris 10 has no issues identifying the device. I've
> matched register accesses with driver code in OpenSolaris and I'm
> pretty sure the device is attached successfully. Also, if you boot
> Solaris 10 with debugging output, you can see that the device gets
> labelled as su0. The only time Solaris is capable of writing to the
> console is when OpenBIOS is used as a proxy.
>
> Rather than Solaris deciding against using SuperIO as a tty, I don't
> think there was ever any support for doing so (at least on SPARC
> machines). This could be an explanation for why the system appears to
> be trucking along just fine despite a seemingly frozen console - there
> is no console. I don't think the frozen console is the fault of broken
> interrupt routing as the 16550A UART is never programmed to generate
> them.

At least Fujitsu Siemens PRIMEPOWER250 had a tty attached to the
16550A UART. I think there were more such machines. I don't expect
there is anything in the Solaris kernel which would prevent any serial
device known to it to be used as a tty.

> I've started work on emulating the SAB 82532 ESSC2 but it's
> unfortunately way more complex than than the 16550A. For instance, it's
> possible to configure different baudrates for receiving and
> transmitting. QEMU's chardev interface doesn't appear to handle that.
> QEMUSerialSetParams has a single speed value that is passed to
> cfsetispeed and cfsetospeed. The chip also has support for stick parity
> , which aren't valid options right now either. If I'm wrong on either
> of those points please correct me. Unless there is an alternative,
> changes to the interface may need to be made if adding this device is
> to be considered.

Well, theoretically yes, but practically there is just one baudrate
which can be specified in the OBP. I think it's perfectly safe to use
max(rxrate,txrate), or min(rxrate,txrate), whatever you prefer.

Regards,
Artyom
>
> On Sun, 2020-02-09 at 11:26 +0000, Mark Cave-Ayland wrote:
> > On 05/02/2020 06:31, jasper.lowell@bt.com wrote:
> >
> > > I'm currently working towards emulating Solaris 10 on sun4u.
> > >
> > >
> > >
> > > The Solaris 10 ISO image I am attempting to boot is the one from
> > > the Oracle
> > >
> > > download page at
> > > https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html.
> > >
> > > Image: sol-10-u11-ga-sparc-dvd.iso
> > >
> > > MD5:   53e8b066f7f250ce2fd2cef063f8072b
> > >
> > >
> > >
> > > I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
> > >
> > >
> > >
> > > The command I am using to run QEMU is:
> > >
> > > ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios
> > > ./openbios/obj-sparc64/openbios-builtin.elf -cdrom
> > > ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m 3G
> > >
> > >
> > >
> > > ```
> > >
> > > CPUs: 1 x SUNW,UltraSPARC-IIi
> > >
> > > UUID: 00000000-0000-0000-0000-000000000000
> > >
> > > Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
> > >
> > >   Type 'help' for detailed information
> > >
> > > Trying cdrom:f...
> > >
> > > Not a bootable ELF image
> > >
> > > Not a bootable a.out image
> > >
> > >
> > >
> > > Loading FCode image...
> > >
> > > Loaded 7420 bytes
> > >
> > > entry point is 0x4000
> > >
> > > Evaluating FCode...
> > >
> > > Evaluating FCode...
> > >
> > > Ignoring failed claim for va 1000000 memsz af6d6!
> > >
> > > Ignoring failed claim for va 1402000 memsz 4dcc8!
> > >
> > > Ignoring failed claim for va 1800000 memsz 510c8!
> > >
> > > SunOS Release 5.10 Version Generic_147147-26 64-bit
> > >
> > > Copyright (c) 1983, 2013, Oracle and/or its affiliates. All rights
> > > reserved.
> > >
> > > could not find debugger-vocabulary-hook>threads:interpret:
> > > exception -13 caught
> > >
> > > interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
> > >
> > > \ All rights reserved.
> > >
> > > \
> > >
> > > \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
> > >
> > >
> > >
> > > hex
> > >
> > >
> > >
> > > only forth also definitions
> > >
> > > vocabulary kdbg-words
> > >
> > > also kdbg-words definitions
> > >
> > >
> > >
> > > defer p@
> > >
> > > defer p!
> > >
> > > ['] x@ is p@
> > >
> > > ['] x! is p!
> > >
> > >
> > >
> > > 8 constant ptrsize
> > >
> > >
> > >
> > > d# 32 constant nbitsminor
> > >
> > > h# ffffffff constant maxmin
> > >
> > > \
> > >
> > > \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
> > >
> > > \ Use is subject to license terms.
> > >
> > > \
> > >
> > >
> > >
> > > \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
> > >
> > >
> > >
> > > h# 7ff constant v9bias
> > >
> > > h# unix-tte:interpret: exception -13 caught
> > >
> > > interpret ' unix-tte is va>tte-data failed with error
> > > ffffffffffffffed
> > >
> > > WARNING: consconfig: cannot find driver for screen device /pci@1fe,
> > > 0/pci@1,1/QEMU,VGA@2
> > >
> > > Configuring devices.
> > >
> > > WARNING: Interrupt not seen after set_features
> > >
> > > Using RPC Bootparams for network configuration information.
> > >
> > > Attempting to configure interface hme0...
> > >
> > > WARNING: Power off requested from power button or SC, powering down
> > > the system!
> > >
> > > Skipped interface hme0
> > >
> > > svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs mount
> > > -a failed: one or
> > > more file systems failed to mount
> > >
> > > Serial console, reverting to text install
> > >
> > > Beginning system identification...
> > >
> > > Searching for configuration file(s)...
> > >
> > > Search complete.
> > >
> > > Discovering additional network configuration...
> > >
> > > ```
> > >
> > >
> > >
> > > The installation menu is shown after but the console is
> > > unresponsive.
> > >
> > >
> > >
> > > After some debugging, it looks like the QEMU front-end is correctly
> > > filling
> > >
> > > the serial receive buffer with characters, and then starts dropping
> > > them once
> > >
> > > the number of characters in the buffer reach the interrupt level.
> > > The interrupt
> > >
> > > level happens to be 1 when booting Solaris 10. This looks like
> > > normal behaviour
> > >
> > > to me.
> > >
> > >
> > >
> > > I started looking at why the serial receive buffer might not be
> > > consumed and
> > >
> > > considered that interrupts might not be being raised correctly. I
> > > ran with
> > >
> > > tracing and there were no interrupts for IRQ 0x2b like there are
> > > when using
> > >
> > > OpenBSD. When inspecting the registers of the serial device it
> > > looks like the
> > >
> > > Interrupt Enable Register is set to zero.
> > >
> > >
> > >
> > > If Solaris 10 was using the device is polling mode, it should be
> > > reading the RBR
> > >
> > > or at least the LSR. When tracing serial_ioport_read and
> > > serial_ioport_write,
> > >
> > > once the menu is hit, I don't see any read or writes to the serial
> > > device
> > >
> > > registers despite me trying to send characters and use the menu.
> > >
> > >
> > >
> > > The driver Solaris 10 is using for the device appears to be
> > > similar/same as
> > >
> > > /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found at
> > > https://github.com/nxmirrors/onnv.
> > >
> > >
> > >
> > > ```
> > >
> > > asy->asy_hwtype = ASY16550AF;
> > >
> > > OUTB(FIFOR, 0x00); /* clear fifo register */
> > >
> > > asy->asy_trig_level = 0x00; /* sets the fifo Threshold to 1 */
> > >
> > >
> > >
> > > /* set/Enable FIFO */
> > >
> > > OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
> > >
> > > (asy->asy_trig_level & 0xff));
> > >
> > >
> > >
> > > if ((INB(ISR) & 0xc0) == 0xc0)
> > >
> > >     asy->asy_use_fifo = FIFO_ON; /* QEMU REACHES HERE. */
> > >
> > > else {
> > >
> > >     asy->asy_hwtype = ASY8250;
> > >
> > >     OUTB(FIFOR, 0x00); /* NO FIFOs */
> > >
> > >     asy->asy_trig_level = 0;
> > >
> > > }
> > >
> > > ```
> > >
> > >
> > >
> > > From what I can tell when tracing serial_ioport_write and
> > > serial_ioport_read,
> > >
> > > Solaris 10 correctly identifies the serial device and successfully
> > > attaches it.
> > >
> > > In the asyattach function (OpenSolaris driver), interrupts are
> > > disabled by zeroing the
> > >
> > > Interrupt Enable Register. From what I'm reading in OpenSolaris
> > > source code, interrupts
> > >
> > > are reenabled when the device is "opened". This seems like
> > > consistent and
> > >
> > > correct behaviour though I'm not sure why the device is not being
> > > opened to be
> > >
> > > used by the serial console.
> > >
> > >
> > >
> > > Is this an issue anyone else has tried to debug?
> > >
> > > Are there any leads that I can follow up on for why the serial
> > > console becomes
> > > unresponsive
> > >
> > > on Solaris 10?
> >
> > It has been a while since I've looked at booting Solaris >= 10 but
> > certainly the
> > messages above about set_features and the frozen console suggest that
> > something is
> > going amiss with interrupt routing, although since Linux and NetBSD
> > were fine the
> > last time I ran my OpenBIOS release tests then Solaris must be doing
> > something
> > different here.
> >
> > Note that the serial interrupts are routed from the ebus into sabre
> > so the first
> > thing to check would be that the end-to-end routing from device to
> > CPU looks correct
> > when using Solaris.
> >
> >
> > ATB,
> >
> > Mark.



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

