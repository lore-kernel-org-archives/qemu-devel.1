Received: from eggs.gnu.org ([208.118.235.92]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMtly-0005Wn-3D
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMth4-0006Xz-1N
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:50:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gMth3-0006Uo-Lk
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:50:49 -0500
References: <c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
	<20181108171437.GM12503@habkost.net>
	<dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
	<20181108184242.GQ12503@habkost.net>
	<2f4793c3-5509-1def-3157-02bc0d9bbe26@redhat.com>
	<20181108210047.GU12503@habkost.net>
	<00978318-b3b4-bd00-25c5-7b843cc09f13@redhat.com>
	<20181109191657.GB12503@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a9227a2-b380-6155-896e-977f6934f14e@redhat.com>
Date: Wed, 14 Nov 2018 12:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181109191657.GB12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 09/11/2018 20:16, Eduardo Habkost wrote:
> On Fri, Nov 09, 2018 at 11:10:21AM +0100, Paolo Bonzini wrote:
>> On 08/11/2018 22:00, Eduardo Habkost wrote:
>>> Understood.  My interpretation of "target" was just "a QEMU
>>> binary".  In other words, I thought we were talking about
>>> anything that could be compiled in/out from a specific QEMU
>>> binary.
>>
>> The idea is "target" as opposed to "host".
>>
>>> Do you have a specific reason to restrict the scope to only
>>> guest-visible effects?  Is this just a way to reduce the effort
>>> required for the task, or there are other caveats I'm missing?
>>
>> Because that's what default-configs/ is for---producing
>> config-devices.mak.  IOW it's mostly to reduce the scope, but also
>> because there are differences between config-devices.mak (produced from
>> default-configs/) and config-{host,target}.h (produced by configure).
> 
> I have the impression that the build system has an implicit
> assumption: that any build option that affects only one QEMU
> binary is always guest-visible, and that any build option that is
> not guest visible must affect all built QEMU binaries.  Is this
> going to be always true?

I don't think it's an assumption.  It's more a side effect of avoiding
obj-y unless needed.  Because any build option that affects only one
QEMU binary must use obj-y, and non-guest-visible code generally doesn't
use obj-y, the result is what you say.

Paolo
