Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKJrY-000739-OG
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKJrX-00013J-Lr
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:06:28 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4941ea11-2349-832d-bc32-956566b65ac9@virtuozzo.com>
Date: Thu, 30 Nov 2017 11:06:17 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 03/20] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

12.10.2017 21:58, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the file protocol driver accordingly.
>
> In want_zero mode, we continue to report fine-grained hole
> information (the caller wants as much mapping detail as possible);
> but when not in that mode, the caller prefers larger *pnum and
> merely cares about what offsets are allocated at this layer, rather
> than where the holes live.  Since holes still read as zeroes at
> this layer (rather than deferring to a backing layer), we can take
> the shortcut of skipping lseek(), and merely state that all bytes
> are allocated.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
