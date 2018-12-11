Received: from eggs.gnu.org ([2001:4830:134:3::10]:36262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnIr-0003cZ-Cq
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnIm-0003tF-7O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:02:45 -0500
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
	<20181210034642.GJ4261@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3a6b0293-7c58-acab-d4be-daed3f5cfc65@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:00:59 +0000
MIME-Version: 1.0
In-Reply-To: <20181210034642.GJ4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/12/2018 03:46, David Gibson wrote:

> On Fri, Dec 07, 2018 at 04:08:05PM +0000, Mark Cave-Ayland wrote:
>> This is in preparation for some upcoming QEMU NDRV driver changes that pass
>> display information from the host to the guest.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> This looks fine by my limited knowledge of this area.  I'm slightly
> perturbed I can't see any existing examples in the tree of setting the
> edid property from the machine.

Certainly both patches work in that the corresponding MemoryRegion appears in both
machines when applied, and indeed now also I have guest code that can read from it too.


ATB,

Mark.
