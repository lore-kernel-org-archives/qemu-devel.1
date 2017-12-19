Received: from eggs.gnu.org ([2001:4830:134:3::10]:46829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRM1X-0004iJ-RT
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRM1U-0004BP-Ax
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:49:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRM1U-0004AA-50
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:49:48 -0500
Date: Tue, 19 Dec 2017 19:49:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219194923-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-6-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217125457.3429-6-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 5/5] MAINTAINERS: add entry for
 hw/net/pvrdma
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

On Sun, Dec 17, 2017 at 02:54:57PM +0200, Marcel Apfelbaum wrote:
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffd77b461c..d24401a4d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1960,6 +1960,13 @@ F: block/replication.c
>  F: tests/test-replication.c
>  F: docs/block-replication.txt
>  
> +PVRDMA
> +M: Yuval Shaia <yuval.shaia@oracle.com>
> +M: Marcel Apfelbaum <marcel@redhat.com>
> +S: Maintained
> +F: hw/net/pvrdma/*
> +F: docs/pvrdma.txt
> +
>  Build and test automation
>  -------------------------
>  Build and test automation

Not really a network device, I think it needs its own
directory.

> -- 
> 2.13.5
