Received: from eggs.gnu.org ([2001:4830:134:3::10]:48253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3nwx-0005f6-AQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3nws-0005St-Ds
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:15:31 -0400
Received: from mail.kernel.org ([198.145.29.136]:42576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d3nws-0005SV-7g
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:15:26 -0400
Date: Thu, 27 Apr 2017 11:15:22 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <149328634220.30266.1628882080436632549.stgit@bahia>
Message-ID: <alpine.DEB.2.10.1704271115150.11141@sstabellini-ThinkPad-X260>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
	<149328634220.30266.1628882080436632549.stgit@bahia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 1/4] fsdev: don't allow unknown format
 in marshal/unmarshal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 27 Apr 2017, Greg Kurz wrote:
> The code only uses well known format strings. An unknown format token is a
> bug.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  fsdev/9p-iov-marshal.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
> index 1d16f8df4bd4..a1c9beddd2e7 100644
> --- a/fsdev/9p-iov-marshal.c
> +++ b/fsdev/9p-iov-marshal.c
> @@ -168,7 +168,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
>              break;
>          }
>          default:
> -            break;
> +            g_assert_not_reached();
>          }
>          if (copied < 0) {
>              return copied;
> @@ -281,7 +281,7 @@ ssize_t v9fs_iov_vmarshal(struct iovec *in_sg, int in_num, size_t offset,
>              break;
>          }
>          default:
> -            break;
> +            g_assert_not_reached();
>          }
>          if (copied < 0) {
>              return copied;
> 
> 
