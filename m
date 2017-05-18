Received: from eggs.gnu.org ([2001:4830:134:3::10]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBTIy-0006Xq-Ik
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBTIv-0005a8-Du
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBTIv-0005a2-7V
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:49:53 -0400
References: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
	<20170517112756.74cf6e47@nial.brq.redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACB970@ORSMSX112.amr.corp.intel.com>
	<6eff688c-b62e-8796-f852-a855079f3175@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACCB4D@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a55757b-fcdb-0829-c23d-68b1d416599f@redhat.com>
Date: Thu, 18 May 2017 23:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1ACCB4D@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Memory: use memory address space for
 cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 18/05/2017 23:48, Xu, Anthony wrote:
>> It should be called.  Alternatively you could try adding a new function
>> to mark address_space_memory as a never-destroyed AddressSpace:
>>
> This patch would do it, could you please submit this patch?

If you have tested it (together with the change in the initialization of
address_space_memory), I can do that.

Thanks,

Paolo
