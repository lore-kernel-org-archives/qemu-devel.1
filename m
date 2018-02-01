Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehJCy-0007aM-E0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehJCx-0006Hn-Iy
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:03:36 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehJCx-0006H6-Cz
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:03:35 -0500
Received: by mail-ot0-x242.google.com with SMTP id f100so17758359otf.3
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:03:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517506091-10396-1-git-send-email-wei@redhat.com>
References: <1517506091-10396-1-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2018 18:03:14 +0000
Message-ID: <CAFEAcA-AVqDdVwdwYM6vRkNSymGbOiEEqU5+sAN2w4pjpUtiig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/arm/virt: Set default machine and
 CPU types for mach-virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 1 February 2018 at 17:28, Wei Huang <wei@redhat.com> wrote:
> Unlike most other QEMU architectures, the default machine type for
> mach-virt is not set.

This is deliberate. There is no single "right" choice for
a machine type for Arm boards. We had a bunch of problems
back when we did have a default type, because it was the
ancient integratorcp board, and users got confused expecting
QEMU to just work without specifying a machine type.

> This causes problems in situations where the
> default machine types are not provided (e.g. qtest_start() function
> in many QEMU tests). This patch designates the latest mach-virt
> machine type (alias of "virt") as the default machine type. It also
> changes the default CPU depending on the target.

> +#ifdef TARGET_AARCH64
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
> +#else
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> +#endif

This makes the behaviour be different depending whether you're
running qemu-system-arm or qemu-system-aarch64. The two are
supposed to behave the same way if you give them the same
command line options (like x86 QEMU).


thanks
-- PMM
