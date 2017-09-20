Received: from eggs.gnu.org ([2001:4830:134:3::10]:50630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duihH-00041i-3T
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duihD-0004po-PY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:22:03 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duihD-0004pE-I1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:21:59 -0400
Received: by mail-io0-x233.google.com with SMTP id z187so5119046ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:21:59 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-16-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32822ee7-ab8d-7455-e6ad-ac705fc54c4d@linaro.org>
Date: Wed, 20 Sep 2017 12:21:55 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-16-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/19] nvic: Handle v8M changes in
 nvic_exec_prio()
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
> Update nvic_exec_prio() to support the v8M changes:
>  * BASEPRI, FAULTMASK and PRIMASK are all banked
>  * AIRCR.PRIS can affect NS priorities
>  * AIRCR.BFHFNMINS affects FAULTMASK behaviour
> 
> These changes mean that it's no longer possible to
> definitely say that if FAULTMASK is set it overrides
> PRIMASK, and if PRIMASK is set it overrides BASEPRI
> (since if PRIMASK_NS is set and AIRCR.PRIS is set then
> whether that 0x80 priority should take effect or the
> priority in BASEPRI_S depends on the value of BASEPRI_S,
> for instance). So we switch to the same approach used
> by the pseudocode of working through BASEPRI, PRIMASK
> and FAULTMASK and overriding the previous values if
> needed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
