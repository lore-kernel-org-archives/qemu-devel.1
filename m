Received: from eggs.gnu.org ([2001:4830:134:3::10]:46565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMN7-0007K5-2w
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMN6-0000b7-AZ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:14:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMN5-0000WO-Lh
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:14:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id p125-v6so17560222oic.3
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:14:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70f911cb-7d49-e8cb-e3cd-081033e010c2@linaro.org>
References: <20181005080729.6480-1-jerome.forissier@linaro.org>
	<CAFEAcA9h7_vaKk7GuGVWv2_hFeR=xC4ZgJzLuD+iSqCdwa1PSw@mail.gmail.com>
	<d52c8388-5482-633b-bd9d-5eaf0eeb3eec@linaro.org>
	<70f911cb-7d49-e8cb-e3cd-081033e010c2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:14:18 +0100
Message-ID: <CAFEAcA-+tmc5E7VksWTe_0UEs5xt9YBVGiE+8ev8ChDu0OLRYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: add DT property
 /secure-chosen/sdtout-path being secure UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>

On 15 October 2018 at 10:08, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
> Hi Peter,
>
> On 10/05/2018 11:26 AM, Jerome Forissier wrote:
>> +CC: Rob Herring
>>
>> On 10/05/2018 11:16 AM, Peter Maydell wrote:
>>> On 5 October 2018 at 09:07, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>> Bindings for /secure-chosen and /secure-chosen/stdout-path have been
>>>> proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].
>>>>
>>>> This patch creates the property when the machine is secure.
>>>>
>>>> [1] https://patchwork.kernel.org/patch/9602401/
>>>> [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>
>>> The patch seems OK, but it looks like the DT bindings are
>>> not upstream yet? [*]
>>
>> No, they're not.
>
> Update: Rob has now accepted the bindings [3] (thanks!).

OK; I've applied the QEMU patch to my target-arm.next branch.

thanks
-- PMM
