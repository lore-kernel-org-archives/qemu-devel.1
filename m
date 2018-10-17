Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjO3-0004Pj-MA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjO0-0007fd-AK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCjNy-0007XP-8f
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:49:07 -0400
References: <20181017093053.8811-1-tao3.xu@intel.com>
	<20181017093053.8811-2-tao3.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b494abe-93ae-71fc-01f3-e149df5e24b5@redhat.com>
Date: Wed, 17 Oct 2018 12:48:58 +0200
MIME-Version: 1.0
In-Reply-To: <20181017093053.8811-2-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Tao Xu <tao3.xu@intel.com>, ehabkost@redhat.com
Cc: rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org

On 17/10/2018 11:30, Tao Xu wrote:
> As the release document ref below link (page 13):
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> PKU is supported in Skylake Server (Only Server) and later, and 
> on Intel(R) Xeon(R) Processor Scalable Family. OSPKE is to reads 
> the value of PKRU (Instruction of PKU) into EAX and clears EDX.
> So PKU/OSPKE are supposed to be in Skylake-Server CPU model. 
> And PKU/OSPKE 's CPUID has been exposed to QEMU. But PKU/OSPKE
> can't be find in Skylake-Server CPU model in the code. 
> So this patch will fix PKU/OSPKE this issue in Skylake-Server 
> CPU model.  

OSPKE is not needed, since it is added automatically based on CR4 (and
is not set on boot).

Also, the guru of CPU model compatibility is Eduardo, so I'll wait for
him to chime in anyway.

Paolo
