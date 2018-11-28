Received: from eggs.gnu.org ([2001:4830:134:3::10]:40625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRzBs-00035z-6A
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRzBp-00085T-0R
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:43:40 -0500
References: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74a43b98-de88-6130-4e2f-30f0884cb56c@redhat.com>
Date: Wed, 28 Nov 2018 13:43:26 +0100
MIME-Version: 1.0
In-Reply-To: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 26/11/18 10:58, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 502ce6f0af..464744a406 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
>      }
>  
>      /*
> -     * 1. The hax_tunnel is also destroied when vcpu destroy
> +     * 1. The hax_tunnel is also destroyed when vcpu destroy
>       * 2. close fd will cause hax module vcpu be cleaned
>       */
>      hax_close_fd(vcpu->fd);
> 

Queued, thanks.

Paolo
