Received: from eggs.gnu.org ([2001:4830:134:3::10]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGngx-0005V8-AP
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGngw-0004gU-Ja
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:36:43 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
	<e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
	<4a281f99-0a86-e965-3790-2424cf3c277c@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <69700814-f013-821a-c58c-fff2be364152@virtuozzo.com>
Date: Fri, 2 Jun 2017 17:34:48 +0300
MIME-Version: 1.0
In-Reply-To: <4a281f99-0a86-e965-3790-2424cf3c277c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/15] file-posix: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com, qemu-block@nongnu.org


On 06/01/2017 10:54 PM, Eric Blake wrote:
> On 06/01/2017 02:49 PM, Eric Blake wrote:
>> On 06/01/2017 10:14 AM, Anton Nefedov wrote:
>>> Current write_zeroes implementation is good enough to satisfy this flag too
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>>   block/file-posix.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> Are we sure that fallocate() is always fast, or are there some file
>> systems where it is no faster than manually writing zeroes?  I'm worried
>> that blindly claiming BDRV_REQ_ALLOCATE may fail if we encounter a libc
> 
> not so much fail as in "break the guest", but fail as in "take far more
> time than we were expecting, pessimising our behavior to worse than if
> we had not tried the allocation at all"
> 
>> or kernel-based fallback that takes a slow patch on our behalf.
>>
> 

I would expect such filesystems to not support fallocate.

Though I must admit I can't see anywhere in the documentation that it 
MUST be strictly faster than writing zeroes; it would look very strange
to me if there were a slowpath fallback somewhere past the libc.

/Anton
