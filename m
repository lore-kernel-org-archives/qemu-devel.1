Received: from eggs.gnu.org ([2001:4830:134:3::10]:35473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cigjB-0000hm-5F
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cigj7-0001Kb-Vd
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:18:01 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170228111935.10826-3-stefanha@redhat.com>
References: <20170228111935.10826-1-stefanha@redhat.com>
	<20170228111935.10826-3-stefanha@redhat.com>
Date: Tue, 28 Feb 2017 13:17:55 +0100
Message-ID: <w51innu5x1o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] throttle: make
 throttle_config(throttle_get_config()) symmetric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org

On Tue 28 Feb 2017 12:19:35 PM CET, Stefan Hajnoczi wrote:
> +/* undo internal bucket parameter changes (see throttle_fix_bucket()) */
> +static void throttle_unfix_bucket(LeakyBucket *bkt)
> +{
> +    double min = bkt->avg / 10;
> +
> +    if (bkt->max == min) {
> +        bkt->max = 0;
> +    }
> +}

I guess you could do the more general if (bkt->max < bkt->avg), but your
solution is also fine with me.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
