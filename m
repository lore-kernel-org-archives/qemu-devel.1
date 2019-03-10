Received: from eggs.gnu.org ([209.51.188.92]:44528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h35cX-0000ED-JO
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 17:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h35ML-0004Ju-Kg
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 16:47:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h35ML-0004JK-Dm
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 16:47:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id z39so2938133qtz.0
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 13:47:49 -0700 (PDT)
Date: Sun, 10 Mar 2019 16:47:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190310164736-mutt-send-email-mst@kernel.org>
References: <1552098649-28341-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552098649-28341-1-git-send-email-guoheyi@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] arm/acpi: simplify aml code and
 enable SHPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

On Sat, Mar 09, 2019 at 10:30:47AM +0800, Heyi Guo wrote:
> After the introduction of generic PCIe root port and PCIe-PCI bridge, we will
> also have SHPC controller on ARM, and we don't support ACPI hot plug, so just
> enable SHPC native hot plug.
> 
> Igor also spotted the store operation outside of bit and/or is not necessary, so
> simply the code at first.
> 
> v5:
> - Refine commit message of patch 1/2
> 
> v4:
> - Improve the code indention.
> 
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> 
> 
> Heyi Guo (2):
>   hw/arm/acpi: simplify AML bit and/or statement
>   hw/arm/acpi: enable SHPC native hot plug
> 
>  hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> -- 
> 1.8.3.1
