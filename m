Received: from eggs.gnu.org ([2001:4830:134:3::10]:47292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBjDk-0004Ct-1Y
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBjDg-0006Gn-KM
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:26:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBjDf-0006Fo-U1
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:26:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id m77-v6so8459848pfi.8
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 09:26:19 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c1dc4cd3-7379-0602-b911-d8e2845c02c2@linaro.org>
Date: Sun, 14 Oct 2018 09:26:15 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/10] target/arm: Implement HCR.DC
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
> The HCR.DC virtualization configuration register bit has the
> following effects:
>  * SCTLR.M behaves as if it is 0 for all purposes except
>    direct reads of the bit
>  * HCR.VM behaves as if it is 1 for all purposes except
>    direct reads of the bit
>  * the memory type produced by the first stage of the EL1&EL0
>    translation regime is Normal Non-Shareable,
>    Inner Write-Back Read-Allocate Write-Allocate,
>    Outer Write-Back Read-Allocate Write-Allocate.
> 
> Implement this behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
