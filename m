Received: from eggs.gnu.org ([2001:4830:134:3::10]:54767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGkX-00047y-Pq
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGkX-0006Uv-1X
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:53:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
	<20170729164104.29537-4-vsementsov@virtuozzo.com>
Date: Mon, 14 Aug 2017 16:53:42 +0200
In-Reply-To: <20170729164104.29537-4-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Sat, 29 Jul 2017 19:41:04 +0300")
Message-ID: <87k226qjyh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/3] qemu-img check: add format
 allocation info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  6 +++++-
>  qemu-img.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 93f6995381..d662786261 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -249,6 +249,9 @@
>  #                       field is present if the driver for the image format
>  #                       supports it
>  #
> +# @format-alloc-info: Format-allocation information, see
> +#                     BlockFormatAllocInfo description. (Since: 2.11)

We don't usually add 'see the type'.  Would just

   # @format-alloc-info: Format allocation information

suffice?

> +#
>  # Since: 1.4
>  #
>  ##
> @@ -257,7 +260,8 @@
>             '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
>             '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
>             '*total-clusters': 'int', '*allocated-clusters': 'int',
> -           '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
> +           '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
> +           '*format-alloc-info': 'BlockFormatAllocInfo' } }
>  
>  ##
>  # @MapEntry:
[...]
