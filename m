Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjpXy-0006u7-8V
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjpXu-0004sV-CJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:10 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cjpXu-0004sM-7j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:06 -0500
Received: by mail-it0-x243.google.com with SMTP id 203so2726626ith.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:55:06 -0800 (PST)
In-Reply-To: <20170303164426.42472535@bahia.lan>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 3 Mar 2017 10:55:01 -0500
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 3, 2017, at 10:44 AM, Greg Kurz wrote:

> On Fri, 3 Mar 2017 10:28:00 -0500
> G 3 <programmingkidx@gmail.com> wrote:
>
>> On Mar 3, 2017, at 9:59 AM, qemu-devel-request@nongnu.org wrote:
>>> On 02/03/17 17:40, Daniel P. Berrange wrote:
>>>
>>>> On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote:
>>>>> Does anyone else see the following error when trying to build git
>>>>> master?
>>>>>
>>>>> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
>>>>> -I/home/build/src/qemu/git/qemu/tcg
>>>>> -I/home/build/src/qemu/git/qemu/tcg/i386
>>>>> -I/home/build/src/qemu/git/qemu/linux-headers
>>>>> -I/home/build/src/qemu/git/qemu/linux-headers -I.
>>>>> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/
>>>>> include
>>>>> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/ 
>>>>> libfdt
>>>>> -Werror -pthread -I/usr/include/glib-2.0
>>>>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -
>>>>> D_GNU_SOURCE
>>>>> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
>>>>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing- 
>>>>> prototypes
>>>>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
>>>>> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
>>>>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>>>>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
>>>>> -fstack-protector-all -I/usr/include/p11-kit-1
>>>>> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -
>>>>> MMD -MP
>>>>> -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
>>>>> -D_FORTIFY_SOURCE=2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
>>>>> In file included from hw/9pfs/9p-util.c:15:0:
>>>>> hw/9pfs/9p-util.h: In function ?openat_dir?:
>>>>> hw/9pfs/9p-util.h:25:57: error: ?O_PATH? undeclared (first use in
>>>>> this
>>>>> function)
>>>>> hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is
>>>>> reported
>>>>> only once for each function it appears in
>>>>> hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void
>>>>> function
>>>>> [-Werror=return-type]
>>>>>
>>>>> Build platform is Debian Wheezy on an x86_64 host.
>>>>
>>>> IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.
>>>>
>>>> So unless we want to make this 9pfs code a configurable option,  
>>>> this
>>>> means Debian Wheezy is no longer a supportable platform for QEMU.
>>>
>>> Oh sure, I appreciate that wheezy is getting towards then end of its
>>> lifetime - it's just a little bit inconvenient to break my  
>>> development
>>> environment just as we enter 2.9 freeze ;)
>>>
>>> If everyone agrees that wheezy is no longer supported after 2.9  
>>> then I
>>> can look to upgrading, however my QEMU development is done on my
>>> laptop
>>> which is also setup for my day job so it's not a simple case of just
>>> switching the repository and running dist-upgrade to get me going
>>> again...
>>
>> I remember years ago something like O_PATH was not defined on Mac  
>> OS X,
>> so the solution was to define the constant as zero. Something like  
>> this:
>>
>> #ifndef O_PATH
>> 	#define O_PATH 0
>> #endif
>>
>> Maybe this might work in 9p-util.h.
>>
>
> Yes. Please send a patch and I'll merge it.
>
> Cheers.
>
> --
> Greg


Here is the patch. I think we should let Mark or some else test it to  
see if it does fix the problem before a real patch is submitted.

---
  hw/9pfs/9p-util.h | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce..254d2a9 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -13,6 +13,10 @@
  #ifndef QEMU_9P_UTIL_H
  #define QEMU_9P_UTIL_H

+#ifndef O_PATH
+    #define O_PATH 0
+#endif
+
  static inline void close_preserve_errno(int fd)
  {
      int serrno = errno;
-- 
2.10.2
