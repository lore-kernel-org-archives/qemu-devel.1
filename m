Received: from eggs.gnu.org ([2001:4830:134:3::10]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQ9c-0004p2-1v
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQ9Y-00066y-Nb
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:26:36 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:40665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eSQ9Y-00066k-IV
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:26:32 -0500
Received: by mail-io0-x22b.google.com with SMTP id v186so25107561iod.7
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 08:26:32 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
Date: Fri, 22 Dec 2017 11:26:30 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
References: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


> On Dec 22, 2017, at 9:10 AM, qemu-devel-request@nongnu.org wrote:
>=20
> Message: 16
> Date: Fri, 22 Dec 2017 15:03:04 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: QEMU Developers <qemu-devel@nongnu.org>
> Subject: Re: [Qemu-devel] [PULL v3 00/19] Initial support for
> 	Hypervisor.framework
> Message-ID: <92df467d-dab6-7ad6-b625-1fa3a724066a@redhat.com>
> Content-Type: text/plain; charset=3Dutf-8
>=20
> On 22/12/2017 14:47, Peter Maydell wrote:
>> On 21 December 2017 at 20:27, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>> The following changes since commit =
200780a3a3ed067dfb2e0d2210b0ed09e748ba26:
>>>=20
>>>  Merge remote-tracking branch =
'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging =
(2017-12-20 13:20:48 +0000)
>>>=20
>>> are available in the Git repository at:
>>>=20
>>>  git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>>>=20
>>> for you to fetch changes up to =
e7c116fa90f3508a7ef5950e9bed5af11d8c192c:
>>>=20
>>>  i386: hvf: cleanup x86_gen.h (2017-12-21 21:24:54 +0100)
>>>=20
>>> ----------------------------------------------------------------
>>> Initial support for the HVF accelerator
>>=20
>>=20
>> OSX still doesn't build:
>>=20
>> /Users/pm215/src/qemu-for-merges/target/i386/hvf/x86_task.c:23:10:
>> fatal error: 'x86_cpuid.h' file not found
>> #include "x86_cpuid.h"
>>         ^
>>=20
>> make -k thinks this is the last compile error, though.
>=20
> Thanks (the errors were the result of some late removal of unused
> functions, after a user told me it worked fine for him).  During the
> holidays I might try to actually use it on my in-laws' Mac...
>=20
> Paolo

I was able to clone your git repository and successfully build the hvf =
branch. The latest commit is this:

commit aabe2a1a77b70efe96c9345f737068a0dcef0281 (HEAD -> hvf, =
origin/hvf)
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Dec 21 00:10:03 2017 +0100

    i386: hvf: avoid useless exit to the main loop

How do I make QEMU use the hvf feature?=
