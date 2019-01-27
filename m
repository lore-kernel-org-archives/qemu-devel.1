Received: from eggs.gnu.org ([209.51.188.92]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnfjI-00083P-6l
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 03:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnfjH-00084f-Ad
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 03:23:48 -0500
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20190102025904.GH27457@umbus.fritz.box>
	<41c0bc74-a976-93e1-1104-99b191934d89@ilande.co.uk>
	<20190120202824.GA2423@umbus>
	<38f72c0d-a64b-1ac5-d4cd-70c1a6087226@ilande.co.uk>
	<20190126015357.GD22942@umbus>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a3bdcb03-2737-211c-fd6a-68765196bc68@ilande.co.uk>
Date: Sun, 27 Jan 2019 08:23:19 +0000
MIME-Version: 1.0
In-Reply-To: <20190126015357.GD22942@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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

On 26/01/2019 01:53, David Gibson wrote:

> On Mon, Jan 21, 2019 at 05:15:20AM +0000, Mark Cave-Ayland wrote:
>> On 20/01/2019 20:28, David Gibson wrote:
>>> On Fri, Jan 18, 2019 at 01:25:37PM +0000, Mark Cave-Ayland wrote:
>>>> On 02/01/2019 02:59, David Gibson wrote:
>>>>
>>>>> On Fri, Dec 28, 2018 at 01:52:27PM +0000, Mark Cave-Ayland wrote:
>>>>>> >From working on the TCG vector operations patchset, it is apparent that there
>>>>>> are a large number of endian-based hacks in int_helper.c which can be removed by
>>>>>> making use of the various Vsr* macros.
>>>>>>
>>>>>> Patch 1 is simple enough, and implements the complete set of Vsr* macros for
>>>>>> both big endian and little endian hosts.
>>>>>>
>>>>>> Patches 2 and 3 rework the vector merge and multiply algorithms so that they
>>>>>> no longer require the endian-dependent HI_IDX and LO_IDX macros.
>>>>>>
>>>>>> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macros by
>>>>>> replacing the element accesses with their equivalent Vsr* macro instead.
>>>>>>
>>>>>> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shift bug
>>>>>> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the review of
>>>>>> v1.
>>>>>>
>>>>>> Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIGENDIAN
>>>>>> hacks in int_helper.c, again replacing accesses with the relevant Vsr* macro
>>>>>> instead.
>>>>>>
>>>>>> Note that there are still some endian hacks left in int_helper.c after this
>>>>>> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I macro still
>>>>>> remains in places where the index variable was used for purposes other than
>>>>>> accessing elements within the vector.
>>>>>>
>>>>>> There were also some parts where additional conversion could be done, but I
>>>>>> wasn't confident enough to make the change without access to PPC64 test images
>>>>>> or real big-endian host hardware.
>>>>>
>>>>> Applied to ppc-for-4.0, thanks.
>>>>
>>>> Just checking your ppc-for-4.0 branch on github, I can't see where this has been
>>>> applied? Is it queued in a local branch still?
>>>
>>> Yeah, probably.  I've pushed it out now.
>>
>> Thanks David. I've just had another quick look, and whilst I can see newer commits in
>> the branch, I think these ones belonging to this patchset are still
>> missing?
> 
> Um.. hrm.. in that case I think I've lost track of these ones :/

Looking back over my archives, I can see that Richard added a few more R-B tags after
v2. Probably the easiest way forward is for me to pick these up and re-send a v3 that
you can apply, so I'll go and do that.


ATB,

Mark.
