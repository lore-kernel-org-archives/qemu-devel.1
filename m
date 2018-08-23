Received: from eggs.gnu.org ([2001:4830:134:3::10]:49481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fstPK-0001hc-OA
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fstPK-0001ZM-3X
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fstPJ-0001Yv-TQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:30 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
	<1535005708.4104.34.camel@linux.intel.com>
	<20180823171158.GI3778@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f59a30a4-6415-3c15-a3c1-5769eee04ad6@redhat.com>
Date: Thu, 23 Aug 2018 19:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180823171158.GI3778@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>
Cc: robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On 23/08/2018 19:11, Eduardo Habkost wrote:
>>> We don't want QEMU to refuse to run if the kernel doesn't have
>>> KVM_CAP_GET_MSR_FEATURES.  We can treat missing capability as
>>> equivalent to returning an empty list of MSRs.
>> Yes. I'll let caller (kvm_arch_init) ignore the return value but a
>> simple warning.
> Warnings tend to be ignored and are generally a sign that QEMU
> isn't doing the right thing.  Sometimes we have no choice, but I
> don't think that's the case here.
> 
> As far as I can see, we have only two possibilities here:
> 1) The host can run a VM that behaves exactly as requested on the
>    command-line (no warning required).
> 2) The host can't run the requested configuration (fatal error,
>    not a warning).

Right, but if KVM_CAP_GET_MSR_FEATURES is not available I guess you can
assume the MSRs to be zero for everything except "-cpu host".

Paolo
