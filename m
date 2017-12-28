Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQnk-00006q-4N
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQnj-0004Yo-Fj
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:32:20 -0500
Date: Thu, 28 Dec 2017 13:32:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228053203.GD9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-5-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 04/13] dirty-bitmap: add locked state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index fe27ddfb83..6218740c95 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
>      QemuMutex *mutex;
>      HBitmap *bitmap;            /* Dirty bitmap implementation */
>      HBitmap *meta;              /* Meta dirty bitmap */
> +    bool qmp_locked;                /* Bitmap is frozen, it can't be modified
> +                                   through QMP */

Please fix the alignment when you respin. Thanks.

Fam
