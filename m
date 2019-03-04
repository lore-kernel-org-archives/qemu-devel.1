Received: from eggs.gnu.org ([209.51.188.92]:53962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0p2Z-0006Ad-NO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0p2Y-0007Rk-Tb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:58:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:54637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0p2Y-0007P4-MM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:58:02 -0500
Date: Mon, 4 Mar 2019 15:58:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Question about hardware cursor in VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hello,

I'm trying to implement hardware cursor for ati-vga before submitting the 
last version of it before the freeze. (This was found to be used at least 
by MorphOS and Mac OS X.) I've found that vga has facilities for this 
already (used by cirrus) with the cursor_invalidate() and 
cursor_draw_line() functions that I can reuse for this but these are only 
called if !(is_buffer_shared(surface)) at least since 7d957bd8cbc. How is 
this supposed to work? What does draw hardware cursor in cirrus when 
surface is shared? Or is it broken now for cirrus as well? I could remove 
this check from vga.c and add it to the functions in cirrus-vga.c to 
preserve current behaviour but I'm not sure that's correct. Looks more 
like this check is not needed at all for cirrus either. Is there a guest 
to test this with? (This reminds me I've seen mouse pointer disappearing 
in text input fields and notepad or wordpad on WindowsXP guest before 
probably with vmware_vga but likely that's not related to the above, just 
remembered it now.)

Regards,
BALATON Zoltan
