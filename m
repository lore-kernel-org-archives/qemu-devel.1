Received: from eggs.gnu.org ([2001:4830:134:3::10]:44236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnXS-00080u-0g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnXP-0000Js-K8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:14:46 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:36272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnXP-0000Jh-F0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:14:43 -0400
Received: by mail-qt0-x230.google.com with SMTP id f55so79427067qta.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:14:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-21-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5522019e-d1c0-ba34-05fc-af89e2a4c111@twiddle.net>
Date: Tue, 30 May 2017 13:14:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-21-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/29] target/s390x: improve MOVE LONG
 and MOVE LONG EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> As MVCL and MVCLE only differ by their operands, use a common
> do_mvcl helper. Optimize it calling fast_memmove and fast_memset.
> Correctly write back addresses. Check that r1 and r2/r3 registers
> are even.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 90 +++++++++++++++++++++--------------------------
>   target/s390x/translate.c  | 40 +++++++++++++++------
>   2 files changed, 70 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
