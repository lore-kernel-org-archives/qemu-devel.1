Received: from eggs.gnu.org ([2001:4830:134:3::10]:46959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2N0t-00021o-6v
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 16:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2N0o-0002sR-6D
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 16:22:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2N0n-0002qE-Se
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 16:22:06 -0400
References: <20180330195928.15607-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a5a7adc7-f680-515b-62fb-4986626220b9@vivier.eu>
Date: Sat, 31 Mar 2018 22:22:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180330195928.15607-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: linux-user: rewind pc for
 restarted syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

Le 30/03/2018 à 21:59, Max Filippov a écrit :
> In case of syscall restart request set pc back to the syscall
> instruction.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index ba09b7d0c873..8907a8411411 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4006,6 +4006,9 @@ void cpu_loop(CPUXtensaState *env)
>                      break;
>  
>                  case -TARGET_ERESTARTSYS:
> +                    env->pc -= 3;
> +                    break;
> +
>                  case -TARGET_QEMU_ESIGRETURN:
>                      break;
>                  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
