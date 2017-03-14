Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cnpfj-0008RI-Ao
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cnpff-0007qJ-EG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:51:43 -0400
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cnpff-0007q9-80
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:51:39 -0400
Received: by mail-ua0-x22e.google.com with SMTP id f54so168650649uaa.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:51:38 -0700 (PDT)
MIME-Version: 1.0
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 14 Mar 2017 18:51:37 +0200
Message-ID: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Hi all,

I am trying to compile qemu-ga for Windows statically using the following
commands:

./configure --disable-docs --target-list=x86_64-softmmu
--cross-prefix=x86_64-w64-mingw32- --static --enable-guest-agent-msi
--with-vss-sdk=/path/to/VSSSDK72

make -j8 qemu-ga


And I keep getting this error:

/home/sameeh/Builds/q/stubs/error-printf.c:7: undefined reference to
`__imp_g_test_config_vars'
collect2: error: ld returned 1 exit status
Makefile:444: recipe for target 'qemu-ga.exe' failed
make: *** [qemu-ga.exe] Error 1


Notes to consider:
* without --static I can compile it successfully
* Build machine is running Fedora 25
* I have upgraded all of the tools to their latest version
* If I comment out the function which is causing the issue
(g_test_initialized()), qemu ga compiles statically and runs successfully
without the need of any dlls.

Can anyone reproduce this? Do you have any idea why is this happening?

-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
