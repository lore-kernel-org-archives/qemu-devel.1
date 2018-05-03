Received: from eggs.gnu.org ([2001:4830:134:3::10]:35550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fE4YK-0006t5-V3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fE4YH-0003hC-Nb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fE4YH-0003gO-Hr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:05:01 -0400
Date: Thu, 3 May 2018 00:04:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180503030457.GB25013@localhost.localdomain>
References: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86/cpu: Enable CLDEMOTE(Demote Cache
 Line) cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jingqi Liu <jingqi.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Fri, May 04, 2018 at 11:57:33AM +0800, Jingqi Liu wrote:
> The CLDEMOTE instruction hints to hardware that the cache line that
> contains the linear address should be moved("demoted") from
> the cache(s) closest to the processor core to a level more distant
> from the processor core. This may accelerate subsequent accesses
> to the line by other cores in the same coherence domain,
> especially if the line was written by the core that demotes the line.
> 
> Intel Snow Ridge has added new cpu feature, CLDEMOTE.
> The new cpu feature needs to be exposed to guest VM.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=0):ECX[bit 25] CLDEMOTE
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>

Thanks.  Do you have a pointer to the corresponding
GET_SUPPORTED_CPUID patch in KVM?

-- 
Eduardo
