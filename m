Received: from eggs.gnu.org ([2001:4830:134:3::10]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gFvGz-0008HY-FM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gFv4k-0005d9-Do
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 01:54:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:55176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gFv4g-0005YW-UC
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 01:54:24 -0400
References: <20181017093053.8811-1-tao3.xu@intel.com>
	<20181017093053.8811-2-tao3.xu@intel.com>
	<6b494abe-93ae-71fc-01f3-e149df5e24b5@redhat.com>
	<20181025132831.GG4096@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <128b40da-f34e-9a45-e798-25e33855a51f@intel.com>
Date: Fri, 26 Oct 2018 13:53:10 +0800
MIME-Version: 1.0
In-Reply-To: <20181025132831.GG4096@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] i386: Add PKU/OSPKE on Skylake-Server
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org

On 10/25/18 9:28 PM, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 12:48:58PM +0200, Paolo Bonzini wrote:
>> On 17/10/2018 11:30, Tao Xu wrote:
>>> As the release document ref below link (page 13):
>>> https://software.intel.com/sites/default/files/managed/c5/15/\
>>> architecture-instruction-set-extensions-programming-reference.pdf
>>>
>>> PKU is supported in Skylake Server (Only Server) and later, and
>>> on Intel(R) Xeon(R) Processor Scalable Family. OSPKE is to reads
>>> the value of PKRU (Instruction of PKU) into EAX and clears EDX.
>>> So PKU/OSPKE are supposed to be in Skylake-Server CPU model.
>>> And PKU/OSPKE 's CPUID has been exposed to QEMU. But PKU/OSPKE
>>> can't be find in Skylake-Server CPU model in the code.
>>> So this patch will fix PKU/OSPKE this issue in Skylake-Server
>>> CPU model.
>> OSPKE is not needed, since it is added automatically based on CR4 (and
>> is not set on boot).
> Correct.
>
>> Also, the guru of CPU model compatibility is Eduardo, so I'll wait for
>> him to chime in anyway.
> Sorry for taking so long to reply.  This can be safely done only
> if every host that is able to run Skylake-Server today is
> guaranteed to support PKU.  Is that the case?
>
> You'll also need Skylake-Server-*-cpu.pku=off entries on
> PC_COMPAT_3_0 to keep PKU disabled on pc-*-3.0 and older.
>
Thank you Eduardo,


But I can't find PC_COMPAT_3_0 in  include/hw/i386/pc.h. Will it exist on

QEMU 3.1 and will I add "pku=off" after QEMU 3.1  release?


Best Regard

Tao Xu
