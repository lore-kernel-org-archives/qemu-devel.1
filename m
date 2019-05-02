Received: from eggs.gnu.org ([209.51.188.92]:52220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDCr-00044Y-CF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDCq-0006Vi-Bp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:01:05 -0400
Date: Thu, 2 May 2019 17:00:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190502170042.4b714211@Igors-MacBook-Pro>
In-Reply-To: <CAFEAcA-SFrcbQMdv19tJw_baGR8c_ngR2CtsgZKVXMALOo=zoA@mail.gmail.com>
References: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
	<CAFEAcA-SFrcbQMdv19tJw_baGR8c_ngR2CtsgZKVXMALOo=zoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Like Xu <like.xu@linux.intel.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrey Smirnov <andrew.smirnov@gmail.com>

On Tue, 30 Apr 2019 10:18:37 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 30 Apr 2019 at 09:52, Like Xu <like.xu@linux.intel.com> wrote:
> >
> > If "smp_cpus> FSL_IMX6_NUM_CPUS" fails in *_realize(), there is no need to
> > initialize the CPUs in *_init(). So it could be better to create all cpus
> > after the validity in *_realize(). On the other hand, it makes the usages
> > of global variable smp_cpus more centrally for maintenance.
> 
> I'm not a great fan of this. I think that where possible
> we should init child objects in the parent's init
> function, and realize them in the realize function.
> There are a few cases where we're forced to do the
> child init in realize, but this doesn't seem like one of them.

well, if it were unconditional then initializing children in initfn would
be fine, however here number of children to initialize depends on global
smp_cpus. In order to get rid of global, we could move iniialization to realize
time or init all FSL_IMX6_NUM_CPUS and realize only smp_cpus at realize time.

> 
> thanks
> -- PMM
