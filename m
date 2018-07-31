Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka6s-0003N5-Uo
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka6o-0005Js-8B
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:15:06 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:45520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fka6o-0005JT-0n
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:15:02 -0400
Received: by mail-vk0-x241.google.com with SMTP id b78-v6so8079968vka.12
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:15:01 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3aef2761-88c4-7dc3-1560-807b1879e19e@linaro.org>
Date: Tue, 31 Jul 2018 15:14:55 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/76] linux-user: Add preprocessor
 availability control to some syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Add ability to target platforms to individually include user-mode
> support for system calls from "stat" group of system calls.
> 
> This change is related to new nanoMIPS platform in the sense that
> it supports a different set of "stat" system calls than any other
> target. nanoMIPS does not support structures stat and stat64 at
> all. Also, support for certain number of other system calls is
> dropped in nanoMIPS (those are most of the time obsoleted system
> calls).
> 
> Without this patch, build for nanoMIPS would fail.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/strace.c  | 14 +++++++++++++-
>  linux-user/syscall.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
