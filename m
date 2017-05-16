Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAfk3-0002vY-0I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAfjz-000578-Pm
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAfjz-00056q-J9
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:54:31 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<9a93009b-f909-3142-5bc5-915b9a10ed20@redhat.com>
	<f69dcf32-b6a2-fb59-2b54-61fd7b52e66e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28bdbe39-7520-28c1-e58e-ec9f7ed69bde@redhat.com>
Date: Tue, 16 May 2017 18:54:24 +0200
MIME-Version: 1.0
In-Reply-To: <f69dcf32-b6a2-fb59-2b54-61fd7b52e66e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: address space translation
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 16/05/2017 18:51, Maxime Coquelin wrote:
>>
>> I faced the problem the old patch fixes when declaring and attaching
>> an IOMMU device, but booting the kernel with intel_iommu=off.
>>
>> I tested again with patches 1 & 4 of your series, and I confirm it
>> fixes the issue:
>> Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> I did some more testing with my "vhost-user IOMMU" setup, and the series
> actually breaks with IOMMU device attached, and intel_iommu=on.
> 
> The main difference with the previous passing test is the guest RAM
> size. In the working setup, it is 2G of 2M hugepages, vs. 4G of 2M
> hugepages in the failing one. Note that I also reproduce with
> vhost-kernel backend.
> 
> The error happens in the first vhost_device_iotlb_miss() call:
> qemu-system-x86_64: Fail to lookup the translated address b5d7c000
> 
> I don't have the root cause yet, I'll keep you updated.

I suppose it is patch 4?

Paolo
