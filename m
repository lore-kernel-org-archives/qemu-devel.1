Received: from eggs.gnu.org ([2001:4830:134:3::10]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlRn-0004Sw-HP
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlRj-0008Bv-PW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:15:17 -0500
Date: Fri, 30 Nov 2018 17:14:49 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181130161449.dg2yxiac5lnk7mbb@kamzik.brq.redhat.com>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA83C_Eic3K4yY5bGeEKJpY2uf26diFtDJ5r+W71jcX2DQ@mail.gmail.com>
	<CAFEAcA8nfp0ueLMJHhgRyf+mqG1QbakjKJiqSnLF-MFkjkDhZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8nfp0ueLMJHhgRyf+mqG1QbakjKJiqSnLF-MFkjkDhZA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing for
 adding configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peng Hao <peng.hao2@zte.com.cn>, qemu-arm <qemu-arm@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Nov 30, 2018 at 03:57:13PM +0000, Peter Maydell wrote:
> On Fri, 30 Nov 2018 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> > I suspect the reason you've done this is that you're
> > trying to get "-device pvpanic" to work on the command
> > line. I recommend not trying to get that to work.
> > MMIO devices are not pluggable devices, and -device
> > is not expected to work with them.
> 
> If you do want a pluggable pvpanic device for the virt
> board then you should implement it as a PCI device,
> incidentally.
>

We'd have to allocate it a PCI device ID, but I guess that's OK as
there are plenty of IDs left for 1b36. I'm not sure it's worth it
though. Phil asked that this device by user creatable, but maybe
that's not necessary. Maybe we just need a mach-virt compat boolean
and then to always provide this device for 4.0 and later machines?

Thanks,
drew
