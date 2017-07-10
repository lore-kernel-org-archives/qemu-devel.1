Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUYcp-0007Vd-L9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUYco-0005fU-Le
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:21:19 -0400
Date: Mon, 10 Jul 2017 15:21:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170710132106.GF5772@noname.redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-5-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498733831-15254-5-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2 4/8] qemu-img: add documentation for
 compress settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com

Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.texi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 5b925ec..430f0b9 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -621,6 +621,27 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
>  by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
>  the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
>  
> +@item compress.format
> +Defines which compression algorithm is should be used for compressed clusters.
> +The following options are available if support for the respective libraries
> +has been enabled at compile time:
> +
> +   zlib            Uses standard zlib compression
> +
> +The compression algorithm can only be defined at image create time and cannot
> +be changed later.
> +
> +Note: defining a compression format will result in the compression format
> +      extension being written to the Qcow2 image. Older versions of QEMU will
> +      not be able to open images with this extension.

Why not more specifically "QEMU versions before 2.10"?

> +@item compress.level
> +Defines which compression level is used for the selected compression format.
> +The default of @code{compress.level=0} will use the default compression level
> +for the format. Alternate values range from 1 for fastest compression to
> +x for the best compression (x max vary between compression formats). This is
> +always a trade in of compression speed against compressed size.

Start with something like "valid for compress.format=zlib" and then give
the exact range of valid values for zlib.

Kevin
