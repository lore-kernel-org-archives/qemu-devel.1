Received: from eggs.gnu.org ([2001:4830:134:3::10]:48390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eSNg8-0007zU-KG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eSNg7-0004EO-Pi
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:48:00 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:35046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eSNg7-0004Dt-Jc
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:47:59 -0500
Received: by mail-oi0-x22b.google.com with SMTP id 184so18984835oii.2
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:47:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221202724.21410-1-pbonzini@redhat.com>
References: <20171221202724.21410-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Dec 2017 13:47:38 +0000
Message-ID: <CAFEAcA8cU3dcGsJyMS_LmNTAaizHTC2qN72bXHkP1cx1DZRWnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 December 2017 at 20:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba26:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging (2017-12-20 13:20:48 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>
> for you to fetch changes up to e7c116fa90f3508a7ef5950e9bed5af11d8c192c:
>
>   i386: hvf: cleanup x86_gen.h (2017-12-21 21:24:54 +0100)
>
> ----------------------------------------------------------------
> Initial support for the HVF accelerator


OSX still doesn't build:

/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86_task.c:23:10:
fatal error: 'x86_cpuid.h' file not found
#include "x86_cpuid.h"
         ^

make -k thinks this is the last compile error, though.

thanks
-- PMM
