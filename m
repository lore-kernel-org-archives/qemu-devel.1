Received: from eggs.gnu.org ([2001:4830:134:3::10]:40044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxt7W-0000JG-7P
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxt7T-0006H4-5Z
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:33:58 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cxt7S-0006G1-PE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:33:55 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170405151148.16363-8-stefanha@redhat.com>
References: <20170405151148.16363-1-stefanha@redhat.com>
	<20170405151148.16363-8-stefanha@redhat.com>
Date: Tue, 11 Apr 2017 12:33:49 +0200
Message-ID: <w51fuhfz10y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 05 Apr 2017 05:11:46 PM CEST, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> +    QemuOptsList *create_opts = NULL;
> +    bool image_opts = false;
> +    uint64_t img_size = ~0ULL;

Any reason to use ~0ULL instead of UINT64_MAX ?

> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -429,6 +429,31 @@ preallocated.
>  For more information, consult @file{include/block/block.h} in QEMU's
>  source code.
>  
> +@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
> +
> +Calculate the file size required for a new image.  This information can be used
> +to size logical volumes or SAN LUNs appropriately for the image that will be
> +placed in them.  The values reported are guaranteed to be large enough to fit
> +the image.

It's already explained for other commands, but don't you want to mention
what ofmt, output_fmt, etc., mean?

Berto
