Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVbzi-0003s5-7l
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVbzd-0005Op-AX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:09:18 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-17-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <406fd8eb-820d-2511-f4de-630c5d5d724a@virtuozzo.com>
Date: Thu, 13 Jul 2017 14:09:10 +0300
MIME-Version: 1.0
In-Reply-To: <20170713010555.6769-17-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 16/18] qcow2: Switch store_bitmap_data()
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

13.07.2017 04:05, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
