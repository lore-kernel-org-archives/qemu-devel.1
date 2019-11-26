Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C19C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9411B2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9411B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZaM-0002NX-KC
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iZZYv-0001lm-3D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iZZYs-0003fn-Tn
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:20 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:54176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iZZYs-0003dM-JM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:18 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 90B02745702;
 Tue, 26 Nov 2019 13:03:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A17A7456FE; Tue, 26 Nov 2019 13:03:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6918E7456F8;
 Tue, 26 Nov 2019 13:03:14 +0100 (CET)
Date: Tue, 26 Nov 2019 13:03:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aaron Dominick <aaron.zakhrov@gmail.com>
Subject: Re: [RFC 0/8] ATI R300 emulated graphics card
In-Reply-To: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911261233350.87139@zero.eik.bme.hu>
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Tue, 26 Nov 2019, aaron.zakhrov@gmail.com wrote:
> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>
> Hello,
> I thought of working on an emulated R300 GPU for QEMU video acceleration on vintage operating systems (Windows 9x-XP)

Good idea, :-) I very welcome any contribution to this.

> The following patch series contains the initial QEMU device and some register read/write operations.

At first look you have pathces twice in the series (so each patch appears 
twice, I haven't checked if they are identical or different) and also the 
first (and 5th) patch adds a lot of probably unused files which makes 
review difficult. Could you please fix these and resend with only adding 
the headers really needed and each patch only once so we know what are the 
actual changes that are relevant?

Also is it possible to keep everything in ati-vga only adding another 
device model there rather than fully duplicating it as r300* ? Although 
for development it's probably OK to keep it separate but unless there are 
enough differences having a single file at the end may be better. (Also 
changes are clearer that way but if you have a patch only copying ati-vga 
files first then separate patches that changes it can be reviewed that way 
too.)

In short I think this series needs some cleanup first for us to be able to 
revies it better.

> Testing it on an OpenSUSE Linux guest and the kernel correctly detects the card and loads the radeon DRM driver.

So I think this gets a bit further than my ati-vga rv100 which does not 
work with DRM yet. I've thought about targeting RV100 first then moving on 
to later radeons as those probably have more features and differences from 
R128 which is the starting point for ati-vga but if you need R300 for some 
reason specifically targeting that is OK too.

> It gets as far as the CRTC probing before crashing with an error that there is not enough bandwidth.

Getting DRM to load is one thing but likely you'll need to implement 
microengine/command processor (also referred to as PM4 or programming mode 
4 sometimes) to get it fully working as that's how DRM and Windows ATI 
drivers likely send commands to the card. I've looked at it but couldn't 
find documentation on how the microengine works. We get a microcode 
uploaded by no idea how to run that. If we can't figure out how the 
microengine works anther approach could be what xenia.jp XBox 360 emulator 
does and directly parse the packets not using the microcode. It could be 
possible to copy code from Xenia for that but we need to convert C++ to C. 
The difficult part is probably figuring out how to run it in a different 
thread so the device emulation does not block the machine and it works in 
parallel like real hardware does.

> I know next to nothing about hardware emulation and would like to know if what I have got so far is on the right track.

Are you aware of my project page for ATI VGA emulation here:

https://osdn.net/projects/qmiga/wiki/SubprojectAti

where I have collected some knowledge that I could gather so far? I have 
some experience in implementing devices in QEMU but know next to nothing 
about GPUs so hopefully you know more about those which is more needed for 
ati-vga. The QEMU knowledge can be picked up by looking at existing 
devices and asking here or on IRC (if you prefer that, I don't use it but 
I know some do).

Regards,
BALATON Zoltan

