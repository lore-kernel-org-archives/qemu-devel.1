Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPWXf-0000pB-23
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPWXb-00026O-0A
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:07:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24601 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dPWXa-00025P-Kq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:07:06 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:07:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170605123908.18777-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 16/19] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

HI!

One question here, should not 'bdrv_undo_clear_dirty_bitmap' be under 
lock too?

05.06.2017 15:39, Paolo Bonzini wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   block/dirty-bitmap.c         | 68 ++++++++++++++++++++++++++++++++++++++------
>   block/mirror.c               | 11 +++++--
>   include/block/block_int.h    |  4 +--
>   include/block/dirty-bitmap.h | 25 +++++++++++-----
>   migration/block.c            | 10 ++++---
>   5 files changed, 94 insertions(+), 24 deletions(-)

-- 
Best regards,
Vladimir
