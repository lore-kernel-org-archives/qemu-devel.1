Received: from eggs.gnu.org ([2001:4830:134:3::10]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsWsK-0000DI-CQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsWsH-0003St-6h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:20:24 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:49679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dsWsG-0003Qn-VT
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:20:21 -0400
Received: by mail-wm0-x236.google.com with SMTP id e71so1897198wmg.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:20:19 -0700 (PDT)
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170912162513.21694-10-richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 17:20:16 +0100
Message-ID: <871sn99rr3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/16] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  46 ++++-
>  tcg/i386/tcg-target.inc.c | 438 +++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 438 insertions(+), 46 deletions(-)

My compiler doesn't like you ;-)

In file included from /home/alex/lsrc/qemu/qemu.git/tcg/tcg.c:254:0:
/home/alex/lsrc/qemu/qemu.git/tcg/tcg.c: In function ‘tcg_gen_code’:
/home/alex/lsrc/qemu/qemu.git/tcg/i386/tcg-target.inc.c:2494:13: error: ‘c’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
             tcg_out_modrm(s, c, a0, a1);
             ^
In file included from /home/alex/lsrc/qemu/qemu.git/tcg/tcg.c:254:0:
/home/alex/lsrc/qemu/qemu.git/tcg/i386/tcg-target.inc.c:2035:9: note: ‘c’ was declared here
     int c, const_a2, vexop, rexw = 0;
         ^
cc1: all warnings being treated as errors

--
Alex Bennée
