Received: from eggs.gnu.org ([2001:4830:134:3::10]:37058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQtU-000679-NG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 12:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eSQtQ-0001vq-P6
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 12:14:00 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eSQtQ-0001uY-Js
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 12:13:56 -0500
Received: by mail-it0-x22d.google.com with SMTP id d16so15340421itj.1
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 09:13:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <8eb78791-4951-e5ee-bcba-b13038c2bc39@redhat.com>
Date: Fri, 22 Dec 2017 12:13:54 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <034292AA-D4E9-49EE-8622-E3C3860C2BBB@gmail.com>
References: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
	<79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
	<6cb05b76-0dcc-0baa-3ca1-9e5deb5baafe@redhat.com>
	<D67FF13F-57E4-47C9-BCD3-48CDC8E17D65@gmail.com>
	<8eb78791-4951-e5ee-bcba-b13038c2bc39@redhat.com>
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


> On Dec 22, 2017, at 11:52 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 22/12/2017 17:51, Programmingkid wrote:
>> Thanks. When I tried using qemu-system-i386 with the -accel hvf =
feature I saw this error: accel=3Dhvf: No accelerator found.
>>=20
>> I tried to build the qemu-system-x86_64 target but I also saw this =
error:
>>=20
>> /Users/misbah/desktop/qemu/target/i386/hvf/x86_task.c:23:10: fatal =
error:=20
>>      'x86_cpuid.h' file not found
>> #include "x86_cpuid.h"
>>         ^~~~~~~~~~~~~
>> 1 error generated.
>=20
> Just remove the line, that's what Peter was complaining about. :)  =
Also,
> the top two commits in the branch are not included in the pull =
request.
>=20
> Paolo

Excellent job! With this accelerator I was able to watch a youtube video =
in my Windows XP guest. Without the accelerator youtube isn't even =
usable.

When I add "-smp 2", Windows XP does not boot. This error message is =
displayed:

Warning: host doesn't support requested feature: CPUID.80000001H:ECX.svm =
[bit 2]

In the BSOD, I see this error message: DRIVER_IRQL_NOT_LESS_OR_EQUAL.

I tried experimenting with -cpu pentium3, -cpu pentium, -cpu qemu64, and =
-cpu core2duo, but none of them changed the error message.=
