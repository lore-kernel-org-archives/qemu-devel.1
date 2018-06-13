Received: from eggs.gnu.org ([2001:4830:134:3::10]:37734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSwnr-0002bU-Ap
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSwno-00054s-8v
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:50:35 -0400
Date: Tue, 12 Jun 2018 23:50:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180613035030.GB25430@flamenco>
References: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH] tracing.txt: add missing '-' for trace
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com

On Tue, Jun 12, 2018 at 23:15:49 -0400, Yaowei Bai wrote:
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> ---
>  docs/devel/tracing.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 07abbb3..6ab32cc 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -18,7 +18,7 @@ for debugging, profiling, and observing execution.
>  
>  3. Run the virtual machine to produce a trace file:
>  
> -    qemu -trace events=/tmp/events ... # your normal QEMU invocation
> +    qemu --trace events=/tmp/events ... # your normal QEMU invocation

The second dash is not missing; both '-args' and '--args' work.

'-args' seems to be favoured though; see `qemu -h' or `qemu --h' :-)

		Emilio
