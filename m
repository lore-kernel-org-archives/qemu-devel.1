Received: from eggs.gnu.org ([2001:4830:134:3::10]:60718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXrlr-00007J-LY
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXrlo-0003t3-JA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:28:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:46531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fXrlo-0003rE-93
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:28:48 -0400
Date: Tue, 26 Jun 2018 19:28:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <f60449f0-0544-5f6f-76e5-38d4f416de13@t-online.de>
Message-ID: <alpine.BSF.2.21.1806261904290.6896@zero.eik.bme.hu>
References: <20150706172738.3886.69660.malonedeb@wampee.canonical.com>
	<152959184007.27230.621946142209363986.malone@gac.canonical.com>
	<f60449f0-0544-5f6f-76e5-38d4f416de13@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Bug 1471904] Re: qemu fails under NeXTStep 3.3
 when accessing ROM in SCSI-Adapter am53c974
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1471904 <1471904@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Tue, 26 Jun 2018, Uwe Lienig wrote:
> the issue is still reproducible. I'm still eager to run this old beast
> because of an old database application that has not been converted to
> our new platform. There is an old NeXTStep Black Hardware that is
> running the sybase database. The frontend runs under NeXTStep intel.
> Using qemu would allow to remove some old i486 NeXTStep systems.

This reminds me to this:

http://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg00280.html

my reply to a patch submitted on list a few years ago that was needed to 
fix OpenStep (which might be the same for NeXTStep too) but at the end 
after several iterations it was not accepted due to fear that it may break 
backwards migration which was deemed more important than supporting old 
guests at the time. Maybe this could be reconsidered now if it fixes your 
problem or at least you can have a local fix.

The actual patch needed is just this:

http://lists.nongnu.org/archive/html/qemu-devel/2012-12/msg02360.html

from this series:

http://lists.nongnu.org/archive/html/qemu-devel/2012-12/msg02356.html

which is the last version I've found. You can discover the whole story and 
a lot of background info by searching the qemu-devel list archives for 
"Microport UNIX". For KVM, I think another set of patches are needed (or 
one of those patches) that are linked from one of those messages 
somewhere but I don't remember that.

This may not fix your SCSI problems but could be relevant to the other IDE 
bug mentioned in this bug but it was easier to reply to this email than 
trying to log into launchpad. Sorry for the noise if this turns out not to 
be relevant.

Regards,
BALATON Zoltan
