Received: from eggs.gnu.org ([209.51.188.92]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gkU9c-0004tW-OV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gkU9b-0004ox-9l
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:25:48 -0500
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20190102025904.GH27457@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <41c0bc74-a976-93e1-1104-99b191934d89@ilande.co.uk>
Date: Fri, 18 Jan 2019 13:25:37 +0000
MIME-Version: 1.0
In-Reply-To: <20190102025904.GH27457@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] target/ppc: remove various endian
 hacks from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/01/2019 02:59, David Gibson wrote:

> On Fri, Dec 28, 2018 at 01:52:27PM +0000, Mark Cave-Ayland wrote:
>> >From working on the TCG vector operations patchset, it is apparent that there
>> are a large number of endian-based hacks in int_helper.c which can be removed by
>> making use of the various Vsr* macros.
>>
>> Patch 1 is simple enough, and implements the complete set of Vsr* macros for
>> both big endian and little endian hosts.
>>
>> Patches 2 and 3 rework the vector merge and multiply algorithms so that they
>> no longer require the endian-dependent HI_IDX and LO_IDX macros.
>>
>> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macros by
>> replacing the element accesses with their equivalent Vsr* macro instead.
>>
>> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shift bug
>> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the review of
>> v1.
>>
>> Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIGENDIAN
>> hacks in int_helper.c, again replacing accesses with the relevant Vsr* macro
>> instead.
>>
>> Note that there are still some endian hacks left in int_helper.c after this
>> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I macro still
>> remains in places where the index variable was used for purposes other than
>> accessing elements within the vector.
>>
>> There were also some parts where additional conversion could be done, but I
>> wasn't confident enough to make the change without access to PPC64 test images
>> or real big-endian host hardware.
> 
> Applied to ppc-for-4.0, thanks.

Just checking your ppc-for-4.0 branch on github, I can't see where this has been
applied? Is it queued in a local branch still?


ATB,

Mark.
