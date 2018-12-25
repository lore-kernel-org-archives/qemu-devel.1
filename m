Received: from eggs.gnu.org ([208.118.235.92]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtbQ-000802-E3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtbN-0002GA-Aq
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:47:00 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtbN-0002E4-5I
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:46:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so6818889pgs.2
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:46:57 -0800 (PST)
References: <20181221195200.6544-1-cota@braap.org>
	<20181221195200.6544-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98ec98e3-3ddc-ae8e-5e2c-738ae8c4c057@linaro.org>
Date: Wed, 26 Dec 2018 07:46:43 +1100
MIME-Version: 1.0
In-Reply-To: <20181221195200.6544-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] fp-bench: remove wrong exponent raise
 in fill_random
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/22/18 6:52 AM, Emilio G. Cota wrote:
> At this point random_ops[] only contains normals, so there's
> no need to do anything to them. In fact, raising the exponent
> here can make the output !normal, which is precisely
> what the comment says we want to avoid.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tests/fp/fp-bench.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
