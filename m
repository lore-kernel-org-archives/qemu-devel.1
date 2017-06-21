Received: from eggs.gnu.org ([2001:4830:134:3::10]:53739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNngk-00061E-NY
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNngh-0003fr-HL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:01:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNngh-0003fX-DG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:01:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id r62so17629728qkf.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:01:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621210704.24388-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <87e9e909-d0d2-84af-6db2-ae5b5eaba4ad@twiddle.net>
Date: Wed, 21 Jun 2017 15:01:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170621210704.24388-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

On 06/21/2017 02:07 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
> v2:
>      add missing cpu_m68k_set_fpcr() to update FPU internal state
> The v1 was in the v5 of the series "target-m68k: implement 680x0 FPU"
> 
>   linux-user/signal.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
