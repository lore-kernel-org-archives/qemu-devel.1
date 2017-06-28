Received: from eggs.gnu.org ([2001:4830:134:3::10]:60339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQD8w-0002Kq-6W
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQD8s-0006n2-9X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:36:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623124700.1389-6-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
Date: Wed, 28 Jun 2017 15:35:48 +0200
Message-ID: <w51h8z01bgr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
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

On Fri 23 Jun 2017 02:46:57 PM CEST, Manos Pitsidianakis wrote:

> +# @BlockdevOptionsThrottle:
> +#
> +# Driver specific block device options for Throttle
> +#

I would put this earlier in the json file, together with the rest of the
BlockdevOptions* structs.

> +# @throttling-group: the name of the throttling group to use

Why not call it simply "group" ?

> +#
> +# @options:        BlockIOThrottle options
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsThrottle',
> +  'data': { 'throttling-group': 'str',
> +            'file' : 'BlockdevRef',
> +            '*options' : 'BlockIOThrottle'
> +             } }

Not sure if 'file' is the best name for the field ("child"?), but I'm
fine with it.

Berto
