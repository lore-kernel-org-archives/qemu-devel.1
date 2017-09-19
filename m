Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNfd-00020M-9q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNfa-0001Aq-5r
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:54:57 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:55274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNfa-0001AU-14
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:54:54 -0400
Received: by mail-io0-x22c.google.com with SMTP id h66so1337968ioh.11
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:54:53 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-14-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b80ed6a1-dc49-c5b8-1e76-7afcf1b3d4f2@linaro.org>
Date: Tue, 19 Sep 2017 13:54:49 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-14-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/19] nvic: Implement v8M changes to fixed
 priority exceptions
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
> In v7M, the fixed-priority exceptions are:
>  Reset: -3
>  NMI: -2
>  HardFault: -1
> 
> In v8M, this changes because Secure HardFault may need
> to be prioritised above NMI:
>  Reset: -4
>  Secure HardFault if AIRCR.BFHFNMINS == 1: -3
>  NMI: -2
>  Secure HardFault if AIRCR.BFHFNMINS == 0: -1
>  NonSecure HardFault: -1
> 
> Make these changes, including support for changing the
> priority of Secure HardFault as AIRCR.BFHFNMINS changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
