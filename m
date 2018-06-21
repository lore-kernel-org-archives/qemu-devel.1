Received: from eggs.gnu.org ([2001:4830:134:3::10]:50720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fW09I-0002Cf-4Y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fW09C-0003FM-1m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:20 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-5-david@redhat.com>
	<8f537d31-91df-99cc-624b-82434dc084ee@redhat.com>
	<a0f58d3e-7c79-f6be-782d-92cd5bbf7868@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1db448af-6dfc-9f56-1b03-b1b03cc50f61@redhat.com>
Date: Thu, 21 Jun 2018 16:01:10 +0200
MIME-Version: 1.0
In-Reply-To: <a0f58d3e-7c79-f6be-782d-92cd5bbf7868@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 4/7] s390x/tcg: SET CLOCK
 COMPARATOR can clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 21.06.2018 15:54, David Hildenbrand wrote:
> On 21.06.2018 14:09, Thomas Huth wrote:
>> On 20.06.2018 12:08, David Hildenbrand wrote:
[...]
>>>      if (time == -1ULL) {
>>
>> I wonder whether that check is still adequate? Is there really a way to
>> disable the clock comparator like this? At least I haven't seen it in
>> the PoP.
> 
> e.g. 4-61 (Control)
> 
> 4. When the clock-comparator sign control is zero,
> (a) the program can set the clock comparator to
> all zeros to ensure that an interruption condition
> is immediately present, and (b) the program can
> set the clock comparator to a value of all binary
> ones to ensure that a clock-comparator interrup-
> tion is never recognized. [...]
> 
> Rational from 4-59 (Control):
> 
> The clock comparator provides a means of causing
> an interruption when the TOD-clock value exceeds a
> value specified by the program.
> 
> We can never exceed all binary 1s. So it is really exceeding, not "hitting"

Thanks! ... maybe you could add a comment to the code with a pointer to
that section in the PoP while you're at it? (just if you agree that it
is useful)

 Thomas
