Received: from eggs.gnu.org ([2001:4830:134:3::10]:36693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf83-0005TU-3t
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf82-0006t2-8R
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:51:43 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:35352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDf82-0006su-3s
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:51:42 -0400
Received: by mail-qk0-x235.google.com with SMTP id a72so165510976qkj.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:51:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-2-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7c774f9a-0706-8adc-a497-b31bc3cfd482@twiddle.net>
Date: Wed, 24 May 2017 15:51:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/sh4: log unauthorized accesses
 using qemu_log_mask
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
> qemu_log_mask() is preferred over fprintf() for logging errors.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
