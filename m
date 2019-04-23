Received: from eggs.gnu.org ([209.51.188.92]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5OR-0001cP-86
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ58Z-0004GT-NF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:47:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ58Z-0004FB-Ey
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:47:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id c207so8276235pfc.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:47:42 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbefe736-b85f-1b97-6ffb-07630992d3f4@linaro.org>
Date: Tue, 23 Apr 2019 16:47:37 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/26] target/arm: Move NS TBFLAG from bit
 19 to bit 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Move the NS TBFLAG down from bit 19 to bit 6, which has not
> been used since commit c1e3781090b9d36c60 in 2015, when we
> started passing the entire MMU index in the TB flags rather
> than just a 'privilege level' bit.
> 
> This rearrangement is not strictly necessary, but means that
> we can put M-profile-only bits next to each other rather
> than scattered across the flag word.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
