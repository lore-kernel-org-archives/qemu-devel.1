Received: from eggs.gnu.org ([2001:4830:134:3::10]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzUmk-0005B9-CK
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzUmf-0005kM-GD
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzUmf-0005k6-A0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:31:21 -0400
Date: Tue, 3 Oct 2017 18:31:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003213118.GF4760@localhost.localdomain>
References: <20171003211730.31843-1-ehabkost@redhat.com>
	<20171003211730.31843-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003211730.31843-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qemu-options: Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

On Tue, Oct 03, 2017 at 06:17:30PM -0300, Eduardo Habkost wrote:
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  Update documentation and document -nodefconfig as
> deprecated.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Document at "Deprecated features" section in qemu-doc.texi
>   (Daniel)
> * Remove documentation for the option from qemu-options.hx
>   (Markus)
> ---
>  qemu-doc.texi   |  4 ++++
>  qemu-options.hx | 17 ++++-------------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index ecd186a159..039abe0cfe 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2533,6 +2533,10 @@ or ``ivshmem-doorbell`` device types.
>  The ``spapr-pci-vfio-host-bridge'' device type is replaced by
>  the ``spapr-pci-host-bridge'' device type.
>  
> +@subsection -nodefconfig (since 2.11.0)
> +
> +The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
> +

This is at the wrong section.  I will submit v3 fixing that.
Sorry for the noise.

>  @node License
>  @appendix License
>  

-- 
Eduardo
