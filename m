Received: from eggs.gnu.org ([2001:4830:134:3::10]:47325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQXa-00052m-VL
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQXX-0001yw-CD
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:51:22 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eSQXX-0001yM-6V
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:51:19 -0500
Received: by mail-io0-x244.google.com with SMTP id n14so1944482iob.4
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 08:51:19 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <6cb05b76-0dcc-0baa-3ca1-9e5deb5baafe@redhat.com>
Date: Fri, 22 Dec 2017 11:51:16 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D67FF13F-57E4-47C9-BCD3-48CDC8E17D65@gmail.com>
References: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
	<79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
	<6cb05b76-0dcc-0baa-3ca1-9e5deb5baafe@redhat.com>
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


> On Dec 22, 2017, at 11:42 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 22/12/2017 17:26, Programmingkid wrote:
>> I was able to clone your git repository and successfully build the =
hvf branch. The latest commit is this:
>>=20
>> commit aabe2a1a77b70efe96c9345f737068a0dcef0281 (HEAD -> hvf, =
origin/hvf)
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Thu Dec 21 00:10:03 2017 +0100
>>=20
>>    i386: hvf: avoid useless exit to the main loop
>>=20
>> How do I make QEMU use the hvf feature?
>=20
> "-accel hvf".
>=20
> Paolo

Thanks. When I tried using qemu-system-i386 with the -accel hvf feature =
I saw this error: accel=3Dhvf: No accelerator found.

I tried to build the qemu-system-x86_64 target but I also saw this =
error:

/Users/misbah/desktop/qemu/target/i386/hvf/x86_task.c:23:10: fatal =
error:=20
      'x86_cpuid.h' file not found
#include "x86_cpuid.h"
         ^~~~~~~~~~~~~
1 error generated.=
