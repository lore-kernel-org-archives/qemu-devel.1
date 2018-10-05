Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1g8MRT-0001nL-E9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1g8MNt-0001gR-Dr
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:27:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jerome.forissier@linaro.org>)
	id 1g8MNr-0001be-Jl
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:26:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id b19-v6so1195113wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 02:26:54 -0700 (PDT)
References: <20181005080729.6480-1-jerome.forissier@linaro.org>
	<CAFEAcA9h7_vaKk7GuGVWv2_hFeR=xC4ZgJzLuD+iSqCdwa1PSw@mail.gmail.com>
From: Jerome Forissier <jerome.forissier@linaro.org>
Message-ID: <d52c8388-5482-633b-bd9d-5eaf0eeb3eec@linaro.org>
Date: Fri, 5 Oct 2018 11:26:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9h7_vaKk7GuGVWv2_hFeR=xC4ZgJzLuD+iSqCdwa1PSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>

+CC: Rob Herring

On 10/05/2018 11:16 AM, Peter Maydell wrote:
> On 5 October 2018 at 09:07, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>> Bindings for /secure-chosen and /secure-chosen/stdout-path have been
>> proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].
>>
>> This patch creates the property when the machine is secure.
>>
>> [1] https://patchwork.kernel.org/patch/9602401/
>> [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> The patch seems OK, but it looks like the DT bindings are
> not upstream yet? [*]

No, they're not.

 I wouldn't want QEMU to start creating
> bindings until the spec is definitely final.

I understand, but I think we may have a chicken-and-egg problem, because
Rob said he'd like to see more usage of DT in secure world before
merging the bindings ;-)

That being said, I can certainly re-submit the binding to the LKML. Rob,
what do you say?

> 
> [*] they're not in
> https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/secure.txt
> anyway; is that the wrong place to look?
> 
> thanks
> -- PMM
> 

Thanks,
-- 
Jerome
