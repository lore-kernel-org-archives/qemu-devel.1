Received: from eggs.gnu.org ([2001:4830:134:3::10]:57872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCOD0-0002Gb-PI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCOCy-0005YM-E9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:12:22 -0400
Date: Tue, 16 Oct 2018 14:12:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181016121204.GE5620@dhcp-200-186.str.redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015172817.19796-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] option: Make option help
 nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 15.10.2018 um 19:28 hat Max Reitz geschrieben:
> This adds some whitespace into the option help (including indentation)
> and replaces '=' by ': ' (not least because '=' should be used for
> values, not types).  Furthermore, the list name is no longer printed as
> part of every line, but only once in advance, and only if the caller did
> not print a caption already.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

If this isn't a bike shedding series, then what is? So...

> --- a/tests/qemu-iotests/082.out
> +++ b/tests/qemu-iotests/082.out
> @@ -44,171 +44,171 @@ cluster_size: 8192
>  
>  Testing: create -f qcow2 -o help TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size

I like the result of this series better than what we have in current
master. Looking at this patch, however, I must also say that I like the
original state better than both.

How about aligning the description to the same column again to combine
the best of both worlds?

Kevin
