Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etJxd-0000cv-I9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etJxc-0003gv-FL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:17:25 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Mar 2018 13:17:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180306211716.GA21453@roeck-us.net>
References: <20180305061237.21484-1-andrew.smirnov@gmail.com>
	<CAFEAcA_Y3oY0w3Xmrs0BTfhXw1s7S-8pESZ-rB2HgXzZ_5Vxmw@mail.gmail.com>
	<CAHQ1cqFrb3eryu9Dvi2=8aV_=K-MX9bqPHNAH4Fc4p402Sm0Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqFrb3eryu9Dvi2=8aV_=K-MX9bqPHNAH4Fc4p402Sm0Bw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RESEND PATCH v7 0/3] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Mon, Mar 05, 2018 at 07:50:23AM -0800, Andrey Smirnov wrote:
> On Mon, Mar 5, 2018 at 7:31 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 5 March 2018 at 06:12, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >> RESEND due to botched original v7 submission (patch 1/3 broken)
> >>
> >> Hi everyone,
> >>
> >> This v7 of the patch series containing the work that I've done in
> >> order to enable support for i.MX7 emulation in QEMU.
> >
> > Thanks; applied to target-arm.next.
> >
> > By the way there were a couple of i.MX bug reports this weekend:
> > https://bugs.launchpad.net/qemu/+bug/1753314  (about the UART)
> 
> Sure, might not be able to look at it immediately but I'll give it a
> spin by the end of this week.
> 
> > https://bugs.launchpad.net/qemu/+bug/1753309  (about ethernet)
> >
> 
> Peter:
> 
> Ha! This is a rather amusing coincidence since I was just talking
> about this exact bug with Guenter Roeck (added to this thread), who
> was going to submit a patch to fix it.
> 
> Guenter:
> 
> Sorry for just randomly pulling you into this seemingly random
> discussion, but I though this additional context would be helpful to
> you.
> 
I just updated https://bugs.launchpad.net/qemu/+bug/1753309 with my
observations. As it turns out, the Ethernet interface on older kernels
(4.9 and older) only works with the current version of qemu. It is
possible to fix the problem by applying upstream commit 4c8777892e80b
to v4.9 and older kernels. However, I don't know if the problem is also
seen with real hardware, or if there is some other problem lurking
somewhere in qemu.

Guenter
