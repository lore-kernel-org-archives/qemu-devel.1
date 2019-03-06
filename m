Received: from eggs.gnu.org ([209.51.188.92]:43929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1ZYC-0008P7-Q4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1ZYB-0006lL-N2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:37:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1ZYB-0006kv-EH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:37:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7CE9307E044
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 16:37:46 +0000 (UTC)
Received: from Igors-MacBook-Pro.local (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2F45D71A
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 16:37:45 +0000 (UTC)
Date: Wed, 6 Mar 2019 17:37:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306173742.4afb46ca@Igors-MacBook-Pro.local>
In-Reply-To: <1551879417-21031-1-git-send-email-guoheyi@huawei.com>
References: <1551879417-21031-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] arm/acpi: simplify aml code and
 enable SHPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Wed, 6 Mar 2019 21:36:55 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> After the introduction of generic PCIe root port and PCIe-PCI bridge, we will
> also have SHPC controller on ARM, and we don't support ACPI hot plug, so just
> enable SHPC native hot plug.
> 
> Igor also spotted the store operation outside of bit and/or is not necessary, so
> simply the code at first.

Since it's pretty close to soft-freeze ping Peter in 1-2 days,
otherwise patches might miss 4.0 release.

> 
> v4:
> - Improve the code indention.
> 
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> 
> Heyi Guo (2):
>   hw/arm/acpi: simplify AML bit and/or statement
>   hw/arm/acpi: enable SHPC native hot plug
> 
>  hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
