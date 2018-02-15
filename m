Received: from eggs.gnu.org ([2001:4830:134:3::10]:53575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLEh-00035d-Bg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLEg-0001NQ-Er
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:14:11 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
	<1518664462-2960-3-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8d09f7ec-c8de-d9fb-21c3-925e1c1a4247@twiddle.net>
Date: Thu, 15 Feb 2018 07:13:48 -0800
MIME-Version: 1.0
In-Reply-To: <1518664462-2960-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 02/14/2018 07:14 PM, Emilio G. Cota wrote:
> A couple of notes:
> 
> - removed ctx->nip in favour of base->pc_next. Yes, it is annoying,
>   but didn't want to waste its 4 bytes.
> 
> - ctx->singlestep_enabled does a lot more than
>   base.singlestep_enabled; this confused me at first.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/translate.c              | 129 +++++++++++++++++++-----------------
>  target/ppc/translate/dfp-impl.inc.c |  16 ++---
>  target/ppc/translate_init.c         |  32 ++++-----
>  3 files changed, 91 insertions(+), 86 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
