Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTYUL-0004ON-SW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 15:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTYUI-0000ji-OY
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 15:00:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTYUI-0000jX-Jf
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 15:00:22 -0400
Received: by mail-qt0-x241.google.com with SMTP id m54so5354865qtb.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 12:00:22 -0700 (PDT)
Received: from bigtime.twiddle.net (rrcs-66-91-136-156.west.biz.rr.com.
	[66.91.136.156]) by smtp.googlemail.com with ESMTPSA id
	b195sm3072499qka.20.2017.07.07.12.00.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Jul 2017 12:00:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<20170707163826.22631-1-rth@twiddle.net>
	<CAD-reDZ5RUnTm3JZG7rQ_dDSE41KJ_HoARQuiCLpT0wkdcowAQ@mail.gmail.com>
Message-ID: <6894e2eb-2ca2-cf92-80fc-b715996aba3e@twiddle.net>
Date: Fri, 7 Jul 2017 09:00:15 -1000
MIME-Version: 1.0
In-Reply-To: <CAD-reDZ5RUnTm3JZG7rQ_dDSE41KJ_HoARQuiCLpT0wkdcowAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fwd: [PATCH v2.5] fixup! linux-user/sh4: Notice
 gUSA regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

On 07/07/2017 07:57 AM, Richard Henderson wrote:
> +    /* ??? The SH4 kernel checks for and address above 0xC0000000.
> +       However, the page mappings in qemu linux-user aren't as restricted
> +       and we wind up with the normal stack mapped above 0xF0000000.
> +       That said, there is no reason why the kernel should be allowing
> +       a gUSA region that spans 1GB.  Use a tighter check here, for what
> +       can actually be enabled by the immediate move.  */

Additionally, I can (and should) fix the address space problem for SH4 in 
linux-user/main.c, where we have already done so for MIPS and Nios2.

See the initialization of reserved_va.


r~
