Received: from eggs.gnu.org ([2001:4830:134:3::10]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvJmp-0002eQ-L2
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvJmk-0007mU-Nc
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:02:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1fvJmk-0007hR-7U
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:02:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id w11-v6so7484753wrc.5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 03:02:37 -0700 (PDT)
Date: Thu, 30 Aug 2018 11:02:33 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Aug 30, 2018 at 09:39:33AM +0100, Peter Maydell wrote:
> On 30 August 2018 at 09:31, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
> >> @Ard, @Leif, is there any possibility to remove all the DT nodes?
> >> On real hardware, how does UEFI find the memory size and CPU number?
> >
> > Usually by asking some form of SCP/PMU.
> > So until we have rock-solid multi-cpu-instance (making terms up here,
> > there may be a proper name already?) support upstream, we need to take
> > shortcuts.
> 
> I would expect that you'd want a "faked-on-the-QEMU end" SCP
> communications endpoint to start with anyway. We have one of
> those for vexpress, for instance.

Ah, I wasn't aware we did!

In that case - sure, that is probably the more sensible solution.
Does it emulate SCMI?

/
    Leif
