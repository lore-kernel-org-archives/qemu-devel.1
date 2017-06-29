Received: from eggs.gnu.org ([2001:4830:134:3::10]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVq7-00067s-TM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVq7-0004Vy-AL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:34:19 -0400
Date: Thu, 29 Jun 2017 17:34:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629093409.GE28654@lemon.lan>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 3/4] util/oslib-win32: Fix up if
 conditional
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
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7ec0f8e083..a015e1ac96 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -438,7 +438,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>          if (timeout == 0 && nhandles > 1) {
>              /* Remove the handle that fired */
>              int i;
> -            if (ready < nhandles - 1) {
> +            if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
>                  for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
>                      handles[i-1] = handles[i];
>                  }
> -- 
> 2.11.0
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
