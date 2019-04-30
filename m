Received: from eggs.gnu.org ([209.51.188.92]:56531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPDd-0005nH-O1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPDc-0002Gg-SI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLPDc-0002GP-Lj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id b10so3004884wmj.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:38:32 -0700 (PDT)
Date: Tue, 30 Apr 2019 11:38:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190430093828.gu3b7yjyh447qw6j@steredhat>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> We often need to do read/write with buffer, not qiov. Instead of
> creating qiov in such cases, let's introduce corresponding helpers.
> 
> Vladimir Sementsov-Ogievskiy (9):
>   block: introduce byte-based io helpers
>   block/qcow2: use buffer-based io
>   block/qcow: use buffer-based io
>   block/qed: use buffer-based io
>   block/parallels: use buffer-based io
>   block/backup: use buffer-based io
>   block/commit: use buffer-based io
>   block/stream: use buffer-based io
>   qemu-img: use buffer-based io
> 
>  include/block/block_int.h      | 16 ++++++++++++++++
>  include/sysemu/block-backend.h | 19 +++++++++++++++++++
>  block/backup.c                 | 14 ++++++--------
>  block/commit.c                 |  5 ++---
>  block/parallels.c              | 14 ++++++--------
>  block/qcow.c                   | 19 ++++++-------------
>  block/qcow2.c                  |  9 ++-------
>  block/qed-table.c              | 12 +++++-------
>  block/qed.c                    |  6 ++----
>  block/stream.c                 |  4 +---
>  qemu-img.c                     | 13 ++++---------
>  11 files changed, 69 insertions(+), 62 deletions(-)
> 
> -- 
> 2.18.0
> 

The series LGTM and new helpers could be very useful!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
