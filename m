Received: from eggs.gnu.org ([2001:4830:134:3::10]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GQT-0000Fn-VT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GQQ-0001dE-2G
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:04:10 -0400
References: <20170429123707.16675-1-aik@ozlabs.ru>
	<20170502182550.5edb9565.cornelia.huck@de.ibm.com>
	<e6d90400-3bcd-77c5-dbe6-24dc14d6bcd3@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c2db34f-4713-66b3-0741-66e26dac5cd3@redhat.com>
Date: Thu, 4 May 2017 15:03:58 +0200
MIME-Version: 1.0
In-Reply-To: <e6d90400-3bcd-77c5-dbe6-24dc14d6bcd3@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 03/05/2017 03:25, Alexey Kardashevskiy wrote:
>> <bikeshed>
>> I find "iommumr" terribly hard to read. Maybe iommu_mr is better? (Lots
>> of times in this patch.)
>> </bikeshed>
> Terribly? Really? :) Seriously, since linux uses underscores in typenames,
> I kind of developed resistance to underscores in variable names which look
> like typenames (even though c allows using same token for a type and a
> variable).

And especially even though QEMU uses camelcase for types. :)

> May be just "iommu"? I need one more vote for "iommu" vs.
> "iommumr" vs. "iommu_mr" to respin v6 :)

I am fine with either iommu or iommu_mr.

Paolo
