Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0P8Q-0005XR-UU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0P8Q-0007ZU-4V
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:13:50 -0400
References: <20180323164254.26487-1-pbonzini@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c99593ce-b8b6-2fc0-2e36-b3ad5f52128f@virtuozzo.com>
Date: Mon, 26 Mar 2018 13:13:36 +0300
MIME-Version: 1.0
In-Reply-To: <20180323164254.26487-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block: remove bdrv_dirty_bitmap_make_anon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

23.03.2018 19:42, Paolo Bonzini wrote:
> All this function is doing will be repeated by
> bdrv_do_release_matching_dirty_bitmap_locked, except
> resetting bm->persistent.  But even that does not matter
> because the bitmap will be freed.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
