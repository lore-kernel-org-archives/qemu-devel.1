Received: from eggs.gnu.org ([2001:4830:134:3::10]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ewsr0-0001aN-AA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ewsqv-0004jj-2Z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:09:18 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:44180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ewsqu-0004iG-SW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:09:13 -0400
Date: Fri, 16 Mar 2018 18:09:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180316170909.fd4laqzyktjboyvf@var.youpi.perso.aquilenet.fr>
References: <20180316143921.30780-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316143921.30780-1-nia.alarie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] net/slirp: Convert atoi to qemu_strtoi to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, jasowang@redhat.com, jan.kiszka@siemens.com

Nia Alarie, on ven. 16 mars 2018 14:39:21 +0000, wrote:
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>

Applied to my tree, thanks!

> ---
>  net/slirp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index 8991816bbf..e938944bd4 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -486,7 +486,9 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
>          goto fail_syntax;
>      }
>  
> -    host_port = atoi(p);
> +    if (qemu_strtoi(p, NULL, 10, &host_port)) {
> +        goto fail_syntax;
> +    }
>  
>      err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr, host_port);
>  
> -- 
> 2.16.2
> 

-- 
Samuel
"...[Linux's] capacity to talk via any medium except smoke signals."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)
