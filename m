Received: from eggs.gnu.org ([2001:4830:134:3::10]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5V0x-0005mb-AT
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5V0w-0007lq-II
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:31:11 -0400
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
	<1522422996-14235-4-git-send-email-vsementsov@virtuozzo.com>
	<20180403133632.GC11070@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <92a757db-fa28-04ca-cd95-999b4cd5e1b0@virtuozzo.com>
Date: Mon, 9 Apr 2018 14:30:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180403133632.GC11070@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: blacklist bochs and cloop for
 205 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@openvz.org

03.04.2018 16:36, Kevin Wolf wrote:
> Am 30.03.2018 um 17:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Blacklist these formats, as they don't support image creation, as they
>> say:
>>      > ./qemu-img create -f bochs x 1m
>>      qemu-img: x: Format driver 'bochs' does not support image creation
>>
>>      > ./qemu-img create -f cloop x 1m
>>      qemu-img: x: Format driver 'cloop' does not support image creation
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> We can take this for now, but I think I would actually prefer a solution
> like in the bash tests, where the $IMGFMT_GENERIC environment variable
> is checked for "_supported_fmt generic".
>
> I suppose in Python test cases, we can assume that generic is meant when
> neither supported_fmts nor unsupported_fmts are given (or both are empty
> lists).
>
> Kevin

it may be ok for verify_image_format, as we can call it or not call (to 
support all formats).

but iotests main function always call verify_image_format, so, this will 
skip bochs and cloop for all
iotests which call maind() without format restriction.

So, I think it is safer to directly mimic bash tests behavior - allow 
'generic' as a member of supported_fmts.

-- 
Best regards,
Vladimir
