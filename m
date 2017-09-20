Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duj1s-0002bZ-V5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duj1o-0002D5-58
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:43:21 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:50041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duj1n-0002Ck-UT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:43:16 -0400
Received: by mail-io0-x231.google.com with SMTP id 21so5304698iof.6
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:43:15 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-18-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a4721f0f-5018-7fe2-3751-588b35db5bec@linaro.org>
Date: Wed, 20 Sep 2017 12:43:11 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-18-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/19] nvic: Make ICSR banked for v8M
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

On 09/12/2017 01:14 PM, Peter Maydell wrote:
> The ICSR NVIC register is banked for v8M. This doesn't
> require any new state, but it does mean that some bits
> are controlled by BFHNFNMINS and some bits must work
> with the correct banked exception. There is also a new
> in v8M PENDNMICLR bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
