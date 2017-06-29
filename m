Received: from eggs.gnu.org ([2001:4830:134:3::10]:56531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVhs-0007aR-6U
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVhr-0008F3-Dh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:25:48 -0400
Date: Thu, 29 Jun 2017 17:25:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629092534.GD28654@lemon.lan>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 2/4] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org

On Tue, 06/27 16:57, Alistair Francis wrote:
> There is no way nhandles can be zero in this section so that part of the
> if statement will always be false. Let's just remove it to make the code
> easier to read.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 80e4668935..7ec0f8e083 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>          /* If we have a timeout, or no handles to poll, be satisfied
>           * with just noticing we have messages waiting.
>           */
> -        if (timeout != 0 || nhandles == 0) {
> +        if (timeout != 0) {
>              return 1;
>          }
>  
> -- 
> 2.11.0
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
