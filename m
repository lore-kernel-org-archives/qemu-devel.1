Received: from eggs.gnu.org ([2001:4830:134:3::10]:59577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9DvT-0007SS-HJ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9DvS-00076J-OP
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:32:39 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9445173a-2fe4-1a7a-be2d-3c557575b079@virtuozzo.com>
Date: Mon, 30 Oct 2017 20:32:28 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 09/12] nbd/client: refactor
 nbd_receive_starttls
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
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Split out nbd_request_simple_option to be reused for structured reply
> option.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>


ok for me.

>
> ---
> v6: error message tweak [Vladimir]
> v5: only check length for ACK responses
> v4: reduce redundant traces, typo fix in commit message
> ---


-- 
Best regards,
Vladimir
