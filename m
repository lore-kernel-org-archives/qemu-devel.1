Received: from eggs.gnu.org ([2001:4830:134:3::10]:51251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmNgR-0004Gr-NF
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmNgO-0005mf-JS
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:46:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmNgO-0005lc-Cl
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:46:24 -0500
References: <20170310101405.26974-1-lma@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b2c47af-6ee0-5ece-1427-783fd3de3b1f@redhat.com>
Date: Fri, 10 Mar 2017 17:46:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170310101405.26974-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: add the missing help output for
 optional features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru



On 10/03/2017 11:14, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  configure | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/configure b/configure
> index 6c21975..2603e10 100755
> --- a/configure
> +++ b/configure
> @@ -1335,6 +1335,12 @@ Advanced options (experts only):
>    --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
>    --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
>    --tls-priority           default TLS protocol/cipher priority string
> +  --enable-gprof           QEMU profiling with gprof
> +  --enable-profiler        profiler support
> +  --enable-xen-pv-domain-build
> +                           xen pv domain builder
> +  --enable-debug-stack-usage
> +                           track the maximum stack usage of stacks created by qemu_alloc_stack
>  
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -1403,6 +1409,12 @@ disabled with --disable-FEATURE, default is enabled if available:
>    tcmalloc        tcmalloc support
>    jemalloc        jemalloc support
>    replication     replication support
> +  vhost-vsock     virtio sockets device support
> +  opengl          opengl support
> +  virglrenderer   virgl rendering support
> +  xfsctl          xfsctl support
> +  qom-cast-debug  cast debugging support
> +  tools           build qemu-io, qemu-nbd and qemu-image tools
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> 

Queued, thanks.

Paolo
