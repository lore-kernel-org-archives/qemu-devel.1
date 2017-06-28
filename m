Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBni-0002ZW-KF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBnc-0005L6-Pi
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:10:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14333 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBnc-0005K9-Dy
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:10:24 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-14-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:10:08 +0300
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-14-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

28.06.2017 15:05, Vladimir Sementsov-Ogievskiy wrote:
> Add format driver handler, which should mark loaded read-only
> bitmaps as 'IN_USE' in the image and unset read_only field in
> corresponding BdrvDirtyBitmap's.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Reviewed-by: John Snow<jsnow@redhat.com>


Forgot to add:

Reviewed-by: Max Reitz<mreitz@redhat.com>


-- 
Best regards,
Vladimir
