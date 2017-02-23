Received: from eggs.gnu.org ([2001:4830:134:3::10]:40477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgsf2-0006Sy-5Z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgsf1-0008IF-I5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:38:16 -0500
Date: Thu, 23 Feb 2017 13:38:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170223123807.GD6931@noname.redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-9-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221115512.21918-9-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/18] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Am 21.02.2017 um 12:55 hat Daniel P. Berrange geschrieben:
> Instead of requiring separate input/output buffers for
> encrypting data, change encrypt_sectors() to assume
> use of a single buffer, encrypting in place. One current
> caller uses the same buffer for input/output already
> and the other two callers are easily converted to do so.
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

> @@ -734,21 +729,15 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
>          if (bs->encrypted) {
>              Error *err = NULL;
>              assert(s->cipher);
> -            if (!cluster_data) {
> -                cluster_data = g_malloc0(s->cluster_size);
> -            }
> -            if (encrypt_sectors(s, sector_num, cluster_data, buf,
> +            if (encrypt_sectors(s, sector_num, buf,
>                                  n, true, &err) < 0) {

This fits in a single line now.

Other than that:
Reviewed-by: Kevinn Wolf <kwolf@redhat.com>
