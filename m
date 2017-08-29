Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj8S-00064W-Jk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj8P-0006ef-Dp
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:13:04 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:33280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj8P-0006e9-7s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:13:01 -0400
Received: by mail-pf0-x22b.google.com with SMTP id r62so11562842pfj.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:13:01 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-20-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb01a522-9cd5-070b-018a-8f0087d3a843@linaro.org>
Date: Tue, 29 Aug 2017 09:12:57 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-20-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/20] target/arm: Move regime_is_secure()
 to target/arm/internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Move the regime_is_secure() utility function to internals.h;
> we are going to want to call it from translate.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 26 ++++++++++++++++++++++++++
>  target/arm/helper.c    | 26 --------------------------
>  2 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
