Received: from eggs.gnu.org ([2001:4830:134:3::10]:36852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6oG-00014t-Fp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6oD-0005yz-CO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:15:00 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS6oD-0005yo-7h
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:14:57 -0400
Received: by mail-qk0-x242.google.com with SMTP id 91so25098909qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:14:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-4-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0629eeb9-5b12-b528-0904-ec120b777cad@twiddle.net>
Date: Mon, 3 Jul 2017 12:14:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170703162328.24474-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/m68k: add fmod/frem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 07/03/2017 09:23 AM, Laurent Vivier wrote:
> Use libm functions fmodl() and remainderl().
> The quotient byte of the FPSR is updated with
> the result of the operation.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/cpu.h        |  1 +
>   target/m68k/fpu_helper.c | 35 +++++++++++++++++++++++++++++++++++
>   target/m68k/helper.h     |  2 ++
>   target/m68k/translate.c  |  6 ++++++
>   4 files changed, 44 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
