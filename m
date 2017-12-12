Received: from eggs.gnu.org ([2001:4830:134:3::10]:45721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eOkNo-0004kp-1e
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eOkNn-0001BO-3g
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:14:04 -0500
Date: Tue, 12 Dec 2017 14:13:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171212131348.GE3879@localhost.localdomain>
References: <20171212005113.909-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212005113.909-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

Am 12.12.2017 um 01:51 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v4: "images". [Kevin]
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
> index fdcf120f36..d93501f94f 100644
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

Each time you read a text, you find something new...

s/result/results/

> +etc. This option is only allowed when opening images in read-only mode.
> +

Thanks, fixed the above and applied the patch to block-next.

Kevin
