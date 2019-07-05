Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC18C468A0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0E621670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0E621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjS28-0003VD-Gr
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hjS1A-0002n0-Pt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hjS18-0006eJ-RL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:19909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hjS16-0006YT-U7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 505457461AE;
 Fri,  5 Jul 2019 19:28:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 03F477461AA; Fri,  5 Jul 2019 19:28:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E620774569A;
 Fri,  5 Jul 2019 19:28:54 +0200 (CEST)
Date: Fri, 5 Jul 2019 19:28:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190705135919.vcm3n64qdyr3yrs4@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1907051649410.69768@zero.eik.bme.hu>
References: <99bb800cba3596e47d2681642116756330dc6f63.1562320946.git.balaton@eik.bme.hu>
 <20190705135919.vcm3n64qdyr3yrs4@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Add registers for getting
 apertures
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019, Gerd Hoffmann wrote:
> On Fri, Jul 05, 2019 at 12:02:26PM +0200, BALATON Zoltan wrote:
>> Some drivers (e.g. Linux radeon drm and MacOS) access these to find
>> apertures to access card. Try to implement these but not sure these
>> are correct yet.
>
>> +    case CONFIG_APER_SIZE:
>> +        val = s->vga.vram_size;
>> +        break;
>
> Given the math linux is doing I don't think this is correct:
>
> static u32 r100_get_accessible_vram(struct radeon_device *rdev)
> {
> 	u32 aper_size;
> 	u8 byte;
>
> 	aper_size = RREG32(RADEON_CONFIG_APER_SIZE);
>
> 	[ ... ]
>
> 	/* Single function older card. We read HDP_APER_CNTL to see how the BIOS
> 	 * have set it up. We don't write this as it's broken on some ASICs but
> 	 * we expect the BIOS to have done the right thing (might be too optimistic...)
> 	 */
> 	if (RREG32(RADEON_HOST_PATH_CNTL) & RADEON_HDP_APER_CNTL)
> 		return aper_size * 2;
> 	return aper_size;
> }

I don't know and probably will take a while to figure out but here's what 
I could find so far.

Your patch has set CONFIG_APER_SIZE to vram_size/2 and set HDP_APER_CNTL 
bit in HOST_PATH_CNTL to 1 so above would return aper_size * 2 = vram_size

My patch sets CONFIG_APER_SIZE to vram_size and does not set APER_CNTL bit 
so results should be the same: returning vram_size, just differently.

Unless I've missed something that would make both of our patches correct 
or broken for Linux which does not set HOST_PATH_CNTL only uses its value.

> IIRC old ati cards had a pci bar twice the size of the vram, where the lower
> half of the pci bar was straight access to the video memory and the upper
> half byteswapped access.

Correct but maybe only for cards older than R128P (or R128P is an 
exception?), I remember reading about that in Mach64 or Rage PRO docs 
where the second half of the frame buffer would byte-swap. The R128P 
mentions AGP memory instead for high addresses (e.g. in description of 
DST_OFFSET reg). The M6 register reference does not have any description 
of these CONFIG_* regs so I'm not sure how should these behave for 
M6/RV100 but the R128P register reference (found on 
http://vgamuseum.info/index.php/companies/item/111-ati-rage-128-pro) has 
some info on this. It details memory mapping in section 2.2 and says that:

"There are also two identical copies of the relocatable Linear Memory 
Aperture in RAGE 128." (Endiannes of these are settable independently in 
CONFIG_CNTL and the second aperture could be set big endian on PowerMac 
for example but I haven't checked if the ATI MacOS driver tries to do that 
or not but if it produced picture the colors would show that.)

"These apertures allow access to the frame buffer memory, and in AGP 
systems, access to the AGP memory as seen by the RAGE 128.

To determine the base address of Linear Aperture 0, use the 
CONFIG_APER_0_BASE register. To determine the base address of Linear 
Aperture 1, use the CONFIG_APER_1_BASE register. Both these registers can 
be read in any register aperture.

To determine the size of each linear aperture, use the CONFIG_APER_SIZE 
register.

The frame buffer image occupies the area in each aperture from offset 0 to 
CONFIG_MEMSIZE-1." (There's also CONFIG_MEMSIZE_EMBEDDED for chips with 
embedded memory that is I think less or equal to CONFIG_MEMSIZE but "The 
RAGE 128 does not have any embedded memory." The M6 I think has 16MB on 
chip RAM so this may be non-0 for that but likely it's not mandatory so 
should work without that as there are RV100 chips without RAM as well.)

"The RAGE 128 supports up to 32MB of frame buffer memory. This limit may 
be expanded for future hardware generations,"

"Each Linear Aperture contains an image of the AGP system memory as seen 
by the accelerator. This image starts at offset AGP_APER_OFFSET in the 
aperture." (But it says it's intended for debugging only and not 
recommended to use.)

"To determine the size of the AGP memory, use the AGP_APER_SIZE register. 
This register is an enumerated type that must be converted into a number 
(refer to the register definition).

The RAGE 128 supports up to 32MB of AGP memory."

So according to the above I think on R128P CONFIG_APER_SIZE should be 
maximum 32MB FB + 32 MB AGP that is 64MB. The register definition though 
says:

CONFIG_APER_SIZE MMR:0x0108 MMR_1:0x0108 IND:0x0108
[R] 32 bits (access: 8/16/32)
  Field Name    Bits    Default
  APER_SIZE     25: 0  0x2000000
(reserved)     31:26

Description: Size of linear apertures (both 0 and 1). This includes both 
the frame buffer image and the AGP system memory image area.
NOTE: Bits 24:0 of this field are hardwired to ZERO

CONFIG_APER_SIZE: Linear Aperture Size

The default value here is 32MB (and if all bits except 25 is 0 then it 
can't have other value either than 0 or 32MB) so I'm not sure but in any 
case I think what's important is that CONFIG_APER_SIZE should be >= 
CONFIG_MEMSIZE.

> I think that is the background of the "aper_size * 2" logic above, and
> RADEON_HDP_APER_CNTL is probably a config bit for the behavior.

This gets more confusing here. This bit does not seem to exist in R128P, 
the HOST_PATH_CNTL reg lists bits 23:15 as (reserved), but in the M6 
manual we have:

HOST_PATH_CNTL - RW - 32 bits - [MMReg:0x130]
Field Name                       Bits      Default 
HDP_APER_CNTL                     23         0x0

Description

Selects how the two PCI linear memory apertures map into the internal 
32bit address space of the graphics controller.

0=Both host apertures map to same area in MC address space (starting at 
MC_FB_START). Surface ranges are limited to the size of CONFIG_APER_SIZE.

1=Two host apertures are mapped one above the other in MC address space 
stating at MC_FP_START. i.e. they become one big aperture. Surface ranges 
can cover the double size of CONFIG_APER_SIZE.

So I'm confused (what a mess these cards are) but with this bit 0 there 
should be no need to double or halve the aperture/RAM sizes and behaviour 
should match that of R128P, therefore I'd do that unless we find something 
that acually sets this to 1 and tries to use it that way. (In my 
understanding of the above setting this bit to 1 would allow to have the 
two apertures to map to two consecutive 32MB (or whatever size) window 
(instead of both showing the same memory area) allowing to access twice 
the size of card memory but not sure how this relates to CONFIG_MEMSIZE. 
Maybe the aperture windows are limited to 32MB and there would be no way 
to access more card RAM otherwise?

One more thing I don't understand is that it says apertures are 
relocatable but how are these set? The base registers are listed as read 
only (with CONFIG_MEMSIZE actually RW(?)). The APER_0 can be set via the 
PCI BAR but how is APER_1 set? The MacOS ATI driver just tries to read its 
value and then can't access the card so apparemtly it's looking for it 
somewhere else or maybe expects the firmware to map it somewhere first? 
I'll need to check that more closely eventually.

Regards,
BALATON Zoltan

