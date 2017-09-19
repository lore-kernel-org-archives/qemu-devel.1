Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duNsm-0007bW-Tt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duNsj-0002aK-Nr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:08:32 -0400
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
	<ab1516cb-9590-0833-b872-0e691e8ace49@redhat.com>
	<23cfaae7-7744-9865-6f43-9b74b2d60ec9@redhat.com>
	<a59a9f94-a8e1-29e0-8456-dbcd07b359b0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e431646d-808c-3eac-7cc6-b192fd1f0dc3@redhat.com>
Date: Tue, 19 Sep 2017 21:08:20 +0200
MIME-Version: 1.0
In-Reply-To: <a59a9f94-a8e1-29e0-8456-dbcd07b359b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Clean up some bad code
 in the vvfat driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 19.09.2017 21:01, John Snow wrote:
> 
> 
> On 09/19/2017 04:06 AM, Paolo Bonzini wrote:
>> On 13/09/2017 21:08, John Snow wrote:
>>>
>>>
>>> On 09/13/2017 06:21 AM, Thomas Huth wrote:
>>>> Remove the unnecessary home-grown redefinition of the assert() macro here,
>>>> and remove the unusable debug code at the end of the checkpoint() function.
>>>> The code there uses assert() with side-effects (assignment to the "mapping"
>>>> variable), which should be avoided. Looking more closely, it seems as it is
>>>> apparently also only usable for one certain directory layout (with a file
>>>> named USB.H in it) and thus is of no use for the rest of the world.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Farewell, bitrot code.
>>>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>
>>> Out of curiosity, I wonder ...
>>>
>>> jhuston@probe (foobar) ~/s/qemu> git grep '#if 0' | wc -l
>>> 320
>>
>>
>> $ git grep -c '#if 0' | sort -k2 --field-separator=: -n
>> ...
>> hw/net/eepro100.c:21
>> target/ppc/cpu-models.h:76
>>
>> whoa :)
>>
> 
> Wonder if '#if 0' should be against the style guide / in checkpatch.

checkpatch already complains if you have a "#if 0" in your patch, so I
think we should be pretty fine here already - but of course you can
still add a paragraph to the CODING_STYLE if you like.

 Thomas
