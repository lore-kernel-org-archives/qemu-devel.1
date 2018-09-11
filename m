Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziLc-000847-GG
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziIn-0004h6-RZ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:02:01 -0400
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-2-mark.cave-ayland@ilande.co.uk>
	<20180911012726.GB7978@umbus.fritz.box>
	<20180911063834.GA19292@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b1a1feb-c23b-63f1-457d-905b951dace3@redhat.com>
Date: Tue, 11 Sep 2018 15:01:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180911063834.GA19292@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] lsi53c895a: add optional external
 IRQ via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 11/09/2018 08:38, Fam Zheng wrote:
> On Tue, 09/11 11:27, David Gibson wrote:
>> On Mon, Sep 10, 2018 at 09:46:30PM +0100, Mark Cave-Ayland wrote:
>>> On some early machines the on-board PCI devices IRQs are wired directly to
>>> the interrupt controller instead of via the PCI host bridge.
>>>
>>> Add an optional external IRQ that if wired up via qdev will replace the
>>> in-built PCI IRQ.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Fam, if I get an Acked-by from you I'm happy to take this through my tree.
> 
> This looks good to me, but I'm only 'R:' of scsi code. You'd perhaps need Paolo
> to ack.

Not really. :)  Mark, go ahead!

Paolo
