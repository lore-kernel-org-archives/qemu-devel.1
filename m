Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpSmK-0001F4-5X
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpSmG-0004Xa-0q
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:21:32 -0400
References: <1504550378-2291-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504550378-2291-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170905011343.GD2735@umbus.fritz.box>
	<20170906031619.GE2735@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f6d2df4e-a67d-a601-40a1-0c9d0d610eec@ilande.co.uk>
Date: Wed, 6 Sep 2017 06:21:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170906031619.GE2735@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 06/09/17 04:16, David Gibson wrote:
> On Tue, Sep 05, 2017 at 11:13:43AM +1000, David Gibson wrote:
>> On Mon, Sep 04, 2017 at 07:39:38PM +0100, Mark Cave-Ayland wrote:
>>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>
>>> This adds a simplistic emulation of the Sun GEM ethernet controller
>>> found in Apple ASICs.
>>>
>>> Currently we only support the Apple UniNorth 1.x variant, but the
>>> other Apple or Sun variants should mostly be a matter of adding
>>> PCI IDs options.
>>>
>>> We have a very primitive emulation of a single Broadcom 5201 PHY
>>> which is supported by the MacOS driver.
>>>
>>> This model brings out-of-the-box networking to MacOS 9, and all
>>> versions of OS X I tried with the mac99 platform.
>>>
>>> Further improvements from Mark:
>>> - Remove sungem.h file, moving constants into sungem.c as required
>>> - Switch to using tracepoints for debugging
>>> - Split register blocks into separate memory regions
>>> - Use arrays in SunGEMState to hold register values
>>> - Add state-saving support
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Applied to ppc-for-2.11.
> 
> Until I discovered that it breaks compile with
> --enable-trace-backend=ust.   So I've removed it again.

Oh that's interesting. I've had --enable-trace-backend=simple as part of
my default build for a long while now, so I'm quite surprised that the
trace-events are backend sensitive.

Any clue as to what the error might be before I go and start installing
the relevant libraries?


ATB,

Mark.
