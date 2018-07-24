Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2QA-0001p6-6Y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2Q9-0003VO-Gt
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:30 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2Q9-0003Ui-91
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:29 -0400
Received: by mail-pl0-x242.google.com with SMTP id m1-v6so2153324plt.6
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:52:29 -0700 (PDT)
References: <20180724115950.17316-1-peter.maydell@linaro.org>
	<20180724115950.17316-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3cd03de-46e7-11f1-bc35-1a351052864e@linaro.org>
Date: Tue, 24 Jul 2018 11:52:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180724115950.17316-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/arm: Honour HCR_EL2.TGE and
 MDCR_EL2.TDE in debug register access checks
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

On 07/24/2018 04:59 AM, Peter Maydell wrote:
> Some debug registers can be trapped via MDCR_EL2 bits TDRA, TDOSA,
> and TDA, which we implement in the functions access_tdra(),
> access_tdosa() and access_tda(). If MDCR_EL2.TDE or HCR_EL2.TGE
> are 1, the TDRA, TDOSA and TDA bits should behave as if they were 1.
> Implement this by having the access functions check MDCR_EL2.TDE
> and HCR_EL2.TGE.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
