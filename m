Received: from eggs.gnu.org ([2001:4830:134:3::10]:47452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gQE3j-0002wW-Eu
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gQE3g-0000rN-8w
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:11:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gQE3g-0000pT-1X
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:11:56 -0500
Date: Fri, 23 Nov 2018 11:11:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181123111017-mutt-send-email-mst@kernel.org>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] acpi: RSDP: fix checksum calculations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, drjones@redhat.com, peter.maydell@linaro.org

On Thu, Nov 22, 2018 at 11:29:32AM +0100, Igor Mammedov wrote:
>  * arm/virt is broken but it looks like linux doesn't care, lets fix it anyways
>  * x86, got lucky since we didn't use extended fields,
>    fix it so that it will calculate checksum using correct length
>    so that it would be easier to unify arm/x86 into one impl.
> 

I'd say patch 2 should go into this release.
What about patch 1? It's cosmetic and it isn't the best we can do.

Let me know whether you agree.

> Igor Mammedov (2):
>   pc: acpi: use correct RSDT length for checksum
>   arm/virt: acpi: fix incorrect checksums in RSDP
> 
>  hw/arm/virt-acpi-build.c | 7 ++++++-
>  hw/i386/acpi-build.c     | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
