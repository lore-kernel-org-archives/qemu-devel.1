Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7647C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 11:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9195720733
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9195720733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0kkA-0007rr-JX
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 06:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j0kjG-0007BH-6v
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 06:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j0kjD-0002gb-UF
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 06:26:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38720
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j0kjD-0002ea-O0
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 06:26:19 -0500
Received: from host86-175-83-30.range86-175.btcentralplus.com ([86.175.83.30]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j0kjH-0007j2-S3; Sun, 09 Feb 2020 11:26:28 +0000
To: jasper.lowell@bt.com, qemu-devel@nongnu.org
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
Date: Sun, 9 Feb 2020 11:26:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.175.83.30
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/2020 06:31, jasper.lowell@bt.com wrote:

> I'm currently working towards emulating Solaris 10 on sun4u.
> 
>  
> 
> The Solaris 10 ISO image I am attempting to boot is the one from the Oracle
> 
> download page at
> https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html.
> 
> Image: sol-10-u11-ga-sparc-dvd.iso
> 
> MD5:   53e8b066f7f250ce2fd2cef063f8072b
> 
>  
> 
> I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
> 
>  
> 
> The command I am using to run QEMU is:
> 
> ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios
> ./openbios/obj-sparc64/openbios-builtin.elf -cdrom
> ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m 3G
> 
>  
> 
> ```
> 
> CPUs: 1 x SUNW,UltraSPARC-IIi
> 
> UUID: 00000000-0000-0000-0000-000000000000
> 
> Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
> 
>   Type 'help' for detailed information
> 
> Trying cdrom:f...
> 
> Not a bootable ELF image
> 
> Not a bootable a.out image
> 
>  
> 
> Loading FCode image...
> 
> Loaded 7420 bytes
> 
> entry point is 0x4000
> 
> Evaluating FCode...
> 
> Evaluating FCode...
> 
> Ignoring failed claim for va 1000000 memsz af6d6!
> 
> Ignoring failed claim for va 1402000 memsz 4dcc8!
> 
> Ignoring failed claim for va 1800000 memsz 510c8!
> 
> SunOS Release 5.10 Version Generic_147147-26 64-bit
> 
> Copyright (c) 1983, 2013, Oracle and/or its affiliates. All rights reserved.
> 
> could not find debugger-vocabulary-hook>threads:interpret: exception -13 caught
> 
> interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
> 
> \ All rights reserved.
> 
> \
> 
> \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
> 
>  
> 
> hex
> 
>  
> 
> only forth also definitions
> 
> vocabulary kdbg-words
> 
> also kdbg-words definitions
> 
>  
> 
> defer p@
> 
> defer p!
> 
> ['] x@ is p@
> 
> ['] x! is p!
> 
>  
> 
> 8 constant ptrsize
> 
>  
> 
> d# 32 constant nbitsminor
> 
> h# ffffffff constant maxmin
> 
> \
> 
> \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
> 
> \ Use is subject to license terms.
> 
> \
> 
>  
> 
> \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
> 
>  
> 
> h# 7ff constant v9bias
> 
> h# unix-tte:interpret: exception -13 caught
> 
> interpret ' unix-tte is va>tte-data failed with error ffffffffffffffed
> 
> WARNING: consconfig: cannot find driver for screen device /pci@1fe,0/pci@1,1/QEMU,VGA@2
> 
> Configuring devices.
> 
> WARNING: Interrupt not seen after set_features
> 
> Using RPC Bootparams for network configuration information.
> 
> Attempting to configure interface hme0...
> 
> WARNING: Power off requested from power button or SC, powering down the system!
> 
> Skipped interface hme0
> 
> svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs mount -a failed: one or
> more file systems failed to mount
> 
> Serial console, reverting to text install
> 
> Beginning system identification...
> 
> Searching for configuration file(s)...
> 
> Search complete.
> 
> Discovering additional network configuration...
> 
> ```
> 
>  
> 
> The installation menu is shown after but the console is unresponsive.
> 
>  
> 
> After some debugging, it looks like the QEMU front-end is correctly filling
> 
> the serial receive buffer with characters, and then starts dropping them once
> 
> the number of characters in the buffer reach the interrupt level. The interrupt
> 
> level happens to be 1 when booting Solaris 10. This looks like normal behaviour
> 
> to me.
> 
>  
> 
> I started looking at why the serial receive buffer might not be consumed and
> 
> considered that interrupts might not be being raised correctly. I ran with
> 
> tracing and there were no interrupts for IRQ 0x2b like there are when using
> 
> OpenBSD. When inspecting the registers of the serial device it looks like the
> 
> Interrupt Enable Register is set to zero.
> 
>  
> 
> If Solaris 10 was using the device is polling mode, it should be reading the RBR
> 
> or at least the LSR. When tracing serial_ioport_read and serial_ioport_write,
> 
> once the menu is hit, I don't see any read or writes to the serial device
> 
> registers despite me trying to send characters and use the menu.
> 
>  
> 
> The driver Solaris 10 is using for the device appears to be similar/same as
> 
> /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found at
> https://github.com/nxmirrors/onnv.
> 
>  
> 
> ```
> 
> asy->asy_hwtype = ASY16550AF;
> 
> OUTB(FIFOR, 0x00); /* clear fifo register */
> 
> asy->asy_trig_level = 0x00; /* sets the fifo Threshold to 1 */
> 
>  
> 
> /* set/Enable FIFO */
> 
> OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
> 
> (asy->asy_trig_level & 0xff));
> 
>  
> 
> if ((INB(ISR) & 0xc0) == 0xc0)
> 
>     asy->asy_use_fifo = FIFO_ON; /* QEMU REACHES HERE. */
> 
> else {
> 
>     asy->asy_hwtype = ASY8250;
> 
>     OUTB(FIFOR, 0x00); /* NO FIFOs */
> 
>     asy->asy_trig_level = 0;
> 
> }
> 
> ```
> 
>  
> 
> From what I can tell when tracing serial_ioport_write and serial_ioport_read,
> 
> Solaris 10 correctly identifies the serial device and successfully attaches it.
> 
> In the asyattach function (OpenSolaris driver), interrupts are disabled by zeroing the
> 
> Interrupt Enable Register. From what I'm reading in OpenSolaris source code, interrupts
> 
> are reenabled when the device is "opened". This seems like consistent and
> 
> correct behaviour though I'm not sure why the device is not being opened to be
> 
> used by the serial console.
> 
>  
> 
> Is this an issue anyone else has tried to debug?
> 
> Are there any leads that I can follow up on for why the serial console becomes
> unresponsive
> 
> on Solaris 10?

It has been a while since I've looked at booting Solaris >= 10 but certainly the
messages above about set_features and the frozen console suggest that something is
going amiss with interrupt routing, although since Linux and NetBSD were fine the
last time I ran my OpenBIOS release tests then Solaris must be doing something
different here.

Note that the serial interrupts are routed from the ebus into sabre so the first
thing to check would be that the end-to-end routing from device to CPU looks correct
when using Solaris.


ATB,

Mark.

