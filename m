Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er8lh-0001Se-1z
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er8lc-0000yM-MB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:56:05 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:34546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er8lc-0000y6-FX
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:56:00 -0500
Received: by mail-pl0-x22e.google.com with SMTP id u13-v6so2260757plq.1
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:56:00 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-5-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd9a9862-cdd9-97f5-d70e-9e6bf703ed43@linaro.org>
Date: Wed, 28 Feb 2018 12:55:56 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/16] tcg: move
 tb_ctx.tb_phys_invalidate_count to tcg_ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/26/2018 09:39 PM, Emilio G. Cota wrote:
> Thereby making it per-TCGContext. Once we remove tb_lock, this will
> avoid an atomic increment every time a TB is invalidated.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c |  5 +++--
>  include/exec/tb-context.h |  1 -
>  tcg/tcg.c                 | 14 ++++++++++++++
>  tcg/tcg.h                 |  3 +++
>  4 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
