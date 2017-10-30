Received: from eggs.gnu.org ([2001:4830:134:3::10]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D9r-0006YO-BT
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D9q-000625-Ke
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:43:27 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7cbeda36-a17d-4a7c-35fd-b56d2b380f79@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:43:15 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 05/12] nbd/server: Simplify
 nbd_negotiate_options loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

27.10.2017 13:40, Eric Blake wrote:
> Instead of making each caller check whether a transmission error
> occurred, we can sink a common error check to the end of the loop.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
