Received: from eggs.gnu.org ([2001:4830:134:3::10]:54384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drRwg-0001yV-4i
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drRwd-0003hR-32
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:52:26 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911105729.GC2784@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1d0c4384-fc32-05bb-7e42-44480f51610f@ilande.co.uk>
Date: Mon, 11 Sep 2017 17:52:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170911105729.GC2784@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/09/17 11:57, David Gibson wrote:

> On Sun, Sep 10, 2017 at 03:37:34PM +0100, Mark Cave-Ayland wrote:
>> This is referenced in cpu_ppc_handle_mmu_fault() and so should be included
>> in the migration stream.
> 
> That is not, on its own, sufficient reason.
> 
>> Note: the vmstate_ppc version number has already been bumped by the previous
>> patch in this series.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> As with 2/4 it breaks backwards migration.
> 
> But more, I really disklike the idea of migrating this.  It's internal
> state for one, and it's also essentially transitory state.  Can we
> avoid putting it in the otherwise persistent structure at all? Can we
> derive the state from elsewhere?  Can we prevent migration from
> occurring in the small windows where this data is live?

>From what I can see references to access_type are scattered throughout
mmu_helper.c although I'm not necessarily familiar enough with PPC to
know whether this is something that can be derived elsewhere instead.
And once again it was something that was removed by a90db15.

When pausing a VM, does execution stop at the end of the current TB
rather than immediately? If so, perhaps someone could confirm that
guarantee is good enough for access_type?


ATB,

Mark.
