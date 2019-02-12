Received: from eggs.gnu.org ([209.51.188.92]:44648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gtQ2v-0001Ne-Kr
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gtQ2i-0003T5-Mv
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:51:39 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gtQ2h-0003NJ-L1
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:51:36 -0500
Received: by mail-pg1-x544.google.com with SMTP id w7so642256pgp.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:51:32 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190211192039.5457-1-svens@stackframe.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <22f48be8-b1d6-f03e-509c-22c486c46a99@twiddle.net>
Date: Mon, 11 Feb 2019 20:51:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190211192039.5457-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/hppa: forward requests to CPU HPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de

On 2/11/19 11:20 AM, Sven Schnelle wrote:
> HP-UX 10.20 uses busmaster writes to the CPU EIR to signal
> interrupts from the SCSI constroller. (Similar to what is known
> as MSI on x86)
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/hppa/dino.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Queued, thanks.


r~
