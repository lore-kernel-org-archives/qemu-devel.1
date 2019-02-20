Received: from eggs.gnu.org ([209.51.188.92]:48112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwXJj-0006Of-88
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwXJi-0001Jk-KB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:14:03 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwXJg-0001DU-I4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:14:02 -0500
Received: by mail-ot1-x342.google.com with SMTP id i20so42162257otl.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-4-peter.maydell@linaro.org>
	<a2bc1e0a-b3d1-1f5a-d82c-7a3e1f06522f@linaro.org>
In-Reply-To: <a2bc1e0a-b3d1-1f5a-d82c-7a3e1f06522f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Feb 2019 19:13:42 +0000
Message-ID: <CAFEAcA_mnA36ZcJ9WJh=tA=ZDncD9b==09B_ub3Zfyu-zKpZ+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Wed, 20 Feb 2019 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/19/19 4:58 AM, Peter Maydell wrote:
> > +static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
> > +                               void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    visit_type_uint32(v, name, &cpu->init_svtor, errp);
> > +}
>
> Since there's no validation needed, can this use object_property_add_uint32_ptr?

I tried that first, but it doesn't let you set the property,
only read it...

thanks
-- PMM
