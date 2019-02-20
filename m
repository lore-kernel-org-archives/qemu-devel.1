Received: from eggs.gnu.org ([209.51.188.92]:39441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWui-0000qt-Ea
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWfU-0004JO-95
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:32:30 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWfS-0004HH-85
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:32:28 -0500
Received: by mail-pl1-x641.google.com with SMTP id o6so12637460pls.13
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:32:22 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3372d40-ba23-2060-cffa-18e63955a654@linaro.org>
Date: Wed, 20 Feb 2019 10:32:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] hw/arm/armsse: Unify init-svtor and
 cpuwait handling
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

On 2/19/19 4:58 AM, Peter Maydell wrote:
> At the moment the handling of init-svtor and cpuwait initial
> values is split between armsse.c and iotkit-sysctl.c:
> the code in armsse.c sets the initial state of the CPU
> object by setting the init-svtor and start-powered-off
> properties, but the iotkit-sysctl.c code has its own
> code setting the reset values of its registers (which are
> then used when updating the CPU when the guest makes
> runtime changes).
> 
> Clean this up by making the armsse.c code set properties on the
> iotkit-sysctl object to define the initial values of the
> registers, so they always match the initial CPU state,
> and update the comments in armsse.c accordingly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-sysctl.h |  3 ++
>  hw/arm/armsse.c                 | 49 +++++++++++++++++++++------------
>  hw/misc/iotkit-sysctl.c         | 20 ++++++--------
>  3 files changed, 42 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
