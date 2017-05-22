Received: from eggs.gnu.org ([2001:4830:134:3::10]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dCpIP-0005NS-J8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dCpIM-00010k-Gm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dCpIM-00010K-63
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:30:54 -0400
References: <33183CC9F5247A488A2544077AF19020DA2AF6CA@DGGEMA505-MBX.china.huawei.com>
	<0f88ad61-06d8-57bb-3228-9b2dde993c70@redhat.com>
	<20170522083203.GE5158@redhat.com>
	<2bbe969f-a9f7-920a-26dd-b92c5b498705@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA2B24F2@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3570bfd4-e963-df19-9df6-5629e5e203af@redhat.com>
Date: Mon, 22 May 2017 17:30:49 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA2B24F2@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] memory consumption of Qemu is twice as much
 as the previous version in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



On 22/05/2017 17:11, Gonglei (Arei) wrote:
>> These are kernel allocations done by KVM when it gets the
>> KVM_SET_USER_MEMORY_REGION ioctl; of course the two memory maps
>> point to
>> the same userspace mmap-ed area.
>
> Oh? What's the mmapd-ed area you pointed?

I mean the MAP_ANON pages that back the guest memory.

> If the KVM allocate memory by vmalloc(), then it will occupy physical
> memory (non physically contiguous memory) IMO.
> 
> We can get the information from /proc/meminfo:
> 
> # cat /proc/meminfo |grep Vmalloc     
> VmallocTotal:   34359738367 kB
> VmallocUsed:      532796 kB
> VmallocChunk:   34292018200 kB
> 
> So I think this part of memory is double after that SMM commit. Right?

Yes.

Paolo
