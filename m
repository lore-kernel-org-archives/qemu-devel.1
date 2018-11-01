Received: from eggs.gnu.org ([2001:4830:134:3::10]:58247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIHpF-0003Kp-2Z
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIHpD-000834-8g
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:36:12 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 1 Nov 2018 11:36:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181101183601.GA26023@roeck-us.net>
References: <20181030193044.25954-1-philmd@redhat.com>
	<CAFEAcA-r=d-s0SS4_VDX1A=viaZkS0SxJW-3mVn6Brrx8QHCew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-r=d-s0SS4_VDX1A=viaZkS0SxJW-3mVn6Brrx8QHCew@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] arm: exynos4: Add dma support for
 smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Thu, Nov 01, 2018 at 05:24:15PM +0000, Peter Maydell wrote:
> On 30 October 2018 at 19:30, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > QEMU already supports pl330. Instantiate it for smdkc210.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I don't suppose anybody has the SoC datasheet to crosscheck
> the irq/address values (and maybe see if it lists any of
> the other pl330 settings) ?
> 

Not me. This was "look into the Linux kernel code and then play
with parameters until it magically starts working".

Guenter
