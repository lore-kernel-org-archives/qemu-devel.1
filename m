Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIw1-0004Ez-Kr
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIvy-0000jW-Is
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:36:05 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIvy-0000jK-C5
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:36:02 -0400
Received: by mail-pf0-x241.google.com with SMTP id z6so11795845pfk.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:36:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-15-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <97867694-8ed7-9268-11f1-09bdaa174d5e@twiddle.net>
Date: Sun, 9 Jul 2017 10:35:57 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-15-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/22] tcg: take .helpers out of TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> Before TCGContext is made thread-local.
> 
> The hash table becomes read-only after it is filled in,
> so we can save space by keeping just a global pointer to it.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/tcg.h |  2 --
>   tcg/tcg.c | 10 +++++-----
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
