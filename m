Received: from eggs.gnu.org ([2001:4830:134:3::10]:37058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7qr-0005mu-FJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7qo-0000O2-Bi
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:00:01 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:40300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB7qo-0000NN-5Q
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:59:58 -0400
Received: by mail-pf0-x22d.google.com with SMTP id f189so4485335pfa.7
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 16:59:57 -0700 (PDT)
References: <20180424160329.8089-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a2d5409-76ea-ce00-331b-4d12f909d453@linaro.org>
Date: Tue, 24 Apr 2018 13:59:51 -1000
MIME-Version: 1.0
In-Reply-To: <20180424160329.8089-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/24/2018 06:03 AM, Alex Bennée wrote:
> As support was merged into the mainline kernel at 4.15 it is unlikely
> 3.8.0 is the correct value. Indeed when I testing binaries created by
> the current Debian SID compiler the tests failed with:
> 
>   FATAL: kernel too old
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/riscv/target_syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
