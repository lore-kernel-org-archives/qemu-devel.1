Received: from eggs.gnu.org ([2001:4830:134:3::10]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS89U-0003nN-ON
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS89T-0006rL-MG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:44 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS89T-0006rG-HL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:43 -0500
Received: by mail-yw0-x243.google.com with SMTP id a10so4506422ywa.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:08:43 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484332593-16782-1-git-send-email-laurent@vivier.eu>
	<1484332593-16782-6-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1203c578-e30e-0d6c-24b8-39373965ee8d@twiddle.net>
Date: Fri, 13 Jan 2017 12:08:40 -0800
MIME-Version: 1.0
In-Reply-To: <1484332593-16782-6-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target-m68k: increment/decrement
 with SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 10:36 AM, Laurent Vivier wrote:
> On 680x0 family only.
> 
> Address Register indirect With postincrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is incremented by two.
> 
> Address Register indirect With predecrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is decremented by two.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  target/m68k/translate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
