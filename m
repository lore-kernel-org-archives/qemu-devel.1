Received: from eggs.gnu.org ([2001:4830:134:3::10]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBTTL-0004av-DD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBTTG-00008f-Ne
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:00:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBTTG-00008P-HX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:00:34 -0400
References: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
	<9fa04242-c144-d5d1-f49b-1bce1df10053@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB8D87@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23ecbc03-751d-e804-ea99-949e5dabe63b@redhat.com>
Date: Fri, 19 May 2017 00:00:30 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1AB8D87@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] SMM: disable smram region if smm is
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 16/05/2017 22:22, Xu, Anthony wrote:
>> On 16/05/2017 03:21, Anthony Xu wrote:
>>> when smm is disabled, smram is not used, so disable it
>>>
>>> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
>>
>> What is the benefit?
> 
> This patch removes 1 memory region for i440 platform and 3 memory regions
> for q35 platform. That makes functions which iterates memory region tree
> a little bit fast even the memory regions are disabled.

Does it translate to anything measurable in benchmarks?  Could you leave
the regions there, but skip the creation of the SMRAM address space in
register_smram_listener when the machine doesn't have SMM enabled?

Paolo
