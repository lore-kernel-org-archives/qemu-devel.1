Received: from eggs.gnu.org ([2001:4830:134:3::10]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ndM-0006R1-5T
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ndG-00073E-K3
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:20:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7ndF-0006pv-SP
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:20:30 -0400
Received: by mail-oi1-x241.google.com with SMTP id j68-v6so5631510oib.7
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:20:08 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69209684-a544-8d67-1c37-cf5e3a1ef159@linaro.org>
Date: Wed, 3 Oct 2018 15:20:04 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/13] target/arm: Add v8M stack checks for
 VLDM/VSTM
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
> Add the v8M stack checks for the VLDM/VSTM
> (aka VPUSH/VPOP) instructions. This code is currently
> unreachable because we haven't yet implemented M profile
> floating point support, but since the change is simple,
> we add it now because otherwise we're likely to forget to
> do it later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
