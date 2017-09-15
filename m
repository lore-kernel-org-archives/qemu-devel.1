Received: from eggs.gnu.org ([2001:4830:134:3::10]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dskA3-0007qI-OJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dskA2-0003fS-D5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:31:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_D=4M2vyo4m2xPi_hFDCmoKHk5kLY3s1ota602ywgHTQ@mail.gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-6-git-send-email-sundeep.lkml@gmail.com>
	<CAFEAcA_D=4M2vyo4m2xPi_hFDCmoKHk5kLY3s1ota602ywgHTQ@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Fri, 15 Sep 2017 12:01:33 +0530
Message-ID: <CALHRZuoviT4xbYLVWPybVTkASZquxhcQU=h4+YC1KK=1SW=VWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi Peter,

On Thu, Sep 14, 2017 at 10:44 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 7 September 2017 at 20:24, Subbaraya Sundeep <sundeep.lkml@gmail.com>
> wrote:
> > Emulated Emcraft's Smartfusion2 System On Module starter
> > kit.
> > +static void emcraft_sf2_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
> > +    mc->init = emcraft_sf2_s2s010_init;
> > +    mc->ignore_memory_transaction_failures = true;
>
> Please don't set ignore_memory_transaction_failures in new boards.
> This is a legacy-old-code-only flag.
>
> New boards should define enough devices, either properly
> or using create_unimplemented_device(), to make whatever code
> they're being tested against run.
>
> This is a firm requirement for this code to go into master,
> because once we let a board in with the flag set it's almost
> impossible to clear it because we don't know what guest
> code that previously worked on the board will now break.
>

Ok. I am working on it and will send next spin with this fix.

Thanks,
Sundeep


> thanks
> -- PMM
>
