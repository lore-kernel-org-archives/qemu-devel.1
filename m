Received: from eggs.gnu.org ([2001:4830:134:3::10]:49294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gSTIt-0000BS-9S
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gSTIp-00080e-8z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:52:55 -0500
References: <1543312812-2929-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ae8b0b38-0080-0086-5f5c-5d8f575d3381@vivier.eu>
Date: Thu, 29 Nov 2018 21:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <1543312812-2929-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] target: hax: fix errors
 in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, rth@twiddle.net, ehabkost@redhat.com, alex.bennee@linaro.org, philmd@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 27/11/2018 11:00, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 502ce6f0af..b978a9b821 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
>      }
>  
>      /*
> -     * 1. The hax_tunnel is also destroied when vcpu destroy
> +     * 1. The hax_tunnel is also destroyed when vcpu is destroyed
>       * 2. close fd will cause hax module vcpu be cleaned
>       */
>      hax_close_fd(vcpu->fd);
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
