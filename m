Received: from eggs.gnu.org ([2001:4830:134:3::10]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eAUse-0003Bx-52
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 01:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eAUsa-00064N-QU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 01:51:00 -0400
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
	<20171101154204.27146-2-vsementsov@virtuozzo.com>
	<0f8feedf-9650-f004-dae0-c658759588d9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e78e2506-a9e3-f4a4-f752-75089e247a71@virtuozzo.com>
Date: Fri, 3 Nov 2017 08:50:49 +0300
MIME-Version: 1.0
In-Reply-To: <0f8feedf-9650-f004-dae0-c658759588d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: add assert to
 nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org

02.11.2017 21:06, Eric Blake wrote:
> On 11/01/2017 10:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add an assert here to make last length assignment meaningful and
>> following return without tail dropping obvious.
> Not quite sure I followed your explanation, which means it's difficult
> for me to propose an alternative wording.  Maybe:
>
> Add an assert here to make it obvious that the prior loop consumed the
> rest of the input, and that all further code in the function is focused
> on output.
>
> On the other hand, if you are okay with it, I wouldn't mind squashing
> the first and second patches into one (as the first patch is then easier
> to read when it is obvious that we used the wrong length variable).  But
> until I get your feedback (on either squashing the two patches or
> tweaking the wording), I'm just placing your patches as-is on my NBD
> queue for inclusion prior to rc0.


in commit message I mean two things:
1. assignment to length in the previous loop is useless without an assert
2. firstly I thought that the following return statement is a bug as it 
doesn't
drop payload tail. And only then I noticed previous "if (requests != 
length / sizeof(request))".
With an assert the correctness of the code is more evident.

However you may reword or squash it as you want, all is good.

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 1 +
>>   1 file changed, 1 insertion(+)
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


-- 
Best regards,
Vladimir
