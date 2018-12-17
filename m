Received: from eggs.gnu.org ([2001:4830:134:3::10]:53507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gYuKE-0003gM-DM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gYuKB-000329-6k
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:56:54 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gYuKA-00031C-VY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:56:51 -0500
Date: Mon, 17 Dec 2018 15:56:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
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

On Wed, 21 Mar 2018, BALATON Zoltan wrote:
> On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
>>> while the serial output seems to be behind the monitor output in the window
>>> opening with Ctrl+Alt+2 and flashes when I type in this window. (This
>>> doesn't seem to happen with qemu-system-x86_64, maybe that's why it was 
>>> not catched.)
>> 
>> Doesn't reproduce too.  It's also not clear why x86_64 should behave
>> different that ppc.  There is no arch-specific code ui/, so there should
>> be no difference, exept for hardware like paralle ports which are not
>> supported by all machine types.
>> 
>> Any chance you have tested an old ppc binary?
>
> Not likely because I did make distclean and a clean build before testing to 
> avoid any possible mismatch. It still does not work for me though. While

I still have this problem after updating everything on my machine, latest 
QEMU and SDL 2.0.9 so it's not likely to be a bug in some external 
component. If I just start qemu-system-ppc (compiled with --disable-gtk) 
and try to open monitor console with Ctrl-Alt-2 I see QEMU monitor but 
when I type in this window the serial output window contents flash in this 
window. At the same time the window that opens for Ctrl-Alt-3 which should 
have the serial output is empty. It looks like an index may be off 
somewhere or window contents are not associated with the right window but 
I have no idea where to look for it. Can you reproduce it now and do you 
have any idea what could cause this?

Thank you,
BALATON Zoltan
