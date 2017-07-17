Received: from eggs.gnu.org ([2001:4830:134:3::10]:41360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWwpY-000775-2Z
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWwpX-0005CF-De
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:36:20 -0400
Date: Mon, 17 Jul 2017 11:36:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717033608.GC22872@lemon>
References: <20170629132749.997-1-pbonzini@redhat.com>
	<20170629132749.997-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629132749.997-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] qed: introduce bdrv_qed_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu, 06/29 15:27, Paolo Bonzini wrote:
> diff --git a/block/qed.c b/block/qed.c
> index db390efdbd..8228a50f68 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -363,6 +363,15 @@ static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
>      }
>  }
>  
> +static void bdrv_qed_init_state(BlockDriverState *bs)
> +{
> +    BDRVQEDState *s = bs->opaque;

This line should be in the next patch, to keep the compiler happy
(-Wunused-variable). I'll fix it when sending pull request.

> +
> +    memset(s, 0, sizeof(BDRVQEDState));
> +    s->bs = bs;
> +    qemu_co_queue_init(&s->allocating_write_reqs);
> +}
> +

Fam
