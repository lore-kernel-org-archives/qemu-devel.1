Received: from eggs.gnu.org ([2001:4830:134:3::10]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eOKjm-0008RP-W5
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eOKjm-0006In-6J
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:51:03 -0500
Date: Mon, 11 Dec 2017 10:50:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171211095044.GA7707@localhost.localdomain>
References: <20171211093314.16974-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211093314.16974-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com, eblake@redhat.com

Am 11.12.2017 um 10:33 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v3: Document that the option is not allowed for read-write. [Stefan]
> 
> v2: - "code{qemu-img}". [Kashyap, Eric]
>     - "etc.." -> "etc.".
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/qemu-img.texi b/qemu-img.texi
> index fdcf120f36..d85ace73f0 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -57,6 +57,15 @@ exclusive with the @var{-O} parameters. It is currently required to also use
>  the @var{-n} parameter to skip image creation. This restriction may be relaxed
>  in a future release.
>  
> +@item --force-share (-U)
> +
> +If specified, @code{qemu-img} will open the image with shared permissions,
> +which makes it less likely to conflict with a running guest's permissions due
> +to image locking. For example, this can be used to get the image information
> +(with 'info' subcommand) when the image is used by a running guest. Note that
> +this could produce inconsistent result because of concurrent metadata changes,
> +etc. This option is only allowed when opening image in read-only mode.

I think "an image", "the image" or "images" could all work in this
context, but just "image" without an article doesn't.

Kevin
