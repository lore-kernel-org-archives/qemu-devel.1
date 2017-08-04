Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddj0E-0005Nw-Rs
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddj09-0000v4-PA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:15:22 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:37138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddj09-0000uX-IN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:15:17 -0400
Received: by mail-pg0-x235.google.com with SMTP id y129so11842139pgy.4
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 13:15:15 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7b74b23-2979-e3d5-0d1d-98d795ec89ee@linaro.org>
Date: Fri, 4 Aug 2017 13:15:13 -0700
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] target/arm: Allow deliver_fault()
 caller to specify EA bit
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

On 08/04/2017 10:20 AM, Peter Maydell wrote:
> For external aborts, we will want to be able to specify the EA
> (external abort type) bit in the syndrome field.  Allow callers of
> deliver_fault() to do that by adding a field to ARMMMUFaultInfo which
> we use when constructing the syndrome values.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h |  2 ++
>  target/arm/op_helper.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
