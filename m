Received: from eggs.gnu.org ([2001:4830:134:3::10]:33510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eMtt4-0000W8-6v
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eMtt3-0002HW-9Q
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:58:42 -0500
Date: Thu, 7 Dec 2017 11:58:27 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
References: <20171207084453.23773-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207084453.23773-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Dec 07, 2017 at 04:44:53PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/qemu-img.texi b/qemu-img.texi
> index fdcf120f36..3aa63aad55 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -57,6 +57,14 @@ exclusive with the @var{-O} parameters. It is currently required to also use
>  the @var{-n} parameter to skip image creation. This restriction may be relaxed
>  in a future release.
>  
> +@item --force-share (-U)
> +
> +If specified, qemu-img will open the image with shared permissions, which makes

Does 'texi' requires to quote tools like `qemu-img` (or single quotes),
to highlight them in documentation?

> +it less likely to conflict with a running guest's permissions due to image
> +locking. For example, this can be used to get the image information (with
> +'info' subcommand) when the image is used by a running guest. Note that this
> +could produce inconsistent result because of concurrent metadata changes, etc..

Super nit-pick:  an ellipsis[*] is three dots :-), so, when applying you
might want to: s/../.../

[*] https://dictionary.cambridge.org/dictionary/english/ellipsis

Regardless:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
