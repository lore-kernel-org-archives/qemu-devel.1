Received: from eggs.gnu.org ([2001:4830:134:3::10]:40004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4OkN-0007GP-K1
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4OkK-0003UA-HS
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:32:59 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d4OkK-0003Tj-BE
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 05:32:56 -0400
Received: by mail-wr0-x233.google.com with SMTP id l50so44033194wrc.3
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 02:32:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170428211018.2927-1-shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ad616d4e-a6fc-c8e3-9698-ad57762ac035@twiddle.net>
Date: Sat, 29 Apr 2017 11:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170428211018.2927-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/openrisc: Support non-busy idle
 state using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>

On 04/28/2017 11:10 PM, Stafford Horne wrote:
> +            raise_exception(cpu, EXCP_HLT);

One minor tweak -- EXCP_HALTED.

HLT is, in theory, i386 specific.  Not that you'd have noticed a difference. 
FWIW, I've just found the same error in target/alpha.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
