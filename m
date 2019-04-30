Received: from eggs.gnu.org ([209.51.188.92]:52550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOuY-0006Ki-BB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOuX-00079e-GK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLOuX-000794-BJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id t189so7636760oih.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:18:37 +0100
Message-ID: <CAFEAcA-SFrcbQMdv19tJw_baGR8c_ngR2CtsgZKVXMALOo=zoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/fsl-imx: move cpus initialization
 to realize time after smp_cpus check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, 30 Apr 2019 at 09:52, Like Xu <like.xu@linux.intel.com> wrote:
>
> If "smp_cpus> FSL_IMX6_NUM_CPUS" fails in *_realize(), there is no need to
> initialize the CPUs in *_init(). So it could be better to create all cpus
> after the validity in *_realize(). On the other hand, it makes the usages
> of global variable smp_cpus more centrally for maintenance.

I'm not a great fan of this. I think that where possible
we should init child objects in the parent's init
function, and realize them in the realize function.
There are a few cases where we're forced to do the
child init in realize, but this doesn't seem like one of them.

thanks
-- PMM
