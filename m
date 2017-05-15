Received: from eggs.gnu.org ([2001:4830:134:3::10]:48117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAPkH-0004DY-1Y
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAPkE-0005oc-0K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dAPkD-0005nM-Pp
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:49:41 -0400
Date: Mon, 15 May 2017 16:49:38 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170511113542.16682-1-anthony.perard@citrix.com>
Message-ID: <alpine.DEB.2.10.1705151649320.2898@sstabellini-ThinkPad-X260>
References: <20170511113542.16682-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] configure: Remove -lxencall for Xen
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, 11 May 2017, Anthony PERARD wrote:
> QEMU does not depends on libxencall, it was added because it was a
> missing link dependency of libxendevicemodel, but now the later should
> be built properly.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 7c020c076b..fa3522d18a 100755
> --- a/configure
> +++ b/configure
> @@ -2014,7 +2014,7 @@ if test "$xen" != "no" ; then
>    else
>  
>      xen_libs="-lxenstore -lxenctrl -lxenguest"
> -    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
> +    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
>  
>      # First we test whether Xen headers and libraries are available.
>      # If no, we are done and there is no Xen support.
> -- 
> Anthony PERARD
> 
