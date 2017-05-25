Received: from eggs.gnu.org ([2001:4830:134:3::10]:43695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDwzj-0004Pk-Ct
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDwzf-0008A5-Hu
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:56:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:1696 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDwzf-00089c-5v
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:56:15 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-2-vsementsov@virtuozzo.com>
	<3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
	<28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
	<7f22ab2c-e87a-ac26-fe47-7ba0068762c8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f912f7e7-085c-8e3f-4eed-c91bd6aceb8d@virtuozzo.com>
Date: Thu, 25 May 2017 20:56:08 +0300
MIME-Version: 1.0
In-Reply-To: <7f22ab2c-e87a-ac26-fe47-7ba0068762c8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

25.05.2017 20:46, Eric Blake wrote:
> On 05/25/2017 12:03 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 25.05.2017 19:32, Eric Blake wrote:
>>> On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Current comment is not clear enough: which sparseness is meant, coming
>>>> from sparse image format or from sparse file system?
>>>>
>>>> For example, if we have qcow2 above raw file on non-sparse file system,
>>>> this function will say nothing about unallocated (by qcow2 layer)
>>>> clusters.
>>>>
>>>> + * Size of allocated in underlying file system area. Sparseness is
>>>> taken into
>>> Doesn't read well.  Maybe: s/Size of allocated/Allocation size/ ?
>>>
>>>> + * account for sparse file systems. Return < 0 if error or unknown.
>>> I still don't get what we are trying to present.
>>>
>>> I think we still need to do a better job at writing a precise comment.
>>>
>> bdrv_get_allocated_file_size is not related to qcow2, as qcow2 doesn't
>> support it. So, it is finally just raw_get_allocated_file_size, which
>> returns st.st_blocks * 512 after fstat(s->fd).
>>
>> It will correspond to qcow2 sparseness if qcow2 discarded corresponding
>> clusters in bs->file and if underlying fs is sparse.
> Okay, that helps.  How about this wording:
>
> Allocation size of the underlying file system area.  Sparseness is taken
> into account (holes do not contribute to this size).  Return < 0 if
> error or unknown.
>
OK for me, thank you. Will use your wording if no other comments on this.



-- 
Best regards,
Vladimir
