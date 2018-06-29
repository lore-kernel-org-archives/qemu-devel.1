Received: from eggs.gnu.org ([2001:4830:134:3::10]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrfG-0006jE-0l
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrfE-0000HR-Ej
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:34:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYrfE-0000H0-9b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:34:08 -0400
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
	<58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
	<20180628183033.GF914@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1bae170-2543-2030-05a7-51378544b575@redhat.com>
Date: Fri, 29 Jun 2018 13:34:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180628183033.GF914@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, robert.hu@intel.com

On 28/06/2018 20:30, Eduardo Habkost wrote:
>> For migration to work, you need to add new "features" corresponding to
>> the bits in the MSR, and include them in the Icelake-Server and
>> Icelake-Client models.  Unfortunately there is no code for this in QEMU
>> yet, though the API is there in KVM.
> Will all Icelake VCPUs of a given model have the same value on
> MSR_IA32_ARCH_CAPABILITIES?
> 
> If not, we can't choose a value that will work on all cases, and
> it will require management software to be smarter and explicitly
> configure some of the MSR bits on the command-line.

We can expect that it will change as more vulnerabilities are found and
more microcode updates are issued.  We should get it right from the
beginning.

Paolo
