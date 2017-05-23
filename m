Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCyIQ-00074D-8p
	for qemu-devel@nongnu.org; Mon, 22 May 2017 21:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCyIP-0004bY-Fg
	for qemu-devel@nongnu.org; Mon, 22 May 2017 21:07:34 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dCyIP-0004bQ-AS
	for qemu-devel@nongnu.org; Mon, 22 May 2017 21:07:33 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so21234528qka.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 18:07:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-5-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fa8a29a3-9c78-54c4-a91b-24937ece8e1d@twiddle.net>
Date: Mon, 22 May 2017 18:07:29 -0700
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/mips: optimize WSBH,
 DSBH and DSHD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>

On 05/16/2017 04:01 PM, Aurelien Jarno wrote:
> Use the same mask to avoid having to load two different constants, as
> suggested by Richard Henderson.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/mips/translate.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
