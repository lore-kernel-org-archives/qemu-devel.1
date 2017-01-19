Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU8h7-0003Pn-3y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU8h3-0000pc-6A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:07:45 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cU8h2-0000pM-VI
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:07:41 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so4527049lfi.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 01:07:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<2163e04a-68cb-6c49-61bf-71c9e32e0487@redhat.com>
	<b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
	<665c0c20-e39d-8f6e-2a09-e2169e5376bb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a83f2689-b016-d77d-48ac-625e258bfb7a@redhat.com>
Date: Thu, 19 Jan 2017 10:07:37 +0100
MIME-Version: 1.0
In-Reply-To: <665c0c20-e39d-8f6e-2a09-e2169e5376bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Richard Henderson <rth@twiddle.net>



On 19/01/2017 04:32, Jason Wang wrote:
>>
>>>
>>>> +        addr &= ~(sz - 1);
>>>> +    } else {
>>>> +        sz = VTD_PAGE_SIZE;
>>>> +    }
>>>>   +    entry.target_as = &vtd_dev_as->as;
>>>> +    entry.addr_mask = sz - 1;
>>>> +    entry.iova = addr;
>>> If S=1, entry.iova must mask away the 1 bits that specified the size.
>>> For example,
>>>
>>>       addr = 0xabcd1000
>>>
>>> has cto64(0xabcd1) == 1, so it indicates a 16K invalidation from
>>> 0xabcd0000 to 0xabcd3fff.  The "1" must be masked away with "addr & -sz"
>>> or "addr & ~entry.addr_mask".
>>>
>>> Thanks,
>>>
>>> Paolo
>>
>> Good catch.
> 
> It should be addr & ~(sz - 1) I think? And it has been done above :)

Oh, of course!

Paolo
