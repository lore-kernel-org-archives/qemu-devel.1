Received: from eggs.gnu.org ([2001:4830:134:3::10]:55696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNS5N-0001Bx-7Z
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNS5M-0003Lt-Ke
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:57:25 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNS5M-0003Lf-GI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:57:24 -0400
Received: by mail-qk0-x244.google.com with SMTP id d14so13025392qkb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:57:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-7-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dd9013e0-1bc9-631c-35ad-e27312d5d6ba@twiddle.net>
Date: Tue, 20 Jun 2017 15:57:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/20/2017 01:51 PM, Laurent Vivier wrote:
> +    __get_user(env->fpcr, &fpregs->f_fpcntl[0]);

cpu_m68k_set_fpcr


r~
