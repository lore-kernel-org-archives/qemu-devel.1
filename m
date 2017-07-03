Received: from eggs.gnu.org ([2001:4830:134:3::10]:48539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8y1-00017M-F8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8xy-00047S-DV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:33:13 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS8xy-00046y-8I
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:33:10 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so25536397qke.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 14:33:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170702163220.8039-1-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <963f0ac0-4e34-c0e0-458f-8ca6e9e10a49@twiddle.net>
Date: Mon, 3 Jul 2017 14:33:04 -0700
MIME-Version: 1.0
In-Reply-To: <20170702163220.8039-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/sh4: fix fabs and optimize fneg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Bruno Haible <bruno@clisp.org>

On 07/02/2017 09:32 AM, Aurelien Jarno wrote:
> This patchset should fix the bug #1701821 reported by Bruno Haible,
> which makes the gnulib testsuite to fail for single precision libm
> tests.
> 
> Aurelien Jarno (2):
>    target/sh4: do not check for PR bit for fabs instruction
>    target/sh4: do not use a helper to implement fneg
> 
>   target/sh4/helper.h    |  3 ---
>   target/sh4/op_helper.c | 15 ---------------
>   target/sh4/translate.c | 20 +++++---------------
>   3 files changed, 5 insertions(+), 33 deletions(-)
> 

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
