Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er70J-0001SR-AS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er70G-0006UI-8v
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:03:03 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er70G-0006Ty-1W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:03:00 -0500
Received: by mail-pl0-x241.google.com with SMTP id 93-v6so2063748plc.9
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:02:59 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4769076a-58e4-925b-126d-ab39ef30610f@linaro.org>
Date: Wed, 28 Feb 2018 11:02:55 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/16] qht: require a default comparison
 function
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
> qht_lookup now uses the default cmp function. qht_lookup_custom is defined
> to retain the old behaviour, that is a cmp function is explicitly provided.
> 
> qht_insert will gain use of the default cmp in the next patch.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cpu-exec.c      |  4 ++--
>  accel/tcg/translate-all.c | 16 +++++++++++++++-
>  include/qemu/qht.h        | 23 +++++++++++++++++++----
>  tests/qht-bench.c         | 14 +++++++-------
>  tests/test-qht.c          | 15 ++++++++++-----
>  util/qht.c                | 14 +++++++++++---
>  6 files changed, 64 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
