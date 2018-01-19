Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecTSj-0006tc-Tm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecTSj-00076i-1D
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:59:54 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<20180118181123.37056-3-vsementsov@virtuozzo.com>
	<35482a43-af44-9134-f112-30cf0cb135be@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c8c3ffce-f765-d8ef-c1c4-e7f277dec0b1@virtuozzo.com>
Date: Fri, 19 Jan 2018 12:59:38 +0300
MIME-Version: 1.0
In-Reply-To: <35482a43-af44-9134-f112-30cf0cb135be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] hmp: add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

19.01.2018 00:08, Eric Blake wrote:
> On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Support name parameter for HMP too.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   hmp.c           | 3 ++-
>>   hmp-commands.hx | 9 +++++----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> +++ b/hmp-commands.hx
>> @@ -1553,8 +1553,8 @@ ETEXI
>>   
>>       {
>>           .name       = "nbd_server_add",
>> -        .args_type  = "writable:-w,device:B",
>> -        .params     = "nbd_server_add [-w] device",
>> +        .args_type  = "name:-n,writable:-w,device:B",
>> +        .params     = "nbd_server_add [-n] [-w] device",
> Doesn't quite look like my proposal:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01639.html
>
> -        .args_type  = "writable:-w,device:B",
> -        .params     = "nbd_server_add [-w] device",
> +        .args_type  = "writable:-w,device:B,name:s?",
> +        .params     = "nbd_server_add [-w] device [name]",
>
> In fact, using -n is not quite right, because that's just a boolean flag
> rather than a string.
>

Strange, I don't have your letter. Let's use yours, of course.

-- 
Best regards,
Vladimir
