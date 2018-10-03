Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nVu-0001x1-Qj
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nVp-0002aN-9n
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:12:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nVo-0002ZC-ES
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:12:48 -0400
Received: by mail-ot1-x343.google.com with SMTP id u22so6839158ota.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:12:48 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0893e12-5c6e-8d4f-55ae-bc9b5ada9c2f@linaro.org>
Date: Wed, 3 Oct 2018 15:12:43 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] target/arm: Add v8M stack checks on
 exception entry
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Add checks for breaches of the v8M stack limit when the
> stack pointer is decremented to push the exception frame
> for exception entry.
> 
> Note that the exception-entry case is unique in that the
> stack pointer is updated to be the limit value if the limit
> is hit (per rule R_ZLZG).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 54 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
