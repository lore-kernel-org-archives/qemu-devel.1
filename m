Received: from eggs.gnu.org ([2001:4830:134:3::10]:52036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5ker-0004is-94
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5keq-0002o7-FF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:13:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5keq-0002nj-8R
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:13:24 -0400
Received: by mail-pf0-x244.google.com with SMTP id f15so7173588pfn.0
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:13:24 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-14-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97040c1f-3d45-d048-735b-1d78171ea271@linaro.org>
Date: Tue, 10 Apr 2018 14:13:18 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-14-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/17] target/openrisc: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> While at it, set is_jmp to DISAS_NORETURN when generating
> an exception.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/translate.c | 93 ++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
