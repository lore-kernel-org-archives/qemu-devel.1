Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3PL4-0001Xl-Ex
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3PL3-0008Dk-PT
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:31:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507930220-17461-1-git-send-email-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6defdad1-35aa-2849-8483-e714132fc2b1@amsat.org>
Date: Sat, 14 Oct 2017 13:30:50 -0300
MIME-Version: 1.0
In-Reply-To: <1507930220-17461-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] futex: add missing header guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

Cc: trivial

On 10/13/2017 06:30 PM, Emilio G. Cota wrote:
> The header file was introduced by fbcc3e5 ("qemu-thread: optimize QemuLockCnt
> with futexes on Linux", 2017-01-16) without header guards. Add them.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qemu/futex.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> index bb7dc9e..91ae889 100644
> --- a/include/qemu/futex.h
> +++ b/include/qemu/futex.h
> @@ -11,6 +11,9 @@
>   *
>   */
>  
> +#ifndef QEMU_FUTEX_H
> +#define QEMU_FUTEX_H
> +
>  #include <sys/syscall.h>
>  #include <linux/futex.h>
>  
> @@ -34,3 +37,5 @@ static inline void qemu_futex_wait(void *f, unsigned val)
>          }
>      }
>  }
> +
> +#endif /* QEMU_FUTEX_H */
> 
