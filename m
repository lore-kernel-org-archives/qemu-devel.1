Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dxSUz-000792-5L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dxSUw-00072k-0v
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:40:41 -0400
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1506264466-28252-7-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170926034706.GG12504@umbus>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <aaa2b280-4028-b593-e92a-5125d96fcbb6@ilande.co.uk>
Date: Thu, 28 Sep 2017 07:40:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170926034706.GG12504@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] mac_dbdma: change
 DBDMA_register_channel to a MAC_DBDMA type method
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

On 26/09/17 04:47, David Gibson wrote:

> On Sun, Sep 24, 2017 at 03:47:45PM +0100, Mark Cave-Ayland wrote:
>> Using this we can change the MACIO_IDE instance to register the channel
>> itself via a type method instead of requiring a separate
>> DBDMA_register_channel() function.
>>
>> As a consequence of this it is now possible to remove the old external
>> macio_ide_register_dma() function.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Ok, two concerns about this.
> 
> First, you've added the function pointer to the instance, not to the
> class, which is not how a QOM method would normally be done.

Yeah I did think about whether I needed to create a full class but was
torn since as you say there is only one implementation.

> More generally, though, why is a method preferable to a plain
> function?  AFAICT it's not plausible that there will ever be more than
> one implementation of the method.
> 
> Same comments apply to patch 7/7.

For me it's really for encapsulation. It seems a little odd requiring a
global function to configure a QOM object to which I already have a
reference.

If I were to redo the last 2 patches using a proper class, would you
accept them?


ATB,

Mark.
