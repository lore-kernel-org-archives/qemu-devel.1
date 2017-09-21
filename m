Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv1D0-0002hv-3U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv1Cu-0005uS-6s
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dv1Ct-0005tH-UP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:07:56 -0400
References: <20170918160012.4317-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2ee2a862-d52a-486d-bb99-f7dfc5579e4e@redhat.com>
Date: Thu, 21 Sep 2017 15:07:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/27] s390x: SMP for TCG (+ cleanups)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>


> David Hildenbrand (27):
>   s390x: raise CPU hotplug irq after really hotplugged
>   s390x/cpumodel: fix max STFL(E) bit number
>   target/s390x: get rid of next_core_id
>   s390x: introduce and use S390_MAX_CPUS

It probably makes sense to apply 1-3/4 before the SMP support.

Igor, can you take a look at Patch nr. 3?

>   s390/tcg: turn INTERRUPT_EXT into a mask
>   s390x/tcg: injection of emergency signals and extarnal calls
>   s390x/tcg: STOPPED cpus can never wake up
>   s390x/tcg: a CPU cannot switch state due to an interrupt
>   target/s390x: factor out handling of WAIT PSW into handle_wait()
>   s390x/kvm: pass ipb directly into handle_sigp()
>   s390x/kvm: generalize SIGP stop and restart interrupt injection
>   s390x/kvm: factor out storing of CPU status
>   target/s390x: proper cpu->be convertion in s390_store_status()
>   s390x/kvm: factor out storing of adtl CPU status
>   s390x/kvm: drop two debug prints
>   s390x/kvm: factor out SIGP code into sigp.c
>   s390x/kvm: factor out actual handling of STOP interrupts
>   s390x/tcg: implement SIGP SENSE RUNNING STATUS
>   s390x/tcg: implement SIGP SENSE
>   s390x/tcg: implement SIGP EXTERNAL CALL
>   s390x/tcg: implement SIGP EMERGENCY SIGNAL
>   s390x/tcg: implement SIGP CONDITIONAL EMERGENCY SIGNAL
>   s390x/tcg: implement STOP and RESET interrupts for TCG
>   s390x/tcg: flush the tlb on SIGP SET PREFIX
>   s390x/tcg: switch to new SIGP handling code
>   s390x/tcg: unlock NMI
>   s390x/tcg: refactor stfl(e) to use s390_get_feat_block()


-- 

Thanks,

David
