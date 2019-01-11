Received: from eggs.gnu.org ([209.51.188.92]:43551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1ghz9l-0006qh-GA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1ghz9k-0006X4-ID
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:55:37 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:46650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=907059760=anthony.perard@citrix.com>)
	id 1ghz9k-0006Vt-AQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:55:36 -0500
Date: Fri, 11 Jan 2019 15:55:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190111155531.GM1508@perard.uk.xensource.com>
References: <20190110134917.16425-1-anthony.perard@citrix.com>
	<CAFEAcA-RQkXCvijrDkQY=QADq4O6c60ab1d-9oeq+vdObtQiUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-RQkXCvijrDkQY=QADq4O6c60ab1d-9oeq+vdObtQiUw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] xen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, Jan 11, 2019 at 01:35:29PM +0000, Peter Maydell wrote:
> On Thu, 10 Jan 2019 at 13:52, Anthony PERARD <anthony.perard@citrix.com> wrote:
> >
> > The following changes since commit 8ae951fbc1068308313b2c57a4fc3c68451641f4:
> >
> >   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190109' into staging (2019-01-09 16:08:31 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190110
> >
> > for you to fetch changes up to 24edb91f5009fa941e1294aaf4bb2103d9ad077e:
> >
> >   xen-block: avoid repeated memory allocation (2019-01-10 11:25:17 +0000)
> >
> > ----------------------------------------------------------------
> > xen queue
> >
> > * Xen PV backend 'qdevification'.
> >   Starting with xen_disk.
> > * Performance improvements for xen-block.
> > * Remove of the Xen PV domain builder.
> > * bug fixes.
> >
> > ----------------------------------------------------------------
> 
> Hi. This fails to compile for me (x86-64 Linux host):
> 
>   CC      hw/block/xen-block.o
> In file included from
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-block.h:11:0,
>                  from
> /home/petmay01/linaro/qemu-for-merges/hw/block/xen-block.c:22:
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-bus.h:32:5:
> error: unknown type name ‘xenevtchn_port_or_error_t’
>      xenevtchn_port_or_error_t local_port;
>      ^
> /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> 'hw/block/xen-block.o' failed
> 
> Probably the code is accidentally assuming a newer version
> of the Xen headers than this system has installed? This
> is Ubuntu 16.04.5 with libxen-dev  4.6.5-0ubuntu1.4.

Sorry, I did stop build testing againt 4.6 as it went out of security
support. Let me fix this and I'll resend a pull requests.

Thanks,

-- 
Anthony PERARD
