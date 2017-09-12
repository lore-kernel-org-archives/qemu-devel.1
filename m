Received: from eggs.gnu.org ([2001:4830:134:3::10]:53062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1droFp-00016u-Vz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1droFp-0000TC-4x
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:41:42 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box> <20170912162100.GD2225@work-vm>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
Date: Tue, 12 Sep 2017 17:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170912162100.GD2225@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/09/17 17:21, Dr. David Alan Gilbert wrote:

>> Right, a subsection is certainly necessary to avoid breaking backwards
>> migration.
>>
>> But apart from that I want to understand better exactly why this is
>> necessary.  What's the state that's being lost, and is it really not
>> recoverable from anywhere else.
>>
>> The other thing that concerns me is how we're encoding the
>> information.  These are essentially internal fields, not reflecting
>> something with an architected encoding - adding those to the migration
>> stream is often a bad idea - it inhibits our ability to rework
>> internal encodings.
> 
> Yes, agreed, where possible the contents of the stream should reflect
> 'real' state that's actually being modelled and be as independent of
> the implementation as possible.

Oh sure. However I should re-iterate that I'm not trying to add new
fields into the migration stream, merely reinstate the ones that were
dropped without warning in commit a90db15 by Alexey since without them
TCG state doesn't restore correctly in my local tests.

The commit message mentions that prior to the conversion some CPU state
was missing but it doesn't mention anything about dropping existing
fields as part of the conversion process so I suspect that this was an
accidental side-effect.

I can definitely look at re-implementing the patch using a subsection in
order to preserve backwards compatibility though.


ATB,

Mark.
