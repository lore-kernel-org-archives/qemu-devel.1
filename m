Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb6v9-0002IN-0n
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb6v4-000144-TF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:15:50 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb6v4-00011l-Mq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:15:46 -0400
Received: by mail-pl0-x243.google.com with SMTP id bi1-v6so1479437plb.12
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:15:46 -0700 (PDT)
References: <1530806837-5416-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <899abe1c-ed7a-d0f0-dde5-bf65225a8da9@linaro.org>
Date: Thu, 5 Jul 2018 09:15:42 -0700
MIME-Version: 1.0
In-Reply-To: <1530806837-5416-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>

On 07/05/2018 09:07 AM, Emilio G. Cota wrote:
> This fixes a record-replay regression introduced by 95590e2
> ("translate-all: discard TB when tb_link_page returns an existing
> matching TB", 2018-06-15). The problem is that code using CF_NOCACHE
> assumes that the TB returned from tb_gen_code is always a
> newly-generated one. This assumption, however, was broken in
> the aforementioned commit.
> 
> Fix it by honouring CF_NOCACHE, so that tb_gen_code always
> returns a newly-generated TB when CF_NOCACHE is passed to it.
> Do this by avoiding the TB hash table if CF_NOCACHE is set.
> 
> Reported-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
