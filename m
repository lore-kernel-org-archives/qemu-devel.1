Received: from eggs.gnu.org ([2001:4830:134:3::10]:53173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxb3N-0001D3-Nk
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxb3J-0003L8-Oi
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:53:17 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
	<b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
Date: Wed, 05 Sep 2018 18:53:09 +0200
Message-ID: <w51sh2nzy16.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 08/10] block: Allow changing 'discard'
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon 03 Sep 2018 04:34:06 PM CEST, Alberto Garcia <berto@igalia.com> wrote:

> +    value = qemu_opt_get_del(opts, "discard");
> +    if (value != NULL) {
> +        if (bdrv_parse_discard_flags(value, &reopen_state->flags) != 0) {
> +            error_setg(errp, "Invalid discard option");
> +            ret = -EINVAL;
> +            goto error;
> +        }
> +    }

I just realized that we're leaking the string here. qemu_opt_get_del()
expects that the returned value is freed by the caller.

I'll correct all the patches from this series with this problem and
resend the series.

Berto
