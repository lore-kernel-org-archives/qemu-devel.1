Received: from eggs.gnu.org ([2001:4830:134:3::10]:44701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9IyN-00059V-Vn
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9IyM-0004Jw-Uh
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:23:44 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9IyM-0004Ji-Pv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:23:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so8519201qta.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:23:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-10-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6d744a51-225a-49cf-0531-fe09d19a88ee@twiddle.net>
Date: Fri, 12 May 2017 15:23:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-10-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/15] target/sh4: optimize
 gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 11:26 AM, Aurelien Jarno wrote:
> Using extr and avoiding intermediate temps.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
