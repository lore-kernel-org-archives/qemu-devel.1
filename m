Received: from eggs.gnu.org ([2001:4830:134:3::10]:45525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4ws-0006Fr-M8
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4wn-0007eZ-M1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:38:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC4wm-0007cp-Kc
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:38:20 -0400
Received: by mail-pg1-x544.google.com with SMTP id v133-v6so9348635pgb.2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 08:38:18 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cca1e586-39d1-d2d2-c9be-c39ac8ad05c1@linaro.org>
Date: Mon, 15 Oct 2018 08:38:13 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/10] target/arm: Implement HCR.PTW
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

On 10/12/18 7:42 AM, Peter Maydell wrote:
> If the HCR_EL2 PTW virtualizaiton configuration register bit
> is set, then this means that a stage 2 Permission fault must
> be generated if a stage 1 translation table access is made
> to an address that is mapped as Device memory in stage 2.
> Implement this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
