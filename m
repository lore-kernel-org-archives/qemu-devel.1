Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daoPM-0001VY-9p
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daoPJ-0005qt-Cy
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:25:16 -0400
References: <1501122983-20801-1-git-send-email-jiang.biao2@zte.com.cn>
From: John Snow <jsnow@redhat.com>
Message-ID: <22cd68ee-bebd-3de0-24b4-59373b37390b@redhat.com>
Date: Thu, 27 Jul 2017 15:25:06 -0400
MIME-Version: 1.0
In-Reply-To: <1501122983-20801-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/README: fix a description error.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>, qemu-devel@nongnu.org
Cc: shi.zhongbing@zte.com.cn, jiang.yong5@zte.com.cn, rth@twiddle.net, QEMU Trivial <qemu-trivial@nongnu.org>



On 07/26/2017 10:36 PM, Jiang Biao wrote:
> The atomics.txt is not in the docs directory but in docs/devel/
> instead.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>   tcg/README | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/README b/tcg/README
> index bf49e82..03bfb6a 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -446,7 +446,7 @@ when MTTCG is enabled.
>   The guest translators should generate this opcode for all guest instructions
>   which have ordering side effects.
>   
> -Please see docs/atomics.txt for more information on memory barriers.
> +Please see docs/devel/atomics.txt for more information on memory barriers.
>   
>   ********* 64-bit guest on 32-bit host support
>   
> 

Reviewed-by: John Snow <jsnow@redhat.com>

CC qemu-trivial
