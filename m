Received: from eggs.gnu.org ([2001:4830:134:3::10]:43809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVdat-0006Vp-Ag
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVdaq-0000CG-38
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:51:47 -0400
Received: from nihsmtpxway6.hub.nih.gov ([128.231.90.122]:8484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <njh@bandsman.co.uk>) id 1dVdap-0008Tt-Ts
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:51:44 -0400
From: Nigel Horne <njh@bandsman.co.uk>
Message-ID: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
Date: Thu, 13 Jul 2017 08:51:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The latest version in github fails to link (using gcc-7) with this error:

   LINK    aarch64-softmmu/qemu-system-aarch64
accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_le_mmu':
cputlb.c:(.text+0x5f3d): undefined reference to 
`__atomic_compare_exchange_16'
accel/tcg/cputlb.o: In function `helper_atomic_cmpxchgo_be_mmu':
cputlb.c:(.text+0x6000): undefined reference to 
`__atomic_compare_exchange_16'
accel/tcg/cputlb.o: In function `helper_atomic_ldo_be_mmu':
cputlb.c:(.text+0x602f): undefined reference to `__atomic_load_16'
accel/tcg/cputlb.o: In function `helper_atomic_ldo_le_mmu':
cputlb.c:(.text+0x5f73): undefined reference to `__atomic_load_16'
accel/tcg/cputlb.o: In function `helper_atomic_sto_le_mmu':
cputlb.c:(.text+0x5fa9): undefined reference to `__atomic_store_16'
accel/tcg/cputlb.o: In function `helper_atomic_sto_be_mmu':
cputlb.c:(.text+0x607f): undefined reference to `__atomic_store_16'
collect2: error: ld returned 1 exit status
Makefile:197: recipe for target 'qemu-system-aarch64' failed
make[1]: *** [qemu-system-aarch64] Error 1
Makefile:328: recipe for target 'subdir-aarch64-softmmu' failed
make: *** [subdir-aarch64-softmmu] Error 2

-Nigel
