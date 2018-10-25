Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFmZS-0007YF-La
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFmZO-0003El-2v
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:49:34 -0400
References: <20180811211011.6277-1-cota@braap.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a101eaea-7605-f9f7-cc2b-762a6539a91c@vivier.eu>
Date: Thu, 25 Oct 2018 21:48:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180811211011.6277-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix comment
 s/atomic_write/atomic_set/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-trivial@nongnu.org

On 11/08/2018 22:10, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  linux-user/qemu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index b4959e41c6..e6a8bc5867 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -143,7 +143,7 @@ typedef struct TaskState {
>      /* Nonzero if process_pending_signals() needs to do something (either
>       * handle a pending signal or unblock signals).
>       * This flag is written from a signal handler so should be accessed via
> -     * the atomic_read() and atomic_write() functions. (It is not accessed
> +     * the atomic_read() and atomic_set() functions. (It is not accessed
>       * from multiple threads.)
>       */
>      int signal_pending;
> 

Applied

Thanks,
Laurent
