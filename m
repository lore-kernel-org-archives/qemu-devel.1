Received: from eggs.gnu.org ([2001:4830:134:3::10]:57119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVe7Z-0007ja-35
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVe7T-0008NU-8S
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:25:33 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVe7T-0008N7-3Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:25:27 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so5997436qte.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:25:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
	<CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
	<be531cc1-50d4-4149-7499-ac8fe554bd23@bandsman.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff9234b1-1d33-dc38-8e62-846914f7d0ea@amsat.org>
Date: Thu, 13 Jul 2017 10:25:23 -0300
MIME-Version: 1.0
In-Reply-To: <be531cc1-50d4-4149-7499-ac8fe554bd23@bandsman.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nigel Horne <njh@bandsman.co.uk>, QEMU Developers <qemu-devel@nongnu.org>

Hi Nigel,

On 07/13/2017 09:59 AM, Nigel Horne wrote:
> On 7/13/17 8:57 AM, Peter Maydell wrote:
>> On 13 July 2017 at 13:51, Nigel Horne <njh@bandsman.co.uk> wrote:
>>> The latest version in github fails to link (using gcc-7) with this 
>>> error:
>>>
>>>    LINK    aarch64-softmmu/qemu-system-aarch64
>>> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_le_mmu':
>>> cputlb.c:(.text+0x5f3d): undefined reference to
>>> `__atomic_compare_exchange_16'
>>> accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_be_mmu':
>>> cputlb.c:(.text+0x6000): undefined reference to
>>> `__atomic_compare_exchange_16'
>>> accel/tcg/cputlb.o: In function `helper_atomic_ldo_be_mmu':
>>> cputlb.c:(.text+0x602f): undefined reference to `__atomic_load_16'
>>> accel/tcg/cputlb.o: In function `helper_atomic_ldo_le_mmu':
>>> cputlb.c:(.text+0x5f73): undefined reference to `__atomic_load_16'
>>> accel/tcg/cputlb.o: In function `helper_atomic_sto_le_mmu':
>>> cputlb.c:(.text+0x5fa9): undefined reference to `__atomic_store_16'
>>> accel/tcg/cputlb.o: In function `helper_atomic_sto_be_mmu':
>>> cputlb.c:(.text+0x607f): undefined reference to `__atomic_store_16'
>>> collect2: error: ld returned 1 exit status
>>> Makefile:197: recipe for target 'qemu-system-aarch64' failed
>>> make[1]: *** [qemu-system-aarch64] Error 1
>>> Makefile:328: recipe for target 'subdir-aarch64-softmmu' failed
>>> make: *** [subdir-aarch64-softmmu] Error 2
>> Emilio's recent-ish change (commit f3ced3c5928) maybe?
>>
>> Nigel -- what host architecture are you building for?
> x86_64 - Debian Linux.

can not reproduce, what are your ./configure options?

((f0d2ead97c...))$ head -2 config.log
# QEMU configure log Thu Jul 13 10:08:49 -03 2017
# Configured with: '../configure' 
'--target-list=aarch64-softmmu,aarch64-linux-user' 
'--enable-trace-backends=simple' '--disable-docs' '--disable-vnc' 
'--disable-brlapi' '--disable-bluez' '--disable-smartcard' 
'--disable-gtk' '--audio-drv-list=pa' '--disable-tpm' '--enable-curses' 
'--cc=gcc-7'

((f0d2ead97c...))$ make -j5 subdir-aarch64-softmmu
[...]
   CC      aarch64-softmmu/trace/generated-helpers.o
   LINK    aarch64-softmmu/qemu-system-aarch64

((f0d2ead97c...))$ readelf -p .comment aarch64-softmmu/qemu-system-aarch64

String dump of section '.comment':
   [     0]  GCC: (Debian 6.4.0-1) 6.4.0 20170704
   [    25]  GCC: (Debian 7.1.0-9) 7.1.0
   [    41]  GCC: (Debian 6.3.0-18) 6.3.0 20170516

((f0d2ead97c...))$ readelf -wi aarch64-softmmu/qemu-system-aarch64|fgrep 
DW_AT_producer|cut -d: -f2-|sort -u
  (indirect string, offset: 0x12026f): GNU C11 6.3.0 20170516 
-mtune=generic -march=x86-64 -g -O2 -std=gnu11 -fgnu89-inline 
-fmerge-all-constants -frounding-math -fPIC -ftls-model=initial-exec
  (indirect string, offset: 0x57c0): GNU C11 7.1.0 -m64 -mcx16 
-mtune=generic -march=x86-64 -g -O2 -fPIE -fno-strict-aliasing 
-fno-common -fwrapv -fstack-protector-strong
  (indirect string, offset: 0x72b6e): GNU C++14 6.4.0 20170704 -m64 
-mcx16 -mtune=generic -march=x86-64 -g -O2 -fPIE -fno-strict-aliasing 
-fno-common -fwrapv -fstack-protector-strong
  (indirect string, offset: 0x7768a): GNU C++14 6.4.0 20170704 -m64 
-mcx16 -mtune=generic -march=x86-64 -ggdb -g -fPIE -fno-strict-aliasing 
-fno-common -fwrapv -fstack-protector-strong
  (indirect string, offset: 0xcc5ac): GNU C11 7.1.0 -m64 -mcx16 
-mtune=generic -march=x86-64 -ggdb -g -fPIE -fno-strict-aliasing 
-fno-common -fwrapv -fstack-protector-strong

(f0d2ead97c...))$ aarch64-softmmu/qemu-system-aarch64 -version
QEMU emulator version 2.9.50 (v2.9.0-1376-g80f464ef84-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

((f0d2ead97c...))$ apt-cache policy gcc-7
gcc-7:
   Installed: 7.1.0-9
   Candidate: 7.1.0-9
   Version table:
  *** 7.1.0-9 500
         500 http://httpredir.debian.org/debian unstable/main amd64 Packages
         100 /var/lib/dpkg/status

Regards,

Phil.
