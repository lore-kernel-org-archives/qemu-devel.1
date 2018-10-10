Received: from eggs.gnu.org ([2001:4830:134:3::10]:34496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gAG0n-0000Qp-JH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gAG0m-0007wY-Fq
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:02:57 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Oct 2018 08:02:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181010150241.GA4418@roeck-us.net>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<a98fbbe0-ead2-b32a-54ee-8aacc08ed7a6@amsat.org>
	<2955b0dc-9730-4d54-5c26-bcb18002373e@roeck-us.net>
	<CAAdtpL6c-_=zHqF1vBHVgM9=DA3PMYu1HX60oCy1DrzZ-LRVmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAdtpL6c-_=zHqF1vBHVgM9=DA3PMYu1HX60oCy1DrzZ-LRVmA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH] hw: arm: Add basic support
 for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>, Clement Deschamps <clement.deschamps@antfield.fr>, Luc Michel <luc.michel@git.antfield.fr>

On Wed, Oct 10, 2018 at 03:25:22PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On Tue, Jul 17, 2018 at 6:08 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 07/16/2018 06:53 PM, Philippe Mathieu-Daudé wrote:
> > > Hi Guenter,
> > >
> > > On 07/15/2018 07:06 PM, Guenter Roeck wrote:
> > >> Add basic support for BCM283x CPRMAN. Provide support for reading and
> > >> writing CPRMAN registers and initialize registers with sensible default
> > >> values. During runtime retain any written values.
> > >>
> > >> Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
> > >> and raspi3 systems.
> > >>
> > >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >> ---
> > >> I don't seriously expect this patch to get accepted, but I thought
> > >> it might be valuable enough for others to use it when playing with
> > >> raspi2 and raspi3 emulations.
> > >
> > > I've been working on a very similar patch... But due to soft-freeze I
> > > postponed it.
> > >
> >
> > > I don't feel very confident with my local work, as you, it is based on
> > > looking at the Broadcom firmware [1] and how the Linux kernel initialize
> > > the devices. I'll however compare with your work.
> > >
> >
> > I'll be more than happy to drop my patch and go with yours instead.
> > Let's just do that - it looks like it is much more comprehensive.
> 
> Did you make any progress with your work?
> 
My patch works for me, and continue using it. My suggestion above was
for you to finalize your patch and submit it. I did not spend any further
time on it. Sorry for any confusion I may have caused.

> Your patch might be useful to solve the following issue:
> https://bugs.launchpad.net/bugs/1779017

Yes, that was one of the reasons for writing the patch in the first place.

Thanks,
Guenter
