Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlBDN-0007Er-Ly
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlBDJ-00080K-Q3
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:47:45 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170824120601.26963-6-el13635@mail.ntua.gr>
References: <20170824120601.26963-1-el13635@mail.ntua.gr>
	<20170824120601.26963-6-el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 11:47:38 +0200
Message-ID: <w51wp5sugg5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu 24 Aug 2017 02:06:00 PM CEST, Manos Pitsidianakis wrote:
> +bool throttle_group_exists(const char *name)
> +{
> +    return throttle_group_by_name(name) != NULL;
> +}

I realized that you needed to add throttle_group_exists() after all
because you need it in block/throttle.c

>      /* error if name is duplicate */
> -    if (throttle_group_by_name(tg->name) != NULL) {
> +    if (throttle_group_exists(tg->name)) {
>          error_setg(errp, "A group with this name already exists");
>          return;
>      }

In that case you can also add it directly in patch #4 so you don't need
to change this line here.

But I won't oppose if you prefer to keep it like this, so either way

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
