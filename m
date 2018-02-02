Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehd6k-0005VY-Ij
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehd6j-0003t1-H4
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:18:30 -0500
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
	<7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
	<9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
Date: Fri, 2 Feb 2018 18:18:17 +0300
MIME-Version: 1.0
In-Reply-To: <9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

31.01.2018 22:04, Max Reitz wrote:
> On 2018-01-29 19:43, Max Reitz wrote:
>> On 2018-01-22 11:41, Vladimir Sementsov-Ogievskiy wrote:
>>> To maintain load/store disabled bitmap there is new approach:
>>>
>>>   - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>>>   - store enabled bitmaps as "auto" to qcow2
>>>   - store disabled bitmaps without "auto" flag to qcow2
>>>   - on qcow2 open load "auto" bitmaps as enabled and others
>>>     as disabled (except in_use bitmaps)
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> ---
>> Thanks, looks very reasonable.  Applied to my block branch:
>>
>> https://github.com/XanClic/qemu/commits/block
> ...aaand I've only just now seen that iotest 176 will need to be fixed
> along with this, so I'm going to unqueue this patch for now.

ohh, sorry for that. Will resend today.

>
> And when I'm already at it: Should we add deprecation information to
> qemu-doc.texi?

didn't find anything in qemu-doc.texi about dirty bitmaps, so I think, no.

Is there a way to generate some documentation files from qapi comments? 
Where is it?

>
> Max
>



-- 
Best regards,
Vladimir
