Received: from eggs.gnu.org ([2001:4830:134:3::10]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSQZ0-00063H-Hf
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSQYz-0003CL-TS
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:52:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eSQYz-0003BW-MX
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:52:49 -0500
References: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
	<79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
	<6cb05b76-0dcc-0baa-3ca1-9e5deb5baafe@redhat.com>
	<D67FF13F-57E4-47C9-BCD3-48CDC8E17D65@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8eb78791-4951-e5ee-bcba-b13038c2bc39@redhat.com>
Date: Fri, 22 Dec 2017 17:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <D67FF13F-57E4-47C9-BCD3-48CDC8E17D65@gmail.com>
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 22/12/2017 17:51, Programmingkid wrote:
> Thanks. When I tried using qemu-system-i386 with the -accel hvf feature I saw this error: accel=hvf: No accelerator found.
> 
> I tried to build the qemu-system-x86_64 target but I also saw this error:
> 
> /Users/misbah/desktop/qemu/target/i386/hvf/x86_task.c:23:10: fatal error: 
>       'x86_cpuid.h' file not found
> #include "x86_cpuid.h"
>          ^~~~~~~~~~~~~
> 1 error generated.

Just remove the line, that's what Peter was complaining about. :)  Also,
the top two commits in the branch are not included in the pull request.

Paolo
