Received: from eggs.gnu.org ([2001:4830:134:3::10]:38652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUb9K-0002Bm-5C
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUb9F-0004uP-Dn
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:03:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUb9F-0004tx-7y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:02:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id 16so13381084qkg.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 09:02:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499677934-2249-1-git-send-email-jiang.biao2@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d6583a64-dbc4-f557-7688-b3d3081c382c@twiddle.net>
Date: Mon, 10 Jul 2017 06:01:49 -1000
MIME-Version: 1.0
In-Reply-To: <1499677934-2249-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: reserve a register for the
 guest_base.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>, qemu-devel@nongnu.org
Cc: jinguojie@loongson.cn, james.hogan@imgtec.com, jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, zhong.weidong@zte.com.cn

On 07/09/2017 11:12 PM, Jiang Biao wrote:
> Reserve a register for the guest_base using ppc code for reference.
> By doing so, we do not have to recompute it for every memory load.
> 
> Signed-off-by: Jiang Biao<jiang.biao2@zte.com.cn>
> Signed-off-by: Richard Henderson<rth@twiddle.net>
> ---
>   tcg/mips/tcg-target.inc.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)

For future reference, you should not add a Signed-off-by for someone else. 
That is like writing someone else's signature.

You may acknowledge my suggestion with a Suggested-by tag.

QEMU uses the same rules for this as does the linux kernel.  Please read

> https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst

or at least section 11 from

> https://github.com/torvalds/linux/blob/master/Documentation/translations/zh_CN/SubmittingPatches

(The translation may be be out of date.  I don't see any of the other tags, 
like Suggested-by, within the Chinese text.)

That said, applied to tcg-next.


r~
