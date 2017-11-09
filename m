Received: from eggs.gnu.org ([2001:4830:134:3::10]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiX2-0004is-Im
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiX1-0002VG-Ob
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:49:52 -0500
References: <20171107030912.23930-1-eblake@redhat.com>
	<20171107030912.23930-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d684d752-3ca9-9d14-b75e-59485962924f@virtuozzo.com>
Date: Thu, 9 Nov 2017 11:49:39 +0300
MIME-Version: 1.0
In-Reply-To: <20171107030912.23930-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: Optimize final chunk of
 sparse read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com

07.11.2017 06:09, Eric Blake wrote:
> If we are careful to handle 0-length read requests correctly,
> we can optimize our sparse read to send the NBD_REPLY_FLAG_DONE
> bit on our last OFFSET_DATA or OFFSET_HOLE chunk rather than
> needing a separate chunk.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
