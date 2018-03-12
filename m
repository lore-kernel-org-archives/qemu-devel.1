Received: from eggs.gnu.org ([2001:4830:134:3::10]:59963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evKKw-00076r-Bw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evKKr-00060Y-8L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:05:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evKKr-00060K-4J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:05:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9887AD1425
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:05:35 +0000 (UTC)
References: <20180312094308.21716-1-pbonzini@redhat.com>
	<68ce30df-0acd-d50e-5af4-0ca23e3a6ca5@redhat.com>
	<3bd96555-ac06-f66a-6c0f-a84c3987c9ca@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <afc0d944-d040-a0a6-eab8-617bf8f4ba0b@redhat.com>
Date: Mon, 12 Mar 2018 11:05:29 +0100
MIME-Version: 1.0
In-Reply-To: <3bd96555-ac06-f66a-6c0f-a84c3987c9ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12.03.2018 10:53, Paolo Bonzini wrote:
> On 12/03/2018 10:48, Thomas Huth wrote:
>>> +obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
>>> +obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
>> The linker likely does not care if x86-iommu.o is included twice
> 
> The linker actually cares, but rules.mak drops the duplicate:
> 
>     commit e2a99ad3e174ab4c9d2320dcecd779230409829f
>     Author: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>     Date:   Thu Aug 25 09:18:52 2011 +0100
> 
>     build: sort objects to remove duplicates for link

Ah, nice, I wasn't aware of that trick. The current patch looks fine to
me in this case:

Reviewed-by: Thomas Huth <thuth@redhat.com>
