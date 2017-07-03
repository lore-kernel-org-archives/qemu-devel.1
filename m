Received: from eggs.gnu.org ([2001:4830:134:3::10]:40872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dRtG6-0000G9-TP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 00:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dRtG5-0001cf-RL
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 00:46:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zxjMJN0Uv4L+vM5S8yw93GDbAh9xQxmrOESAxeAS_Rg@mail.gmail.com>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<d403f33f-647e-a142-4265-7d856d8be6aa@amsat.org>
	<CALHRZur8Uh0JCnOoY-_mUU_fyzbUgxbmWKtfOoB-GTYR5UcEnQ@mail.gmail.com>
	<CALHRZuoVHFOYV345JmvSkfJHsVjS7Wv_ySzAUtwo1D7eyoS_XQ@mail.gmail.com>
	<648515bf-ba1e-3d7f-d5bd-51b243f8c29f@amsat.org>
	<CALHRZuoihb2Oiu9adm=2gPUf-LFdkBR9qw1iV+ohL6kp0t5d=A@mail.gmail.com>
	<CALHRZuoFU6vmnEBobVEqesApB6qm6cmNQfm9oVMG2RaooNEh7Q@mail.gmail.com>
	<CALHRZuosbYEcBYgjRu+45RZD6e7VWL5hQErAB7rJNEQ7ZdPguA@mail.gmail.com>
	<CAFEAcA8zxjMJN0Uv4L+vM5S8yw93GDbAh9xQxmrOESAxeAS_Rg@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 3 Jul 2017 10:16:48 +0530
Message-ID: <CALHRZur+Kg8fsUG6Ct=4SUgaAZ+ge3Zf-R9gn=Y1G29eQ1FHFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Peter,

On Mon, Jul 3, 2017 at 2:30 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 2 July 2017 at 18:39, sundeep subbaraya <sundeep.lkml@gmail.com> wrote:
> > I figured out that systick uses cpu clock as clock source and
> > system_clock_scale
> > need to be set in msf2-soc.c. There is a bug in u-boot where it uses cpu
> > clock as
> > systick input but configures systick in external clock mode. I have
> tested
> > the modified
> > u-boot on real hardware too and it works fine. I am calculating
> > system_clock_scale
> > as below:
> > If CPU clock is X MHz then system_clock_scale = (1 / X) * 1000
> >
> > Tested with different frequencies and they are yielding same results.
>
> If you calculate it like that you'll probably get rounding
> errors. Better is
>   system_clock_scale = NANOSECONDS_PER_SECOND / freq_in_hz;
>
> (Our systick implementation hardwires the external clock
> frequency at 1MHz, but this is not really correct, it
> depends on the SoC.)
>

Ok. Modified as per your comment.

Thanks,
Sundeep

>
> thanks
> -- PMM
>
