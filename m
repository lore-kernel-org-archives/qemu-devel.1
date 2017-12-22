Received: from eggs.gnu.org ([2001:4830:134:3::10]:32917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSNur-0003W8-B3
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSNul-0002bW-CY
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:03:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eSNul-0002aL-6s
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:03:07 -0500
References: <20171221202724.21410-1-pbonzini@redhat.com>
	<CAFEAcA8cU3dcGsJyMS_LmNTAaizHTC2qN72bXHkP1cx1DZRWnw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92df467d-dab6-7ad6-b625-1fa3a724066a@redhat.com>
Date: Fri, 22 Dec 2017 15:03:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8cU3dcGsJyMS_LmNTAaizHTC2qN72bXHkP1cx1DZRWnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22/12/2017 14:47, Peter Maydell wrote:
> On 21 December 2017 at 20:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba26:
>>
>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging (2017-12-20 13:20:48 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>>
>> for you to fetch changes up to e7c116fa90f3508a7ef5950e9bed5af11d8c192c:
>>
>>   i386: hvf: cleanup x86_gen.h (2017-12-21 21:24:54 +0100)
>>
>> ----------------------------------------------------------------
>> Initial support for the HVF accelerator
> 
> 
> OSX still doesn't build:
> 
> /Users/pm215/src/qemu-for-merges/target/i386/hvf/x86_task.c:23:10:
> fatal error: 'x86_cpuid.h' file not found
> #include "x86_cpuid.h"
>          ^
> 
> make -k thinks this is the last compile error, though.

Thanks (the errors were the result of some late removal of unused
functions, after a user told me it worked fine for him).  During the
holidays I might try to actually use it on my in-laws' Mac...

Paolo
