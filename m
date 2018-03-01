Received: from eggs.gnu.org ([2001:4830:134:3::10]:42355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erL5i-0004uq-Ti
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erL5f-0004gX-55
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:34 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:36101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erL5f-0004fn-0C
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:31 -0500
Received: by mail-oi0-x234.google.com with SMTP id u73so4067852oie.3
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 02:05:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180301105030.2b716e68@redhat.com>
References: <000e01d3afad$b9a13830$2ce3a890$@codeaurora.org>
	<20180227104708.GA11391@cbox>
	<ac329e1b1f5265a805916ab4f8708f9d@codeaurora.org>
	<20180227124604.GA2373@cbox>
	<20180227132131.fipafmnb56a7fj76@kamzik.brq.redhat.com>
	<20180301105030.2b716e68@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 10:05:09 +0000
Message-ID: <CAFEAcA9yaU745Asy--jM0nu8FDJ62CEXSH_TKa-ZZfC16qye6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm]  VCPU hotplug on KVM/ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, bthakur@codeaurora.org, Christoffer Dall <cdall@cs.columbia.edu>, Christoffer Dall <cdall@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christofferdall@christofferdall.dk>, qemu-arm <qemu-arm@nongnu.org>, kvmarm@lists.cs.columbia.edu

On 1 March 2018 at 09:50, Igor Mammedov <imammedo@redhat.com> wrote:
> In QEMU on x86 (and I think ppc, s390 as well), we create vCPUs on demand.
>
> It would be nice if ARM would be able to do that too,
> so that it could take advantage of the same code.

It's not clear to me how that would work, given that for
instance the interrupt controller wants to know up-front
how many CPUs it has to deal with.

thanks
-- PMM
