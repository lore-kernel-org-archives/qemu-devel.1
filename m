Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiJMS-0004jg-7Q
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiJMP-00013v-9z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:57:48 -0400
Date: Wed, 25 Jul 2018 14:57:34 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180725125734.pzsv5mieynulqw6k@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
	<CAKv+Gu9n5Y9tghjR7VJcnH96-rzDWvhY4UCkPtFP9hNUh=LK=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9n5Y9tghjR7VJcnH96-rzDWvhY4UCkPtFP9hNUh=LK=Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 25, 2018 at 02:29:09PM +0200, Ard Biesheuvel wrote:
> To prevent spending a disproportionate amount of time on inventing
> ways to parameterize these 'models', which includes interfaces not
> only between UEFI and QEMU but also between ARM-TF and QEMU (and
> potentially between UEFI and ARM-TF as well), could we please consider

I guess a UEFI <=> ARM-TF interface will also need to work on real
hardware, and therefore need a QEMU model. If whatever that interface
needs can also satisfy the UEFI <=> QEMU and ARM-TF <=> interfaces,
then that's all we need - no need for fw-cfg.

> fixed configurations for the non-discoverable bits? If there is a new

Well, at least one thing must to be fixed, which is

 a) address/register where the address of the DTB will be stored
 b) address of the QEMU interface device, e.g. fw-cfg. fw-cfg or
    whatever can then be used to get the DTB.

And I guess everything the SBSA says should be fixed should be fixed.
Otherwise, what's non-discoverable?

> and improved sbsa model in the future, we could call it sbsa-2.0, no?

Of course the model can be versioned, allowing for any change, but
I don't think model versions were meant to be aliases for peripheral
selections. That's what scripts wrapped around qemu are for.

Thanks,
drew
