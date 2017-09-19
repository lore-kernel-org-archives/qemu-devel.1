Received: from eggs.gnu.org ([2001:4830:134:3::10]:38859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNbL-0000Oh-Q5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNbK-0006pg-QU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:50:31 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:50970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNbK-0006pL-Mc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:50:30 -0400
Received: by mail-io0-x231.google.com with SMTP id w94so1347339ioi.7
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:50:30 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-13-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58618c0e-9336-2cf8-9db2-d11181c29ea7@linaro.org>
Date: Tue, 19 Sep 2017 13:50:26 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-13-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/19] nvic: In escalation to HardFault,
 support HF not being priority -1
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

On 09/12/2017 01:13 PM, Peter Maydell wrote:
> When escalating to HardFault, we must go into Lockup if we
> can't take the synchronous HardFault because the current
> execution priority is already at or below the priority of
> HardFault. In v7M HF is always priority -1 so a simple < 0
> comparison sufficed; in v8M the priority of HardFault can
> vary depending on whether it is a Secure or NonSecure
> HardFault, so we must check against the priority of the
> HardFault exception vector we're about to use.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
