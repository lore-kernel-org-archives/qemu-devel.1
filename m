Received: from eggs.gnu.org ([2001:4830:134:3::10]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duevA-0005kh-4x
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dueu7-0003Mv-2D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:20:07 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:50198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dueu6-0003I9-8c
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:19:02 -0400
Received: by mail-wr0-x229.google.com with SMTP id w12so2137377wrc.7
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:19:02 -0700 (PDT)
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170919150313.10833-5-richard.henderson@linaro.org>
Date: Wed, 20 Sep 2017 12:17:45 +0100
Message-ID: <87y3p9d3fq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> If configured, prefer this over our rather dated copy of the
> GPLv2-only binutils.  This will be especially apparent with
> the proposed vector extensions to TCG, as disas/i386.c does
> not handle AVX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hmm I get a link failure:

  LINK    tilegx-linux-user/qemu-tilegx
disas.o: In function `cap_disas_start':
/home/alex/lsrc/qemu/qemu.git/disas.c:196: undefined reference to `cs_open'
/home/alex/lsrc/qemu/qemu.git/disas.c:210: undefined reference to `cs_option'
/home/alex/lsrc/qemu/qemu.git/disas.c:214: undefined reference to `cs_malloc'
/home/alex/lsrc/qemu/qemu.git/disas.c:216: undefined reference to `cs_close'
/home/alex/lsrc/qemu/qemu.git/disas.c:206: undefined reference to `cs_option'
disas.o: In function `cap_disas_target':
/home/alex/lsrc/qemu/qemu.git/disas.c:244: undefined reference to `cs_disasm_iter'
/home/alex/lsrc/qemu/qemu.git/disas.c:272: undefined reference to `cs_close'
disas.o: In function `cap_disas_host':
/home/alex/lsrc/qemu/qemu.git/disas.c:292: undefined reference to `cs_disasm_iter'
/home/alex/lsrc/qemu/qemu.git/disas.c:304: undefined reference to `cs_close'
collect2: error: ld returned 1 exit status
Makefile:199: recipe for target 'qemu-tilegx' failed
make[1]: *** [qemu-tilegx] Error 1
make[1]: Target 'all' not remade because of errors.
Makefile:326: recipe for target 'subdir-tilegx-linux-user' failed
make: *** [subdir-tilegx-linux-user] Error 2
  LINK    x86_64-linux-user/qemu-x86_64

I wonder if this is a version thing?

    Package: libcapstone-dev
    Status: install ok installed
    Priority: optional
    Section: libdevel
    Installed-Size: 4079
    Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    Architecture: amd64
    Source: capstone
    Version: 3.0.4-0.2
    Depends: libcapstone3 (= 3.0.4-0.2)
    Description: lightweight multi-architecture disassembly framework - devel files
     Capstone is a lightweight multi-platform, multi-architecture disassembly
     framework.


--
Alex Bennée
