Received: from eggs.gnu.org ([2001:4830:134:3::10]:59118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er77P-00038z-3F
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er77K-00036y-SS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:10:23 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er77K-00036L-M6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:10:18 -0500
Received: by mail-pl0-x243.google.com with SMTP id i6-v6so2082806plt.7
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:10:18 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-3-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a47e952e-f89b-c5a8-8c80-fb8feb6be4c2@linaro.org>
Date: Wed, 28 Feb 2018 11:10:14 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/16] qht: return existing entry when
 qht_insert fails
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
> The meaning of "existing" is now changed to "matches in hash and
> ht->cmp result". This is saner than just checking the pointer value.
> 
> Note that we now return NULL on insertion success, or the existing
> pointer on failure. We can do this because NULL pointers are not
> allowed to be inserted in QHT.
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/qht.h |  7 ++++---
>  tests/qht-bench.c  |  4 ++--
>  tests/test-qht.c   |  5 ++++-
>  util/qht.c         | 17 +++++++++--------
>  4 files changed, 19 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
