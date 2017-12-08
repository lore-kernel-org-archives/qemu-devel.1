Received: from eggs.gnu.org ([2001:4830:134:3::10]:42259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNJWh-0004xR-Dd
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNJWd-0000D1-I7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:21:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eNJWd-0000Co-BS
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30D01C07FC26
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 14:21:14 +0000 (UTC)
Date: Fri, 8 Dec 2017 14:21:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171208142107.GH11767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171208141430.21169-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208141430.21169-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Document -object tls-creds-x509
 priority=xxx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Dec 08, 2017 at 03:14:30PM +0100, Christophe Fergeau wrote:
> This was added in 13f1243, but is missing from qemu-options.hx
> 
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  qemu-options.hx | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f11c4ac960..118784ceb7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4249,7 +4249,7 @@ expensive operation that consumes random pool entropy, so it is
>  recommended that a persistent set of parameters be generated
>  upfront and saved.
>  
> -@item -object tls-creds-x509,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/cred/dir},verify-peer=@var{on|off},passwordid=@var{id}
> +@item -object tls-creds-x509,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/cred/dir},priority=@var{priority},verify-peer=@var{on|off},passwordid=@var{id}
>  
>  Creates a TLS anonymous credentials object, which can be used to provide
>  TLS support on network backends. The @option{id} parameter is a unique
> @@ -4282,6 +4282,15 @@ version by providing the @var{passwordid} parameter. This provides
>  the ID of a previously created @code{secret} object containing the
>  password for decryption.
>  
> +The @var{priority} parameter allows to override the global default
> +priority used by gnutls. This can be useful if the system administrator
> +needs to use a weaker set of crypto priorities for QEMU without
> +potentially forcing the weakness onto all applications. Or conversely
> +if one wants wants a stronger default for QEMU than for all other
> +applications, they can do this through this parameter. Its format is
> +a gnutls priority string as described at
> +@url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
> +
>  @item -object filter-buffer,id=@var{id},netdev=@var{netdevid},interval=@var{t}[,queue=@var{all|rx|tx}][,status=@var{on|off}]
>  
>  Interval @var{t} can't be 0, this filter batches the packet delivery: all

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
