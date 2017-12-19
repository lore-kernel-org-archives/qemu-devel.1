Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRKVP-0007tQ-13
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRKVL-0007Tf-CP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:12:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRKVL-0007Sm-6g
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:12:31 -0500
Date: Tue, 19 Dec 2017 18:12:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219181158-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217125457.3429-5-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com

On Sun, Dec 17, 2017 at 02:54:56PM +0200, Marcel Apfelbaum wrote:
> @@ -2847,15 +2847,16 @@ if test "$rdma" != "no" ; then
>  #include <rdma/rdma_cma.h>
>  int main(void) { return 0; }
>  EOF
> -  rdma_libs="-lrdmacm -libverbs"
> +  rdma_libs="-lrdmacm -libverbs -libumad"
>    if compile_prog "" "$rdma_libs" ; then
>      rdma="yes"
>    else
> +    libs_softmmu="$libs_softmmu $rdma_libs"
>      if test "$rdma" = "yes" ; then
>          error_exit \
> -            " OpenFabrics librdmacm/libibverbs not present." \
> +            " OpenFabrics librdmacm/libibverbs/libibumad not present." \
>              " Your options:" \
> -            "  (1) Fast: Install infiniband packages from your distro." \
> +	    "  (1) Fast: Install infiniband packages (devel) from your distro." \
>              "  (2) Cleanest: Install libraries from www.openfabrics.org" \
>              "  (3) Also: Install softiwarp if you don't have RDMA hardware"
>      fi

Some whitespace damage here.
