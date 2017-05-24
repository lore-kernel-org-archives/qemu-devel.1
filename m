Received: from eggs.gnu.org ([2001:4830:134:3::10]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf98-0006zL-E9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf97-00078l-LQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:50 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDf97-00078Y-HB
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:49 -0400
Received: by mail-qk0-x242.google.com with SMTP id k74so28363660qke.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:52:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-5-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cc502da0-45ea-a6f1-fd9a-7f7b9f47b3b8@twiddle.net>
Date: Wed, 24 May 2017 15:52:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/sh4: ignore interrupts in a
 delay slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 03:47 PM, Aurelien Jarno wrote:
> Delay slots are indivisible, therefore avoid scheduling an interrupt in
> the delay slot. However exceptions are possible.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/helper.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
