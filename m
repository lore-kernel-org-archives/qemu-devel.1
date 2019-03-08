Received: from eggs.gnu.org ([209.51.188.92]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h23VQ-0008So-AG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h23VN-0007Vq-8h
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:36:56 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:57307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h23VM-0007S1-8i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:36:52 -0500
Date: Fri, 8 Mar 2019 01:36:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1903071507470.53555@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1903080125270.3082@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
	<20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903061440270.30260@zero.eik.bme.hu>
	<20190307064332.mvxhuaopgpdtp3za@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903071507470.53555@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Question about hardware cursor in VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 7 Mar 2019, BALATON Zoltan wrote:
> I still have the unfinished version using the callbacks which might work with 
> force_shadow like for cirrus but I'd need to finish and clean that up. Now 
> that we have both implemented probably will allow switching between them but 
> may not be able to do it before the freeze so don't wait for that. (The 
> define_cursor way is enough for testing at the moment and rewriting it to use 
> different callback could be considered bugfix or added in next devel cycle as 
> well.)

I've sent a v6 now (of just the ati-vga patch, the other patch in the 
series is unchanged) with this. Defaults to define_cursor but cursor 
rendering via callbacks can be enabled with guest_hwcursor=true property. 
The cursor seems to be less jumpy with it but probably slower. I'm still 
not sure why it jumps with define_cursor but I think that may be a problem 
outside of this device.

I've also attempted to implement DDC for EDID but that's not ready yet and 
it will be a separate series because I'll likely need some changes to i2c 
as well to be able to use bitbang_i2c in this device model. (Probably we 
should merge contents of hw/bitbang_i2c.h in include/hw/i2c.h where the 
structure definition had to be moved already or move this header to 
include to be able to use it outside of hw/i2c. Currently I just #include 
"../i2c/bitbang_i2c.h" from hw/display/ati.c but I think that's not 
acceptable.)

Regards,
BALATON Zoltan
