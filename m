Received: from eggs.gnu.org ([2001:4830:134:3::10]:43161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBndA-0005Xl-0b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBnd6-0001H9-2W
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:04:24 -0500
Date: Mon, 6 Nov 2017 20:04:17 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171106200417.GC19281@kos.to>
References: <1508364103-16131-1-git-send-email-cota@braap.org>
	<1508364103-16131-3-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508364103-16131-3-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 2/4] linux-user: fix 'finshed' typo in
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Applied to linux-user, thanks

Riku

On Wed, Oct 18, 2017 at 06:01:41PM -0400, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9d4cc4c..47b4a79 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6231,7 +6231,7 @@ static void *clone_func(void *arg)
>      pthread_mutex_lock(&info->mutex);
>      pthread_cond_broadcast(&info->cond);
>      pthread_mutex_unlock(&info->mutex);
> -    /* Wait until the parent has finshed initializing the tls state.  */
> +    /* Wait until the parent has finished initializing the tls state.  */
>      pthread_mutex_lock(&clone_lock);
>      pthread_mutex_unlock(&clone_lock);
>      cpu_loop(env);
> -- 
> 2.7.4
> 
> 
