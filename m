Received: from eggs.gnu.org ([2001:4830:134:3::10]:58920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etsko-0008Gi-C7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etskj-00004w-F7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:26:30 -0500
Date: Thu, 8 Mar 2018 11:26:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180308061707.GP3083@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1803081124250.30088@zero.eik.bme.hu>
References: <20180307205427.3A2877456C6@zero.eik.bme.hu>
	<20180308061707.GP3083@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] ppc440_pcix: Add dummy implementation of
 BRDGOPT registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>

On Thu, 8 Mar 2018, David Gibson wrote:
> On Wed, Mar 07, 2018 at 09:43:59PM +0100, BALATON Zoltan wrote:
>> I don't know what should be the correct implementation for these so
>> these are just stored and returned as is without doing anything for
>> now only to silence warnings when u-boot accesses these registers.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> I'm a bit dubious about putting in a dummy register implementation.
> Specifically, I think the case needs to be made that the dummy
> implementation is preferable to just putting up with the test errors.
>
> At the very least there should be a comment in the code indicating
> that it's just a dummy stub implementation.

Let's go with changing the error_report to qemu_log_mask(LOG_UNIMP, ...) 
as suggested by Thomas instead. I'll send another patch.

Regards,
BALATON Zoltan
