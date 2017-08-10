Received: from eggs.gnu.org ([2001:4830:134:3::10]:40914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfohX-0000vM-8p
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfohU-0006qa-4e
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:44:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809100734.17540-5-el13635@mail.ntua.gr>
References: <20170809100734.17540-1-el13635@mail.ntua.gr>
	<20170809100734.17540-5-el13635@mail.ntua.gr>
Date: Thu, 10 Aug 2017 16:44:36 +0200
Message-ID: <w51y3qrwkh7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/7] block: convert ThrottleGroup to
 object with QOM
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

On Wed 09 Aug 2017 12:07:31 PM CEST, Manos Pitsidianakis wrote:
> +    /* unfix buckets to check validity */
> +    throttle_get_config(&tg->ts, cfg);
> +    if (!throttle_is_valid(cfg, errp)) {
> +        return;
> +    }
> +    /* fix buckets again */
> +    throttle_config(&tg->ts, tg->clock_type, cfg);

Ugh, this whole fix/unfix buckets should be transparent to outside users
of throttle.c.

You can leave this here for now but I'll think of a way to eliminate the
need to do this.

Berto
