Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpeXN-0001LA-CS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpeXI-0002DR-IE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:54:53 -0400
References: <1504550378-2291-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504550378-2291-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170905011343.GD2735@umbus.fritz.box>
	<20170906031619.GE2735@umbus.fritz.box>
	<f6d2df4e-a67d-a601-40a1-0c9d0d610eec@ilande.co.uk>
	<20170906065658.GF2735@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <60641d50-0156-e834-9379-1d36753bf6bc@ilande.co.uk>
Date: Wed, 6 Sep 2017 18:54:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170906065658.GF2735@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] net: Add SunGEM device emulation as
 found on Apple UniNorth
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

On 06/09/17 07:56, David Gibson wrote:

>>>> Applied to ppc-for-2.11.
>>>
>>> Until I discovered that it breaks compile with
>>> --enable-trace-backend=ust.   So I've removed it again.
>>
>> Oh that's interesting. I've had --enable-trace-backend=simple as part of
>> my default build for a long while now, so I'm quite surprised that the
>> trace-events are backend sensitive.
>>
>> Any clue as to what the error might be before I go and start installing
>> the relevant libraries?
> 
> Not so far.  I'd investigate myself, but I'm actually really sick
> right now.

Okay, got it - it's because I'd used hwaddr and HWADDR_PRI in
trace-events and of course those types don't exist outside of QEMU.
Switching them over to uint64_t seems to do the trick, so I'll send a v2
shortly.

Hope you feel better soon.


ATB,

Mark.
