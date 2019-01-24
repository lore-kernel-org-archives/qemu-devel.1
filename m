Received: from eggs.gnu.org ([209.51.188.92]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gmixc-0003hF-Md
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gmixZ-0002W2-Fw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:40 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<e18d32e6-4c6f-1d42-7e90-ef9d84721524@tuxfamily.org>
	<3d217d08-56c9-4bab-f897-9ebe67910168@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e400f594-288d-38bb-2b15-4d7d50bfcf76@ilande.co.uk>
Date: Thu, 24 Jan 2019 17:37:59 +0000
MIME-Version: 1.0
In-Reply-To: <3d217d08-56c9-4bab-f897-9ebe67910168@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net

On 24/01/2019 17:15, Laurent Vivier wrote:

> On 24/01/2019 18:02, Thomas Huth wrote:
>> On 2018-11-02 16:22, Mark Cave-Ayland wrote:
>>> (MCA: here's the latest version of the q800 patchset. I've hope that I've
>>> addressed most of the comments, plus this will now boot into the Debian
>>> installer correctly when applied to git master.
>>
>> Any update on this series? Why did it get stalled again?
>>
> 
> I was thinking about this today.
> 
> Mark, perhaps you can send a rebased version of the series?
> 
> I think we need reviews for "esp: add pseudo-DMA as used by Macintosh".

I've just done a quick rebase and push of my latest branch to
https://github.com/mcayland/qemu/tree/q800-dev-part1-mca and from what I can tell it
still boots using the test command line in both graphic and -nographic mode.

Unfortuantely I have a lot less time this dev cycle than normal, so I'm going to hand
this back over to Laurent for now while I focus back on SPARC/PPC. From my notes the
outstanding things to look at are:


1) Do we mind some of the more verbose comments that were taken from the Linux
headers in some of the files? (I can also see that updates to the comment checking in
checkpatch.pl now cause the series to fail with style issues, so these will need to
be touched up regardless)

2) Do we need to add migration support for the ESP pseudo-DMA?

3) Is there a Linux test docker image available?


Other than these points I think the series is about good to go.


ATB,

Mark.
