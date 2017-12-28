Received: from eggs.gnu.org ([2001:4830:134:3::10]:52223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQwt-0005mD-RI
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQws-0004Ql-Vp
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:41:47 -0500
Date: Thu, 28 Dec 2017 13:41:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228054131.GE9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-7-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-7-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 06/13] qapi: add dirty-bitmaps migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  qapi/migration.json   | 6 +++++-
>  migration/migration.h | 1 +
>  migration/migration.c | 9 +++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 03f57c9616..9f20b645a7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -352,12 +352,16 @@
>  #
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
> +# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
> +#                 (since 2.11)

s/2.11/2.12/

But it should be fine to keep all r-b lines when you update that, and add one
more:

Reviewed-by: Fam Zheng <famz@redhat.com>
