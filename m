Received: from eggs.gnu.org ([2001:4830:134:3::10]:49841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCGR4-0001bX-Rv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 23:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCGQz-0003Mo-Qq
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 23:54:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCGQw-0003Id-4m
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 23:54:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id p25-v6so10287542pli.11
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 20:54:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <38a2dbae-42d8-ab2d-2e21-056794945677@linaro.org>
Date: Mon, 15 Oct 2018 20:54:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] check-tcg failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On aa64, "cross-compiling" to aa32, with

CC=arm-linux-gnueabihf-gcc

configure determines

aarch64-linux-user/config-target.mak:CROSS_CC_GUEST="aarch64-linux-gnu-gcc"
aarch64-linux-user/config-target.mak:CROSS_CC_GUEST_STATIC=y
aarch64-softmmu/config-target.mak:CROSS_CC_GUEST="aarch64-linux-gnu-gcc"
aarch64-softmmu/config-target.mak:CROSS_CC_GUEST_STATIC=y
arm-linux-user/config-target.mak:CROSS_CC_GUEST="cc"
arm-linux-user/config-target.mak:CROSS_CC_GUEST_STATIC=y
arm-softmmu/config-target.mak:CROSS_CC_GUEST="cc"
arm-softmmu/config-target.mak:CROSS_CC_GUEST_STATIC=y

which results in

  BUILD   arm guest-tests with cc
cc: error: unrecognized command line option ‘-marm’; did you mean ‘-fasm’?

Because of course cc is the aa64 host compiler.


r~
