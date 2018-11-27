Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRaZf-0008HE-NW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRaZc-0007fG-Rw
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:26:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRaZa-0007cc-SX
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:26:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so22102906wrw.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:26:28 -0800 (PST)
References: <1543312812-2929-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <95ebd5ea-2178-adc6-2733-67712406cb43@redhat.com>
Date: Tue, 27 Nov 2018 11:26:26 +0100
MIME-Version: 1.0
In-Reply-To: <1543312812-2929-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target: hax: fix errors in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, alex.bennee@linaro.org
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 27/11/18 11:00, Li Qiang wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
