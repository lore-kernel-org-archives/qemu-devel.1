Received: from eggs.gnu.org ([2001:4830:134:3::10]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA0j-0002iR-MT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA0g-0001sw-Cn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:15:41 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erA0f-0001s1-Sh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:15:38 -0500
Received: by mail-pl0-x242.google.com with SMTP id u13-v6so2385921plq.1
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:15:37 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-7-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d739d8f-1eba-6415-d514-7609eddc9266@linaro.org>
Date: Wed, 28 Feb 2018 14:15:33 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/16] translate-all: make l1_map lockless
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
> Groundwork for supporting parallel TCG generation.
> 
> We never remove entries from the radix tree, so we can use cmpxchg
> to implement lockless insertions.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c       | 24 ++++++++++++++----------
>  docs/devel/multi-thread-tcg.txt |  4 ++--
>  2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
