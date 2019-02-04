Received: from eggs.gnu.org ([209.51.188.92]:50956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqk7I-0007yp-7e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqjxA-0003jA-OQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:30:50 -0500
References: <20190204160928.11209-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ff802d20-1f6f-4b2e-c77c-19b66380f46b@redhat.com>
Date: Mon, 4 Feb 2019 14:30:37 -0500
MIME-Version: 1.0
In-Reply-To: <20190204160928.11209-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dirty-bitmap: Expose persistent flag to
 'query-block'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, andrey.shinkevich@virtuozzo.com, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/4/19 11:09 AM, Eric Blake wrote:
> Since qemu currently doesn't flush persistent bitmaps to disk until
> shutdown (which might be MUCH later), it's useful if 'query-block'
> at least shows WHICH bitmaps will (eventually) make it to persistent
> storage.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Agree that we want this anyway.

Reviewed-by: John Snow <jsnow@redhat.com>
