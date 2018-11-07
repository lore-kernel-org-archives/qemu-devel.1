Received: from eggs.gnu.org ([2001:4830:134:3::10]:40794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKSeR-0004ew-2b
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKSeO-0002zn-Bo
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:34:03 -0500
Received: from chuckie.co.uk ([82.165.15.123]:35100
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gKSeO-0002uu-4K
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:34:00 -0500
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
	<20181103132509.GF24365@umbus.hotspot.internet-for-guests.com>
	<003301d47597$749c0340$5dd409c0$@ru>
	<20181106122036.GA24589@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <51e7dfce-1dfb-3adf-e35f-13da043244c4@ilande.co.uk>
Date: Wed, 7 Nov 2018 18:33:50 +0000
MIME-Version: 1.0
In-Reply-To: <20181106122036.GA24589@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'David Gibson' <david@gibson.dropbear.id.au>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: maria.klimushenkova@ispras.ru, qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, agraf@suse.de

On 06/11/2018 12:20, 'David Gibson' wrote:

> On Tue, Nov 06, 2018 at 09:10:45AM +0300, Pavel Dovgalyuk wrote:
>>> From: David Gibson [mailto:david@gibson.dropbear.id.au]
>>> On Tue, Oct 30, 2018 at 12:30:31PM +0300, Pavel Dovgalyuk wrote:
>>>> This patch fixes processing of mtmsr instructions in icount mode.
>>>> In this mode writing to interrupt/peripheral state is controlled
>>>> by can_do_io flag. This flag must be set explicitly before helper
>>>> function invocation.
>>>>
>>>> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
>>>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>>
>>> Applied to ppc-for-3.1, thanks.
>>
>> Thanks. What about this one
>> https://patchew.org/QEMU/20181030122134.11055.15711.stgit@pasha-VirtualBox/
>> There is a mess with the subject, but the code is ok :)
> 
> I've been procrastinating on that because I don't understand icount
> well enough to review it easily, and no-one has replied with
> Reviewed-by or Tested-by.

I've just sent a Tested-by tag for this - with icount enabled, QEMU will assert if an
instruction that alters interrupt state doesn't set can_do_io beforehand. With this
patch on top of ppc-for-3.1 then I can boot my OpenBIOS test images without QEMU
asserting in icount mode. Since it should have no effect without icount enabled, it
should be safe.

It might also be worth changing the title of the patch to "target/ppc: fix rfid
instruction for icount" so it matches its companion patch.


ATB,

Mark.
