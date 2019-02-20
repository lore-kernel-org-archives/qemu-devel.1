Received: from eggs.gnu.org ([209.51.188.92]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWPh-0002rW-2L
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWPf-0003f1-Cq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:16:08 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:45021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWPe-0003cu-EC
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:16:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id c4so7588264pls.11
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:16:02 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2bc1e0a-b3d1-1f5a-d82c-7a3e1f06522f@linaro.org>
Date: Wed, 20 Feb 2019 10:15:58 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] target/arm/cpu: Allow init-svtor
 property to be set after realize
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
> +static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    visit_type_uint32(v, name, &cpu->init_svtor, errp);
> +}

Since there's no validation needed, can this use object_property_add_uint32_ptr?

That said, this isn't wrong so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
