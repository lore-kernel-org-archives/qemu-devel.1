Received: from eggs.gnu.org ([2001:4830:134:3::10]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKRlg-0000Zf-16
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKRlb-0005W7-2X
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:32:56 -0500
Date: Thu, 30 Nov 2017 17:32:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171130173243.61db4632.cohuck@redhat.com>
In-Reply-To: <20171130140536.31164-1-cohuck@redhat.com>
References: <20171130140536.31164-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 30 Nov 2017 15:05:36 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> It is not used anywhere.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/helper.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 246ba20f0d..35d9741918 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -31,24 +31,6 @@
>  #include "sysemu/sysemu.h"
>  #endif
>  
> -//#define DEBUG_S390
> -//#define DEBUG_S390_STDOUT
> -
> -#ifdef DEBUG_S390
> -#ifdef DEBUG_S390_STDOUT
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); \
> -         if (qemu_log_separate()) qemu_log(fmt, ##__VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { qemu_log(fmt, ## __VA_ARGS__); } while (0)
> -#endif
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
> -
>  #ifndef CONFIG_USER_ONLY
>  void s390x_tod_timer(void *opaque)
>  {

Queued to s390-next.
