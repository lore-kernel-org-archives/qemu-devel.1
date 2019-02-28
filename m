Received: from eggs.gnu.org ([209.51.188.92]:56176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gzDpG-0000zz-8u
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gzDpF-0006Od-CO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:01:42 -0500
Received: from chuckie.co.uk ([82.165.15.123]:49870
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gzDpF-0006Bs-4S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:01:41 -0500
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
	<20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1ef851d2-4148-56f0-65ac-a0e75022f20e@ilande.co.uk>
Date: Thu, 28 Feb 2019 05:01:18 +0000
MIME-Version: 1.0
In-Reply-To: <20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 27/02/2019 05:27, Gerd Hoffmann wrote:

> On Tue, Feb 26, 2019 at 04:11:06PM -0500, G 3 wrote:
>> When I use edid=on, I do see a lot of extra resolutions available in Mac OS
>> 9 and Mac OS X, just not the resolution I want to use. Is there some kind
>> of rule like the resolution value has to be divisible by a certain number?
> 
> qemu doesn't have such a requirement.
> Might be the guest drivers have.
> Try making width/height multiple of 8 or 16.

Right, at the moment all the MacOS driver does is parse the resolution list from the
EDID and add them to the dropdown list - it doesn't support the xres and yres properties.

The main reason for this that OpenBIOS currently makes use of the -g XxYxD parameter
to set up the display resolution and bit depth, and AFAICT we currently only have
access to the X and Y resolutions via the EDID blob. So it's not clear whether EDID
can completely replace the existing mechanism yet.

The other issue to contend with is that some machines such as SPARC will reject
invalid bit depths (i.e. d != 8 || d != 24) during machine init to prevent screen
corruption, and I'm not yet sure how to enforce this with EDID.


ATB,

Mark.
