Received: from eggs.gnu.org ([2001:4830:134:3::10]:42198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVc0O-0004XG-MV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVc0J-0005fr-OW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:10:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-16-eblake@redhat.com>
	<22ecdb2a-1402-f487-073a-5b368dd2c4b1@virtuozzo.com>
Message-ID: <20c79486-96ee-9543-f27e-ab0fe4a7b760@virtuozzo.com>
Date: Thu, 13 Jul 2017 14:09:53 +0300
MIME-Version: 1.0
In-Reply-To: <22ecdb2a-1402-f487-073a-5b368dd2c4b1@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 15/18] qcow2: Switch load_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

13.07.2017 14:03, Vladimir Sementsov-Ogievskiy wrote:
> 13.07.2017 04:05, Eric Blake wrote:
>> Now that we have adjusted the majority of the calls this function
>> makes to be byte-based, it is easier to read the code if it makes
>> passes over the image using bytes rather than sectors.
>>
>> Signed-off-by: Eric Blake<eblake@redhat.com>
>> Reviewed-by: John Snow<jsnow@redhat.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> -- 
> Best regards,
> Vladimir

stolen whitespace here


-- 
Best regards,
Vladimir
