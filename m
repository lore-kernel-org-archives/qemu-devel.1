Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1gByrk-0004Q2-In
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1gByrf-0002E2-Ko
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:08:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jerome.forissier@linaro.org>)
	id 1gByrZ-000294-5j
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:08:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id y11-v6so20338517wrd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 02:08:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
References: <20181005080729.6480-1-jerome.forissier@linaro.org>
	<CAFEAcA9h7_vaKk7GuGVWv2_hFeR=xC4ZgJzLuD+iSqCdwa1PSw@mail.gmail.com>
	<d52c8388-5482-633b-bd9d-5eaf0eeb3eec@linaro.org>
Message-ID: <70f911cb-7d49-e8cb-e3cd-081033e010c2@linaro.org>
Date: Mon, 15 Oct 2018 11:08:28 +0200
MIME-Version: 1.0
In-Reply-To: <d52c8388-5482-633b-bd9d-5eaf0eeb3eec@linaro.org>
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

Hi Peter,

On 10/05/2018 11:26 AM, Jerome Forissier wrote:
> +CC: Rob Herring
> 
> On 10/05/2018 11:16 AM, Peter Maydell wrote:
>> On 5 October 2018 at 09:07, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>> Bindings for /secure-chosen and /secure-chosen/stdout-path have been
>>> proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].
>>>
>>> This patch creates the property when the machine is secure.
>>>
>>> [1] https://patchwork.kernel.org/patch/9602401/
>>> [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>
>> The patch seems OK, but it looks like the DT bindings are
>> not upstream yet? [*]
> 
> No, they're not.

Update: Rob has now accepted the bindings [3] (thanks!).

[3] http://patchwork.ozlabs.org/patch/980467/#2009642

-- 
Jerome

> 
>  I wouldn't want QEMU to start creating
>> bindings until the spec is definitely final.
> 
> I understand, but I think we may have a chicken-and-egg problem, because
> Rob said he'd like to see more usage of DT in secure world before
> merging the bindings ;-)
> 
> That being said, I can certainly re-submit the binding to the LKML. Rob,
> what do you say?
> 
>>
>> [*] they're not in
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/secure.txt
>> anyway; is that the wrong place to look?
>>
>> thanks
>> -- PMM
>>
> 
> Thanks,
> 
