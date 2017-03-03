Received: from eggs.gnu.org ([2001:4830:134:3::10]:54896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cjoRO-0000dq-42
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cjoRK-0002eI-N7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:44:18 -0500
Received: from chuckie.co.uk ([82.165.15.123]:53208
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cjoRK-0002dJ-Eg
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:44:14 -0500
References: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
	<20170302174026.GI11445@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <19018990-c75e-25d8-b780-434aaa350f48@ilande.co.uk>
Date: Fri, 3 Mar 2017 14:43:53 +0000
MIME-Version: 1.0
In-Reply-To: <20170302174026.GI11445@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 02/03/17 17:40, Daniel P. Berrange wrote:

> On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote:
>> Does anyone else see the following error when trying to build git master?
>>
>> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
>> -I/home/build/src/qemu/git/qemu/tcg
>> -I/home/build/src/qemu/git/qemu/tcg/i386
>> -I/home/build/src/qemu/git/qemu/linux-headers
>> -I/home/build/src/qemu/git/qemu/linux-headers -I.
>> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/include
>> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
>> -Werror -pthread -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
>> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
>> -fstack-protector-all -I/usr/include/p11-kit-1
>> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
>> -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
>> -D_FORTIFY_SOURCE=2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
>> In file included from hw/9pfs/9p-util.c:15:0:
>> hw/9pfs/9p-util.h: In function ‘openat_dir’:
>> hw/9pfs/9p-util.h:25:57: error: ‘O_PATH’ undeclared (first use in this
>> function)
>> hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is reported
>> only once for each function it appears in
>> hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void function
>> [-Werror=return-type]
>>
>> Build platform is Debian Wheezy on an x86_64 host.
> 
> IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.
> 
> So unless we want to make this 9pfs code a configurable option, this 
> means Debian Wheezy is no longer a supportable platform for QEMU.

Oh sure, I appreciate that wheezy is getting towards then end of its
lifetime - it's just a little bit inconvenient to break my development
environment just as we enter 2.9 freeze ;)

If everyone agrees that wheezy is no longer supported after 2.9 then I
can look to upgrading, however my QEMU development is done on my laptop
which is also setup for my day job so it's not a simple case of just
switching the repository and running dist-upgrade to get me going again...


ATB,

Mark.
