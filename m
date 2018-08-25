Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftbd2-0002Io-Lm
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftbW5-00055Z-S4
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:34:30 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftbW5-000552-EM
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:34:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id a4-v6so2334460plm.13
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 09:34:25 -0700 (PDT)
References: <20180824203101.30125-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9401017-cd51-aec6-05bd-2a4115133757@linaro.org>
Date: Sat, 25 Aug 2018 09:34:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180824203101.30125-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: fix leak of rev array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 08/24/2018 01:31 PM, Emilio G. Cota wrote:
> Introduced in 04d595b300 ("spapr: do not use CPU_FOREACH_REVERSE",
> 2018-08-23)
> 
> Fixes: CID1395181
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
