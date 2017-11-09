Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCimk-0000ec-5G
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCime-0001tj-I4
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:06:06 -0500
References: <20171108215703.9295-3-eblake@redhat.com>
	<20171108222337.12400-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9163cfc2-2cc9-b26e-696c-2cc0bae8a171@virtuozzo.com>
Date: Thu, 9 Nov 2017 12:05:50 +0300
MIME-Version: 1.0
In-Reply-To: <20171108222337.12400-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2.5/7] fixup! nbd-client: Refuse
 read-only client with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

09.11.2017 01:23, Eric Blake wrote:
> ...
>
> Fix several iotests to comply with the new behavior (since
> qemu-nbd of an internal snapshot, as well as nbd-server-add over QMP,
> default to a read-only export, we must tell blockdev-add/qemu-io to
> set up a read-only client).
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
