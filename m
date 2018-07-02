Received: from eggs.gnu.org ([2001:4830:134:3::10]:35479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fa2Gc-0004Le-9U
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fa2Ga-0000oL-TT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:05:33 -0400
Date: Mon, 2 Jul 2018 10:05:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180702170522.GA9885@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
	<CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 02, 2018 at 05:46:39PM +0100, Peter Maydell wrote:
> On 2 July 2018 at 17:27, Guenter Roeck <linux@roeck-us.net> wrote:
> > Again, in my observation the boot sometimes stalls without my
> > patch. Maybe there is a better fix, but the code as-is doesn't
> > work for me. All I can say is that the current code does not set
> > one-shot mode when it should, and that seems wrong.
> >
> > You could of course take out the zero delta warning. Personally
> > I would caution against that - whenever I have seen that warning,
> > it suggested that something is wrong with the emulation, and it
> > helped me track down the problem. Your call, of course. Also,
> > I don't think taking out the warning would fix my stall problem.
> 
> Can you provide me with something I can reproduce with, then,
> please? My kernel + buildroot don't repro the problem: it always
> seems to boot fine. I had a look at your testbuild git repo
> but couldn't manage to figure out how to build a binary
> from it. I'm ok with building a QEMU from your branch for
> testing this, but I'd rather not try to figure out how to
> reproduce your kernel and root filesystem setup.
> 

I don't think I'll have more time available to spend on this
anytime soon. If it works for you, just drop the patch. I can
keep it local in my branch. My version of qemu is different anyway,
after all.

Thanks,
Guenter
