Received: from eggs.gnu.org ([2001:4830:134:3::10]:53924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGnl-00083N-FX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGnf-0002tw-Rh
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:56:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZGnf-0002tN-Im
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:56:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31A1742BBB
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:30:33 +0000 (UTC)
References: <20181217073114.11984-1-peterx@redhat.com>
	<20181217073114.11984-6-peterx@redhat.com>
	<20181218030713.GB16723@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54801de1-3617-0af0-43b1-952b2cc53623@redhat.com>
Date: Tue, 18 Dec 2018 13:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181218030713.GB16723@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] intel_iommu: turn on IR by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>

On 18/12/18 04:07, Peter Xu wrote:
> On Mon, Dec 17, 2018 at 03:31:14PM +0800, Peter Xu wrote:
>> IR has been there for a long time and long time no bug reported.
>> Let's turn it on by default to match general hardwares.  Providing
>> compatibility bit for QEMU<=3.1.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
> I forgot that IR will depend on split kernel irqchip and by default
> that's still "on" so "-M q35 -device intel-iommu" may not be able to
> boot correctly with all the default values and instead QEMU will ask
> user to turn on split irqchip.
> 
> Paolo/Michael, do you think it would make any sense to turn the
> default kernel-irqchip machine parameter to split starting from qemu
> 4.0?  Since AFAIU it should have little degradation to performance but
> at the same time it reduces kvm attack serface, which seems good.

The main problem with that would be the minimal required kernel version,
which is 4.4 for split irqchip.  But, we're already planning to make it
4.5 so it's not an issue.  Go for it. :)

Paolo
